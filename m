From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 1/3] mmc: sdhci-pci: Remove set-but-unused variable.
Date: Wed, 23 Feb 2011 17:29:11 -0500
Message-ID: <1298500153-28081-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:44145 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab1BWWhY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 17:37:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

drivers/mmc/host/sdhci-pci.c: In function =E2=80=98sdhci_pci_probe_slot=
=E2=80=99:
drivers/mmc/host/sdhci-pci.c:913:18: warning: variable =E2=80=98addr=E2=
=80=99 set but
not used [-Wunused-but-set-variable]

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pci.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.=
c
index 4cb2d0e..ed2cffa 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -909,9 +909,6 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_=
probe_slot(
 {
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
-
-	resource_size_t addr;
-
 	int ret;
=20
 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
@@ -958,7 +955,6 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_=
probe_slot(
 		goto free;
 	}
=20
-	addr =3D pci_resource_start(pdev, bar);
 	host->ioaddr =3D pci_ioremap_bar(pdev, bar);
 	if (!host->ioaddr) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
--=20
1.7.0.1

