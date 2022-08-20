Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ACDC25B08
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiHTT6t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiHTT6l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCB2B1B8
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7842466pjl.0
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=dMFXg3AB8Kus5JNouLBHdMgn7Dy/CGRupLO5nuK1l3I=;
        b=t3h0slct3P4QP/EX3QgcDT5fzOEi1f+sZtvp2hNV4pFegjz/A6N13zk1tbwW12sHrQ
         keXZ6YdVdB61vvFtakAppATXAFJn6gqXcvlp0lNMtgiTpMGyUxNipWVIBpbOng7K9stK
         ue4pcaiPHIvUh9bb6ndZLPz42dn5naMduzQb+L8BLvIkdyRFzEv53KSii/q5vlvJ8ZyV
         RdqTQYp873mcqbEFjSs9UMHlv+sf0Sj7AooA27HWn3r6trpSZ21rs3aJF7FUbzKUSQ5r
         BtE1pYh+RQKjrTsKYOzZNxwRKXSqFfroQAgTUQUu12gOWdNChZVj2WhBfi7RJGuMFx3m
         A2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=dMFXg3AB8Kus5JNouLBHdMgn7Dy/CGRupLO5nuK1l3I=;
        b=fyOvzieO7lG1qfBFXZcqLQrOGeZee96/d5sIxb50WxbS9nmiOn6rIbytpbxcUSdWyR
         zjwAgowLtRCIUS08yHn0MpzzsdbqUrwsbUT8TexAgfPalj6J384LuxpWK4swqcnFXMTA
         wFm64ulAiS9zKNA1mbZs7/ZgUKsbN3QDK46ANskGeBmrbRFQnwVMwkwb/fC8tkIFWiwl
         96vezK7KFHKFOhGfTl32CnRkoBX6qVdzfaBUCbxfEtcka2QbK0g0j9A9iOwQAj3q7tTg
         dL6Jyc/0dvcmgP7mhMPv5FPZME0WhzUUzKh6xEKxYTP0/RCKziLWgeh294m+VnjxqjUL
         uFHg==
X-Gm-Message-State: ACgBeo34TCAutnAJd2qrs/yMEddQ2CWHW7AFIw44zWXyXes48gYhFljf
        LIfW4lhwbEzMhBfhc3nDc9yfzQ==
X-Google-Smtp-Source: AA6agR6RW//AMsJUUACM4DrHrFkG9shgWkxpnrOK53CzgPda+VodsA8Lz0C0AMVDuhec/F+nxjtIPg==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:56c3:54ac with SMTP id pc10-20020a17090b3b8a00b001f556c354acmr15312731pjb.2.1661025517240;
        Sat, 20 Aug 2022 12:58:37 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:36 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 09/17] arm64: Add config for AMD Pensando SoC platforms
Date:   Sat, 20 Aug 2022 12:57:42 -0700
Message-Id: <20220820195750.70861-10-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add ARCH_PENSANDO configuration option for AMD Pensando
SoC based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 74e9e9de3759..4de253974544 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -225,6 +225,18 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_PENSANDO
+	bool "AMD Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based AMD Pensando SoC
+	  family to include the Elba SoC.
+
+	  AMD Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

