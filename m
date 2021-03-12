Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3BC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151DB64FE0
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhCLLCy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhCLLCl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Mar 2021 06:02:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F3C061574
        for <linux-mmc@vger.kernel.org>; Fri, 12 Mar 2021 03:02:41 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v9so45092632lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Mar 2021 03:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUkWWP7QtoyKW+p9PVjEC7J9wcMKoCcktZeNogcq/VI=;
        b=W2jGvcdU20upo5UDCNpO+C2xU5sJJgj/WjGt/U/+tBGOkMgJsUWGnMq4q53K11RwC+
         CND6msi+RrkBF3A7rM4EqHb4660MCEd9LIBtRpkykSkJetAEb8Yasl1xelzIiiznekMJ
         MvHQWCzwMX1OhnZzLQxMzPAPrFDNp1gsOo9AS7c9eaDKaFQBy5epYU/qIPoV4BMEeH59
         3QYBQGsGht7h6gV+J5Na81fARuw/fiHFRzZVia/xNcWcXLLiRoRu2C0zRZEI7w4/rQhA
         bZxqceuAPF9cZPd3aQb26bHTglVpixSRV0WobQYEgjueV6eRctvEfk48b38b/KbaMpIx
         I8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUkWWP7QtoyKW+p9PVjEC7J9wcMKoCcktZeNogcq/VI=;
        b=qEOzipfzhXLMfiI0bR0eu0lmEswPzKtqTYNcnnmQCS4xBDF/rOpth9a2BbOUcbS+LA
         KsMKDd5LfnNeLieGXVRgDFGkaJ3MKLLLoy4OJqJcFE3Uj4rExKrD1xgQStslCfDwBQnX
         Ti1WNpjTMGvDVc5hFXtRhJ2/muN/ZvgO/Jrf1xbn+QLa5FEWMy2SGUazt10TROqSsTs9
         MId4cDUWZmyXANZl51V6sA9BRh/2yWJlmERU+2aLflB6lhpVRGCreq/weq4vyfk2TWFo
         gUl9V4kge5n9k9NReibC1R5HTchqxWpzG3KdejwHlTB8WKkMnjQ6+L7nSmb65YbWG3wK
         hwNg==
X-Gm-Message-State: AOAM531ZG9YUBQwbQAxCmBPNjtZ7ajAHIKJWic4VIuB/Zyz9uvrCW/hU
        qVPFscgLM0ZzCb0fVUCryy9KuQ==
X-Google-Smtp-Source: ABdhPJzOz/wOTBs9Q4k/78L4//AFn4BXGSrmYePYXZnvasIVMMl3mFJmCIu8CQfTYK32QMl3fzCamg==
X-Received: by 2002:a05:6512:acb:: with SMTP id n11mr5013428lfu.288.1615546959825;
        Fri, 12 Mar 2021 03:02:39 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id p13sm1933647ljg.116.2021.03.12.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:38 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.12-rc3
Date:   Fri, 12 Mar 2021 12:02:37 +0100
Message-Id: <20210312110237.174917-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.12-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc2

for you to fetch changes up to f06391c45e83f9a731045deb23df7cc3814fd795:

  mmc: cqhci: Fix random crash when remove mmc module/card (2021-03-09 10:00:52 +0100)

----------------------------------------------------------------
MMC core:
 - Fix partition switch time for eMMC

MMC host:
 - mmci: Enforce R1B response to fix busy detection for the stm32 variants
 - cqhci: Fix crash when removing mmc module/card

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: core: Fix partition switch time for eMMC

Frank Li (1):
      mmc: cqhci: Fix random crash when remove mmc module/card

Yann Gautier (1):
      mmc: mmci: Add MMC_CAP_NEED_RSP_BUSY for the stm32 variants

 drivers/mmc/core/bus.c  | 11 +++++------
 drivers/mmc/core/mmc.c  | 15 +++++++++++----
 drivers/mmc/host/mmci.c | 10 +++++++++-
 3 files changed, 25 insertions(+), 11 deletions(-)
