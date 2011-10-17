From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pci: add flag for devices that can support runtime PM
Date: Mon, 17 Oct 2011 10:09:33 -0400
Message-ID: <m2sjmr7lr6.fsf@bob.laptop.org>
References: <1318837964-28654-1-git-send-email-adrian.hunter@intel.com>
	<m21uub93on.fsf@bob.laptop.org> <4E9C34AB.9000206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36390 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab1JQOJi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 10:09:38 -0400
In-Reply-To: <4E9C34AB.9000206@intel.com> (Adrian Hunter's message of "Mon, 17
	Oct 2011 16:59:07 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Mon, Oct 17 2011, Adrian Hunter wrote:
>> Thanks -- any objection to using a bool type instead for allow_runtime_pm?
>
> None at all

Pushed to mmc-next for 3.2 with a conversion to bool, thanks:

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index c22d810..d833d9c 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -47,7 +47,7 @@ struct sdhci_pci_slot;
 
 struct sdhci_pci_fixes {
 	unsigned int		quirks;
-	unsigned int		allow_runtime_pm:1;
+	bool			allow_runtime_pm;
 
 	int			(*probe) (struct sdhci_pci_chip *);
 
@@ -73,7 +73,7 @@ struct sdhci_pci_chip {
 	struct pci_dev		*pdev;
 
 	unsigned int		quirks;
-	unsigned int		allow_runtime_pm:1;
+	bool			allow_runtime_pm;
 	const struct sdhci_pci_fixes *fixes;
 
 	int			num_slots;	/* Slots on controller */
@@ -307,19 +307,19 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.allow_runtime_pm = 1,
+	.allow_runtime_pm = true,
 	.probe_slot	= mfd_sd_probe_slot,
 	.remove_slot	= mfd_sd_remove_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.allow_runtime_pm = 1,
+	.allow_runtime_pm = true,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.allow_runtime_pm = 1,
+	.allow_runtime_pm = true,
 	.probe_slot	= mfd_emmc_probe_slot,
 	.remove_slot	= mfd_emmc_remove_slot,
 };

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
