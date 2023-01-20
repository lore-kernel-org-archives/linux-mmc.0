Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68990C05027
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Jan 2023 10:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjATK12 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Jan 2023 05:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjATK10 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2023 05:27:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87990B2D25
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2023 02:26:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt14so12803245ejc.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2023 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSUR+eB/n+Ie+HKL6NSribhGI7dhtvVP+defqFNYRAM=;
        b=QKsY/7wYUgsJxy1HNf2+uERj8BevvCeoNTPN4R0AbHEk7IIBR50jbMAXQTomKwnd2U
         bj4zCTNIyUObTakzJvvqzQ5yDNf9GI0HhaYZ4yBx1qd3Zj/kJh/4YCjPswuub/NHBxT6
         YoPLwdbhCVosqoAOMSQVA3N5MXxRjRbvqVuUfWbW3IR/5sFBdbAs61oWX9BC/6PrnmWW
         TEeZeavbDNcnksGHGghizOxIdokZlISKmeRAhKcRG3Q/KHoQKBDYI/I5cy1xmxGS41nc
         gV31my49APblgoAv6uJj17u93AuNJSPPe1Jv9KSzLgaWXQOdtqZdr2m/l4pQYkM4NSOO
         teWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSUR+eB/n+Ie+HKL6NSribhGI7dhtvVP+defqFNYRAM=;
        b=n/9j5x7RjUpjIHjJSNZHevQbee0Ds4hzGKzpQQ6VMH4PtLCnKkn2NLJLTHdoaUtni8
         SrTCAYoCo7qROzT6X9bSrZSNGKNHfKpQdpL0EdCBRmODTN3yiAx6hgngcUlj/JOJJQaU
         H7Dty+RDwBLQK5tajqRGyoBZG/PJ7kWZ71PABB1bVpDMHodS2xZArPHFQQS52ueZug+u
         uffOH6WNnclgS+v7GwaLE7LWpfTQipZT2TgFDMVlbXiNZtwwZU0fRF6M3K4EFiBuO7g2
         xp3Ue/ZZFTbBhFGs8EEfKp5NSOZmWgUHKrYY4+Jk7l8z2Geq/grqeQJMri69GeHxqhek
         zevA==
X-Gm-Message-State: AFqh2kp5tyIWGGuaHNBw2jjfpY1saIm5R7hY1JbRHfl43hzxvKaxyuRB
        CqfcH8tBtNP3Y+1UHEt1NQfdRg==
X-Google-Smtp-Source: AMrXdXtbaWbvW0Lei/lXUMUulEmS7v+iToBg8DvXvqXZeCh2Axm6rk0GP/LQu3Ne50FPFovW2RlitA==
X-Received: by 2002:a17:906:3a4d:b0:873:393f:1bda with SMTP id a13-20020a1709063a4d00b00873393f1bdamr12359798ejf.47.1674210416817;
        Fri, 20 Jan 2023 02:26:56 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm17830862ejf.179.2023.01.20.02.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 02:26:56 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.2-rc5
Date:   Fri, 20 Jan 2023 11:26:54 +0100
Message-Id: <20230120102654.113502-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.2-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2-rc2

for you to fetch changes up to 8509419758f2cc28dd05370385af0d91573b76b4:

  mmc: sunxi-mmc: Fix clock refcount imbalance during unbind (2023-01-02 15:57:36 +0100)

----------------------------------------------------------------
MMC host:
 - sunxi-mmc: Fix clock refcount imbalance during unbind
 - sdhci-esdhc-imx: Fix some tuning settings

----------------------------------------------------------------
Haibo Chen (1):
      mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting

Samuel Holland (1):
      mmc: sunxi-mmc: Fix clock refcount imbalance during unbind

 drivers/mmc/host/sdhci-esdhc-imx.c | 22 +++++++++++++++-------
 drivers/mmc/host/sunxi-mmc.c       |  8 +++++---
 2 files changed, 20 insertions(+), 10 deletions(-)
