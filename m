Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34320C352A4
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 08:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0266B20733
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 08:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKmUY/4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgBJIld (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:41:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41720 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJIld (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 03:41:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id d11so5700469qko.8;
        Mon, 10 Feb 2020 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMzxO+pms4irASelkz3xREp787YtIXCiGVQgDQy0n+k=;
        b=sKmUY/4kCNfLJBv/3hfRzHt79AskEo4GgRKgBi+8cr+vj+I0MlA/zskHZja/cbDo+O
         xAESl0V8jIE8MQV6nLDzjAa7yf4v78AnR5awYoLzoKt4cfj6oS0zU5ryakzl9eY2AbXJ
         pa3ruoKQp8e+UlIHTsRmisxkECgRR9ctyzjVHOG8DqVNBNAfj0t0b5rh+D3sAMVPyqjM
         B3EXn6KYueDi+ssHc4l95KWEfcwxphI7gHFGFv9UCmvcQr6HtUjZLOpP3FDQKYLSSIQP
         s1C93kPjWEpPasua117Om4pMnVxoilNn++Xzq3t5Rb7GuyTeudW1QpGl1JLxBtA/PvoS
         asSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMzxO+pms4irASelkz3xREp787YtIXCiGVQgDQy0n+k=;
        b=K99pQGX1FtjnS1z2o0XGtSa5cMAU4zFX6JBzM+xQzVa4Yn9bjAaNFLoDA6IK0PlxMu
         ukmxPLn5hIV3LvbR/ZZo3DKJRiZ+hUrMvx8cu9XQlYFCu4wK34fKcduum+Ulpf/OikHL
         joPw7mcuMEUQOQiBf9RaYaZsH4pdcSVNNgN9Ap04J9iS0LNmjLbpA5CxU327zTIv2cK9
         rMYZfMoCbhrSx/fZ2tgdbJsei92Vfq4etxVdflz3vvUppDrkFhX5DMfPTZNNOF/6Bgai
         kHY11luKlQrnV8EqaaaKjxcBw1fhwRiPzlmLj1nTuPNVwMCSmLNHGRRZIz1z3/zTN4AO
         4lMA==
X-Gm-Message-State: APjAAAWPceMATuTbxIHx33OMsL7iw0G3x1n8LzfqYnXgWBaDNZ1CesSD
        T+WA58OQYDBr7fCkLZXq4OjHXkui9dQ2JpWRgPc=
X-Google-Smtp-Source: APXvYqy0KS0DKQM9QxfxyWZ8s4Z6fyhAmZi6o+euGuhDCCtDJfvt//oXsgMQH/s9bXOCobYjqgxaX9UUFB7HRjKtRIo=
X-Received: by 2002:a05:620a:a1e:: with SMTP id i30mr321910qka.133.1581324092193;
 Mon, 10 Feb 2020 00:41:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580894083.git.baolin.wang7@gmail.com> <CAPDyKFpqtCi4H7T99PguzsUi+-803EA-y+vXGK7C0cHVbzeJ6A@mail.gmail.com>
In-Reply-To: <CAPDyKFpqtCi4H7T99PguzsUi+-803EA-y+vXGK7C0cHVbzeJ6A@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 10 Feb 2020 16:41:20 +0800
Message-ID: <CADBw62rgoXjgoqaokhBqYCqAY-3vYnCq4iiVYaxZu_JJsufvDQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Add MMC software queue support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, Feb 6, 2020 at 11:00 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 5 Feb 2020 at 13:51, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi All,
> >
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
>
> In the regular request path (non CQE), we call mmc_blk_card_busy() to
> complete a request. For write I/O, this leads to calling
> card_busy_detect(), which starts to poll the card by sending a CMD13.
>
> At least one CMD13 will be sent to the card, before we exit the
> polling loop and a new I/O request can get submitted. However, in many
> cases, depending on the controller/host/card/request-size, my best
> guess is that *one* CMD13 might not be sufficient. At least, that is
> what I have observed on those platforms I recently have been working
> on.
>
> That said, I am wondering if you have done some measurement/profiling
> on this particular behaviour for your controller/driver? For example,
> how many CMD13 gets sent for random small writes during polling?

Ah, I had not checked how many CMD13 for random small writes before.
And I did a quick testing today, I found only 1 CMD13 gets sent for
random writes on my platform.


> Why am I asking this? Because, unless I am mistaken, when using the
> new hsq path that you introduce in $subject series, based on the cqe
> ops, then mmc_blk_card_busy() is not being called at all. In other
> words, you rely on HW busy detection from the controller/driver,
> rather than polling with CMD13. Is that correct?

Right. I think so.

> This seems like an additional reason to why you achieve significant
> improvements for the random write case. Don't you think?

Yes, agree wtih you.

> >
> > Thus this patch set will introduce the MMC software command queue support
> > based on command queue engine's interfaces, and set the queue depth as 64
> > to allow more requests can be be prepared, merged and inserted into IO
> > scheduler, but we only allow 2 requests in flight, that is enough to let
> > the irq handler always trigger the next request without a context switch,
> > as well as avoiding a long latency.
> >
> > Moreover we can expand the MMC software queue interface to support
> > MMC packed request or packed command instead of adding new interfaces,
> > according to previosus discussion.
> >
> > Below are some comparison data with fio tool. The fio command I used
> > is like below with changing the '--rw' parameter and enabling the direct
> > IO flag to measure the actual hardware transfer speed in 4K block size.
> >
> > ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
> >
> > My eMMC card working at HS400 Enhanced strobe mode:
> > [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> > [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> > [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> >
> > 1. Without MMC software queue
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> > Average speed: 59.66MiB/s
> >
> > 2) Random read:
> > Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> > Average speed: 27.04MiB/s
> >
> > 3) Sequential write:
> > Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> > Average speed: 69.68MiB/s
> >
> > 4) Random write:
> > Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> > Average speed: 35.96MiB/s
> >
> > 2. With MMC software queue
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> > Average speed: 60.68MiB/s
> >
> > 2) Random read:
> > Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> > Average speed: 31.36MiB/s
> >
> > 3) Sequential write:
> > Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> > Average speed: 71.66MiB/s
> >
> > 4) Random write:
> > Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> > Average speed: 68.76MiB/s
> >
> > Form above data, we can see the MMC software queue can help to improve some
> > performance obviously for random read and write, though no obvious improvement
> > for sequential read and write.
> >
> > Any comments are welcome. Thanks a lot.
> >
> > Changes from v7:
> >  - Add reviewed tag from Arnd.
> >  - Use the 'hsq' acronym for varibles and functions in the core layer.
> >  - Check the 'card->ext_csd.cmdq_en' in cqhci.c to make sure the CQE
> >  can work normally.
> >  - Add a new patch to enable the host software queue for the SD card.
> >  - Use the default MMC queue depth for host software queue.
>
> It would be nice to also have some measurements for an SD card, now
> that the series supports this. Is that possible for you test as well?

Yes, but my SD card works at high speed mode, and shows a low speed in
4k block size.
[    2.941965] mmc0: new high speed SDHC card at address b368
[    2.948325] mmcblk0: mmc0:b368 SD08G 7.42 GiB
[    2.956554]  mmcblk0: p1

And I did not see any obvious improvement or recession for my SD card
in 4k block size from below data, I think the most of the time is
spent in hardware. (But when I enabled the packed request based on
hsq, I can see some obvious improvement.)
Without hsq:
read: bw=4347KiB/s
randread: bw=3040KiB/s
write: bw=1361KiB/s
randwrite: bw=692KiB/s

With hsq:
read: bw=4246KiB/s
randread: bw=29950KiB/s
write: bw=1417KiB/s
randwrite: bw=697KiB/s
