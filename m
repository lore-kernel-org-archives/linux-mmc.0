Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB1364047
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696210; cv=none; b=YXCTuxIObG2u3PwU2aCnmKYBeTCvkU3OV3aMlHVbPvdqcoXcYacok4Z3MDSr8HkSSUa4GTayI2g0JF037NhVxRmmpnHNFEL6euFIi8ZZuvSOq1jOzJtscGO8m98xToOEeSOj2OMya0//zSXdDwxyehhKexmtkud0MFsXMYH1Qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696210; c=relaxed/simple;
	bh=7ZLysebN5r4jqlIq8lJt7cS36Tp0ZH2vtfetm2n+Czo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1x+IL0Igd2sA7pIPHeJ1mI2DffayB7sCA83xWc4MjvoosaYlw6AQXbmK2A1qzkHBWgDdh4EugaDFiAeMrdRxDKIxDu6FkVx+Lhl8XOD/+60TZVnyL9UkgFVQ0Sc7Tk+lqPPIA9VDmgzlZuM0WAN9YSLP1OpsdUV7LmajCUA43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI9gSnUH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI9gSnUH"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a3ba1653fso15934147b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696208; x=1774301008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM1zfAemiSSxUbrVM287/KInKHc7Ndyggj5H9U+hf7A=;
        b=NI9gSnUH76u9Lsmrx1WiO/J5ik+ANYGzK5BFniM9pd4Hu/bEEludOPTNYpBnzW6rHm
         zHG0vz9QNORSx1lOSxyvjHT++8sKjoDBEMdcU/xxROYmLoDUIQYHDtaiFUSVkZAyW5Ft
         q0p6M/ZWKusFc3CXYVN+lVys7dVuF9Gxa4ViphWTbCkJJ0PHp4w2h35JkX+ifXrvT6A5
         YPpOAzaijMcj/VNMOZwmAUg9Q/AF8LpmkO4s0RtW2NsdQa6Fo26k0RIjcNiqmDijML/H
         mv3gi3bDhrFnHK+z/YGSOWBVkgoTTqdOD31mKzVqzxDY8gFTDH0/ExPbta4vYYbHG+BX
         PPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696208; x=1774301008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kM1zfAemiSSxUbrVM287/KInKHc7Ndyggj5H9U+hf7A=;
        b=UBvpKOlKYAr2APHQcWHUjMCwapFF6HLZK6cb738cxkc4aX7kj7V+CZjyvRAOhDH7a4
         GK8RgAkQzJdJ4BJLSDAA9i+XAPJiMsmxcvNbGiuAxQZrX9Ieawy3fPG0OPbYQMC6mONo
         ceRAokPGm/JAYocOGbXHFsgcGJ2ekiru/HAnQB2gUX8ucfO/T7fpCoZFwRoNZQ7fuAcC
         Bs532upGy0NYI+9B2ZiKXz7XTMH8ZAI8f91Bvc3yHlMgMbpYsvnHLMaK97nCPintPxkH
         qiX2bIOcTV7VxLJK07CJmlHPX6SPJa0W+FWVw4QqQfAu7T0AOUEebfCQBAdpJ/gW9TPq
         fEWg==
X-Gm-Message-State: AOJu0Yw0WnCgkBolmSZCmBXLfhEfkCgCQI87jEWxyhfhwEy52CfsvoXd
	xCioGoKT+RpTk73hdMajFCEL0J3Bw7tOIc+F1w1QCXKUxSPJQTyAACas9bopwQGw
X-Gm-Gg: ATEYQzwOTQf5waGZHBzuTeZa7mGlDXjpP4GcI5B/NlpKhUwhoxjl1mkf9tkTu40QjUK
	XAxueuGd5bE0g7Hn1dFAR4UFyVGI2k98T3BoSAC7h3zQ0g5xYvMP6Fk/wLeArzYe1Ak6Q/rkiD3
	5uFlYnaPHed45X1fFKh8dVolwvQaVwIXp3LxjabWeNFYtBysWyHwSWf026kLjsrQmaVmHvkUOG/
	EkuFLYSxVSCk7KNUtnGACxwq624rJVL8zRt9GYEM7UF5q9ttB8XrEXaS2FT9DuGfhwbZNUaUANH
	emGUSnp42xbxGno87s9Hvz/T4CxPBc9rt3YraKnPkiSa+NljvLH3BFOWz/UUcBy3t5OrKXbGNF5
	q8xn4U8DX+w7Pum8WZOXssRvbP5uZjmmE2uQlamhF/Cc3WEowKQwp4EGkXmwvQ5lv93ZybjtRsm
	v6PxmPTvMO7vvaIO+2rP3d72ImrMfxjq6D78Sf8J408f5RWGg0Cw==
X-Received: by 2002:a05:690c:c510:b0:79a:5e2f:45ce with SMTP id 00721157ae682-79a5e2f4abfmr24583947b3.2.1773696207769;
        Mon, 16 Mar 2026 14:23:27 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a5e1ae50asm8180437b3.2.2026.03.16.14.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:23:27 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	Nelson Johnson <nzjfr547@gmail.com>
Subject: [PATCH 1/3] mmc: sdhci-pci: disable aggressive runtime PM for Braswell SD on Lenovo N22
Date: Mon, 16 Mar 2026 16:23:23 -0500
Message-ID: <20260316212325.4207-2-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316212325.4207-1-nzjfr547@gmail.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo N22 systems with the Braswell SD controller (PCI ID 8086:2296) regress on kernels newer than 4.9. On this machine the SD slot is exposed through both PCI and ACPI firmware nodes, and enabling the newer aggressive runtime PM/card-detect wake path causes the controller to stop behaving like the older working configuration.

Keep the Lenovo N22 on the pre-4.14 behavior by skipping MMC_CAP_AGGRESSIVE_PM and MMC_CAP_CD_WAKE for the 8086:2296 slot on this DMI match, and disable runtime PM for that host.

This preserves the rest of the Braswell/Atom handling while restoring the power-management behavior that allows the slot to function on the Lenovo N22.

Fixes: 6cf4156c0988 ("mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD controllers")
Signed-off-by: Nelson Johnson <nzjfr547@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 47a0a7388..4b3c61609 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -923,6 +923,13 @@ static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
 			dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
 }
 
+static bool sdhci_pci_is_lenovo_n22_bsw_sd(struct sdhci_pci_slot *slot)
+{
+	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BSW_SD &&
+	       dmi_match(DMI_SYS_VENDOR, "LENOVO") &&
+	       dmi_match(DMI_BOARD_NAME, "N22");
+}
+
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	int ret = byt_emmc_probe_slot(slot);
@@ -1120,9 +1127,13 @@ static void byt_needs_pwr_off(struct sdhci_pci_slot *slot)
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
+	bool runtime_pm_ok = !sdhci_pci_is_lenovo_n22_bsw_sd(slot);
+
 	byt_probe_slot(slot);
-	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
-				 MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
+	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+	if (runtime_pm_ok)
+		slot->host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM |
+					 MMC_CAP_CD_WAKE;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
@@ -1135,7 +1146,10 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	    slot->chip->pdev->subsystem_device == PCI_SUBDEVICE_ID_NI_78E3)
 		slot->host->mmc->caps2 |= MMC_CAP2_AVOID_3_3V;
 
-	byt_needs_pwr_off(slot);
+	if (runtime_pm_ok)
+		byt_needs_pwr_off(slot);
+	else
+		slot->chip->allow_runtime_pm = false;
 
 	return 0;
 }
-- 
2.47.3

