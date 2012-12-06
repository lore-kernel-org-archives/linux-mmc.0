From: Madhvapathi Sriram <Madhvapathi.Sriram@csr.com>
Subject: RE: [PATCH 1/1] mmc: sdhci-pci: Enable SDHCI_CAN_DO_HISPD for ricoh
 SDHCI controller
Date: Thu, 6 Dec 2012 06:18:38 +0000
Message-ID: <AAD401B65941D44692B7183E65771808039451A6@banasiexm01.ASIA.ROOT.PRI>
References: <AAD401B65941D44692B7183E6577180803927CA6@banasiexm01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:59739 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab2LFGSr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 01:18:47 -0500
In-Reply-To: <AAD401B65941D44692B7183E6577180803927CA6@banasiexm01.ASIA.ROOT.PRI>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>
Cc: "'cjb@laptop.org'" <cjb@laptop.org>

Hi,

Can I consider this accepted since there are no comments?


-----Original Message-----
From: Madhvapathi Sriram 
Sent: Monday, October 15, 2012 10:18 AM
To: linux-mmc@vger.kernel.org
Cc: 'cjb@laptop.org'
Subject: [PATCH 1/1] mmc: sdhci-pci: Enable SDHCI_CAN_DO_HISPD for ricoh SDHCI controller

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
