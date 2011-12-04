From: Axel Lin <axel.lin@gmail.com>
Subject: [linux-next] sdhci-s3c build error
Date: Sun, 04 Dec 2011 08:04:05 +0800
Message-ID: <1322957045.19303.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41695 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1LDAER (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Dec 2011 19:04:17 -0500
Received: by iage36 with SMTP id e36so6287325iag.19
        for <linux-mmc@vger.kernel.org>; Sat, 03 Dec 2011 16:04:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sangwook Lee <sangwook.lee@samsung.com>, Chris Ball <cjb@laptop.org>

commit 666b6ab "mmc: sdhci-s3c: Add pm_caps into SD/MMC host" introduces below
build error:

  CC      drivers/mmc/host/sdhci-s3c.o
drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
drivers/mmc/host/sdhci-s3c.c:524: error: 'struct s3c_sdhci_platdata' has no member named 'pm_caps'
drivers/mmc/host/sdhci-s3c.c:525: error: 'struct s3c_sdhci_platdata' has no member named 'pm_caps'
make[3]: *** [drivers/mmc/host/sdhci-s3c.o] Error 1
make[2]: *** [drivers/mmc/host] Error 2
make[1]: *** [drivers/mmc] Error 2
make: *** [drivers] Error 2

Forgot to add pm_caps to struct s3c_sdhci_platdata?

Regards,
Axel


