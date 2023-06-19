Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF82EB64D9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jun 2023 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFSLno (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 07:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFSLno (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 07:43:44 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96FD1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bc40d4145feso3580620276.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687175022; x=1689767022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tuuqkxv8vguWItdEjxVgk+uQj17nZY31Gi6Iy7gHVzQ=;
        b=ALvzcpTNlbQCbywqFDA4CeVAEVfadTaR62VFR4+HNVSFo6kKo/x/EVsCbDTQh/FXF8
         PDhD9a8FpS2851KnlduJBVF6nAcd4xClvDizvERzvqvPHaRW1X93/pBOXRTGzxQ477qQ
         GgpT37ZcgO7Lw2yc7zVrKagmqsU8iSJRCyIH/632b+aYPb0G4TRfIxlPupQQBGkFMWD5
         qqTxnC9NrCFyo+ZJNxwxVBDrs1iqMyPy+p71ILQwHpclpbW1wn/HAhhg0wXCq0sa9s4f
         gsxNrmz/YS0jjBNMgS4p1DqH0c+ei6lg0c69hdcAA11u/1d7uCnaHE+tr1j8FwxkHPcl
         ckNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175022; x=1689767022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuuqkxv8vguWItdEjxVgk+uQj17nZY31Gi6Iy7gHVzQ=;
        b=Dr8RG93wmreO/pOpk4poeNMhaqAHgTWMJ3fSGQtA1Ljbb8ptVxi47ftboyYccb4tqm
         ldT03XjaN7LaYWjdP8cb4gGbzg1LNs3nTSZMtscYUk5Lbvjd4/PYuupTHNd//HQQahhJ
         12FPx9LPpQkpcDjlA3BBvmYbb5UFPmljIfMZU4vScbKZ8SlijUbxgp63nqlLf4T5RrLq
         wpNsWaKb9tnxNrpcPHLj1Js6aR7gg3dWdDe5pdVcgSVgaK6zo+byVPCr3BWRuwg3R0UL
         ApohgmW39gFjQ15xHsFZPVkehlGi4doJZgCwsmK1faOM8afMQqAd+zaTFXfxWuHo3uXd
         yV+g==
X-Gm-Message-State: AC+VfDwWUPrq861exzDu+72Twyc6fXjINvn7V+JR+1btWXRPX/mbkY6B
        5XMOnIYXtEMCA0VK8uPj5QYChZOO32myfDlilW29rQ3jnaw1JWlQ
X-Google-Smtp-Source: ACHHUZ4S5E3DCMuAPi3dzN06neaImvVqARtjGG7NFDVB/itaeBx7xsb4J5l5TEmiFoMJrZp/n5pDSDcepuI8Q2ywJAI=
X-Received: by 2002:a25:fc23:0:b0:bc7:92bf:b8c5 with SMTP id
 v35-20020a25fc23000000b00bc792bfb8c5mr6711182ybd.45.1687175021810; Mon, 19
 Jun 2023 04:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Jun 2023 13:43:05 +0200
Message-ID: <CAPDyKFop7bMSYSe13_d97s9KomR8AvTC9Y0i2UKUv-U6VV-0vw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Fix busydetect on Ux500 PL180/MMCI
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Hansson <newbyte@disroot.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Jun 2023 at 22:42, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This series start to fix a pretty serious problem in the MMCI
> busy detect handling, discovered only after going up and
> down a ladder of refactorings.
>
> The code is written expecting the Ux500 busy detect
> to fire two interrupts: one at the start of the busy
> signalling and one at the end of the busy signalling.
>
> DAT0 busy          +-----------------+
>                    |                 |
> DAT0 not busy  ----+                 +--------
>
>                    ^                 ^
>                    |                 |
>                   IRQ1              IRQ2
>
> The root cause of the problem seen on some devices
> is that only the first IRQ arrives, and then the device
> hangs, waiting perpetually for the next IRQ to arrive.
>
> Sometimes neither IRQ arrives! This could be because
> the card is so fast that the MCLK does not have time
> to latch out the IRQ signal to the bus before it is
> gone.
>
> I included the rewrite of the entire busy detect logic
> to use a state machine as this makes it way easier to
> debug and will print messages about other error
> conditions as well.
>
> The problem affects especially the Skomer
> (Samsung GT-I9070) and Kyle (Samsung SGH-I407).
>
> This series does not finally solve the problem, but
> prepares the ground by making it possible to solve.
> I see no regressions on the HREF boards or the
> known-good Golden device, but enabling the debug
> prints reveals why we have problems on the Skomer:
>
> U8500 HREFv60 TVK:
>
> [    2.343785] mmci-pl18x 80114000.mmc: mmc3: PL180 manf 80 rev4 at 0x80114000 irq 83,0 (pio)
> [    2.352789] mmci-pl18x 80114000.mmc: DMA channels RX dma0chan8, TX dma0chan9
> [    2.609727] mmc3: new high speed MMC card at address 0001
> [    2.610762] mmcblk3: mmc3:0001 008G03 7.38 GiB
> [    2.612989]  mmcblk3: p1
> [    2.613824] mmcblk3boot0: mmc3:0001 008G03 2.00 MiB
> [    2.615367] mmcblk3boot1: mmc3:0001 008G03 2.00 MiB
> [    2.616721] mmcblk3rpmb: mmc3:0001 008G03 128 KiB, chardev (246:1)
>
> Then I can mount partitions etc.
>
> U8500 HREF520P TVK:
>
> [    3.064950] mmci-pl18x 80114000.mmc: mmc3: PL180 manf 80 rev4 at 0x80114000 irq 88,0 (pio)
> [    3.075458] mmci-pl18x 80114000.mmc: DMA channels RX dma0chan10, TX dma0chan11
> [    3.558157] mmc3: new high speed MMC card at address 0001
> [    3.573992] mmcblk3: mmc3:0001 SEM16G 14.8 GiB
> [    3.595782] mmcblk3boot0: mmc3:0001 SEM16G 2.00 MiB
> [    3.610788] mmcblk3boot1: mmc3:0001 SEM16G 2.00 MiB
> [    3.633313] mmcblk3rpmb: mmc3:0001 SEM16G 128 KiB, chardev (246:0)
>
> Golden:
>
> [    2.993989] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4 at 0x80005000 irq 82,0 (pio)
> [    3.003348] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX dma0chan5
> [    3.134052] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    3.142300] mmc2: new DDR MMC card at address 0001
> [    3.148051] mmcblk2: mmc2:0001 SEM08G 7.28 GiB
> [    3.155668] mmc1: new high speed SDIO card at address 0001
> [    3.167170]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
> [    3.232390] mmcblk2boot0: mmc2:0001 SEM08G 2.00 MiB
> [    3.242865] mmcblk2boot1: mmc2:0001 SEM08G 2.00 MiB
> [    3.249808] mmcblk2rpmb: mmc2:0001 SEM08G 128 KiB, chardev (246:0)
>
> Notice an initial error message, then it stabilizes.
>
> Then I can mount partitions etc.
>
> Skomer:
>
> [    2.659027] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4 at 0x80005000 irq 81,0 (pio)
> [    2.670135] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX dma0chan5
> [    3.380554] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    3.387420] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    3.394561] mmci-pl18x 80005000.mmc: lost busy status when waiting for busy start IRQ
> [    3.402893] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    3.409088] mmc2: new DDR MMC card at address 0001
> [    3.433166] mmcblk2: mmc2:0001 M4G1YC 3.69 GiB
> [    3.466766]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
> [    3.485076] mmcblk2boot0: mmc2:0001 M4G1YC 2.00 MiB
> [    3.503265] mmcblk2boot1: mmc2:0001 M4G1YC 2.00 MiB
> [    3.524993] mmcblk2rpmb: mmc2:0001 M4G1YC 128 KiB, chardev (246:0)
> [    4.470245] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    4.489227] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    5.457244] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    5.469512] mmci-pl18x 80005000.mmc: lost busy status when waiting for busy start IRQ
> [    7.133880] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    7.154541] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    7.189270] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    7.542175] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    7.552886] mmci-pl18x 80005000.mmc: no busy signalling in time
> [    8.277618] mmci-pl18x 80005000.mmc: timeout waiting for busy IRQ
>
> This is why the Skomer isn't working.
>
> Next up will be a patch or patches fixing the issue.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

[...]

Kind regards
Uffe
