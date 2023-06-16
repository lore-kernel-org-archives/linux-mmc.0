Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D5EB64DB
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 10:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjFPKDm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbjFPKDj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 06:03:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4592137
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 03:03:34 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc492cb6475so411494276.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686909813; x=1689501813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZalAiwx5INs4sTs2rezAac4qLbCIGtdPtEafE9t5JwM=;
        b=EeFUEI2t7jobknZ8zv/bHZpwxgzBFMZORO5HozJEtFAGH9XAotfx4vDLnlgM2MWbAM
         HVm5VHmLeJ77b9St0CmMpfUDkDdxuD5SsnVpBU8ExPsUca/YZbEwFhQM9WzYg4fSHfvU
         y+tE9VdYSHFFq2kGCQLwOEFbS4oLOQya3jum2y0bwPh8qoN40qeWKyzZ8DE2D6whXwdu
         FlJKNE8wJm7QHeSm/jMGg1law2g2+tA0KbFkorzhGgCBnUkJcejamJkDUNN8RZXHcCjB
         rmhRfMIipQwBSoDxGdlF5EZ9IHiJtDOUzZbmsAaQOK+YD/NcIvZsNnIirEFDz4qUeDfR
         MceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686909813; x=1689501813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZalAiwx5INs4sTs2rezAac4qLbCIGtdPtEafE9t5JwM=;
        b=EdfLbOOJ1HENjloVjGwkkPiWIGjrLCJPXHrlm9igsrKcGNQQ+W0rtWft1d+J0GNJom
         1o/9CAx3/0eYCYpGro0gpysWuynUkznQyN1ygSjw5Krps4vU8Hm8hS5MHrEPFtcq0s/u
         rqDU6lvlpZ2jkugfrANBw0ykSjhVvXeu3TYlb7L/LF11ki2VBKJRIUce+Ko+vMzsMNfF
         tejTYayclFPG/cTC5qPuj0pn+SaIHIukDv5wKoQ8W963IWypFjT+TnE5uKWb59g9wOTJ
         gKGcYTTHl0AP+AS38H3xVhY+/87/isEDcC8hr8iruwtaySy8L8XCVJYnSd5j1jRi2SIK
         8vpg==
X-Gm-Message-State: AC+VfDzjYeLmDq+kkhI4ayoYl3epjXSo4fr4fCbjBa/CNmyyTVB0H9VA
        N5YgfUwUYKImBGbzOvfNqVQJH1Ac48Fv+DnN/S/zpgsgrdsoitXd
X-Google-Smtp-Source: ACHHUZ4l5BTCqkVdQmmBBWQPscMhro1y2lUjuRWkpikUnbZ2LKvZ6iJzAlmxL0kCuuEBYyelrsuSSJtGk2Osd6HfZTw=
X-Received: by 2002:a25:f43:0:b0:bc6:de82:fa22 with SMTP id
 64-20020a250f43000000b00bc6de82fa22mr1032844ybp.51.1686909813275; Fri, 16 Jun
 2023 03:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230531002740.1235620-1-marex@denx.de> <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
 <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de> <f41e1546-f6d3-7f4d-7662-3b7eca291178@intel.com>
 <29a5f24d-2b8c-8387-8c11-601af8e13940@denx.de> <4c8d84ae-c8d0-fa12-81c6-a47382684d73@intel.com>
 <3bd65a30-756d-e7ee-ce77-e5ebfe6b6e30@denx.de> <75ab27e9-9203-f59b-c720-99bfa992bb9b@intel.com>
 <b494062c-7e9e-24ba-ef0a-13faf0fe7706@denx.de> <a316b98e-fe56-23a3-7d58-13fcd5d9abb5@intel.com>
 <0029620e-4d22-d8f9-5566-4b1ea7f05bae@denx.de> <CAPDyKFoe0WWs2-wSETMZR5shjmWnLfD4GPwOXJNhyKd8xntq8A@mail.gmail.com>
 <e6243501-908d-dec9-36ef-206c20ccf8cc@intel.com> <6423ae91-7585-b141-960a-f8cfd4b23538@denx.de>
