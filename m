Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13594C56202
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 10:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947E022226
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZCQEwHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgKTKuM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgKTKuL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2020 05:50:11 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CCEC0613CF
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2020 02:50:10 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id e139so12835574lfd.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2020 02:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui6T7CKVZyX5zdmfFixy92Jf09nez5RkHLtV0WeJzY0=;
        b=dZCQEwHNsskYy5D8AIWz2qi45Wcs2Z4e3xfY3hTUk2tKBatAOnviRmerOylIfPKZEl
         /Sras5siDr0dT01k0si+JSuJfNxrBSOan/3ulR3lp6WVXjas4lKdolIUMWkEgr+t/sKH
         Bu5Wpar/LnDEmp3pRRoS1IPMrlnXYL0JrJxCjjwNjhU5MecV0Wocrf/oMq8w9w819L8F
         pJ4ICNTExU6+CoHAtxrWcemC2eS/5oFioel086QvUSOwl3lJIFTJwSL2FyqSGfKeCW7Y
         0GKUVaw+lhVvpByWp5qUkIpLZXw6w4k7RblCsT/ihZomp82v6bcW4DQQTxyEHaKcAYZC
         /WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui6T7CKVZyX5zdmfFixy92Jf09nez5RkHLtV0WeJzY0=;
        b=kD/LBX24T3/+9UQVbBo8xTend9mYlCYODe90+ZXdzvZjONo4NzifKyUMl3KECrfZy3
         7cIcMYzSH1Z+Q9IOjHbBwXAxQdkzTX2z7luTuR8Gab53zjrhCsVTv0bn3kgH8cXOiyUk
         dl20MG/5TCMTizjid/OMn0bOG8jhuWWSHvK9OUdx8T04fQJa0enCKEoyhYkrN8miUQ6u
         WY30DMigXhonoRW//lSOdGk/DyckzIIIDeC/LoOLVn80xms2vCbA2A6hJnrArvgCgFYS
         koKdKJjS+ro9+I0iGsTQyDxSJ/1w/2ImcNZgg8/vi9a28l5L1I6Etg0v+w4NtB2AQN4D
         T0gg==
X-Gm-Message-State: AOAM533MCANZwQGnN4LSNWLRDY/+cgvS0rkBd9C6ww3f0OqDyGFvCO/S
        ggDUiCKSnVkkIoJeg+Hmzt78sA==
X-Google-Smtp-Source: ABdhPJzq8ILTQ9yBLCQ/f9XRy5F3bqzu27ePwvgzTE82Is2/Rk36zeq42qf4V6XmwUJhiZ2fyx6zcA==
X-Received: by 2002:a19:5c7:: with SMTP id 190mr8263208lff.467.1605869409385;
        Fri, 20 Nov 2020 02:50:09 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-251.NA.cust.bahnhof.se. [98.128.180.251])
        by smtp.gmail.com with ESMTPSA id 13sm313017lfy.90.2020.11.20.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:50:08 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc5
Date:   Fri, 20 Nov 2020 11:50:07 +0100
Message-Id: <20201120105007.8184-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4

for you to fetch changes up to d06d60d52ec0b0eef702dd3e7b4699f0b589ad0f:

  mmc: sdhci-of-arasan: Issue DLL reset explicitly (2020-11-17 12:44:44 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-of-arasan: Stabilize communication by fixing tap value configs
 - sdhci-pci: Use SDR25 timing for HS mode for BYT-based Intel HWs

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode for BYT-based Intel controllers

Manish Narani (3):
      mmc: sdhci-of-arasan: Allow configuring zero tap values
      mmc: sdhci-of-arasan: Use Mask writes for Tap delays
      mmc: sdhci-of-arasan: Issue DLL reset explicitly

 drivers/mmc/host/sdhci-of-arasan.c | 51 ++++++++++++++------------------------
 drivers/mmc/host/sdhci-pci-core.c  | 13 ++++++++--
 2 files changed, 30 insertions(+), 34 deletions(-)
