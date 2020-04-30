Return-Path: <SRS0=CLt1=6O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA269C8300A
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2642214D8
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsgulO4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD3JQ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3JQ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 05:16:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED56C035494
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:16:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b2so5687383ljp.4
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PLEzFtiTHiEFZcHjUWZsk1as7iY/+JvOpvH6h5KaAg=;
        b=zsgulO4dH6Do3VLsT9f6zvu2dpTxiUxO2SFwYAi9HkkAAg4JSb1g4ZVe0twlUbfDpf
         30bxNRvUrjtk83t9+fxVdVZoAbMzJF1dty37BByl6zDGYXYAVThgD/cDiKHRbPmg0FgA
         h/JMcCi7C+k/Y7s5uY9oRkkncDrmydYcZJkzrHByCGXxdxl5G73VWtmt35kwVe53mEYc
         syHyacn5KN8YRmuKCidwj5OXUfO9+sON6MJzAWJ2ARBrFEDwZsUMezwJTu1QZy/9ip7V
         4TR257zdscbQ9mrz4jZn9QqRtMPH6Qh3BKkjTrOrt43GDzz4zQqsdVz8qPA3Lv8T2eRO
         RqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PLEzFtiTHiEFZcHjUWZsk1as7iY/+JvOpvH6h5KaAg=;
        b=cQd0KfY431U3itc++0QlQ/1YX/hP8wGT4hviNlX2Kwsin35yQCMK+gj4xAw0N7wiel
         2QtIF1uk41+UR9tUKr0SE8qDE4p78seNVcg0VL+VBj44TwcieMzMJRY5xsdek7EoR0zB
         tCyVp12/RQWKLhVKpK/MI4lJVtDtrd5ICymTbm1P9N9ezt3YAdoZ1JsM41ICcGa0D4UO
         DKQlKGb9F+dj+l5XTZf3fHdJKgGKPPiyHfgyBItpaL3MnQJkmyNGAAuE8yxUWg8S6P0N
         PkOrz7SlJpTj2x8Ybe7RVTegFDv7aWS1lHSbv6v6gzdpadwuJukN0Dgp68kSfIDISyPs
         dZyQ==
X-Gm-Message-State: AGi0Pube9tyFsnBASw0bKm7PrGpAq8FCAjK1VeFF4elsjzE6sMNflHE6
        skNJH0dzXXYgGPXoHKmKknTrc2unv24=
X-Google-Smtp-Source: APiQypIk8S4FeWypTzc/IlTqJlvLuTOrnen4IjIj+4LjqQ6dgxQqQf3++gUkr7FL7gKDQPnm355s2Q==
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr1561552ljj.97.1588238214479;
        Thu, 30 Apr 2020 02:16:54 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x29sm4417818lfn.64.2020.04.30.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:16:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 0/4] mmc: sdio: Fix various issues in mmc_sdio_init_card()
Date:   Thu, 30 Apr 2020 11:16:36 +0200
Message-Id: <20200430091640.455-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Over the years, the code in mmc_sdio_init_card() has grown to become quite
messy. Unfortunate also leading to several various errors.

This series addresses some of them, but it's likely that there are even more
things that needs to be fixed on top.

I have tested this on Hikey board, with an SDIO card corresponding to a WiFi
chip from TI (wl1835). Additional tests and review comments, are usual much
appreciated.

Kind regards
Uffe

Ulf Hansson (4):
  mmc: sdio: Fix potential NULL pointer error in mmc_sdio_init_card()
  mmc: sdio: Fix several potential memory leaks in mmc_sdio_init_card()
  mmc: sdio: Re-use negotiated OCR mask when re-sending CMD8
  mmc: sdio: Align the initialization commands in retry path for UHS-I

 drivers/mmc/core/sdio.c | 116 +++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 61 deletions(-)

-- 
2.20.1

