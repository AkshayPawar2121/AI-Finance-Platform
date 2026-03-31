const fs = require('fs');

function processFile(file) {
    let content = fs.readFileSync(file, 'utf8');
    // Replace en-dash, em-dash, and any corrupted dash `â€“`, `â€”`, `−` with simple hyphen `-`
    content = content.replace(/[—–−]/g, '-');
    content = content.replace(/â/g, ''); // For stray 'â'
    
    // Replace $ followed by a digit with ₹ followed by that digit
    content = content.replace(/\$(\d)/g, '₹$1');
    content = content.replace(/- \$/g, '- ₹');
    content = content.replace(/\+ \$/g, '+ ₹');
    
    // Specifically handle the weird `?${` in home.jsp that represented rupees
    content = content.replace(/\?\$\{/g, '₹${');
    
    fs.writeFileSync(file, content, 'utf8');
    console.log(`Processed ${file}`);
}

['nextgendemo/src/main/webapp/WEB-INF/jsp/index.jsp',
 'nextgendemo/src/main/webapp/WEB-INF/jsp/home.jsp',
 'nextgendemo/src/main/webapp/WEB-INF/jsp/register.jsp'].forEach(processFile);
