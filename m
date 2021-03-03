Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11619C433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D294D64F70
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhCDAAU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbhCCMWc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 07:22:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03FC061793
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 04:20:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u4so36778118lfs.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hA5MnWnH4b98jsrotQXDzoePbCFhv2AxGnot/fu2+EE=;
        b=DLlkMoi1+ZjRGJoWSN/yLilCPcqaxU21fi+/pyC8IcGigkQFRPgOgHmHopwpRolB5G
         ZnwXsVCsy4abkc8JEg+jOJXY7OBy2qaBFAwa8xRYIvW+3rBK7Qi7Kfh9M+h8B/WgiIlv
         76wOYf9NAOJAKSP1DmE1nxWL6FgT4dvwTRTK8/KHLEMZAGmnbBxYKmbO4WTX5xLL/lVk
         MOclwmp8259qTHietYbJ/oBgvdgJ7oFtdPmJ3Zq4BiUozx/Dnm1TwSFk4hSYuOUfgT0S
         Cwmj4CbfeBGzgqGa6boik1fbhY9WB6GZTXaQl4EyYoyzmowj1mYXbY1jIPOohoPeVlGL
         iF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hA5MnWnH4b98jsrotQXDzoePbCFhv2AxGnot/fu2+EE=;
        b=DvdzC7+Ab+RvnMY5PAMYkR926xldENbFfQqMIcd5Vjc3VYBUC66kWkljXyl/1L9ut0
         t6Kp+SchcJeUNl6fWtau4ux8L57FXA9LmudaxWSq8fiQdrYz0neXRPWJYbydBD6Z84H7
         6NWxbyhcXMiw9lbEjiIrDRMOIuelYLgMp59rK/nzH52n9lAVgOjBKrYuZKthD/SNeXoP
         6hjgwLJ1yROjuDlrKERoWN5If4YkRemE5py9qOw4Gff74wbjAZvXYjqWgyZuhbpijCTJ
         FwfT5QNRTn6OAvDKSCIkmFBGNiqYqKwkIBKUJjz/y0OSvdkXqY1DFZBYyHbPyHapXHQ5
         l/jA==
X-Gm-Message-State: AOAM533LhG6TiNezal+27VtXW8pTppKIlUgZQDoAs6KUSkfk/GH2TpCD
        kXXtcmEEw/bjG070Z/nzOTd3FhttpeUvZQ==
X-Google-Smtp-Source: ABdhPJyC8DmkA2DFtAwigbc46smsN7jy7jbnqc1TpM0VC+8BqYa6SmI9pmBOUwovZMnl9Zlt5Tc4pQ==
X-Received: by 2002:ac2:5149:: with SMTP id q9mr13810577lfd.619.1614774052598;
        Wed, 03 Mar 2021 04:20:52 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id d3sm811519lfq.249.2021.03.03.04.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:20:51 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: block: Cleanup mmc_blk_probe() path
Date:   Wed,  3 Mar 2021 13:20:46 +0100
Message-Id: <20210303122049.151986-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

While working on fixing KASAN splats for the mmc block device driver, I stumbled
over a couple of annoying things in the mmc_blk_probe() path. This series takes
care of them.

Ulf Hansson (3):
  mmc: block: Drop use of unlikely() in mmc_blk_probe()
  mmc: block: Simplify logging during probe about added partitions
  mmc: block: Fix error path in mmc_blk_probe()

 drivers/mmc/core/block.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

-- 
2.25.1

