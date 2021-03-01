Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD89C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A4964E45
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 08:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhCAIZG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhCAIZC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Mar 2021 03:25:02 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB82C061788
        for <linux-mmc@vger.kernel.org>; Mon,  1 Mar 2021 00:24:22 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id i4so2530183vkc.12
        for <linux-mmc@vger.kernel.org>; Mon, 01 Mar 2021 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHCZlU+c9CUTU/gpQiF5hFVniv5vmhFaRF7G3ycFPv0=;
        b=CnbCOR7VKbhXI0bk25JR9P+t9AMdFZgv5kR4d/sgiZ2aNaTvn1yx2XRktQCLSI/yRN
         yjUIXW+HQYNDqhUGJnqbU4SFT2YjnqYkZb217Q1EUYQsxu0/fUifhQhjkdYYL+BLlVik
         BeiCyw7t8Oeo4IBHpmza8ZR9jR9L5AleyPSiWMdYvV6OjCrWVulqpIDFkoH/su5i8OAz
         NWP/AYWxTVOGUNS2bxgkBCEvnJ5tDL/cRt8zT/XFuOMKRdM4ZAUXtWDlta1hYsDbN8uS
         VknrxoVykR0+3NImhaRpBG81OzfYZr9CafNb+fwWcYgmlPKHqa0l/B65Xc7gwmOQphhF
         Ua4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHCZlU+c9CUTU/gpQiF5hFVniv5vmhFaRF7G3ycFPv0=;
        b=RmJKUtEp8DP6KdAbf9fHKf43japBnqJcaxiPP0XxucKZxu40WL2KU2X2BIVzJYTdbQ
         KMF/W6lyEXPuPoZmsuQ4ZSEtcV0247LYFaPfk1yRkRT7cvPzey1p5HUKzq1gMG70rsoS
         tbSQYCswiNKzhNr/VZooplTHPCSSylSCzTv0pvjLTS0Sf6kJzE3KQFVL87VOlBZyjqB0
         ZH8RE5oMXt2W+bO+Iz03g58wDT1uIRUo7p6OBLgB+4Dqr3CuYfZ0TvjX2MtqxjDYnP3e
         cLfPOow+f6DeVlYhyWe3K7xfLH50CE+X4zxQxRFbORP7eMQsao7xbcExfyZKc2gvjKev
         SDoA==
X-Gm-Message-State: AOAM533JGvjF2rrAdqJ0HfEL7cMfyQVkEqbvzMUJcC39abNl/l4PE39P
        ZqkbTMdYT6SCqU3DP2anaLs1trRJM/ue6mVeSnipMA==
X-Google-Smtp-Source: ABdhPJzvoEAOhO13PrlIDICiW+zZStCDpACerIy2ridZD7d00uMib+hyu24W5F9akMcfLFPYmiz9D15G43dtz9jNKIQ=
X-Received: by 2002:a1f:a68d:: with SMTP id p135mr7504410vke.6.1614587061060;
 Mon, 01 Mar 2021 00:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20210217052239.13780-1-dh0421.hwang@samsung.com>
 <CGME20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c@epcas1p2.samsung.com>
 <20210217052239.13780-3-dh0421.hwang@samsung.com> <4035139d-7850-8460-f069-06fc61d13039@intel.com>
 <3e6525b5-9cd7-e632-800a-1066c5fa3581@intel.com> <000001d70509$54bf59b0$fe3e0d10$@samsung.com>
In-Reply-To: <000001d70509$54bf59b0$fe3e0d10$@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Mar 2021 09:23:44 +0100
Message-ID: <CAPDyKFrgAanRYCe1QckWK8vxwV=rXV3KzTRynY_mkNaRkSrj+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add no single read retries
To:     DooHyun Hwang <dh0421.hwang@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>, ebiggers@google.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, Chanwoo Lee <cw9316.lee@samsung.com>,
        sh8267.baek@samsung.com, wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Feb 2021 at 09:46, DooHyun Hwang <dh0421.hwang@samsung.com> wrote:
>
>
> On 17/02/21 8:00 am, Adrian Hunter wrote:
> >On 17/02/21 7:46 am, Adrian Hunter wrote:
> >> On 17/02/21 7:22 am, DooHyun Hwang wrote:
> >>> This makes to handle read errors faster by not retrying multiple
> >>> block read(CMD18) errors with single block reads(CMD17).
> >>>
> >>> On some bad SD Cards that have problem with read operations, it is
> >>> not helpful to retry multiple block read errors with several single
> >>> block reads, and it is delayed to treat read operations as I/O error
> >>> as much as retrying single block reads.
> >>
> >> If the issue is that it takes too long, then maybe it would be better
> >> to get
> >> mmc_blk_read_single() to give up after a certain amount of time.
> >>
> >
> >So that a device property would not be needed I mean.  Then everyone would
> >benefit.

