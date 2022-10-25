Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8244BC04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 10:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiJYKv7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiJYKv5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 06:51:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1A83F38
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 03:51:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso9293854pjc.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMR0ddTFv7GdRVa2PRqCa57wNNnrO53l74+NorYNmr4=;
        b=RmHRWjPq8zpVDXhGHMkdsICNtBK+vkVv5YYXjWErNyLDNr9MtDPDJneXT+Zj7gaxqx
         ANEflr71UPYszURYPBkJ/+sEVCvMr/LtwygomMG/jF3HUJaIIxk52f3QSkuEnx6IbZ1M
         y43PANUXj8RfxRZrbbF/tbYQDinV6IA4CwVQIBFwaMV3eSoQ9qtLHy36t1zMf6mB6uT8
         ehnp79FxWUkQWX859rdNYlegfmIVXbF89gS03xesBlh56zMR+5UIr+7Fm/TZzAMG+2fZ
         0XeKLuur0uc++20RgHl/2nivcJaKT9uVBfCACadDXYOucl0P863LXDlQX/rmg5XiJbVg
         dmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMR0ddTFv7GdRVa2PRqCa57wNNnrO53l74+NorYNmr4=;
        b=XAI3SAMoP0tL1cUG3DMWBcn7iiSZRLZm0LhcsMJdnhpdqcZb2oruOc2JJpSoojQli+
         QpzXTA4SyYjIikLjNOvSZ4TFyMgCVnZLmbGJQR23lVPB1W09MvKrRfqnGLQeaR5Saj5n
         2iZkUn5C5B2WXTFJFkTAz11PaQ3lSYnn1XHcsH4B1LFmRG6ZzyL2La9hbaMhhM/1Fn+j
         NBsrxIzjBVpTMDipz7ESkiNhOb0mjUtksRb5ECYw/RJKUgEwkuFjOblMeXUTgpdD46fI
         nscvOwUhF7GAis89xVZrCuUUqZaXojouzBRk07/FwpvNsNUvRTu/EWW8LrYlFvrrBwEY
         8Psw==
X-Gm-Message-State: ACrzQf2VcGqp2+/QoFNfxIgXOvLbzdPNS0mS4MmDtZ554cZVZb8wC7t+
        /PSqB+yH0Ix6pJ7qqFiGXDC0r3QKgFUDo+qYaqD7YBg2XC4=
X-Google-Smtp-Source: AMsMyM6pCrEhaEVZ6R6ud+2CoXjO1iBU5GcPQ4aaVIFN77cJ8BQJUiXqJtflvOZxnqhYZNJ9Zk0aeCKRccCeA7Zc1NU=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr81462696pjb.164.1666695115318; Tue, 25
 Oct 2022 03:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Oct 2022 12:51:18 +0200
Message-ID: <CAPDyKFqA1RtcaGMCQgDsKKju4izHWJRAD12SqqirNm+TWLt_hA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] mmc: renesas_sdhi: add support for DMA end irqs
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

On Thu, 6 Oct 2022 at 21:05, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Motivation for this series from patch 5:
>
> ===
> So far, we have been relying on access_end interrupts only to mark DMA
> transfers as done implying that DMA end interrupts have occurred by then
> anyhow. On some SoCs under some conditions, this turned out to be not
> enough. So, we enable DMA interrupts as well and make sure that both
> events, DMA irq and access_end irq, have happened before finishing the
> DMA transfer.

The tmio/sdhi core still relies on using tasklets. I think we should
strive to move away from tasklets for all mmc host drivers and to use
threaded irqs instead.

That said, I am worried that it might be harder to move away from
tasklets beyond $subject series, for tmio/sdhi, but I might be wrong?
So, I am wondering if it perhaps would be better to make that
modernization/conversion as the first step instead?

Kind regards
Uffe


> ===
>
> The first two patches are cleanups. For the rest, the basis were BSP
> patches, but they have been refactored heavily, so they look very
> different now:
>
> * self-contained
>   except for the new dma_irq callback which is for the TMIO core, all
>   other code is self-contained in renesas_sdhi_internal_dmac now.
> * concise
>   Less new members for the existing structs, also code duplication was
>   avoided by moving code to more suitable locations
> * replaced the spinlock with atomic bit operators
> * used quirk mechanism for the old INFO1 layout
>
> Tested on a Salvator-X board with M3-W (r8a77960) and a Salvator-XS
> board with M3-N (r8a77965). No regression encountered in functionality
> and performance. A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/upport_dmaend
>
>
> Here are excerpts of a log when booting the M3-N with patch 6 applied to
> show that all combinations of incoming irqs are handled:
>
> === DMA first, Access second ===
>
>           <idle>-0       [000] d.h..     0.505454: renesas_sdhi_internal_dmac_dma_irq: DMA end
>           <idle>-0       [000] d.h..     0.505496: renesas_sdhi_internal_dmac_dataend_dma: Access end: 0
>           <idle>-0       [000] ..s..     0.505498: renesas_sdhi_internal_dmac_complete_tasklet_fn: Tasklet
>
> === Access first, DMA second ===
>
>      kworker/0:2-42      [000] d.h..     0.510603: renesas_sdhi_internal_dmac_dataend_dma: Access end: 0
>      kworker/0:2-42      [000] d.h..     0.510605: renesas_sdhi_internal_dmac_dma_irq: DMA end
>      kworker/0:2-42      [000] ..s..     0.510606: renesas_sdhi_internal_dmac_complete_tasklet_fn: Tasklet
>
> === Access first, Simulated DMA second ===
>
>           <idle>-0       [000] d.H..     0.510635: renesas_sdhi_internal_dmac_dataend_dma: Access end: 0
>           <idle>-0       [000] ..s..     0.510637: renesas_sdhi_internal_dmac_issue_tasklet_fn: Simulated DMA end
>           <idle>-0       [000] ..s..     0.510638: renesas_sdhi_internal_dmac_complete_tasklet_fn: Tasklet
>
> (I have never seen Simulated DMA (= CMD error happened) first, but it
> should be handled like regular DMA end as well(tm).)
>
> === Access first, no DMA end needed because of DATA error (EILSEQ) ===
>
>           <idle>-0       [000] d.H..     0.510894: renesas_sdhi_internal_dmac_dataend_dma: Access end: -84
>           <idle>-0       [000] ..s..     0.510896: renesas_sdhi_internal_dmac_complete_tasklet_fn: Tasklet
>
> ===
>
> I think this is as far as I can reach alone. I'd love to get review
> comments and further testing. Shimoda-san, can you kindly ask the BSP
> team to do further testing?
>
> Thank you everyone and happy hacking,
>
>    Wolfram
>
>
> Wolfram Sang (6):
>   mmc: renesas_sdhi: remove accessor function for internal_dmac
>   mmc: renesas_sdhi: improve naming of DMA struct
>   mmc: tmio: add callback for dma irq
>   mmc: renesas_sdhi: add quirk for broken register layout
>   mmc: renesas_sdhi: take DMA end interrupts into account
>   DEBUG mmc: renesas_sdhi: debug end_flags for DMA
>
>  drivers/mmc/host/renesas_sdhi.h               | 14 ++-
>  drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 86 ++++++++++++-------
>  drivers/mmc/host/tmio_mmc.h                   |  1 +
>  drivers/mmc/host/tmio_mmc_core.c              |  3 +
>  5 files changed, 72 insertions(+), 34 deletions(-)
>
> --
> 2.35.1
>
