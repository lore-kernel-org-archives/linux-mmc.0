Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E2C433ED
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9520861434
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhDUM50 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhDUM50 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 08:57:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D64C06138A
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2021 05:56:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g8so66759323lfv.12
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2021 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULnHBQgqSbvoxbafI3CKu7NeQDJtQC81cSXhVI6lf0w=;
        b=N/8js+bsCKnk8kn2LD3IJPlGrF5nvRvn103em0ekmQid3aD4GAZLSb4TJngcFRfbnV
         M3pAQODecv8VU5htUnaqPJF2IcYMFX+uq7r7zq3offVzmzhUpAiFUJkGVsdJsrA34N5v
         ickiSLeTZ7vopPMwXWCZDSau/6+l/Z7UXZoTEWeBiTVaK546Q1qlM0YL51Fa8lomDJoK
         HLuQgiOj4nEQEd7A8AuSpyvlPg688XN81hPerSJBs13kREie5SbNsYBhOWyLKry2uqiz
         UMj5qZ1MJ6bIE2Y8O3x42818smeHst2d3F9WbX2N29E+pvFlQ++HBWOmYE93BOUAm/gj
         qEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULnHBQgqSbvoxbafI3CKu7NeQDJtQC81cSXhVI6lf0w=;
        b=g4KStydXIwFbVra3WuItytuiNx9P4UtXTSeYOet3vf/riDuAG3+sVj2nH6/u9cgaVJ
         C0hJomkQMmfTGgDgzTxFSU7oM9ClOg559Z4NTLZPfaPcdwFDZ/suaitPU5/+dbWtgjG2
         Z1Zb3PDrBNmrBX0SWA+Z+JBsGZHDz/W+0NJVp9Wq5CEibr/OEMWCri3NAJNu0f9tXHyK
         dlKF48AzOQFoGdaOidhpeBmaKSntpncanc2YZwYso5ksERI349JsZmWudpJiq91+ITzv
         3zG1UWqoID4zoeKLaN3V9NqMFVpb7HZG8Lo+hZH2UKmvGMZf22rVWkr7u5/nuP1dFDrv
         6jlg==
X-Gm-Message-State: AOAM531vqtP3wbm7P2BhKPlLeyQnpxRhuZMIa7m8jqNPqP1fy3M4BpJ2
        7oTEP2pEcLZVVltCuao0ubiIxg==
X-Google-Smtp-Source: ABdhPJyMdN4uTIIrROWbubtFi9/LZ/4GDHBfqJu/j0dfDoLoX5neHk6e/pEGswf/0PADosfLCdpnWQ==
X-Received: by 2002:a05:6512:ba6:: with SMTP id b38mr19833917lfv.128.1619009811533;
        Wed, 21 Apr 2021 05:56:51 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id a28sm204584lfb.88.2021.04.21.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:56:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.12-rc9
Date:   Wed, 21 Apr 2021 14:56:49 +0200
Message-Id: <20210421125649.186054-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.12-rc9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc5

for you to fetch changes up to 7412dee9f1fd3e224202b633fdfa6eeaebe0307e:

  mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode (2021-04-19 09:49:27 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Replace WARN_ONCE with dev_warn_once for non-optimal sg-alignment

----------------------------------------------------------------
Neil Armstrong (1):
      mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode

 drivers/mmc/host/meson-gx-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