Just wanted to confirm with Adrian's points, that we don't want a
device property for this.

In fact, the DT maintainers would reject it because it would be
considered as a software configuration, which doesn't belong in DT.

>
> Thank you for reviewing this.
>
> mmc_blk_read_single() takes a different time depending on the number of
> sectors to read and the timeout value for each CMD.
>
> I think it's difficult to set the criteria for "a certain amount of time"
> you talked about.
> And it's harder to proceed with any errors caused by giving up in
> mmc_blk_read_single() than no retrying.
>
> So, I would like to add a configurable property to skip the single block
> read retrying because if multiple block read error occurs, single block
> read retrying doesn't help for some bad SD cards.

I certainly agree that falling back to single block reads is
questionable, at least for some cases. Moreover, I am pretty sure it's
not always the SD card that should be blamed, but a broken mmc host
driver or broken HW/controller.

That said, I assume that the main reason why we fall back to retry
with single block reads, is to try to recover as much data as possible
from a broken SD card. The intent is good, but to recover data from a
broken card, we should also consider to move to a lower/legacy speed
mode and to decrease the clock rate of the interface.

For the clock rate, we already have a debugfs node, allowing us to
change the rate per mmc host. I suggest we add a few more debugfs
nodes, allowing us to restrict the speed mode and to enable/disable
single/multi block read.

If we can get these things in place to help with recovery, I wouldn't
mind us changing the default behaviour to skip the single block read
in the recovery path.

