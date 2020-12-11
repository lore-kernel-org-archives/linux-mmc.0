Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A67C2BBCA
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEE323F57
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 08:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437227AbgLKI5d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437223AbgLKI5a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 03:57:30 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8FC0613CF
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 00:56:43 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id m25so12277733lfc.11
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gloM2T2ytwyUj9mw0BbcdmsyAq0N53F7iLnhz3YRDo=;
        b=xi7RNWckbmr6CRXwoyierGqRYmJyCzHui6XnK1w2uv8z79VBmCeaGOVcfnUDrnBskf
         zC8qwUx/abwLjFAJvi8XOjGWEcEeNCNNsIw9VkvJ60xtrx6T/tVcsseecm90B68hjnbJ
         Un9Xg5cVRZ1l6nWLRDMm3+dP01kkcTbTlHO54yAjWGgzm4YePrdCkwKqbfswtXh4DbKs
         jEgrhrc3jaDe2GIH54R6rnhp34h+okoYqZa9GOyAhJxvtZhitAWNVfNi6WSeiZYnw6og
         WPiuWG+me+DpDEUf7VUNioWVU7ZLxVCwXXghcBmL2HNAEEdzH9Q93RFR0rkt24tmidL+
         BmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gloM2T2ytwyUj9mw0BbcdmsyAq0N53F7iLnhz3YRDo=;
        b=VxE+i6av20EkJI5kYyBtBAukEkUO05WCg/5E93uTXOanAKk3a4rEw9AQvC1+ZAONOW
         9vwyJxnw8HNDY5uqjgcIXRdCw1MerHwH1O/Wqy/QUBzYeaCWQyMeWsM+9hNdokwwg7+N
         4B3Y/H9sAF5+nkV07xx8Mn5PbOjru0vXGQhYK22nYRY2xMfpo9z8pDFe2b1E/UkwgRhX
         pHj0j0FBUMcBhgLJrYqMyHKPi1RFqLVVY7qCJky/KeaGRe1Krrup/Hl9Diiji8u6dtNw
         i1SX7HKPD0SHXuIWTvvblKTGEFsxi1l/C42f9YhGPAh+TWSObpSRYENd+1CO7X2rgbpW
         w1WQ==
X-Gm-Message-State: AOAM533u0MCpF6+fmIBQ2ko1ri/nwwpQtOllcuAP052YWd2POx/HFDcu
        rOipJLRYsukzAqJl0ihWE1iw/Q==
X-Google-Smtp-Source: ABdhPJxenfhBS5LaX+OydQLlgTw/3JR3lCKOpzxn08h4EeaJjncY+IRLxBvsjjBkyJkV76PQT4hfFg==
X-Received: by 2002:a19:a06:: with SMTP id 6mr873535lfk.624.1607677002443;
        Fri, 11 Dec 2020 00:56:42 -0800 (PST)
Received: from localhost.localdomain (h-155-4-133-162.NA.cust.bahnhof.se. [155.4.133.162])
        by smtp.gmail.com with ESMTPSA id 186sm809087lfb.176.2020.12.11.00.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:56:41 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc8
Date:   Fri, 11 Dec 2020 09:56:40 +0100
Message-Id: <20201211085640.234657-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d06d60d52ec0b0eef702dd3e7b4699f0b589ad0f:

  mmc: sdhci-of-arasan: Issue DLL reset explicitly (2020-11-17 12:44:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4-2

for you to fetch changes up to c0d638a03bc5dfdb08fb95d0a79ecada25f40da8:

  mmc: mediatek: mark PM functions as __maybe_unused (2020-12-04 15:35:54 +0100)

----------------------------------------------------------------
MMC core:
 - Fixup condition for CMD13 polling for RPMB requests

MMC host:
 - mtk-sd: Fix system suspend/resume support for CQHCI
 - mtd-sd: Extend SDIO IRQ fix to more variants
 - sdhci-of-arasan: Fix clock registration error for Keem Bay SOC
 - tmio: Bring HW to a sane state after a power off

----------------------------------------------------------------
Arnd Bergmann (1):
      mmc: mediatek: mark PM functions as __maybe_unused

Bean Huo (1):
      mmc: block: Fixup condition for CMD13 polling for RPMB requests

Muhammad Husaini Zulkifli (1):
      mmc: sdhci-of-arasan: Fix clock registration error for Keem Bay SOC

Wenbin Mei (1):
      mmc: mediatek: Fix system suspend/resume support for CQHCI

Wolfram Sang (1):
      mmc: tmio: improve bringing HW to a sane state with MMC_POWER_OFF

yong mao (1):
      mmc: mediatek: Extend recheck_sdio_irq fix to more variants

 drivers/mmc/core/block.c           |  2 +-
 drivers/mmc/host/mtk-sd.c          | 39 +++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci-of-arasan.c |  3 +++
 drivers/mmc/host/tmio_mmc_core.c   |  6 +++---
 4 files changed, 35 insertions(+), 15 deletions(-)
