Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2308C07E99
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC67613F7
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 10:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGEKf3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGEKf2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 06:35:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B81C061760
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jul 2021 03:32:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq39so19034382lfb.12
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jul 2021 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYZpVwbfMVbx6/fArrYjrJ15D0k3jdBPYEWHCYqTbjo=;
        b=U7C1hslnJQyOfy306sXVLA+OS9YyZH+ctC0OqDgCzZLbWD3UmAiJQUUAs9zSPrJSRW
         NlJ6eTJRMGvxxb9dqQaCFGOTQMH/u7sJrJ/dQjidVJuXSGz8W+Epq6DE/36OAdNIkz3k
         tRX7RX7+o5zD+PBIGbXybl3/o7Zz0QiyVXovwWH42rJf6ifoNVAkfUioQXgLxa+dVoSL
         yAM7NTyff5sFoogkLx1xSefMnC5kcnana6CgLvUR/h05qFmgBIK90CKao8ktxO8Ja4KS
         u2I6td6gh2q9FdRbr8FSvMjnN8hIG+KVbRTrsVIhdnvr2MyfSY6GUsIvwgJCwzxkSpKL
         h/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYZpVwbfMVbx6/fArrYjrJ15D0k3jdBPYEWHCYqTbjo=;
        b=H5LLWqTafkZJn3wVOOKYNyMdkSvLCj6lptbhr7kJdFd/Ccb5kuaDKpgOkMRSBTmNQc
         jbwQNK7P+0EpSncQd3pJN+b7EhPzXiljIsZFbRVnpZsQ05oKiZhsO8xY4f8f28NZwxNh
         lGABe2J7QwRtNdWSX/+gvkZ6SSa4DOgIa+uWMFxfxXCo9JMhaRSeNwCwFnqXqZxw7mKU
         Rn6GlGKGt8tVOrBUKOFhzMl7OGoN5p70Apjfa3Sa4sLLfGlXjh5CJyu0nL5ehfYyEYAS
         tvowPx4qLY8FMm3uhpUIbztHefWogSDQZzo+jUU60PFpcn0nINrj55e45A1ciyIRldkT
         KwIg==
X-Gm-Message-State: AOAM531xSKUPXS7ZfS0CYSIIhqnzsk9M9SzpOBiFK4mmXDdN1MhM1U/x
        P5SWcxcLi8QSCSVrdsWktJeITA==
X-Google-Smtp-Source: ABdhPJzVMP+7krxZlOZ0s0aPMV4he6kHPqvw4QgGuPeFhb+EjLSfLWUKhYesSggPN5ACyFLTuYiqlA==
X-Received: by 2002:a05:6512:b92:: with SMTP id b18mr10141323lfv.11.1625481170316;
        Mon, 05 Jul 2021 03:32:50 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id e4sm1276031ljn.100.2021.07.05.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:32:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.14-rc1
Date:   Mon,  5 Jul 2021 12:32:48 +0200
Message-Id: <20210705103248.7811-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a pull-request with a few updates/fixes for MMC for v5.14-rc1. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c54b245d011855ea91c5beff07f1db74143ce614:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2021-06-28 20:39:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-2

for you to fetch changes up to d0244847f9fc5e20df8b7483c8a4717fe0432d38:

  mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode (2021-07-02 14:59:51 +0200)

----------------------------------------------------------------
MMC core:
  - Clear flags before allowing to retune

MMC host:
 - sdhci: Clear unused bounce buffer at DMA mmap error path
 - sdhci: Fix warning message when accessing RPMB in HS400 mode
 - sdhci-of-arasan: Use clock-frequency property to update clk_xin
 - mtk-sd: Fixup compatible string for MT8195

----------------------------------------------------------------
Al Cooper (1):
      mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode

Rashmi A (2):
      mmc: sdhci-of-arasan: Use clock-frequency property to update clk_xin
      phy: intel: Fix for warnings due to EMMC clock 175Mhz change in FIP

Takashi Iwai (1):
      mmc: sdhci: Clear unused bounce buffer at DMA mmap error path

Wenbin Mei (1):
      dt-bindings: mmc: change compatiable string for MT8195 mmc host IP

Wolfram Sang (1):
      mmc: core: clear flags before allowing to retune

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  2 ++
 drivers/mmc/core/core.c                           |  7 +++++--
 drivers/mmc/host/sdhci-of-arasan.c                | 14 ++++++++++++--
 drivers/mmc/host/sdhci.c                          | 10 +++++++++-
 drivers/mmc/host/sdhci.h                          |  1 +
 drivers/phy/intel/phy-intel-keembay-emmc.c        |  3 ++-
 6 files changed, 31 insertions(+), 6 deletions(-)
