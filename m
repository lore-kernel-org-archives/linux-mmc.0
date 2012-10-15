From: Madhvapathi Sriram <Madhvapathi.Sriram@csr.com>
Subject: [PATCH 1/1] mmc: sdhci-pci: Enable SDHCI_CAN_DO_HISPD for ricoh
 SDHCI controller
Date: Mon, 15 Oct 2012 04:47:30 +0000
Message-ID: <AAD401B65941D44692B7183E6577180803927CA6@banasiexm01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:44682 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab2JOFbt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 01:31:49 -0400
Received: from rly14d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly14d.srv.mailcontrol.com (MailControl) with ESMTP id q9F4m2dI008724
	for <linux-mmc@vger.kernel.org>; Mon, 15 Oct 2012 05:48:03 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly14d.srv.mailcontrol.com (MailControl) id q9F4lbBp007493
	for <linux-mmc@vger.kernel.org>; Mon, 15 Oct 2012 05:47:37 +0100
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "'cjb@laptop.org'" <cjb@laptop.org>

The ricoh SDHCI controller supports Highspeed clocks as evident from
the ricoh_mmc_probe_slot() settings. Hence, SDHCI_CAN_DO_HISPD needs
to be set to enable SDIO client drivers to set/enable high speed clock
settings

Signed-off-by: Madhvapathi Sriram <Madhvapathi.Sriram@csr.com>
---
 drivers/mmc/host/sdhci-pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 4bb74b0..0245666 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -114,6 +114,7 @@ static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
 
 		SDHCI_TIMEOUT_CLK_UNIT |
 		SDHCI_CAN_VDD_330 |
+		SDHCI_CAN_DO_HISPD |
 		SDHCI_CAN_DO_SDMA;
 	return 0;
 }
-- 
1.7.4.1


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
