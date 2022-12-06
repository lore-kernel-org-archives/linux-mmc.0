Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8615C636F9
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiLFQ76 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiLFQ74 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5042A416;
        Tue,  6 Dec 2022 08:59:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gh17so7713430ejb.6;
        Tue, 06 Dec 2022 08:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+x7sVgmVUy0nFilA/xgoX4WHBeOpUbanqvIivo4H6c=;
        b=LGz7Kzq8lENoaan4SBI6zDEXk8fp9vwOKrepzBGWOBETMkQNMcbeliyf3aCuhx9p6k
         d5ixVo3Kjh65WEYHDN9R05qzpMWqiQ9k4TlCMhwjC20RvJXmA6JZyL2zXq+n5ETdmf1x
         dM0usmfqkIzDWmSCGeQBu81Hgee++KhBtgkvdQyIKjC2eN3Pmv6BVnWRagR/qbjiCd+e
         RLyi6Ikxen0K7AKtBMc9VpuaeOVF9qNDshqv4PBe5ar/tNCALH8dW+Dd9nePCaLy9Taq
         JTXL8p9Y4sQYXKe9M5aYc44FZTKeFluq+qHe5I6nQ6OSsFKIATnNftnM7NUKBPv/OjLi
         Ex2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+x7sVgmVUy0nFilA/xgoX4WHBeOpUbanqvIivo4H6c=;
        b=burfE1oWXu7S9jcZIqYwSFEAKPGtV7TdfS10GpFxj0odNbeFkrc9/DBC+K0syNgJp1
         T9yV7gDuwrPnuNHZQ8UqSiomI4xy1LHNusWFAWnUnr++EynsyWg34v+Pd6wwLu3ODEjR
         brhAtR1tVYe4sa6X9gUinNEuH5lCoOmfqHhhq5zbeGHqxmtqdcRp/i8PvMdSVlTG2UrK
         02a3myxrItkMOaRCwdemFgcai3mIbbCiQijR/v88qNtmDuaDcmN/V6a7PtEDJMSednSj
         zIkhLOzxgCAXQkfX2pyF0KX+MhxvkE3eQAayJTWFuZT0kuNSkiT2rMH2V7acEXQYQtlf
         VQFw==
X-Gm-Message-State: ANoB5pmcyP/Ty3OYmcUu/Kfz9/Q7nwWSDz6cPycv8bJ51hluyvf43Ic+
        6c00vU5eVm8fGc+Oki4ZyTG1mCT/UOg=
X-Google-Smtp-Source: AA0mqf5QmHP1nzFD7AQZdcqYoVCmZXCASRpkvt5zy3F/Y/FgJAMYj9rWZiXewQseLfanbILzQI5sPA==
X-Received: by 2002:a17:906:e244:b0:7c0:f9ec:1dff with SMTP id gq4-20020a170906e24400b007c0f9ec1dffmr7426748ejb.283.1670345994319;
        Tue, 06 Dec 2022 08:59:54 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906285a00b007af0f0d2249sm7611273ejc.52.2022.12.06.08.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:54 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v13 6/6] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Tue,  6 Dec 2022 17:59:45 +0100
Message-Id: <20221206165945.3551774-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

In case of error condition to avoid system crash Tegra SDMMC controller
requires CMD and DAT resets issued together. SDHCI controller FSM goes
into bad state due to rapid SD card hot-plug event. Issuing reset on the
CMD FSM before DATA FSM results in kernel panic, hence add support to
issue CMD and DAT resets together.

This is applicable to Tegra186 and later chips.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 drivers/mmc/host/sdhci.c       | 5 +++++
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index fb3823c87cb8..4c2563b27ed6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1528,7 +1528,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df1c1d10a338..81f4fed11629 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -270,6 +270,11 @@ enum sdhci_reset_reason {
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
+	if (host->quirks2 & SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		return;
+	}
+
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b6f31a7d6152..605eaee805f7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -478,6 +478,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Issue CMD and DATA reset together */
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.38.1

