From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] atmel-mci.c: use resource size()
Date: Mon, 14 Dec 2009 14:11:56 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200E9EA@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932477AbZLNTMF@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
Cc: haavard.skinnemoen@atmel.com
List-Id: linux-mmc@vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>

---

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fc25586..150242f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1628,7 +1628,7 @@ static int __init atmci_probe(struct platform_device *pdev)
 	}
 
 	ret = -ENOMEM;
-	host->regs = ioremap(regs->start, regs->end - regs->start + 1);
+	host->regs = ioremap(regs->start, resource_size(regs));
 	if (!host->regs)
 		goto err_ioremap;
  
