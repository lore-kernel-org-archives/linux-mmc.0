Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEE4C433E4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 11:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0752067D
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmv062P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGXLJq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLJq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 07:09:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E9C0619D3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 04:09:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r19so9519883ljn.12
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/KD4aKU1LRGZHLPLJ0VWv8tqMriXUQc32LrDiAo5nQ=;
        b=cmv062P8gVKgR1Bf+VENef/dUn3rWKwpQ9VzCk0ClVmGMWD9SAPor86aqoCEtU9UvR
         T8dgYBGx6kC2Antw9orTdIatEw5aIIBph+495swIXL+RhwEfLPUV/tu2+0xYQdjSyFRL
         D702OOeqkFjs4trf5oC94hweZZj2lBDJUU2aFj39tiW0/kXJ+aoHmIyb6UiSU+o7MiIR
         qpY/f9vamyezqU9kvCsBpEEc/bd0L9Nh+nyyb8KhJNy+kQls0C6GMc2Q9JttFi3Abhfi
         V3tU4/GK8uDvV18fm4OA97urCAnLktxfj5Z5Oz0IAlsNm/0HzDY1rFiEVdyXIAzK9FPc
         tJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/KD4aKU1LRGZHLPLJ0VWv8tqMriXUQc32LrDiAo5nQ=;
        b=ci25Xe/B5iWrTy2lOY2QiOH+zpl8fKsEljuCf9wXa1Abc3CNXsSvR38lt9E3/HBtvg
         hzPsq8aawdLuoBdOw7QwAzzt3zn0TtebfWmHUb144IvtzG3vnEH3iOgyIEkgam51CDuo
         3CmqfS2nFQOxIKNr/5BMHtdsYJkgAbgKUFMXGPNMGIZ4WsG9IkHTqTvJGkbDFtX+zHDJ
         /cPLeL5cxq1xrXH42el70IfdJp6fBFpaBGZVm7EQ2ouMy+mpH9YL5s4eoHhhYKw/iSLg
         SVtLgH2wRNIh36bE2YwEade2100t4MdV4CUcFsjRX2UreQeQVSr6QME4ORzSZLIGurkz
         i03w==
X-Gm-Message-State: AOAM531IV+wPline3OxnfQ6WwkBzd0aAAjAnE6C4wGAVExDwWXLJJDK4
        XxvVtUxLB9mctWwXjvVkSZE2CA==
X-Google-Smtp-Source: ABdhPJwjIntbFc6Cnszefa8g4lKKgiHzXBlivUuJD/YmGzOA1aKsOwmCBFEzyDfJSkMyEbSYUtzXzg==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr4119214lji.129.1595588980813;
        Fri, 24 Jul 2020 04:09:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id v3sm169165ljj.110.2020.07.24.04.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:09:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.8-rc7
Date:   Fri, 24 Jul 2020 13:09:39 +0200
Message-Id: <20200724110939.8934-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.8-rc7. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc5

for you to fetch changes up to ebd4050c6144b38098d8eed34df461e5e3fa82a9:

  mmc: sdhci-of-aspeed: Fix clock divider calculation (2020-07-13 12:17:34 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-of-aspeed: Fix clock divider calculation

----------------------------------------------------------------
Eddie James (1):
      mmc: sdhci-of-aspeed: Fix clock divider calculation

 drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
