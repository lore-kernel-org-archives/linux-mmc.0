Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA22C35242
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 04:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1802072C
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 04:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmzCHPm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBKErs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 23:47:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40873 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBKErs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 23:47:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so7022579qto.7;
        Mon, 10 Feb 2020 20:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8WJ/W+UW0dQGCW8Sq5kDx3v13kzVUPCKegMl5AIzlc=;
        b=gmzCHPm/KCovTjVzM1U7MO9lc336FJQNuSLBbi17+QoE51ZD8eXVjP8P3k8wayTD5a
         PmCmUFvtICDI69kRVVNyUQr0E/raEnnyhMF2kz5Nl/a561RQXjqxS8vPRp+dnlNiNNkW
         6aSFAquJgXFoOeAt/av01WIIqCT1PSDTu5lM8+o8OqeCOJ5Sd9IOCHsbJAxtpOcrlpDJ
         6dXeq8wsIJHlZ7cQ6rCaUBgcVcCD4uYTwJMOs++z/Hk2IHU+4Odfln+mtn/9QO+DAxox
         EAbnY+gKQ0YZRGb2OjJ7P3WLD6sPz3l7pwq3Kk03Wg//ABKs5jyyRDN5xJh+yjiguP9d
         3V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8WJ/W+UW0dQGCW8Sq5kDx3v13kzVUPCKegMl5AIzlc=;
        b=DxkVbMsdvADDHQw47Mr8YAFhXbbsZSfj8nYHiyAyZuai39Ekgm6vL1DAnK/tyJl+7C
         g9z0rofm6Lbl8oMfMS66FbIYnmQruXSVL4hq18v6419gaMalWr7mF6oJFbyGZOE6Wf6x
         H02iQxCg+BUklLJtolfPlpanKW0PyTtWgFGx/ULAPSKNRIpsy/Ctbk63WvGkQMThkP8y
         EQpgtXCLlljx2xmZSEiwTTF52HKPR90lHuarz18v9xOjpT8xabWxbtDjpbIjVKnyvqZB
         Ni7/muxEfupYXonrz0AeUHBeq/yWb0tW4Gor3yeJUup1LvvOk1qZ022pn4D3ffudEd6t
         idkg==
X-Gm-Message-State: APjAAAUnByUe0nXB13dQwNgqDmcrGeLaxl46JQrHu91SxhcyVaPEuvzf
        06bcOO6DWCzwDVOxcs1fLEzTKO2UaTsgPqKq6c4=
X-Google-Smtp-Source: APXvYqzRP2APAszas2j9Qd1f0VpxMEk5gASWrqucUV0SP3yLsfhVDKUVW3/4hKAwZRBuJuGVlTU08fgS4Y01gPoF/m4=
X-Received: by 2002:ac8:7b24:: with SMTP id l4mr871396qtu.3.1581396467073;
 Mon, 10 Feb 2020 20:47:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580894083.git.baolin.wang7@gmail.com> <CAPDyKFpqtCi4H7T99PguzsUi+-803EA-y+vXGK7C0cHVbzeJ6A@mail.gmail.com>
 <CADBw62rgoXjgoqaokhBqYCqAY-3vYnCq4iiVYaxZu_JJsufvDQ@mail.gmail.com> <CAPDyKFp6he4cvYGwyu8Jrdd5A-EDfdNOKahEE6zBU7VCb3TfTg@mail.gmail.com>
In-Reply-To: <CAPDyKFp6he4cvYGwyu8Jrdd5A-EDfdNOKahEE6zBU7VCb3TfTg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 11 Feb 2020 12:47:34 +0800
Message-ID: <CADBw62rg8Ofmh0+9Pyy_SuC_4ugxkBGBgKSchS4u5JGJAYYdJw@mail.gmail.com>
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

