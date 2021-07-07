Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE530C07E9B
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 04:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A5161C7B
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 04:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhGGE1T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhGGE1P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 00:27:15 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D0C061762
        for <linux-mmc@vger.kernel.org>; Tue,  6 Jul 2021 21:24:26 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso204326ooc.5
        for <linux-mmc@vger.kernel.org>; Tue, 06 Jul 2021 21:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T5eesMdf5Nrj9pK3NIaB7nSUdGYeCdFkTId4f8BW4ZU=;
        b=tPTrcigMEKCFZ7a6xFgzrlmW1iML4en1XfIhI5xNwsJ+v9h71GEnMN/JEjVktXtw/q
         E+AYjIjbVj3+sZnbbhnvuUcLzxsBn0RwlXpDnuCY/Z0m8qyNKZS2t+OFtY8zfNTQemRs
         opOjhUCGsm8F7xe9HJBUiYIJqkKBTgGuAvo8s0SkXkqwhZ9N45cWkJEX24h3ouT8pCHA
         /KtIdsBIWUg8Vo0Vtr355Cm9ZZLHJmluY4dFK+QNhruq1EwjQ/ID6okzyxpsfcLwzEDK
         BBN1FOVoC3UT+f9+E1oRFAFSMk8m+3ph478sm5fzycR/8WhUObmEmwbA+JLD/fUbWLiA
         dFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T5eesMdf5Nrj9pK3NIaB7nSUdGYeCdFkTId4f8BW4ZU=;
        b=jyE0KBd8cRYHl5gObqpG8wZ74SIuvN5SNXPLEhrkCqHJrOJXxyOuMMSUNg+Y+/VrQK
         WWdKaxmZp1cpbNLlaHU6lCHYPwmAPY2UatEA8nsY44l1ctXrdszyBiLi7rVviprl+RYJ
         vYnBemrimu7PA9vgpArbd3XDGIRn97n29/uBXv5czhHKZs+8JdHfI7vOZDts5zgMnFiJ
         iNBfE/9J/nMAtmxnXdcSlysp0EtJNMJruL3u/5TJhB00TWtzTffPHXm2zW+P5ifhKoCO
         MRsD4wdontTASOvAN43X/zbv2C9nEiz/a8WcAxNQJFYlZfYUsWA5cwAnVPx2Fl7ZS/ER
         bBoA==
X-Gm-Message-State: AOAM5300tKJTQigVZETLKBUKVO6rm/Vq3RS8c2DhTtSj8sGH7fO3TxA+
        D0J1rgcnMbnSfjJQrdY3B/YenEdKsp3j+LG62PnSQA==
X-Google-Smtp-Source: ABdhPJyNreJlEUu+o5gbpM5GMpnr9I8lFvyLndF+hbluewkRo30YD4jJYglnW2me3aLqDgmoqrxcHt3YvnrbYbw8v0c=
X-Received: by 2002:a4a:dbcb:: with SMTP id t11mr14426728oou.2.1625631865397;
 Tue, 06 Jul 2021 21:24:25 -0700 (PDT)
MIME-Version: 1.0
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Wed, 7 Jul 2021 12:23:38 +0800
Message-ID: <CAPpJ_ecx4byFQ+SJL3ZgFyf1q2HvGfLHhdf1khM9Znib_8iwEw@mail.gmail.com>
Subject: [BUG] U-Boot makes Linux kernel boot failed with "mmc1: invalid bus
 width" on RPi 400
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     u-boot@lists.denx.de, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I tried to boot Linux next kernel at tag 5.13.0-next-20210701 from
latest U-Boot at commit 1311dd37ec ("Merge branch
'2021-07-01-update-CI-containers'") on Raspberry Pi 400.
* U-Boot goes with the bcm2711-rpi-400.dtb from Raspberry Pi OS
firmware at tag 1.20210527 [1].  U-Boot is built with the
rpi_4_defconfig.
* The Linux next kernel goes with the corresponding
bcm2711-rpi-400.dtb at tag 5.13.0-next-20210701.
However, the Linux kernel is stuck at failed mmc, which keeps showing
"mmc1: invalid bus width":

[    7.776752] mmc1: invalid bus width
[    7.781398] mmc1: error -22 whilst initialising SD card
[   17.891183] mmc1: Timeout waiting for hardware cmd interrupt.
[   17.900265] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   17.910046] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
[   17.919829] mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[   17.929595] mmc1: sdhci: Argument:  0x80000c08 | Trn mode: 0x00000000
[   17.939337] mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000001
[   17.949092] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[   17.958827] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000f447
[   17.968531] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[   17.978201] mmc1: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
[   17.987850] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   17.997456] mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
[   18.007044] mmc1: sdhci: Cmd:       0x0000341a | Max curr: 0x00080008
[   18.016622] mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[   18.026157] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   18.035650] mmc1: sdhci: Host ctl2: 0x00000000
[   18.043066] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
[   18.052540] mmc1: sdhci: ============================================
[   18.139162] mmc1: invalid bus width
[   18.144682] mmc1: error -22 whilst initialising SD card
[   19.498785] mmc1: invalid bus width
[   19.503344] mmc1: error -22 whilst initialising SD card

The full log can be foud at
https://gist.github.com/starnight/dec6e6ee627f19c2d291f3ff973b06fa#file-uboot-kernel-log

In Linux kernel, SD card driver checks the bus_width bits for
validation [2] in mmc_decode_scr(). The value of bus_width comes from
the resp, which is assigned from mmc_card's raw_scr.
However, the values of resp[0..3] are 0, which means no
SD_SCR_BUS_WIDTH_1, nor SD_SCR_BUS_WIDTH_4.
After studied the call trace of mmc_decode_scr(), learned that
mmc_sd_init_card() -> mmc_app_send_scr() gets and assigns mmc_card's
raw_scr value [3] with "DMA" mechanism.

Therefore, I try to boot the same Linux next kernel with the same
corresponding bcm2711-rpi-400.dtb at tag 5.13.0-next-20210701
directly, without u-boot.
The system boots up and the mmc works correctly.  The full log can be
found at https://gist.github.com/starnight/dec6e6ee627f19c2d291f3ff973b06fa#file-kernel-without-uboot-log

Is there something special that should be done in U-Boot for Raspberry Pi 400?

[1] https://github.com/raspberrypi/firmware/blob/1.20210527/boot/bcm2711-rpi-400.dtb
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mmc/core/sd.c?h=next-20210701#n239
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mmc/core/sd_ops.c?h=next-20210701#n297

Thanks,
Jian-Hong Pan
