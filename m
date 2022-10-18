Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C06C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 03:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRD5j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRD5i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 23:57:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F218366
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h2so5299372plb.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttn9BtsRvPHZDctoQFYhqchv6f4WZOW0AdvCedAYGAQ=;
        b=AxoTvulQsXHyVthGzQJijYlWVIHRm2hUNQK040FlpeeFvQfV2Fvgv53nLi9MQeFpC5
         W7LFWCpzSLU8uOaqCg3PaGdrVYGk2e45mCqzVkiUVsvgpJJWHBZXv+8xyrtBsCbemUNX
         UpMYHFkZZ11zxyfkIYH+H7UVa8lDBE+rdIoow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ttn9BtsRvPHZDctoQFYhqchv6f4WZOW0AdvCedAYGAQ=;
        b=S0lbgDhiP8QB5unMvsZ9DJ6rEWLKZL5Ax4FYk0yRMAQ95ISwrI9NGkCArTIA6JYFKx
         jlBfWMIeozeHXZCPWS4Jl1892d8p6rPrURsMFHouQfTeZxHCIbUAI0mg+f9CYkuw0Grl
         WY+AgNSIje6N+cmQq06ITP5epZe6JBS53OEgrAguNO1MzMrmqtZmcOWrAP6+TARz/uw0
         0gfa1HXMqPwLQntcAGj8/CVr6WhRj9H19TtyQss2fH4B2k24PfGTqTU8eW7svB9tgm8P
         KA5EkPoKD5TMeI5qUujZaYRXg1xk+H5k8pHYsucZ5zoHrou8yDJGjfrV59C93v9w412o
         jt7g==
X-Gm-Message-State: ACrzQf0BdBu8V3rkGgyfhl5gSabVY4xtn6sdwoY1XfGn3g7fNhbgAM7Q
        /ReNq7CSvnhmshHJ+AATjX+dAg==
X-Google-Smtp-Source: AMsMyM5/MMsR3dKwAlnXsP26b3+7tHkvjjlj4iiVTtsPTtcIH0lwoZsn74D8o17KJH1w3ZfKQ3PUHg==
X-Received: by 2002:a17:902:f549:b0:185:3b98:380f with SMTP id h9-20020a170902f54900b001853b98380fmr1074842plf.36.1666065456717;
        Mon, 17 Oct 2022 20:57:36 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id d9-20020a170902654900b00182305a787fsm7418748pln.62.2022.10.17.20.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:36 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/5] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:19 -0700
Message-Id: <20221018035724.2061127-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a series of nearly identical fixes for several SDHCI host
drivers. The first patch (for sdhci-of-arasan) is the only one I've
tested, and I wrote it due to a bug described there.

I then noticed that several other drivers do the same thing, and that
commit df57d73276b8 ("mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for
Intel GLK-based controllers") points out the likely-repeated bug.

Thus, I include additional patches (compile-tested only) that apply
similar fixes to the other drivers which call cqhci_init() but not
cqhci_deactivate(). They contain appropriate disclaimers and the
relevant parties are CC'd. I would suggest only merging them if you get
some kind of ACK from people familiar with the relevant hardware.

Notably, I do *not* patch drivers/mmc/host/mtk-sd.c although it uses
CQHCI, because it doesn't seem to be an SDHCI-based controller, and so
even if it has a similar bug, it's not clear to me how to patch it.

- Brian


Brian Norris (5):
  mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
  mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI

 drivers/mmc/host/sdhci-brcmstb.c   |  7 ++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  7 +++++++
 drivers/mmc/host/sdhci-of-arasan.c | 17 +++++++++++------
 drivers/mmc/host/sdhci-tegra.c     |  4 ++++
 drivers/mmc/host/sdhci_am654.c     |  3 +++
 5 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.38.0.413.g74048e4d9e-goog

