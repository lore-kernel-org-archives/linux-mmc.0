From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] cb710: fix possible pci_dev leak in
 cb710_pci_configure()
Date: Thu, 28 Jul 2011 20:55:27 +0200 (CEST)
Message-ID: <d8d89ffdad20168a3c2273418aff74036eb24add.1311879121.git.mirq-linux@rere.qmqm.pl>
References: <20110728183319.GC24120@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:57225 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755249Ab1G1Sz2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 14:55:28 -0400
In-Reply-To: <20110728183319.GC24120@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: kernel-janitors@vger.kernel.org, Julia Lawall <julia@diku.dk>

Reported-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/misc/cb710/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index efec413..68cd05b 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL_GPL(cb710_pci_update_config_reg);
 static int __devinit cb710_pci_configure(struct pci_dev *pdev)
 {
 	unsigned int devfn =3D PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
-	struct pci_dev *pdev0 =3D pci_get_slot(pdev->bus, devfn);
+	struct pci_dev *pdev0;
 	u32 val;
=20
 	cb710_pci_update_config_reg(pdev, 0x48,
@@ -43,6 +43,7 @@ static int __devinit cb710_pci_configure(struct pci_d=
ev *pdev)
 	if (val & 0x80000000)
 		return 0;
=20
+	pdev0 =3D pci_get_slot(pdev->bus, devfn);
 	if (!pdev0)
 		return -ENODEV;
=20
--=20
1.7.5.4

