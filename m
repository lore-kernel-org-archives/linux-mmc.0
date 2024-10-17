Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15321D278C;
	Thu, 17 Oct 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152688; cv=none; b=tSIVTsUpFMYkeL3fibkfvbvkK3NmHwpGbjJw5u/3y/CH7ugXOhscTlicj5gYkR1YzxUTXQpVo7t/R8uoc/4U7SC/AFVfydf0zJ50gLG0koGHNOz6N+8pWdOfRKM9Pmtc2zNgXnNA5Qb00XgGzz6VV3C+7CCT/WCJaA2Bead1SE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152688; c=relaxed/simple;
	bh=L6LmrLd1QFSEntUWb7XQSEIeIbyw7jUSRFYRRWTV/ck=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=HtZSX9n7Q1AQxj/XZFXs+l6ajqAmlrY8zrjWmPKqj2B8tBiJ5n+c5CsRcV47qXorlq+Yxb5GyXTLt6nrBVwxAIdbrqYIqi5viztrzQQ5HQ8APlfvbelUyreN/X0F0VKtsKasmLAnuD73EJyNJrccNpgTeVwKtPOZsp7V1tFhYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=A3v8o0xO; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="A3v8o0xO"
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 97D2A2FC005F;
	Thu, 17 Oct 2024 10:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1729152679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=68VuTC6Xxo1LxwhwBMk+4MMZAYXOcNtEil4dk7qsY3c=;
	b=A3v8o0xO+EvK1zO00NHYtI+1uAsvLGHOhvFf8xSAxlmTcdW9Q6kXEbD0sf5nH9CTda4px0
	QUe2eIY5ZXBZuqB2Q3SJ1uOCEJuXeGnIYZGz/2eZPGgsnmdA4Yc7xjt2//4MBd+seFgceH
	1rIYMJP4wHIqJKl71rpwbG+46ppvsrg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com>
Date: Thu, 17 Oct 2024 10:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ben Chuang <benchuanggli@gmail.com>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
Subject: [RFC PATCH v2 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs suspend for
 GL9767
Cc: Ben Chuang <benchuanggli@gmail.com>, adrian.hunter@intel.com,
 Ulf Hansson <ulf.hansson@linaro.org>, victor.shih@genesyslogic.com.tw,
 Lucas.Lai@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, cs@tuxedo.de,
 Georg Gottleuber <ggo@tuxedocomputers.com>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adapt commit 1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation
so x86/S0ix SoCs can suspend") also for GL9767 card reader.

This patch was written without specs or deeper knowledge of PCI sleep
states. Tests show that S0ix is reached and lower power consumption
when suspended (6 watts vs 1.2 watts for TUXEDO InfinityBook Pro Gen9
Intel).

The function of the card reader appears to be OK.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
Fixes: f3a5b56c1286 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support")
Co-developed-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
---
v1 -> v2:
- use gl9767_vhs_read() and gl9767_vhs_write()
- editorial changes to the commit message

 drivers/mmc/host/sdhci-pci-gli.c | 61 +++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c
b/drivers/mmc/host/sdhci-pci-gli.c
index 0f81586a19df..bdccd74bacd2 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1205,6 +1205,28 @@ static void
gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
        pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }

+static void gl9767_set_low_power_negotiation(struct sdhci_pci_slot *slot,
+                                            bool enable)
+{
+       struct pci_dev *pdev = slot->chip->pdev;
+       u32 value;
+
+       gl9767_vhs_write(pdev);
+
+       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
+
+       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+
+       if (enable)
+               value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+       else
+               value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+
+       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
+
+       gl9767_vhs_read(pdev);
+}
+
 static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
                                        unsigned int timing)
 {
@@ -1470,6 +1492,42 @@ static int gl9763e_suspend(struct sdhci_pci_chip
*chip)
        gl9763e_set_low_power_negotiation(slot, false);
        return ret;
 }
+
+static int gl9767_resume(struct sdhci_pci_chip *chip)
+{
+       struct sdhci_pci_slot *slot = chip->slots[0];
+       int ret;
+
+       ret = sdhci_pci_gli_resume(chip);
+       if (ret)
+               return ret;
+
+       gl9767_set_low_power_negotiation(slot, false);
+
+       return 0;
+}
+
+static int gl9767_suspend(struct sdhci_pci_chip *chip)
+{
+       struct sdhci_pci_slot *slot = chip->slots[0];
+       int ret;
+
+       /*
+        * Certain SoCs can suspend only with the bus in low-
+        * power state, notably x86 SoCs when using S0ix.
+        * Re-enable LPM negotiation to allow entering L1 state
+        * and entering system suspend.
+        */
+       gl9767_set_low_power_negotiation(slot, true);
+
+       ret = sdhci_suspend_host(slot->host);
+       if (ret) {
+               gl9767_set_low_power_negotiation(slot, false);
+               return ret;
+       }
+
+       return 0;
+}
 #endif

 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
@@ -1605,6 +1663,7 @@ const struct sdhci_pci_fixes sdhci_gl9767 = {
        .probe_slot     = gli_probe_slot_gl9767,
        .ops            = &sdhci_gl9767_ops,
 #ifdef CONFIG_PM_SLEEP
-       .resume         = sdhci_pci_gli_resume,
+       .resume         = gl9767_resume,
+       .suspend        = gl9767_suspend,
 #endif
 };
-- 
2.34.1
