Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F3C38145
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Sep 2022 09:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiIBJvX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiIBJvV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2022 05:51:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FF910A9
        for <linux-mmc@vger.kernel.org>; Fri,  2 Sep 2022 02:51:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k22so1716326ljg.2
        for <linux-mmc@vger.kernel.org>; Fri, 02 Sep 2022 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TBFJI0EeUotcw714y9rA+fHR54otguK4p1tiMHOZkpo=;
        b=kUx6RK8atndn6CFMOl9Bwa4GcwmD68k4WWC+NEszwHvAwzSuy/AEE09aygAIlpQp1a
         n3oLt0pYcGhOPtbxax9DRf9uXAr0DFdxsOOZiObV9y5dlXJUsqSB+uwqtqlr9NCMIGfs
         XnyKjzqms3bM07mE+1ztBqbwwAjwLH8KSK4B7x1oGNjZqNqXWNWQ/Yq6tQ/mFi6XzeyL
         UHsLu8q/O+ev+eIL+Hzcn1tK9DBEKhGmQotVHH5o3hq6xYBPbkT/kSgcsywlZkJ/iILl
         4bQyKr//oPQLUY4FGDk2gf3g4OPjsHR5qEdZDE0O6AU28UUkQyMb48SkEu/M3Nl3x5YJ
         qlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TBFJI0EeUotcw714y9rA+fHR54otguK4p1tiMHOZkpo=;
        b=iEEswS8ybif/S6g/ZGOm8kOpKvo0YLPZuyAzWENnDnekKwF36PxrsneYJsowBYuOql
         kJp9EJak8u0yPSsju3zjtoq9D9Nlrh495OUY+x+cTawaqdWbgMzNMHLl1yHadxFwOY0b
         mWz9Usv5GTe+l+W5OBAEh3hsKHb5lvK0mttoirdwQSip1o8jJ4av96q9aZW7dbnD7F4P
         325N4ENL0u68tqdjrGltgDlL2uBbkIV/V4nPkwmUUFC9Q1XSsCnWENvyavRfIEMGjzc+
         2T9v9YyF1dro42BmnRlezHE4Bfrz87ltRIZ3FIKDuHaOe2HM74DA8PdlskxBtElwZ9Yu
         KOEA==
X-Gm-Message-State: ACgBeo3cnyidutyB8m1+cpddbmnPmSEdKEaS8Vrr10/6LsdlQspD4gJc
        D0p8V3xyfNR8X8cy2PNOcp2XYQ==
X-Google-Smtp-Source: AA6agR4tVeJ1pwC/WJclJV1QdLlZjMk/1HpxHpa7P1PJJ5MM07Z4jY3uDcK9CeWGQQkE/Q+sW4nY2Q==
X-Received: by 2002:a2e:bc21:0:b0:25e:c921:f7d7 with SMTP id b33-20020a2ebc21000000b0025ec921f7d7mr10448983ljf.91.1662112274513;
        Fri, 02 Sep 2022 02:51:14 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a12-20020ac25e6c000000b004947fbc5d28sm186283lfr.303.2022.09.02.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:51:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.0-rc4
Date:   Fri,  2 Sep 2022 11:51:13 +0200
Message-Id: <20220902095113.499331-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.0-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc2

for you to fetch changes up to 63f1560930e4e1c4f6279b8ae715c9841fe1a6d3:

  mmc: core: Fix inconsistent sd3_bus_mode at UHS-I SD voltage switch failure (2022-08-22 12:58:28 +0200)

----------------------------------------------------------------
MMC core:
 - Fix workaround for SD UHS-I voltage switch

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: core: Fix UHS-I SD 1.8V workaround branch
      mmc: core: Fix inconsistent sd3_bus_mode at UHS-I SD voltage switch failure

 drivers/mmc/core/sd.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)
