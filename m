Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A6C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Dec 2021 09:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbhLJJ6K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbhLJJ6J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Dec 2021 04:58:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95143C0617A1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Dec 2021 01:54:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so16947733lfs.13
        for <linux-mmc@vger.kernel.org>; Fri, 10 Dec 2021 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8N1QoomSDHcA8D1T8Tv1TTr0YRk/oLQcu27sC+kmuc=;
        b=XkCisJCEtNeNlUcARJfgK8lAUuGTX8V0RgWLLmy3rHtYvOWlNVSS7bF29eAp/RCADg
         SD9iDqH2813CT+2j0foeTTgPFKqpQgcHrUsViWgXSnI755Uki2fIkHlyjAX0BBXNYtxG
         PaN+zPU1HH7o92dXwLpFfFUMKlqdDV9cpEoBeRZ8DkwP4O2yatG0eC7y3kS5BOvlW1yy
         XlfEnD1pPgg1fsO5KDPLoe3BAGSxtX5oZKbS2989ELBN1cyN9eTpU2PwL2lr3IeYyeeP
         brzbRriIg+nyxCRjQAF4qIExrLAJK+8ISr8tPsuKD/OubSz+jAbbORv3oYQ9YGjTmzP0
         UKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8N1QoomSDHcA8D1T8Tv1TTr0YRk/oLQcu27sC+kmuc=;
        b=et2CoDSRcUMO8ZVLcZWATvKv2ar4SedFsgI686spWZ7Az5Aj/71ukZux+ywcualJSZ
         TR4XD9gzVK+Pv1a8LQK7taSmF5U6DxQLRdoPGu2qemb63LxFLuj90EHv49Tz53Yl+AVG
         DDc31D2pPFlS4ykujfNZI8Wy9Gw0SAiCHhiUlcxllAQvjVIC6Mx3Zxmi/Pe/5LDY1zcZ
         0Zyi+BScreE/qnv/WT3dtCKN6b/NX7Ryxsdhet3tm7lz4VzFQYpJVTJYFuN4XCcSlhpS
         mN2fMz3n8mQYciVE0eUbkotZFm8FlT+MIbNkbQHJjYzc5sb+2Cxp+Y58E5aaWUu35iW3
         U9AQ==
X-Gm-Message-State: AOAM5301G3Pfrh8qBPijqiUHM3zgtVflWzv/TR8vTR0CksBK/XhkApqP
        ITUAbvKThhzQmRkEYZR+eSJb6w==
X-Google-Smtp-Source: ABdhPJxMtCRcg2pLipCeOwRT+EWiXBB1vSlr3YCbOx9Y3LWEahEOmkN4UttF75CaFKwSXPdc/8bb4A==
X-Received: by 2002:a19:c352:: with SMTP id t79mr11305464lff.251.1639130072797;
        Fri, 10 Dec 2021 01:54:32 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id h17sm262875lfv.62.2021.12.10.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:54:32 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.16-rc5
Date:   Fri, 10 Dec 2021 10:54:31 +0100
Message-Id: <20211210095431.63667-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.16-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc3

for you to fetch changes up to d594b35d3b31bc04b6ef36589f38135d3acb8df5:

  mmc: mediatek: free the ext_csd when mmc_get_ext_csd success (2021-12-09 10:30:11 +0100)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Fix memory leak during tuning
 - renesas_sdhi: Initialize variable properly when tuning

----------------------------------------------------------------
Wenbin Mei (1):
      mmc: mediatek: free the ext_csd when mmc_get_ext_csd success

Wolfram Sang (1):
      mmc: renesas_sdhi: initialize variable properly when tuning

 drivers/mmc/host/mtk-sd.c            | 4 +++-
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
