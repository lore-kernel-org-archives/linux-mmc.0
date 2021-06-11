Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6AC4743D
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 07:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0E660FF4
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 07:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhFKHxG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFKHxG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2021 03:53:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90062C061574
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2021 00:51:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j2so7231742lfg.9
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2021 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cuNXmPpzqFMD8TvtPMFEkUsp3qEPzEGNxmv7JPgaL4=;
        b=aZNBz3wjQ3bCk1aoPiSY3+mOUx5x9VV8dBiFQz46j4ZCz5nqZVQ4mPgmniF3i6af7Q
         IyTF7SbDpdWC1CyhitrZwlblRKTO/paLGnuCJuqSFjVkhPIG95C+3myB4Rb3dKtAb8kz
         96+aC1nUiQCzb3J+HvC34j40GR+HC/VcpxtIWQv8xuuwNwrjB9R6HzxgGJJPjpRvePl8
         UaLiG2S6nPrDUokW+PIwYPphpj2Owb1sp6AoRReKt+Wl4+OKbKcW7LevQzG90pwffW6Q
         4vuTqQtdHDter4AX62ZuObXLF6MkEvdb8E4JlyG50ZBPcgyyMIGviCIWYsAEeisjuJuN
         2DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cuNXmPpzqFMD8TvtPMFEkUsp3qEPzEGNxmv7JPgaL4=;
        b=drHqtnDWRBjbwgoYfKWuB9FS7IxfGi5jtRRGpikX/GK2mvjYbhRGrTAiHEnC5jw8QC
         VQ15QU4UcEI7JSte+Qnjk7zgrMFnY0CPHc6RB1eRMHENGQYyElHRl5+QfBqdYNsmf6SG
         3H9pMKdk8x8fn1MOLK4RzVzOSK8UW0G/AnC8KG1uBxUMS0si7vbdHIbPd5XIYhvUr8nD
         cp8jyRhlclI7yKjCKjKi2hF5aqtXrajsEQ7Rg+91gh21ayCvDlEfHRpuK5x21c+putJT
         4M8vYRbuN47vAQUKKBO9WD8YapJLuVOKAet2/zA/a8pJ3yFyQgnu5oK5EoY4g770v9TO
         vYDg==
X-Gm-Message-State: AOAM532iB5r6z8yrKDpbyt/5LH6Czhg5p0Rb3iuKLtBfjkfnNGnItFxf
        puYymlU0y1+Ih4BW2TlZUdeCQw==
X-Google-Smtp-Source: ABdhPJyP4OQaa36O2B2+/ZgQbDwBdwGzZD53zMHkIkyeWN5mM8PllibEwJ9EMRWbnrnA0rbiK5sCMA==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr1843669lfk.409.1623397866001;
        Fri, 11 Jun 2021 00:51:06 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id j26sm227788lfh.254.2021.06.11.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:51:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.13-rc6
Date:   Fri, 11 Jun 2021 09:51:04 +0200
Message-Id: <20210611075104.153361-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.13-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc3

for you to fetch changes up to 6687cd72aa9112a454a4646986e0402dd1b07d0e:

  mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+ (2021-06-08 14:56:54 +0200)

----------------------------------------------------------------
MMC host:
 - renesas_sdhi: Fix HS400 on R-Car M3-W+
 - renesas_sdhi: Abort tuning when timeout detected

----------------------------------------------------------------
Geert Uytterhoeven (1):
      mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+

Wolfram Sang (1):
      mmc: renesas_sdhi: abort tuning when timeout detected

 drivers/mmc/host/renesas_sdhi_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
