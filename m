Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EEC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E87C6108D
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 15:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhHRPUV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhHRPTM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 11:19:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C3C061764
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 08:18:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y6so5794371lje.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mRJIXAZWfL3FHk/FIINd4bbx35hByjZA0KaRevosRfk=;
        b=eLPedI1TaO6lrr0/OxYeOEllEz6gS2MvqQFLZ5nZ/YffS8RyCQsWyoN4xq3bLOnnkN
         abITjWOHAuGBM9ZJgU83WDOgwULIlFbdS5LWReu4l5+exxRoDh2Ve9cFWZ5CXx3YC2V7
         2rl/rwv7fzgg/Aj/QVLoeFXw7lHkcdmEmw3UffZeNUbYgpJJGNrOd8ukid7AehPEarn9
         /PGrnFmKwCH8GfVWFy1Z72Q5sAi05scR//UjOC+qcZMKfsb1fOlnlXybKb61Pgslpdni
         sH9G+FI/Bx8dTqApuHBUgaXwa4MGZXdXECLmAeM64i9s+sMyTEEoE0ppdpJ6i0OGHSWa
         ZZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mRJIXAZWfL3FHk/FIINd4bbx35hByjZA0KaRevosRfk=;
        b=P3NucpZe2x1fkret3OKYNzSL4wS5qApCjCqHK9f2qiTmImyDfo8Mq3AHp34ZzkORwV
         Teq1btfSPakmh0wT0MCoVfAay1PQbHhyts4sDd1GEBsExcGkNxcoopS0DVPGuvF1OWKy
         QHMTJ3XIH9yuBCVN9G8uDlBJ/lB2S/qcaHwscUbu2CGibcIU625v7ZFvdbYpUaP+OJrB
         LpeOkWfkts/fTgcYi6dM+iG74fxd+mLPGwx7HiO2Si/By1xA0y8Eir+8WtTn1y6e07eB
         ULdumCU14LGtgsuUUfH9UJCIAd5vwBCm80JHOPxKhls8hRZTqaySZrV49gEFtlSFYnho
         HNvg==
X-Gm-Message-State: AOAM530hQBh8icDLP87GkTEahQZBhCVi0W06FciQKqx2OxqYe7nBloov
        Wc4rLQrIetJOMXGb3OImisFPXwZvfZbh55ide7drQ9cVS6yVxw==
X-Google-Smtp-Source: ABdhPJy2JugOHeh0mqxJKc73oO/kUEm5cXSbJPfFROIr/YPUOoPlOREjOGD5MhNYs+deACxX18hp4u4zVxkgANuKWJ8=
X-Received: by 2002:a2e:9881:: with SMTP id b1mr8366154ljj.53.1629299916138;
 Wed, 18 Aug 2021 08:18:36 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 12:18:25 -0300
Message-ID: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
Subject: NOHZ tick-stop error with ath10k SDIO
To:     Kalle Valo <kvalo@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

When launching the hostapd application on a i.MX7 based board with an
ath10k device connected via SDIO, the following "NOHZ tick-stop error"
messages are seen:

# hostapd /etc/wifi.conf
Configuration file: /etc/wifi.conf
wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
[   63.021149] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
[   67.332470] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
wlan0: interface state COUNTRY_UPDATE->ENABLED
wlan0: AP-ENABLED
[   68.025845] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   69.025973] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   69.607432] cfg80211: failed to load regulatory.db
[   72.026748] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   73.027039] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   74.027159] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   75.027109] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   76.027461] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   77.027391] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   78.027560] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!

This happens on all kernel versions from 5.10  to 5.13.

Any ideas on how to fix this problem?

Thanks,

Fabio Estevam
