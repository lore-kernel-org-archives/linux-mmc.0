Return-Path: <SRS0=zmAv=DQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB593C43457
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C18B22248
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 06:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/8L3F+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgJIGqG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Oct 2020 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbgJIGqG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2020 02:46:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47362C0613D5
        for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2020 23:46:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so8494515ljn.13
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2020 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lmm8Mvi7GzJTrg4u3PucBYSDr2MfUiIacXtIFkPKG30=;
        b=k/8L3F+yzEPMBGI+i7o6ClamzlIznfZD3avEgWSxszNFZEYRtjH1GgLtlYaDXRRnCa
         TV1DjQZVOMim8NP8+jVEGGPYGaFla4E2HOSFs1GAQ3534bJbm2asY/Dvsl0JIshWuwfI
         MLGufU41s1DuJAdqZrsGRQEQa3mjE9O3OFKbPMXFldDD/H4rKlvmtfHKWpsk5LQjJyL8
         cd2+l5Jv+Os+8YVHVM7PPPGhGhbJmkm0bCgaZGsY3R+Du7WQbGWopjX+lg5yrTtYRtim
         fnzMmBzZdu7ZmAdBkszT/V0K/LZ0Pze5sHeE1oiHWNyyp3SosRuMDiB28FnH1ujgZbe3
         TMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lmm8Mvi7GzJTrg4u3PucBYSDr2MfUiIacXtIFkPKG30=;
        b=sOicX5mAgF0ZiaY7TwC0upZHIzPsR53yRRg/DhgkAvs4WaJ+tUeg/y5bMlXfSPRerG
         3mUK8AZGf/X9l4DUiCNKGqGD8YPMirBpXRZBCM/jK52B/Sgnq5PKxyamH05Fcg462GN0
         xovGtxbW7ogRAikV4oB4HwYK1PJxnxaZkIqD60cKxFkLDNH4t1zDR1ZCsBWNM7h9k1j6
         eXE0+pCqPcbDfMIkhEBwzcYEuecfsbIL/fZIXJtRmfzq3lPbuTUAyZ6VTLpWenkJKHsc
         MbYIwRHHaG72TqUcXYXQL7eiQf9NaG32IHj0eunA78xF05x3SRkKT7tCzrP8acYYEFhY
         IEXQ==
X-Gm-Message-State: AOAM532zdVpa4pRTCgn/KORZbPpBSzzg4a4ilp8vQWocIO96i+QOzPHD
        DNmusGKS6u9Ot3sf2PryvqAriQ==
X-Google-Smtp-Source: ABdhPJxy8pKGr0/o7HKnmC636Ij70ZV/MDIjtW2WR8hYsa6WuPSfrEzWwFPXn/xuoSzIh+r+N2SnJw==
X-Received: by 2002:a2e:9b96:: with SMTP id z22mr5008967lji.181.1602225962491;
        Thu, 08 Oct 2020 23:46:02 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id b66sm1271374lfg.153.2020.10.08.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 23:46:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.9-rc9 (final)
Date:   Fri,  9 Oct 2020 08:46:00 +0200
Message-Id: <20201009064600.335065-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.9-rc9 (final). Details about the
highlights are as usual found in the signed tag.

Note that, this fix didn't get the time to cook in linux next. Although, the
patch is trivial and also well tested by the people being involved.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit afd7f30886b0b445a4240a99020458a9772f2b89:

  mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models (2020-09-28 12:16:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-4

for you to fetch changes up to 4243219141b67d7c2fdb2d8073c17c539b9263eb:

  mmc: core: don't set limits.discard_granularity as 0 (2020-10-09 08:26:09 +0200)

----------------------------------------------------------------
MMC host:
 - Assign a proper discard granularity rather than incorrectly set it to 0

----------------------------------------------------------------
Coly Li (1):
      mmc: core: don't set limits.discard_granularity as 0

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
