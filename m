Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A1C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 10:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1157E221EE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 10:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcuOWDRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgIKKCp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgIKKCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2020 06:02:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F62EC061573
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2020 03:02:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so11879880ljd.10
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2020 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eh1nUbbqqxmB+MKme978FO9UEGUoY3WguilYpMQusuk=;
        b=xcuOWDRbIDvw+1MEKspQA2iMxMTo9XEAUGy07DDQvqxP/VvpaWDP/aefC8l686YZqu
         iZYULv+YIEO++E7KXA5HYTCJy0h2+XPdQ3tHzqTPT1AQcSw3/htJZmGPWAL93Xm1NfJV
         zZWieoYB9vLaPGbgColBzNf8YhWm+gSYR+ImLeTcifhxsi82dO9f1AGHt5X4dLamlGjC
         AzEj923i+cOiO373HfWlaS1JC/IOi1rpp+pPnhVrSkRpLj02unZsKz9A87DKtO7Nfy+D
         Ymmc48R6E2DJLVSc/p+Aq0jOP9Hcvbr44laVgD8PZkv7B8D7q3noB0F9nADHR8/qJc/D
         CNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eh1nUbbqqxmB+MKme978FO9UEGUoY3WguilYpMQusuk=;
        b=rLvrd4UNRECs5QB3V+7b8dFPdCheTDQBAGcMDbw4xHEJBjX2vNP8u+3Wr6QSN1Shlf
         EXkZiinEaqLtYFZtlcsz27f4TwYloi1V4vbMfO1CEzSxMAfbSPUS56ny3Xp3NUSRUcfM
         HJI8AiA59UJIOhmuKNj1Iok62YfRxrWiF/ZtfYKVz4dyCmb7FcDTwxzTaS5V3buCcMHK
         pl+WzI/Okrt6DDaVulYODaqdB/Fr1YMdwyCT9lhS7gh3p4kG0tBw1qNzXb0wf2DMyTky
         9r9YkJph3SOVcwehehWfrl5wuR+VmUXuCn3cFVLrwci790K6YAWhN0svFsCR9HmZbw1u
         0qvg==
X-Gm-Message-State: AOAM53353dSAaOuTEehyYKmj2nGxN1nN94quNWHjqcqDmJPKI7YLgNoK
        DLS17xLsOJWF9qqwXLpXgVXB9A==
X-Google-Smtp-Source: ABdhPJxiBLPmP1E/qIaYCcGGeDDFnt0WmCiOBtVezSksq/cPIltEuXfNjvc2sEwBZkUelUcQKMgd3Q==
X-Received: by 2002:a05:651c:10d:: with SMTP id a13mr522824ljb.217.1599818556165;
        Fri, 11 Sep 2020 03:02:36 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-252.NA.cust.bahnhof.se. [98.128.181.252])
        by smtp.gmail.com with ESMTPSA id j7sm369179lfb.41.2020.09.11.03.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 03:02:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.9-rc5
Date:   Fri, 11 Sep 2020 12:02:34 +0200
Message-Id: <20200911100234.754555-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.9-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4

for you to fetch changes up to f0c393e2104e48c8a881719a8bd37996f71b0aee:

  mmc: sdio: Use mmc_pre_req() / mmc_post_req() (2020-09-07 08:57:44 +0200)

----------------------------------------------------------------
MMC core:
 - sdio: Restore ~20% performance drop for SDHCI drivers, by using
mmc_pre_req() and mmc_post_req() for SDIO requests.

MMC host:
 - sdhci-of-esdhc: Fix support for erratum eSDHC7
 - mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset
 - sdhci-msm: Use retries to fix tuning
 - sdhci-acpi: Fix resume for eMMC HS400 mode

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdio: Use mmc_pre_req() / mmc_post_req()

Chris Packham (1):
      mmc: sdhci-of-esdhc: Don't walk device-tree on every interrupt

Douglas Anderson (1):
      mmc: sdhci-msm: Add retries when all tuning phases are found valid

Raul E Rangel (1):
      mmc: sdhci-acpi: Clear amd_sdhci_host on reset

Ulf Hansson (1):
      mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset

 drivers/mmc/core/sdio_ops.c       | 39 ++++++++++--------
 drivers/mmc/host/Kconfig          |  2 +-
 drivers/mmc/host/mmc_spi.c        | 86 +++++++++++++++++++++++----------------
 drivers/mmc/host/sdhci-acpi.c     | 31 ++++++++++----
 drivers/mmc/host/sdhci-msm.c      | 18 +++++++-
 drivers/mmc/host/sdhci-of-esdhc.c | 10 +++--
 6 files changed, 123 insertions(+), 63 deletions(-)
