Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964D6C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4EF61056
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 08:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhJHIrG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Oct 2021 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJHIrE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Oct 2021 04:47:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1918C061760
        for <linux-mmc@vger.kernel.org>; Fri,  8 Oct 2021 01:45:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so36609507lfa.11
        for <linux-mmc@vger.kernel.org>; Fri, 08 Oct 2021 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kt2zeS8aw7UOEZ6UIIHWzjYYnKYswwjSSwV1Raxj+m8=;
        b=fTfPNAJ5Cgq1rDMNmAMyd5mDbrysDz/ytlWtUV45dO3zjXDMHMp90D5WNdtSMFyek7
         JoXip2UNiYzW6vU9UEoYArzBXBTu8Idi0B19hue3jzH5Ii8rkR8QJkvDrH0auuIDhqTm
         +QsHn2+DDmuMlWEsrcmZz22zIj1/sgIVSroD8RzRE2JjvPWoLOa0hvSDLQz0mL2og7Zq
         eKId3iiMm+kql6bK6BLyM/XH25r4zzpK1ibfffX3K04w4kvlJnGj14BFkoj0bneeKngQ
         e/tRPYS4i+4pAa67dBMvB8Km+CUk+FZVewgAgXfnkbY1A3YTG+SFhkLpFbsAIlgd3Y4J
         h/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kt2zeS8aw7UOEZ6UIIHWzjYYnKYswwjSSwV1Raxj+m8=;
        b=nuX2gvmvhOLa4rxnBT/gl8N7u5u1uBFOxYA0Z0Ux4HDPTGLXaPgMqXuJPOcQ6GkZzq
         NxBHqW2eNH4Tp08L5DZSTNfRnM917caF4ma+43lGMzVA2Wv+TnPFTPEgQvmQdbKvfpN5
         rY012YS/Pkh7MxqbafPS+YvbqRS/xKrM8cv9B2JATMOOhIUT7O42q8nIs3PCQ2peydPy
         XVwS21+sbumzXmtVyg7+6PnhoDuQFrt97a87a6wIA9saZIdaazoM5EZ8cUz0nE+NkEEY
         jJox49XBGPRsqscdC9QPumWTQwlCBpqLWb+fosGB3C4G39LQHd0AR9wakF70GEWk5Lme
         jFnA==
X-Gm-Message-State: AOAM533S6p/Tkxb+XNun4jMHmBjRyRo/FKd7fgk+edCtJOJR6XsYDjmh
        2n7/0zqD2/8123mYshKb+PlLEQ==
X-Google-Smtp-Source: ABdhPJwrtpQdAJ79EajjX9Yv8er2FlDFohRG70iBpVkmrPgMcTjYV9LLJ/a3T2xsfVopSXy3NUB6iw==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr2205874ljo.326.1633682700097;
        Fri, 08 Oct 2021 01:45:00 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id h2sm186649lfe.134.2021.10.08.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:44:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.15-rc5
Date:   Fri,  8 Oct 2021 10:44:58 +0200
Message-Id: <20211008084458.30104-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.15-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc4

for you to fetch changes up to 8a38a4d51c5055d0201542e5ea3c0cb287f6e223:

  mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk (2021-10-06 17:23:28 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Fix read/write access for dram-access-quirk
 - sdhci-of-at91: Fix calibration sequence

----------------------------------------------------------------
Claudiu Beznea (2):
      mmc: sdhci-of-at91: wait for calibration done before proceed
      mmc: sdhci-of-at91: replace while loop with read_poll_timeout

Neil Armstrong (1):
      mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk

 drivers/mmc/host/meson-gx-mmc.c  | 73 ++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci-of-at91.c | 22 ++++++------
 2 files changed, 70 insertions(+), 25 deletions(-)
