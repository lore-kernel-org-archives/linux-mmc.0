Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B06C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiK1Coy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiK1Cow (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:44:52 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F42DF4
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:48 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a16so8738832pfg.4
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10C9l5cM9Gx+6A1r6iqoMzAy/dFS6z3guP1T2Uf7DqQ=;
        b=TzBcy4nze14e3VK8qk9Vn+oKWTOVmmiAYi2YP/56bEjInTRbOpIeA41cLwD8pzVUk4
         KzCdnA5yXc9RPsiHm7U4CSy5JdPHs7nWwd39kH2HaT2ShTAKLT5+bTT/B23Lo7189Vm2
         T2hf2Tfmwi9NVzj2Kvn9Z71RyvTWOu+MH29MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10C9l5cM9Gx+6A1r6iqoMzAy/dFS6z3guP1T2Uf7DqQ=;
        b=UqkrtC4TBHkZp8BktE3urDI6n2mlsv9T5XnGyyw/D/R4wW6TdsxIypmTWRJWq1kudV
         CT3Bw1iP6k7peC79alPGdJXqPxmIci4kZrpCWnD9SSQeX37iqVCsEuOrWNWptfCshFN4
         l6s1eQ9fmF4cpWDhRa4a+3JXKCZfJw9e4Syyh9qdiXL1P0qLHRFDyZnm5FM1b8Srj09b
         hUPA+4aFem6Z1mO4MjOhWx/MtDkUWGP1OmOLtLcGkVHaBq2VJNJMIU+QAVsgK+Kquw+7
         SKOv15U5KKlKoKIiMP/DxSO95LoW7gXWW7eaEuYEcpCJ+p9HxNkiGecAB75daZSaeYeA
         fb8g==
X-Gm-Message-State: ANoB5pmm79I5DaYc5fj6CU/RgsZ1+Go3kE7UEcn4tB1cK8MgcS+A632+
        SfcLDN+IVM+mLCGlwT5cscGImw==
X-Google-Smtp-Source: AA0mqf4wEG3Y0VAbLcuqmet6VRWOB3QCpK1YuSNDfiUOVFN9yKT3gYncIWlBfV5R0ycdyechcMpwzQ==
X-Received: by 2002:a63:f253:0:b0:434:afab:5ff9 with SMTP id d19-20020a63f253000000b00434afab5ff9mr24630939pgk.349.1669603487556;
        Sun, 27 Nov 2022 18:44:47 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:44:47 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 2/8] mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date:   Sun, 27 Nov 2022 18:44:01 -0800
Message-Id: <20221128024407.224393-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128024407.224393-1-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS for the pxav2 driver. The read_w
callback is needed for a silicon bug workaround in the PXA168.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5e19a961c34d..b9e9185c86a6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -360,6 +360,7 @@ config MMC_SDHCI_PXAV2
 	depends on MMC_SDHCI_PLTFM
 	depends on ARCH_MMP || COMPILE_TEST
 	default CPU_PXA910
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Marvell(R) PXAV2 SD Host Controller.
 	  If you have a PXA9XX platform with SD Host Controller
-- 
2.34.1

