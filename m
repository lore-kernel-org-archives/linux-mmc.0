Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D49C49EA5
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 12:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80496613F3
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 12:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFXMfP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhFXMfN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 08:35:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17AC061756
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 05:32:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x20so742421ljc.5
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSWDVqAOh+Ag5QvJMiD9g+xY5O9tKZC36bQUG3SCwlI=;
        b=AyK1i/Hds9BUcdFDxiD15yeXufdfK1Q3svp2aMbZSxlTB4ye7gIlfdluRCnbOhc43T
         Tnzigg0k9aQed2xnZxdjbg4eAqwfeVUY7aGZAoD38xoU3B8agonKtI0t4LngLfAzrlgg
         VL1bMM/qOz9rJkpJnKUqvajlIyPe5l1R0abFlKOeoxssu5QVSN+AFGsPR8bA0RJlbmer
         A79pKUireUbr27xngyR9/+BbzI2/qynBchIXPEHbKCk5pOzKAOMokvWSAzufKU7ykDLI
         +0xlXqsw8atXiZvdWSpF5hq00ghFxrRSmydsOjJbhV3qLbVCJ4RZRWwg/uYW5T5dhnQh
         8v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSWDVqAOh+Ag5QvJMiD9g+xY5O9tKZC36bQUG3SCwlI=;
        b=URZr7ni6fFRGptVnNtPIK+iALMMI1sHp6Hz++P4EfRMR1+3Y9bUq9PC2YS4H2UP8Ae
         oA/g0ZBy1y0oaM7yX2/eO9FjJy12vjp2R2Kadn+s3QMJQy1ShfdwyNbviwtY8fFu9lXL
         3p4nL8hvlOSohO7a4QbnsdWH78DDbcRiqxrGW9mCMg7OS0sfmFW6yGUZlC3f/K1xhis4
         WXSFQWw2OamPvQIap4kR8vTf0NZzDT49ZbPGLphno478/gDYY9CN4uFCeH/KODfwvq0F
         jB4gLvSTzhFe7Q31WlQkTsg1DjMUCPnQYlYoXZh9zIdndwudAlB180XKebWx/UpvhaTg
         ZVnA==
X-Gm-Message-State: AOAM531tlipw+cuHCNQWwBig8U4Q3+2qNvlqjFvAXdddINPtisZV+58b
        dC+ZB4H3edBBOoIhmxUOT/yoS10k69OLkvlg
X-Google-Smtp-Source: ABdhPJw7e5ghg9iO+MSG0sN32yxoB2rCbgrLPRu2ehwGsu3zQoxfsaJ2AmI6kj7c/BJxTlFc90YD3w==
X-Received: by 2002:a2e:a4b7:: with SMTP id g23mr3764933ljm.210.1624537973013;
        Thu, 24 Jun 2021 05:32:53 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id c33sm278706ljr.85.2021.06.24.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:32:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.13-rc8
Date:   Thu, 24 Jun 2021 14:32:51 +0200
Message-Id: <20210624123251.191299-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.13-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc6

for you to fetch changes up to 103a5348c22c3fca8b96c735a9e353b8a0801842:

  mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk (2021-06-14 14:02:33 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Use memcpy_to/fromio for dram-access-quirk

----------------------------------------------------------------
Neil Armstrong (1):
      mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk

 drivers/mmc/host/meson-gx-mmc.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)