On Mon, Feb 10, 2020 at 9:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 10 Feb 2020 at 09:41, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > On Thu, Feb 6, 2020 at 11:00 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 5 Feb 2020 at 13:51, Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > Now the MMC read/write stack will always wait for previous request is
> > > > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > > > or queue a work to complete request, that will bring context switching
> > > > overhead, especially for high I/O per second rates, to affect the IO
> > > > performance.
> > >
> > > In the regular request path (non CQE), we call mmc_blk_card_busy() to
> > > complete a request. For write I/O, this leads to calling
> > > card_busy_detect(), which starts to poll the card by sending a CMD13.
> > >
> > > At least one CMD13 will be sent to the card, before we exit the
> > > polling loop and a new I/O request can get submitted. However, in many
> > > cases, depending on the controller/host/card/request-size, my best
> > > guess is that *one* CMD13 might not be sufficient. At least, that is
> > > what I have observed on those platforms I recently have been working
> > > on.
> > >
> > > That said, I am wondering if you have done some measurement/profiling
> > > on this particular behaviour for your controller/driver? For example,
> > > how many CMD13 gets sent for random small writes during polling?
> >
> > Ah, I had not checked how many CMD13 for random small writes before.
> > And I did a quick testing today, I found only 1 CMD13 gets sent for
> > random writes on my platform.
>
> Thanks for sharing the result, very interesting!
>
> Would you mind running a "dd write operation", to test large
> consecutive writes as those should cause longer busy times. Just to
> make sure the HW busy detection really works as expected.
>
> For example:
> dd of=/dev/mmcblk[n] if=/dev/zero bs=1M count=512 conv=fsync

Sure. I've run the dd command and still got the same result. Only 1
CMD13 for each write operation.

> > > Why am I asking this? Because, unless I am mistaken, when using the
> > > new hsq path that you introduce in $subject series, based on the cqe
> > > ops, then mmc_blk_card_busy() is not being called at all. In other
> > > words, you rely on HW busy detection from the controller/driver,
> > > rather than polling with CMD13. Is that correct?
> >
> > Right. I think so.
>
> A couple of follow up questions then.
>
> Normally, the mmc core adds the MMC_RSP_BUSY (part of MMC_RSP_R1B)
> response flag, for those commands having busy signaling on DAT0, like
> CMD6 for example. After the command has been sent, the core checks
> whether the host supports HW busy signaling, via the
> MMC_CAP_WAIT_WHILE_BUSY flag. If so the polling loop to detect when
> the card stops signaling busy, is skipped by the core. See
> __mmc_switch() and mmc_poll_for_busy(), for example.

Make sense.

> This makes me wonder, why doesn't your driver set the
> MMC_CAP_WAIT_WHILE_BUSY, as it seems to support HW busy signaling?

I think we should set this flag, but missed it before. And I did a
quick testing with setting this flag, I did not find any problem.
So I will post one patch to enable this flag with more stable testing.

> Moreover, it also seems like your driver can support
> MMC_CAP_DONE_COMPLETE. Or at least the part that requires HW busy

No. Cause we will complete the request in the irq context, if we set
this MMC_CAP_DONE_COMPLETE, we will call mmc_blk_mq_post_req()--->
mmc_post_req() in the irq context, which is a time-consuming operation
and not be allowed.

> detection for I/O write operations. I guess we also need your series,
> "[PATCH 0/3] Introduce the request_atomic() for the host"  as to
> support it. What do you think, would it be possible to test this at
> your side?

