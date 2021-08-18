Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D403DC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 00:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66826102A
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 00:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHRAYN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhHRAYM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2021 20:24:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD9C061764
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2021 17:23:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h11so1742861ljo.12
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2021 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Wj7ZYl1WoMaaA1oaw8rVm+2w7aPP8H9UvMYaCDtbsQE=;
        b=Gk1864OUM428zVHNihF4AqEnIOUcy+1NSIzauz5TxGEg12H6IWI0K73NKzlsWLnLWN
         U1+Igg+O4O3VGZbJGnkR00GU9vI8VE3iasEMHktKubRejZEnfOVsaeFfa0d6uOXDj81T
         5ITIkIaefZS7EUxUOsJMiahXPXPSPSDFRYDebVwYLXBT8Iigi5VrqNKA/jA85w9VvgM+
         VynZe4v1pdz94k4ACcGHnatWcEw5mL4wvyRZ1dRa+XJQ66e97wE6pcr71DSzky8rGJsf
         gBKy5jH2ODdVlhhBAF+LStFKlCgDWDmLLhsRCmRjqzcoGR3o2lo97DjS6703JOOswAyQ
         6ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Wj7ZYl1WoMaaA1oaw8rVm+2w7aPP8H9UvMYaCDtbsQE=;
        b=Oll2i5RaX2SuYNV21IWywK7AimaNXGJ/nyz5HoS4owltix94qULdWdmK2Scby65prT
         DzV6cPWniytUsiDL/c6qB6kCSJkrtP/TicGC+slyHrEG1H6tNdYs87C/g2hXENN0sdVT
         0h/THLgJhIwYKH9kdBoB3yE6urZo/+GuW9QTsiC6KG2fCFauRpBis3Y0xgnu7Cj1+WXn
         4VVH1to2lgghEk7IGpbxaKF7gye5CRe1Bcc1lH0VDcUUIkRQJjrECQbIek2M9TyDjlBE
         VeWdBcqfppSKbG2/caTd9NBUmfBEGJBp0ERh3701UZzylN/ghwpEirhzLgeAfTdIoAgo
         zgvQ==
X-Gm-Message-State: AOAM531ipNwkKr0pkeYbfgv4NlqiKsu08abBixm6KZnUVgjhoRgIWhtt
        7wzi8oirq/w/uwJLjAQcaTeU6Izfo8Lc9AQv9ag=
X-Google-Smtp-Source: ABdhPJz9/MVuNT4Q8zJcJCaVC+5ltwIfLIIqxpjCUl7tU3h72qBjSHQb6WPWxjTGTWlNrwG61VYCmq//YlVOOKQ1aNA=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr5399473ljh.264.1629246217149;
 Tue, 17 Aug 2021 17:23:37 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Aug 2021 21:23:26 -0300
Message-ID: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com>
Subject: imx7: dev->coherent_dma_mask NULL warning
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Launching the hostapd application on an imx7d based board with an
ath10k Wifi chip leads to the following warning:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 489 at kernel/dma/mapping.c:427 dma_alloc_attrs+0xd0/0x114
 Modules linked in: ath10k_sdio ath10k_core ath
 CPU: 0 PID: 489 Comm: hostapd Not tainted 5.10.48-stable-standard #1
 Hardware name: Freescale i.MX7 Dual (Device Tree)
 [<c0111378>] (unwind_backtrace) from [<c010bc04>] (show_stack+0x10/0x14)
 [<c010bc04>] (show_stack) from [<c0e26094>] (dump_stack+0xdc/0x104)
 [<c0e26094>] (dump_stack) from [<c0125574>] (__warn+0xd8/0x114)
 [<c0125574>] (__warn) from [<c0e20ecc>] (warn_slowpath_fmt+0x60/0xbc)
 [<c0e20ecc>] (warn_slowpath_fmt) from [<c01b9eac>] (dma_alloc_attrs+0xd0/0x114)
 [<c01b9eac>] (dma_alloc_attrs) from [<bf01373c>]
(ath10k_add_interface+0x2f0/0x1094 [ath10k_core])
 [<bf01373c>] (ath10k_add_interface [ath10k_core]) from [<c0d94470>]
(drv_add_interface+0x88/0x2fc)
 [<c0d94470>] (drv_add_interface) from [<c0db6c58>]
(ieee80211_do_open+0x4c8/0xc70)
 [<c0db6c58>] (ieee80211_do_open) from [<c0b12b7c>] (__dev_open+0xf0/0x170)
 [<c0b12b7c>] (__dev_open) from [<c0b12f40>] (__dev_change_flags+0x164/0x1d0)
 [<c0b12f40>] (__dev_change_flags) from [<c0b12fc4>]
(dev_change_flags+0x18/0x48)
 [<c0b12fc4>] (dev_change_flags) from [<c0bcf968>] (devinet_ioctl+0x6d4/0x868)
 [<c0bcf968>] (devinet_ioctl) from [<c0bd2684>] (inet_ioctl+0x210/0x3b0)
 [<c0bd2684>] (inet_ioctl) from [<c0ae44d4>] (sock_ioctl+0x56c/0x718)
 [<c0ae44d4>] (sock_ioctl) from [<c02ccfb8>] (sys_ioctl+0xf0/0xbf0)
 [<c02ccfb8>] (sys_ioctl) from [<c0100080>] (ret_fast_syscall+0x0/0x28)
 Exception stack(0xc3293fa8 to 0xc3293ff0)
 3fa0:                   bea0190c 00000000 00000008 00008914 bea0190c 00001003
 3fc0: bea0190c 00000000 00000008 00000036 00eeef10 00eeedb8 00000000 000186a0
 3fe0: 0051dbcc bea018fc 004ba26d b6c49fb8
 irq event stamp: 145521
 hardirqs last  enabled at (145531): [<c01949f4>] console_unlock+0x434/0x654
 hardirqs last disabled at (145540): [<c01949ec>] console_unlock+0x42c/0x654
 softirqs last  enabled at (145472): [<c0101604>] __do_softirq+0x324/0x5c4
 softirqs last disabled at (145415): [<c012e1bc>] irq_exit+0x17c/0x1dc
 ---[ end trace 37715f05492d4493 ]---

which comes from:

void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
....
WARN_ON_ONCE(!dev->coherent_dma_mask);

Where should the coherent_dma_mask be set to avoid this problem?

Thanks,

Fabio Estevam