In-Reply-To: <6423ae91-7585-b141-960a-f8cfd4b23538@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Jun 2023 12:02:55 +0200
Message-ID: <CAPDyKFo5PfSWfZdyq25P87hvpZd4=GC54zp-SbjRZE1EZNoFxQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
To:     Marek Vasut <marex@denx.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>, xander_li@kingston.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Jun 2023 at 17:37, Marek Vasut <marex@denx.de> wrote:
>
> On 6/15/23 17:35, Adrian Hunter wrote:
> > On 15/06/23 18:14, Ulf Hansson wrote:
> >> On Mon, 12 Jun 2023 at 10:59, Marek Vasut <marex@denx.de> wrote:
> >>>
> >>> On 6/12/23 06:59, Adrian Hunter wrote:
> >>>> On 7/06/23 23:43, Marek Vasut wrote:
> >>>>> On 6/4/23 18:30, Adrian Hunter wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >>>>>>>>>> index 72b664ed90cf..9c3123867a99 100644
> >>>>>>>>>> --- a/drivers/mmc/core/sd.c
> >>>>>>>>>> +++ b/drivers/mmc/core/sd.c
> >>>>>>>>>> @@ -1313,6 +1313,8 @@ static int sd_flush_cache(struct mmc_host *host)
> >>>>>>>>>>       {
> >>>>>>>>>>           struct mmc_card *card = host->card;
> >>>>>>>>>>           u8 *reg_buf, fno, page;
> >>>>>>>>>> +    unsigned long timeout;
> >>>>>>>>>> +    bool expired;
> >>>>>>>>>>           u16 offset;
> >>>>>>>>>>           int err;
> >>>>>>>>>>       @@ -1338,11 +1340,15 @@ static int sd_flush_cache(struct mmc_host *host)
> >>>>>>>>>>               goto out;
> >>>>>>>>>>           }
> >>>>>>>>>>       +    timeout = jiffies + msecs_to_jiffies(SD_WRITE_EXTR_SINGLE_TIMEOUT_MS) + 1;
> >>>>>>>>>> +again:
> >>>>>>>>>>           err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> >>>>>>>>>>                       MMC_BUSY_EXTR_SINGLE);
> >>>>>>>>>>           if (err)
> >>>>>>>>>>               goto out;
> >>>>>>>>>>       +    expired = time_after(jiffies, timeout);
> >>>>>>>>>> +
> >>>>>>>>>>           /*
> >>>>>>>>>>            * Read the Flush Cache bit. The card shall reset it, to confirm that
> >>>>>>>>>>            * it's has completed the flushing of the cache.
> >>>>>>>>>> @@ -1354,8 +1360,12 @@ static int sd_flush_cache(struct mmc_host *host)
> >>>>>>>>>>               goto out;
> >>>>>>>>>>           }
> >>>>>>>>>>       -    if (reg_buf[0] & BIT(0))
> >>>>>>>>>> -        err = -ETIMEDOUT;
> >>>>>>>>>> +    if (reg_buf[0] & BIT(0)) {
> >>>>>>>>>
> >>>>>>>>> I am getting here, multiple times, with expired=0 .
> >>>>>>>>
> >>>>>>>> So either the host controller's busy detection does not work, or the
> >>>>>>>> card is not indicating busy by pulling down DAT0.
> >>>>>>>>
> >>>>>>>> Can you try to figure out which it is?
> >>>>>>>
> >>>>>>> The byte 261 bit 0 is never cleared, I had this looping for an hour and the 'Flush Cache' bit just never got cleared. The SD spec 6.00 and 9.00 both indicate the bit should be cleared by the card once cache flush is completed.
> >>>>>>>
> >>>>>>> I tried three different controllers now -- STM32MP15xx ARM MMCI, i.MX6Q uSDHC, laptop rtsx_pci_sdmmc , they all fail.
> >>>>>>>
> >>>>>>> I tried to find another card which also has cache, I cannot find any other card, all the rest report no cache. The kingston card SSR (see the 2ff in 6th field, the last f bit 2 is cache supported indication, SSR bit 330):
> >>>>>>>
> >>>>>>> 00000000:08000000:04009000:011b391e:00080000:0002ff00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
> >>>>>>>
> >>>>>>> So either this card is weird, or the cards with cache are so rare that nobody noticed the problem yet.
> >>>>>>
> >>>>>> The patch set cover letter says it was tested with 64GB Sandisk Extreme PRO UHS-I A2 card
> >>>>>>
> >>>>>>       https://lore.kernel.org/linux-mmc/20210506145829.198823-1-ulf.hansson@linaro.org/
> >>>>>
> >>>>> I got that one now, tested it, the cache bit is being cleared correctly. I also tested a few more cards and dumped their SSR too:
> >>>>>
> >>>>> Kingston Canvas Go! Plus:
> >>>>> 80000000:08000000:04009000:011b391e:00080000:0002ff00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
> >>>>> Flush never finishes
> >>>>>
> >>>>> Sandisk Extreme PRO A2 64GiB:
> >>>>> 80000000:08000000:04009000:0f05391e:00080000:0002fc00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
> >>>>> mmc0: flushing cache took 5 ms, 1 iterations, error 0
> >>>>>
> >>>>> Goodram IRDM V30 A2 64GiB:
> >>>>> 80000000:08000000:0400a001:00fd3a1e:00080000:00023c00:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
> >>>>> mmc0: flushing cache took 5 ms, 1 iterations, error 0
> >>>>>
> >>>>> Samsung Pro Plus 512GiB V30 A2 (ext reg general info is all zeroes, cache not enabled):
> >>>>> 80000000:08000000:04009000:0811391e:00080000:0002fc00:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
> >>>>>
> >>>>>> I ordered a Kingston Canvas Go Plus card as you described but it won't arrive for a week.
> >>>>>
> >>>>> I'm really interested in what you would find with that one.
> >>>>
> >>>> It worked just fine, but maybe it is a newer version of hw / firmware - the date is 04/2023
> >>>>
> >>>> $ grep -H . /sys/class/mmc_host/mmc0/mmc0\:5048/*
> >>>> grep: /sys/class/mmc_host/mmc0/mmc0:5048/block: Is a directory
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/cid:9f54495344363447614b1004af017400
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/csd:400e00325b590001cf9f7f800a400000
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/date:04/2023
> >>>> grep: /sys/class/mmc_host/mmc0/mmc0:5048/driver: Is a directory
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/dsr:0x404
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/erase_size:512
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/fwrev:0x1
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/hwrev:0x6
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/manfid:0x00009f
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/name:SD64G
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/ocr:0x00200000
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/oemid:0x5449
> >>>> grep: /sys/class/mmc_host/mmc0/mmc0:5048/power: Is a directory
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/preferred_erase_size:4194304
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/rca:0x5048
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/scr:0205848701006432
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/serial:0x4b1004af
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/ssr:000000000800000004009000011b391e000800000002ff0003000000000000000000000000000000000000000000000000000000000000000000000000000000
> >>>> grep: /sys/class/mmc_host/mmc0/mmc0:5048/subsystem: Is a directory
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/type:SD
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:DRIVER=mmcblk
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:MMC_TYPE=SD
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:MMC_NAME=SD64G
> >>>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:MODALIAS=mmc:block
> >>>
> >>> This one I have here is certainly older (this time tested on STM32MP135F):
> >>>
> >>> $ grep -H . /sys/class/mmc_host/mmc0/mmc0\:5048/*
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/cid:9f544953443634476136980065013b7e
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/csd:400e00325b590001cfff7f800a4000fa
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/date:11/2019
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/dsr:0x404
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/erase_size:512
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/fwrev:0x1
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/hwrev:0x6
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/manfid:0x00009f
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/name:SD64G
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/ocr:0x00300000
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/oemid:0x5449
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/preferred_erase_size:4194304
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/rca:0x5048
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/scr:0205848701006432
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/serial:0x36980065
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/ssr:000000000800000004009000011b391e000800000002ff0003000000000000000000000000000000000000000000000000000000000000000000000000000000
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/type:SD
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:DRIVER=mmcblk
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:MMC_TYPE=SD
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:MMC_NAME=SD64G
> >>> /sys/class/mmc_host/mmc0/mmc0:5048/uevent:MODALIAS=mmc:block
> >>>
> >>> cid, csr, date, ocr, serial differ.
> >>
> >> I have been trying to follow the progress around this matter. If I
> >> understand correctly we are leaning towards making a card quirk for
> >> this particular SD, to avoid us from turning on and using a broken
> >> cache feature.
> >>
> >> Or what are you thinking?
> >
> > That is probably the simplest option.
>
> Just give me a day or two to test the other newer card.
>
> What would you base that quirk off of ? Date ? We don't know when the
> "fixed" cards started to be produced .

Right. It seems like the best we can do is to make a quirk for that
particular version of card that you proved to have failed.

Kind regards
Uffe
