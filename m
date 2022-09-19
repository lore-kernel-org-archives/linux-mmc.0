Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1D6ECAAD3
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 20:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiISUrO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiISUrN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 16:47:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B314A83A
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 13:47:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349e90aa547so3034397b3.8
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=2VpmpPOU+YCJvEpT9wllRVbdFOmf6SySHisIVkYbNR0=;
        b=MxyLPkp2cx9Vw+U01IHnp/7KzFjf8iDt42l5C5qhNipvJtbzOZdY/CD1C5Ri8FU959
         HgennBpDerr8NkeAK6dgLRMAiXSac7nW9cV2FVMkgu7z6dA7yNPCuypWrRC1mqSoabQa
         +pkzbuvKjhI/eXROIrF7HzTk+e5N/6YRR42ZAw71GbKee8ZoKq4rWE9BwCYhtRGud4vH
         2v5EYGC8KSLoHHUIQUB+Vf77IsP5REgjrVFUYHSV2dkRtZbWaHt8Yfw6loWcU0YsnzDh
         l5ARnKQthRj+lxzrQ0OTpepwFztBsLl3GVTKdwgXW+r+b5FsHXM28W017Cpi2uy0g1QL
         CEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2VpmpPOU+YCJvEpT9wllRVbdFOmf6SySHisIVkYbNR0=;
        b=bPfLktNgtsBjVGoPwyeLahs66cydjqpVKleXnVybo85btUGGW5mMZAwQ67xlu80IVB
         nH/WcY5D+nOi7daqQHgTFRjCwQX2PNRTiGv9qLG2m8WzaBHWSENJsL54h1cQtwfof/6z
         mUVax5RsphX+RLvinzfXxNQAtztPyL1E7UZeGWxtAULNDaXiMoIix6YEiJNhCWVMamTB
         R/6eBE3eIqO52lPCnZWlilxCXINpLBi1z6tpmYGYWNJ9fnPkMBJFlagXkm/UveZ5fK2r
         aoeCadoBSp+76CydPZERfx8Xv48GnlwmGn8Y49wgmq2/J9kHvDHPYasKnb+h+1UCerrQ
         sX2g==
X-Gm-Message-State: ACrzQf0crfRegze7uM7QCQ4a0WN/ZybwhYJZerbUu1TTynt3MybqcHeR
        NHv9mM874GmxX68rzNg2oIOLowFZTt1pAsLejhdLSq4EGOm3isGy5hWpoGZzXrxlPewL43RvwY6
        eTdUEb7ociVC6z2ij1nKA5kfki1oZQjCxZLdsoyNH9eW2H3eW9P4tZKrRpQ==
X-Google-Smtp-Source: AMsMyM68ZevqarY5r0B78474DGXHr/QLHL34TGinEO0JyK3r+IWQFGYuoeDk4/W10gTO87K+htZuJgo=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:fa14:2d2d:5271:3002])
 (user=ptf job=sendgmr) by 2002:a81:155:0:b0:345:7ab3:5a18 with SMTP id
 82-20020a810155000000b003457ab35a18mr15774365ywb.228.1663620431974; Mon, 19
 Sep 2022 13:47:11 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:46:51 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220919204651.1517899-1-ptf@google.com>
Subject: [PATCH v2] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake
From:   Patrick Thompson <ptf@google.com>
To:     Linux MMC Development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Patrick Thompson <ptf@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
ES. There are also two system families under the series, thus this is
being scoped to the ASUS BIOS.

The failing ES prevents the installer from writing to disk. Falling back
to HS400 without ES fixes the issue.

Signed-off-by: Patrick Thompson <ptf@google.com>

---

Changes in v2:
V1->V2:
* Only disable ES instead of CQE in its entirety.
* Target Jasper Lake (JSL)
* Target ASUS BIOS instead of specific system family

 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 622b7de96c7f..42406f76f65c 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -893,6 +893,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
 }
 
+static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
+{
+	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC &&
+			dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
+}
+
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	int ret = byt_emmc_probe_slot(slot);
@@ -901,9 +907,13 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
 
 	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
-		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
-		slot->host->mmc_host_ops.hs400_enhanced_strobe =
-						intel_hs400_enhanced_strobe;
+		if (jsl_broken_hs400es(slot)) {
+			slot->host->mmc->caps2 |= MMC_CAP2_HS400;
+		} else {
+			slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
+			slot->host->mmc_host_ops.hs400_enhanced_strobe =
+							intel_hs400_enhanced_strobe;
+		}
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
-- 
2.37.3.968.ga6b4b080e4-goog

