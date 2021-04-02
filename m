Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31AAC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33AF6113C
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 09:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBJYm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBJYm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 05:24:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159DC0613E6;
        Fri,  2 Apr 2021 02:24:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so4849393edb.8;
        Fri, 02 Apr 2021 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VsfUUJwBi1OkrmIFzzD/9YVfSsW45budFDoj+uGAc4=;
        b=p/qj6NG6jlLwxIzS3bQdJuMDCv8YDBoKOJRxmF9aVguJ8bRfTuLiRS1tHXiklRw/f+
         1x2/lNbmL+66H+9rPs5fEW2xSzFAKbE1vEUHlDmFCsJlcybyC9NHg1RqkDzqDl2w5HAz
         Llbl9RyOj6kFZzcGYtIa8OM00Y+7hc34CDe+HPsd0QNe5KSjwFR7ZrhDoyxH4HDLzETG
         2gOmvxhRc43KwT4SQ61YQd0BitJTrQfHSTiQHhw5pAOcpmEGUaGAggSitBjQIrG9aAqR
         SmdrfajQbC5wRRjX7dP2x7wofIUKGOrzKJdCk3M45ge/zAylwkD9qK3i+fnuf4cj/Q8a
         n4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VsfUUJwBi1OkrmIFzzD/9YVfSsW45budFDoj+uGAc4=;
        b=pkq8dsCAi0wcZkmRUSe+oSdSD1Udn/ztWdwHNGHYWcM+/uvSc1ONuRrF8do7he1Nb1
         P41Ew81Xa6+FLNFZBRh6TA9ecx2jTmOKXJPZCwhm3MvWwkjvkKlTr2kCZ4Demc8cPnyW
         rStSVwdAbW+aPapJmU8wbqHuz+03tUEMPFxEBGsT1dxOpZfh93QPxd+Kf20XM0tiJREP
         GP1/24ACahsviV6mGt2S2P6iIIxaSR/O3+V/zTgqDatRQ5ieqPuEZFVgijiEEk+iitF/
         /SL9cu3RHc+gVWdqc17uM/QrrpRFSw2gmB+KQeLOVzjo49tzpL1OSag9UZ9ZhW2rRq3H
         K31w==
X-Gm-Message-State: AOAM532PH1pvYBuY7wfOsf4DUJmwf5CmCU0bKV+53xYjFk6rkJDzcPcK
        K9EKDCw4tHpLHOoRh3XWvMo=
X-Google-Smtp-Source: ABdhPJwnTpfn2Whm0jPZARsoutTyfi/YpwlC7x+yYOX8YrRe4Z/CIMUjAdXlkDX43EDww+Ys1Ce7Rg==
X-Received: by 2002:aa7:d445:: with SMTP id q5mr14363568edr.382.1617355479971;
        Fri, 02 Apr 2021 02:24:39 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id d16sm247990ejo.85.2021.04.02.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:24:39 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 0/2] Two minor changes of eMMC sanitize 
Date:   Fri,  2 Apr 2021 11:24:30 +0200
Message-Id: <20210402092432.25069-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Changelog:

V1--V2:
   1. change wrong nouns in patch 1/2 commit message

v2--v3:
   1. Replace the original patch 1/2 with the new patch 1/2 based
      on the Ulf's suggestion.

Bean Huo (2):
  mmc: core: Pass down user specified timeout value to sanitize
  mmc: core: Let sanitize not retry in case of timeout/failure

 drivers/mmc/core/block.c   | 15 +++++++-----
 drivers/mmc/core/mmc.c     | 47 ++++++++++++++++++++++----------------
 drivers/mmc/core/mmc_ops.c | 24 +++++++++++--------
 drivers/mmc/core/mmc_ops.h |  6 ++---
 4 files changed, 53 insertions(+), 39 deletions(-)

-- 
2.25.1