>
> This is the log to check for this patch.
> #0. time difference is about 2.37s for 8 sectors between with(#1) and without(#2)
>      single block read retrying
>      This is a test for just one CMD18.
>      When there are many I/O requests, it takes too long to handle the errors.
>
> #1. retry multiple block read (8 sectors) error with single block reads
> // It takes about 3.585671s for the I/O error.
> // issue CMD23 (+ arg 0x8)
> // issue CMD18 (+ arg 0x000320e0) and error occurs
> <7>[  316.657115]  [5:   kworker/5:1H:  324] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  316.657124]  [5:   kworker/5:1H:  324] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> <7>[  316.826302] I[0:      swapper/0:    0] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
> <7>[  316.826327] I[0:      swapper/0:    0] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> <7>[  316.826362] I[0:      swapper/0:    0] mmc0:     0 bytes transferred: -110
> <7>[  316.826389] I[0:      swapper/0:    0] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> <7>[  316.826516]  [0:   kworker/0:1H:  338] mmc0: starting CMD13 arg 00010000 flags 00000195
> <7>[  316.826621] I[0:   kworker/0:1H:  338] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> // retry CMD18 (+ arg 0x000320e0) and error occurs again. Same as above.
> <7>[  316.829224]  [5:   kworker/5:1H:  324] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  316.829237]  [5:   kworker/5:1H:  324] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> <7>[  316.999588] I[0:      swapper/0:    0] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
> <7>[  316.999653] I[0:      swapper/0:    0] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> <7>[  316.999725] I[0:      swapper/0:    0] mmc0:     0 bytes transferred: -110
> <7>[  316.999789] I[0:      swapper/0:    0] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> <7>[  317.000034]  [0:   kworker/0:1H:  338] mmc0: starting CMD13 arg 00010000 flags 00000195
> <7>[  317.000370] I[0:   kworker/0:1H:  338] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> // mmc_blk_reset() and it's completed
> <7>[  317.000523]  [0:   kworker/0:1H:  338] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> ...
> // mmc_blk_read_single() : CMD17, CMD13 and CMD12 repeats 8 times (for retrying multiple block read with 8 sectors)
> // CMD17 (+ arg 0x000320e0 ~ 0x000320e7) and timeout errors occur
> // It takes about 1.351s
> <7>[  317.200351]  [0:   kworker/0:1H:  338] mmc0: starting CMD17 arg 000320e0 flags 000000b5
> <7>[  317.368748] I[0:      swapper/0:    0] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> <7>[  317.368776] I[0:      swapper/0:    0] mmc0:     0 bytes transferred: -110
> <7>[  317.368871]  [0:   kworker/0:1H:  338] mmc0: starting CMD13 arg 00010000 flags 00000195
> <7>[  317.368932] I[0:   kworker/0:1H:  338] mmc0: sdhci: IRQ status 0x00000001
> <7>[  317.368970] I[0:   kworker/0:1H:  338] mmc0: req done (CMD13): 0: 00000b00 00000000 00000000 00000000
> <7>[  317.369020]  [0:   kworker/0:1H:  338] mmc0: starting CMD12 arg 00000000 flags 00000095
> <7>[  317.369070] I[0:   kworker/0:1H:  338] mmc0: sdhci: IRQ status 0x00000001
> <7>[  317.369108] I[0:   kworker/0:1H:  338] mmc0: req done (CMD12): 0: 00000b00 00000000 00000000 00000000
> <7>[  317.369155]  [0:   kworker/0:1H:  338] mmc0: starting CMD13 arg 00010000 flags 00000195
> <7>[  317.369204] I[0:   kworker/0:1H:  338] mmc0: sdhci: IRQ status 0x00000001
> <7>[  317.369245] I[0:   kworker/0:1H:  338] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> <3>[  317.369298]  [0:   kworker/0:1H:  338] print_req_error: I/O error, dev mmcblk0, sector 205024
> <7>[  317.369342]  [0:   kworker/0:1H:  338] mmc0: starting CMD17 arg 000320e1 flags 000000b5
> ...
> <7>[  318.382668]  [0:   kworker/0:1H:  338] mmc0: starting CMD17 arg 000320e7 flags 000000b5
> <3>[  318.551568]  [0:   kworker/0:1H:  338] print_req_error: I/O error, dev mmcblk0, sector 205031
> // retry CMD18 (+ arg 0x000320e0) and error occurs again.
> <7>[  318.551850]  [5:   kworker/5:1H:  324] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  318.551867]  [5:   kworker/5:1H:  324] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> ...
> // retry CMD18 (+ arg 0x000320e0) and error occurs again.
> <7>[  318.721767]  [5:   kworker/5:1H:  324] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> // CMD17 (+ arg 0x000320e0 ~ 0x000320e7)
> <7>[  318.891054]  [0:   kworker/0:1H:  338] mmc0: starting CMD17 arg 000320e0 flags 000000b5
> ...
> <7>[  320.073861]  [0:   kworker/0:1H:  338] mmc0: starting CMD17 arg 000320e7 flags 000000b5
> // Return I/O error for read operation finally
> <3>[  320.242786]  [0:   kworker/0:1H:  338] Buffer I/O error on dev mmcblk0, logical block 25628, async page read
>
> #2. retry multiple block read (8 sectors) error without single block reads
> // It takes about 1.205941s for the I/O error.
> // issue CMD23 (+ arg 0x8)
> // issue CMD18 (+ arg 0x000320e0) and error occurs
> <7>[  126.467114]  [7:   kworker/7:2H: 8887] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  126.467125]  [7:   kworker/7:2H: 8887] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> <7>[  126.636188] I[0:Measurement Wor: 9074] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
> <7>[  126.636213] I[0:Measurement Wor: 9074] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> <7>[  126.636241] I[0:Measurement Wor: 9074] mmc0:     0 bytes transferred: -110
> <7>[  126.636265] I[0:Measurement Wor: 9074] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> <7>[  126.636379]  [0:   kworker/0:1H:  336] mmc0: starting CMD13 arg 00010000 flags 00000195
> <7>[  126.636495] I[0:   kworker/0:1H:  336] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> // retry CMD18 (+ arg 0x000320e0) and error occurs again. Same as above.
> <7>[  126.638284]  [7:   kworker/7:2H: 8887] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  126.638298]  [7:   kworker/7:2H: 8887] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> // mmc_blk_reset() and it's completed
> <7>[  126.807645]  [0:   kworker/0:1H:  336] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> ...
> // no mmc_blk_read_single() calling
> // retry CMD18 (+ arg 0x000320e0) and error occurs again.
> <7>[  126.993628]  [7:   kworker/7:2H: 8887] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  126.993643]  [7:   kworker/7:2H: 8887] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> // retry CMD18 (+ arg 0x000320e0) and error occurs again.
> <7>[  127.164836]  [7:   kworker/7:2H: 8887] <mmc0: starting CMD23 arg 00000008 flags 00000015>
> <7>[  127.164848]  [7:   kworker/7:2H: 8887] mmc0: starting CMD18 arg 000320e0 flags 000000b5
> ...
> // Return I/O error for read operation finally
> <3>[  127.673055] I[7:      swapper/7:    0] Buffer I/O error on dev mmcblk0, logical block 25628, async page read
>

Kind regards
Uffe
