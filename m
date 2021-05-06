Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD5C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 14:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E5610D2
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 14:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhEFO7h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbhEFO7g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 10:59:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B777C061763
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 07:58:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a36so7423643ljq.8
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJwR0jpCnsf9y/FTF427NMZV9yLVm+aDyiKh9n5GVw8=;
        b=ckf5P4FnVIgnAHqJq6sdLjCngYSbfUg9saTg+UiXj9SlkI/WGnQwAHvP73bcuenuLn
         L7egDnA2Bpz69apbjpLOE9r6EvVccEOT1FRPTuv6dRbIkAe3xO+6Qxn4jdiaEjQKInIJ
         BQLQlDiQyEAN5jFMAZ7L2W1G+ko0d7WyDTHA2pQnoBvLhq0Ij6AfAApkFBDbicUmsAC2
         W+X2caWQmRzlxeeDNdFVtIzN23PKzcZnUnc4ohOaw9A2s8xGoLzaqQPZKqP4ZRHzLEfG
         j87mbrJYImqP1sc8y03BhRUTRTVhzmPdK81KPskIoRSyU5dfmt7eJfJWnrld24OYkG4D
         Msag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJwR0jpCnsf9y/FTF427NMZV9yLVm+aDyiKh9n5GVw8=;
        b=qS0+X9FB0tsLztJujDZi65LR8kwpbEiG0LvY91o2UFyGq7A3Sl4n6drDgdmOgqtvvD
         iS4ourgsuOgXQgtAB+9Zi7wTXe37PsF+OGJh36QTVh/PqkiveSN66iPsuG0HptoYxnx9
         8dIbOK+LFVtFsTrfmpKYa5zS6szzsDl6LG+GvioqxvuloKsQsYfl5TOg/FgvMMcHtXN1
         XpRdJ0yIMQiJBzt5nIJdg1bJiaAbhxvPV7uGBHjHTLyRTIYCFQOgNiJPCv8bM+KO2zFD
         q5VbqAzfAQxDUKSJOLOLSzepzvPvzcdNA1VsohDKwml47NwSXexQ2hIDD/e6UUKh1Gmx
         lC8A==
X-Gm-Message-State: AOAM532tETRXoHwZxNz70cCkJtVFFNl3B0dOyOsgGu4IHtoJaOxg0TiW
        W+jtQGWoONTYnq/gP25Gl57A+OtSEsGTvbA9
X-Google-Smtp-Source: ABdhPJzv7VVM6GvFLywf+ZD+Zrrlqtw+C+gVfu7nh8M9qTE51onRSgb9pssQA/ZXXGrDIZCqFFfsKg==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr3882282ljm.66.1620313116244;
        Thu, 06 May 2021 07:58:36 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g24sm968774ljl.44.2021.05.06.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:58:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD cards
Date:   Thu,  6 May 2021 16:58:27 +0200
Message-Id: <20210506145829.198823-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the SD spec v6.x the SD function extension registers for performance
enhancements were introduced. As a part of this an optional internal cache on
the SD card can be used to improve performance.

To let the SD card use the cache, the host needs to enable it and take care of
flushing of the cache. This series implement support for this.

Note that, there are no HW updates needed for the host to support this feature.
This has been tested on 64GB Sandisk Extreme PRO UHS-I A2 card.

The series is based upon another recently posted series [1] that added support
for poweroff notification.

Tests and reviews are of course greatly appreciated!

Kind regards
Ulf Hansson

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=476933

Ulf Hansson (2):
  mmc: core: Move eMMC cache flushing to a new bus_ops callback
  mmc: core: Add support for cache ctrl for SD cards

 drivers/mmc/core/block.c   |  2 +-
 drivers/mmc/core/core.h    |  9 ++++
 drivers/mmc/core/mmc.c     | 25 +++++++++-
 drivers/mmc/core/mmc_ops.c | 22 +--------
 drivers/mmc/core/mmc_ops.h |  2 +-
 drivers/mmc/core/sd.c      | 98 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |  1 +
 7 files changed, 134 insertions(+), 25 deletions(-)

-- 
2.25.1

