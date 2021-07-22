Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30584C63797
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 10:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1577861264
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 10:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhGVJfx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhGVJfx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jul 2021 05:35:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542CC061575
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jul 2021 03:16:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 8so7662692lfp.9
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jul 2021 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eHLHjox7zsczggbpP2vHWZT/EIVYwJHBH0DP5HlM7w=;
        b=x1tO8OYnLwZb9nAwnXIGFPsFwfEkpHQOahGVKQx3T3T4EOWPDaOIYtJSrF9v2pwu5l
         mALJ9n3U2pTK+U5IUVgA4mhw8r9dg/WDfliPqylLqZkYDec+84JKimexugRtTNU9xGgy
         +1QM/d7Fo0KEiCSq5KBBVWSSWnYYzEBK60T6fRsMvy7xf1HN3IK8wL406Qr4X0iWaMMP
         K9QIyM7JO8WTabhUcHA7iQg7IhJI84KRKEMXPdo7lgYKL8jLyH9CBMQbpVWKKqTnnHrN
         LcQtthY7r5ovd4fR+rmTQMdTU9ckqBEgEMBQpoU6f+g1LP3TJ/KuQe/HXSS9k7OFvKSb
         PV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eHLHjox7zsczggbpP2vHWZT/EIVYwJHBH0DP5HlM7w=;
        b=NlxFvGu69/wGzHllSsqkHyTNr1GBkecdtniDhb/4x7pExq6MFDt6bS+4B6Drq0Vb/R
         W4pAHwIqLFytqUaqXyyFmtmmvhxHda+Q6tJ53czd4vSMM5Iu3+Bp9FWazusJVONuJpz0
         rdYbGnKqO9SJc8d7aT/PTbyvzRhzHju6ZfIi7iDd1G5HQC1zm5BJeLXR2TRcmgjWQN8L
         87mND+jy2E2LQh04YqQELEhNo6NygXDl0pMg6VHwr/U0zWE86WVb+nqcC5iCrACsppXl
         a6Rie3IcADGzIhlUTGy8C2xhOPmWvRJ91VLVgDb3jSRzVIr6XG6ENOIjMRHvpocLrO1/
         MYuw==
X-Gm-Message-State: AOAM530RQKImotSkMORUVKIi1MEWXdKUX7kh49mLBYYPWBovxWcfGTel
        tkdSisYax4cSguKgU8AXQYVc7DMlmNTMkPfr
X-Google-Smtp-Source: ABdhPJw9TizBuvUh6xSY0JKfIbezhc96UjLT7eNLSWjOA1hKD5sUDSm/1sdz2vsck9JjcbXqj9BpzA==
X-Received: by 2002:a05:6512:13a9:: with SMTP id p41mr28367918lfa.403.1626948977378;
        Thu, 22 Jul 2021 03:16:17 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id j15sm3053181lja.21.2021.07.22.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:16:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.14-rc3
Date:   Thu, 22 Jul 2021 12:16:15 +0200
Message-Id: <20210722101615.31766-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.14-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc1

for you to fetch changes up to 10252bae863d09b9648bed2e035572d207200ca1:

  mmc: core: Don't allocate IDA for OF aliases (2021-07-14 18:55:28 +0200)

----------------------------------------------------------------
MMC core:
 - Use kref to fix KASAN splats triggered during card removal
 - Don't allocate IDA for OF aliases

----------------------------------------------------------------
Stephen Boyd (2):
      mmc: core: Use kref in place of struct mmc_blk_data::usage
      mmc: core: Don't allocate IDA for OF aliases

 drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
 drivers/mmc/core/host.c  | 20 ++++++++++----------
 2 files changed, 31 insertions(+), 24 deletions(-)
