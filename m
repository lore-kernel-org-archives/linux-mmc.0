From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] mmc-sdricoh_cs: Delete unnecessary variable
 initialisations in sdricoh_init_mmc()
Date: Tue, 29 Dec 2015 22:00:35 +0100
Message-ID: <5682F473.9040609@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682F3AC.7050107@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:59857 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbbL2VAk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Dec 2015 16:00:40 -0500
In-Reply-To: <5682F3AC.7050107@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Sascha Sommer <saschasommer@freenet.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 29 Dec 2015 21:11:45 +0100

These variables will eventually be set to an appropriate value a bit later.
* host
* iobase
* result

Thus let us omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/host/sdricoh_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index b7e3057..5e57d9f 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -398,10 +398,10 @@ static struct mmc_host_ops sdricoh_ops = {
 static int sdricoh_init_mmc(struct pci_dev *pci_dev,
 			    struct pcmcia_device *pcmcia_dev)
 {
-	int result = 0;
-	void __iomem *iobase = NULL;
+	int result;
+	void __iomem *iobase;
 	struct mmc_host *mmc = NULL;
-	struct sdricoh_host *host = NULL;
+	struct sdricoh_host *host;
 	struct device *dev = &pcmcia_dev->dev;
 	/* map iomem */
 	if (pci_resource_len(pci_dev, SDRICOH_PCI_REGION) !=
-- 
2.6.3

