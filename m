Return-Path: <SRS0=VXdQ=EF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC89C00A89
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047CC2076E
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 12:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="By0SXtM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ3MIC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgJ3MH7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Oct 2020 08:07:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED59C0613D4
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2020 05:07:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x6so6623997ljd.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2020 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWl6kkg5Q6VUV9xC9388CJRuaSl1dYHpzCndnob9kB4=;
        b=By0SXtM4SXWxM2wU8asEz1qFRuwUiKgBv8vGy49bbCERVMAdtch2iRW6JJydatEryU
         VoiGk06sr1rzNJD+QePlUkQ0lTbwVzoJsL2jDBgjlT5555GSEKNsZ1wB0FjTFk8g8nZI
         1crvgs7RPEYf2mQuH61gDt1F76dUXCI6k4TbUn7JMRuKvZLvyJ1rGrKnXofltRLRGcK0
         nxehGVP2eHV4qmkBO/dUDZfLDo9yuOClcs/Mg0M15lCLb3XFHciCauqsub5dxyAJTirh
         wv2ViUXOzX5/h6RT+ckBGuoycOPpepWs9cQq9p3svkgo0R7XZMFcYCQroLICgjZB4gCM
         XwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWl6kkg5Q6VUV9xC9388CJRuaSl1dYHpzCndnob9kB4=;
        b=juWHnk4BHy7DXsRdXr+QbsOJqtgLmQYu+Qh/c5d0bMTY5JfSmU2Q93KV12HoKQSh4Q
         1BDTY84gD2NlUzEVefmR04UN6kxpQElwAIlf32UbP3rV2e96PbgfO7I82vmi+SrZ5Pam
         QXBAANXWoE1B6WcKgiU1cN8PBarDMYmOaDYvzmCTLVnXJYeLP8kyJ93CzAUuJfAHO/vw
         ASvMA1Lmx0tLB2nzAMLAo6BkGE9CzR6LQZVWZeyHavX3cZogIcOZlwyDxZG5tHeaHwBj
         7NuRIPQocCW1LjQ8Xg4KdYf97rgrBnr6BEm96QOY0K8tf3MoASkjO4sfZhwbGa68/Mw3
         vSbg==
X-Gm-Message-State: AOAM531BpVhw8upjUdA3r/IFkD8WOG25aVf3je1fC7v+3ZPFNCERlMdf
        KIh6lw+s+/yWY+TshYKusjjmAg==
X-Google-Smtp-Source: ABdhPJy9IPZM1kQFdevcRyM6Ic+gWdL1WQ8ywwuUqOhgZS3tV4XXAG7nvD55YzfI4I97HhCTEQOuig==
X-Received: by 2002:a2e:9dd1:: with SMTP id x17mr828972ljj.219.1604059676093;
        Fri, 30 Oct 2020 05:07:56 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id a6sm603780lfm.207.2020.10.30.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 05:07:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc2
Date:   Fri, 30 Oct 2020 13:07:52 +0100
Message-Id: <20201030120752.100388-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3e4fb4346c781068610d03c12b16c0cfb0fd24a3:

  Merge tag 'spdx-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx (2020-10-14 16:19:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-2

for you to fetch changes up to 011fde48394b7dc8dfd6660d1013b26a00157b80:

  mmc: sdhci-of-esdhc: make sure delay chain locked for HS400 (2020-10-28 11:07:01 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix performance regression with auto CMD auto select
 - sdhci-of-esdhc: Fix initialization for eMMC HS400 mode
 - sdhci-of-esdhc: Fix timeout bug for tuning commands

----------------------------------------------------------------
Jisheng Zhang (1):
      mmc: sdhci: Use Auto CMD Auto Select only when v4_mode is true

Michael Walle (1):
      mmc: sdhci-of-esdhc: set timeout to max before tuning

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: make sure delay chain locked for HS400

 drivers/mmc/host/sdhci-esdhc.h    |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 28 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  6 ++++--
 3 files changed, 34 insertions(+), 2 deletions(-)
