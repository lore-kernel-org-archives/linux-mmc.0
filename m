Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0261C07CD;
	Tue, 15 Oct 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996470; cv=none; b=dGQ8C5cNqITLR4ii0kfCLtVx+LvSfjuKKet+I5yhosCL4ihflcbUeWfDixRylw17/SGVzZsPceh/Fdd06j8Naa1/7SafQ1iEGzWcQ5TlC3u9oixfq1Rg5EW1ouvZiZn/bHGXxR36Z7PzVH05A3iujM7Em50rxBGsHeS2QRgNJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996470; c=relaxed/simple;
	bh=K9D3hkjeg/gOkvrq0dJpGPHws4AK7bgMeTDsaOTFeyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d41IBxjTtewRCaOrCvaycXfAlGR1vdHrzx8tbvvfJvX6HO1ZOzPVi7UIjuvg79cg79P78QrudvCG5fNmJPGHTkQRrRKly2CtnQzMssm50x9xyaQ7s0o8SyA/Q9CK7QPh9KxYG1zfqYpy9CNJDcCr3/d5jSlt0nhfwk+YLkGxs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=MQ1+8rDx; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="MQ1+8rDx"
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 9F7952FC0059;
	Tue, 15 Oct 2024 14:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1728996458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mvGkJznbmh3jps4clef9o8wCS2/J44uxG/Nxu7qcpw=;
	b=MQ1+8rDx790ZGrh/YMPgRtfVrESZIDTtyW2gIxC9L66o+J3Ag+yQGh8aPC/Eg+TZkb09aP
	VGraZ542zKdYOBLrf7QREjmObpDYP+0xYrkinLWFTnsnyGpgt9r5njqWNqRrpsQINvbXH7
	bOyPz5xfXdlSPwI0Jz4bKcasCV9NYdw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <4a517433-d105-4e2b-86f8-335e7c537d10@tuxedocomputers.com>
Date: Tue, 15 Oct 2024 14:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs suspend for
 GL9767
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: victor.shih@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw,
 adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Georg Gottleuber <ggo@tuxedocomputers.com>
References: <8235497b-421c-4af7-90e4-95ad4e271ead@tuxedocomputers.com>
 <CAPDyKFrT6-nes784c9rCtqdJZ0nCFS3O5X=600OB6trbz2yJ2w@mail.gmail.com>
Content-Language: en-US
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
In-Reply-To: <CAPDyKFrT6-nes784c9rCtqdJZ0nCFS3O5X=600OB6trbz2yJ2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adapt commit 1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation
so x86/S0ix SoCs can suspend") also for GL9767 card reader.

This patch was written without specs or deeper knowledge of PCI sleep
states. Tests show that S0ix is reached and a lower power consumption
when suspended (6 watts vs 1.2 watts for TUXEDO InfinityBook Pro Gen9
Intel).

The function of the card reader appears to be normal.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
Co-developed-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 65 +++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c
b/drivers/mmc/host/sdhci-pci-gli.c
index 0f81586a19df..40f43f5cd5c7 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1205,6 +1205,32 @@ static void
gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
        pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }

+static void gl9767_set_low_power_negotiation(struct sdhci_pci_slot *slot,
+                                            bool enable)
+{
+       struct pci_dev *pdev = slot->chip->pdev;
+       u32 value;
+
+       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
+       value &= ~GLI_9767_VHS_REV;
+       value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
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
+       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
+       value &= ~GLI_9767_VHS_REV;
+       value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
+       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
+}
+
 static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
                                        unsigned int timing)
 {
@@ -1470,6 +1496,42 @@ static int gl9763e_suspend(struct sdhci_pci_chip
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
@@ -1605,6 +1667,7 @@ const struct sdhci_pci_fixes sdhci_gl9767 = {
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