Yes, we need  this series ("[PATCH 0/3] Introduce the request_atomic()
for the host"), which is used to dispatch next request to the
controller in the irq context directly, to remove context switching.

> Note that, I haven't played with MMC_CAP_DONE_COMPLETE so far, but it
> was invented to allow optimization for these kind of situations.

I think the MMC_CAP_DONE_COMPLETE flag is used for this case: the host
controller completes requests in the irq thread or a workqueue
context, then we do not need queue the 'mq->complete_work' to complete
requests, instead we can compelete requests in the current context.

But now we will complete the requests in the irq context, so seems
MMC_CAP_DONE_COMPLETE is not useful here.

> Now, don't get me wrong, I still think we should move forward with
> @subject series. I just want to make sure we don't have several
> methods to implement the same thing. So perhaps, MMC_CAP_DONE_COMPLETE
> and the corresponding code should be removed, in favor of the more
> generic hsq interface?

Yes, now no host controllers set the MMC_CAP_DONE_COMPLETE flag, I
think we should remove this flag.

> > > This seems like an additional reason to why you achieve significant
> > > improvements for the random write case. Don't you think?
> >
> > Yes, agree wtih you.
> >
> > > >
> > > > Thus this patch set will introduce the MMC software command queue support
> > > > based on command queue engine's interfaces, and set the queue depth as 64
> > > > to allow more requests can be be prepared, merged and inserted into IO
> > > > scheduler, but we only allow 2 requests in flight, that is enough to let
> > > > the irq handler always trigger the next request without a context switch,
> > > > as well as avoiding a long latency.
> > > >
> > > > Moreover we can expand the MMC software queue interface to support
> > > > MMC packed request or packed command instead of adding new interfaces,
> > > > according to previosus discussion.
> > > >
> > > > Below are some comparison data with fio tool. The fio command I used
> > > > is like below with changing the '--rw' parameter and enabling the direct
> > > > IO flag to measure the actual hardware transfer speed in 4K block size.
> > > >
> > > > ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
> > > >
> > > > My eMMC card working at HS400 Enhanced strobe mode:
> > > > [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > > > [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > > > [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> > > > [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> > > > [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> > > >
> > > > 1. Without MMC software queue
> > > > I tested 5 times for each case and output a average speed.
> > > >
> > > > 1) Sequential read:
> > > > Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> > > > Average speed: 59.66MiB/s
> > > >
> > > > 2) Random read:
> > > > Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> > > > Average speed: 27.04MiB/s
> > > >
> > > > 3) Sequential write:
> > > > Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> > > > Average speed: 69.68MiB/s
> > > >
> > > > 4) Random write:
> > > > Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> > > > Average speed: 35.96MiB/s
> > > >
> > > > 2. With MMC software queue
> > > > I tested 5 times for each case and output a average speed.
> > > >
> > > > 1) Sequential read:
> > > > Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> > > > Average speed: 60.68MiB/s
> > > >
> > > > 2) Random read:
> > > > Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> > > > Average speed: 31.36MiB/s
> > > >
> > > > 3) Sequential write:
> > > > Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> > > > Average speed: 71.66MiB/s
> > > >
> > > > 4) Random write:
> > > > Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> > > > Average speed: 68.76MiB/s
> > > >
> > > > Form above data, we can see the MMC software queue can help to improve some
> > > > performance obviously for random read and write, though no obvious improvement
> > > > for sequential read and write.
> > > >
> > > > Any comments are welcome. Thanks a lot.
> > > >
> > > > Changes from v7:
> > > >  - Add reviewed tag from Arnd.
> > > >  - Use the 'hsq' acronym for varibles and functions in the core layer.
> > > >  - Check the 'card->ext_csd.cmdq_en' in cqhci.c to make sure the CQE
> > > >  can work normally.
> > > >  - Add a new patch to enable the host software queue for the SD card.
> > > >  - Use the default MMC queue depth for host software queue.
> > >
> > > It would be nice to also have some measurements for an SD card, now
> > > that the series supports this. Is that possible for you test as well?
> >
> > Yes, but my SD card works at high speed mode, and shows a low speed in
> > 4k block size.
> > [    2.941965] mmc0: new high speed SDHC card at address b368
> > [    2.948325] mmcblk0: mmc0:b368 SD08G 7.42 GiB
> > [    2.956554]  mmcblk0: p1
> >
> > And I did not see any obvious improvement or recession for my SD card
> > in 4k block size from below data, I think the most of the time is
> > spent in hardware. (But when I enabled the packed request based on
> > hsq, I can see some obvious improvement.)
> > Without hsq:
> > read: bw=4347KiB/s
> > randread: bw=3040KiB/s
> > write: bw=1361KiB/s
> > randwrite: bw=692KiB/s
> >
> > With hsq:
> > read: bw=4246KiB/s
> > randread: bw=29950KiB/s
> > write: bw=1417KiB/s
> > randwrite: bw=697KiB/s
>
> Thanks for testing and sharing!
>
> Did you use "[PATCH 0/3] Introduce the request_atomic() for the host"
> as well? In there, it seems like you are disabling the hsq option for

No, I did not use this series when testing, but I think the result
will be same. Since we will set host->always_defer_done as true for
removable SD cards.

> removable cards, or did I get that wrong? Does it matter?

No, I did not disable the hsq. In this series, we will not implement
the request_atomic() API for these removable cards, since we need
check the card status when handling a request, which maybe a sleepable
operation when detecting the card status (such as from GPIO), so we
can not disaptch next request in the irq context, instead we should
still set the host->always_defer_done as true for the removable cards.
