Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE4C64E7B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C563B2084C
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 11:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHfzAnbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgLALxU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgLALxT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2020 06:53:19 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5728C0613D3
        for <linux-mmc@vger.kernel.org>; Tue,  1 Dec 2020 03:52:33 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id k17so727027vsp.13
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2020 03:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGqFHmSelqvHHbOKtvOpBN/MsYcW5UYeeW+zWHYJy2I=;
        b=OHfzAnbwJWgjZQg+IndkUdNllCtJ5rcVTqBC3YWo6j+PVWl2HmjXvQOZSVTQjZkpnL
         lSz4g+a9INi83o5XPNe4YTvMBEIyGT8D/fznL7qMiHAVlf5kxg5RqNqGXcAE+qaWsO6Y
         blWb+RW9wW48/NmlzkVQZqJBMQEYRUGiHvkFSv6aSdu0Lzho7fP3U9zMKmyJB4jXqZhi
         PsjwCGnQEMxhMUDLxWaR/XzXvivyTz7skNgKrAXbW0GY4H5vgeFYNQ7NRnlnckX2J2tm
         M4pne1DNL/NSd+y9dDKTi4pO5/b1KoWv/8B2bT9gEFA91FGGPSUu3UBQE5tRDeErSaX7
         y1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGqFHmSelqvHHbOKtvOpBN/MsYcW5UYeeW+zWHYJy2I=;
        b=QCCdoiVDrNnqk/7yvaAfXDffo02xwYgK7rzA4yfBE8ZrJ8a17h/kLGQ0AALh2/hjuW
         XZKloMF8qDPk01b4YX97w8IHd3zSR4GTdf+vQaoE1lK1UacHTs2P0cbZgpDVM1nVJZmO
         tq7xqkeGDyZYvClroAt8zk/DUqyK0mvJRjzROj1RDU/JjCwZtQbOM9sI4E3xA+D8Gw3N
         vlIpNTlXEvTGW/eQ+ACZa1dQC2F/sSqyAquQ/MDze+s1AIyz3JCdlEZjc5uQIj8/wXnm
         XZz/W3Zv9aDqS3nLF8WKU/jRQWLWwOsODcJuLmjb0GIHp11DQWp7c2jr07GcNmL8fZCE
         uP6A==
X-Gm-Message-State: AOAM5300BOjwbyGe3bgjNaZLuwwWgFKox+7PiH+sjI2zihBmysMxNQnn
        8gkqvYUQp20YQGnlW54jbkDLUuvU8xd4QsEzCVOuiN1/1wwLRQ==
X-Google-Smtp-Source: ABdhPJyOw1/OrAemUjmu3QU03AP+qOZ+sle5QJFXJPpVR9PBEgf+a5Lu4GSwu8MWksxCy3PHyT7VsXel42yqP5Gy5GQ=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr1825770vsc.34.1606823553041;
 Tue, 01 Dec 2020 03:52:33 -0800 (PST)
MIME-Version: 1.0
References: <c5252887-e4f9-953d-88df-d8cc62ecd136@eaxlabs.cz>
 <CAPDyKFr8t-u_4YkuCzQ3Xd3VgxkTq_Anu+NzBo4Pfj8SLBnsvg@mail.gmail.com> <3ce48390-a4fd-f833-1cb5-9f9e140065b8@eaxlabs.cz>
In-Reply-To: <3ce48390-a4fd-f833-1cb5-9f9e140065b8@eaxlabs.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Dec 2020 12:51:56 +0100
Message-ID: <CAPDyKFqHmpPZ=igi_TPEE4Tw4LdF-cAyJW-8yH+ePnG+L0Mixg@mail.gmail.com>
Subject: Re: armmmci rmmod causes hung tasks
To:     Martin DEVERA <devik@eaxlabs.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 30 Nov 2020 at 18:20, Martin DEVERA <devik@eaxlabs.cz> wrote:
>
> On 11/30/20 4:08 PM, Ulf Hansson wrote:
> > On Sun, 29 Nov 2020 at 19:20, Martin DEVERA <devik@eaxlabs.cz> wrote:
> >> Hello,
> >>
> >> on STM32MP1 with almost vanilla 5.7.7 in single CPU mode. Pair of
> >> modprobe armmmci ; rmmod armmmci
> >>
> >> causes rmmod and kworker to hang. I should note that no MMC is detected
> >> on the board (SDIO device on MMC bus is not responding).
> >> On another board (where SDIO is responding) rmmod works.
> >>
> >> It seems as another manifestation of https://lkml.org/lkml/2019/8/27/945
> >>
> >> Thanks.
> >>
> >> INFO: task kworker/0:1:12 blocked for more than 368 seconds.
> >>         Not tainted 5.7.7kdb-00003-g10397828596c-dirty #224
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> kworker/0:1     D    0    12      2 0x00000000
> >> Workqueue: events_freezable mmc_rescan
> >> (__schedule) from (schedule+0x5b/0x90)
> >> (schedule) from (schedule_timeout+0x1b/0xa0)
> >> (schedule_timeout) from (__wait_for_common+0x7d/0xdc)
> >> (__wait_for_common) from (mmc_wait_for_req_done+0x1b/0x8c)
> >> (mmc_wait_for_req_done) from (mmc_wait_for_cmd+0x4d/0x68)
> >> (mmc_wait_for_cmd) from (mmc_io_rw_direct_host+0x87/0xc8)
> >> (mmc_io_rw_direct_host) from (sdio_reset+0x3b/0x58)
> >> (sdio_reset) from (mmc_rescan+0x15d/0x1d4)
> >> (mmc_rescan) from (process_one_work+0xdd/0x168)
> >> (process_one_work) from (worker_thread+0x17d/0x1ec)
> >> (worker_thread) from (kthread+0x9b/0xa4)
> >> (kthread) from (ret_from_fork+0x11/0x28)
> > It looks like the worker thread, which runs mmc_rescan() to try to
> > detect the SDIO card is hanging. Exactly why, I don't know.
> >
> > Could be a misconfigured clock, pinctrl or a power domain being
> > suddenly gated...
>
> I turned some logging on (see below), IIUC pl18x is starting CMD52 with arg
> SDIO_CCCR_ABORT read and it got IRQ later along with response. Then sending
> again SDIO_CCCR_ABORT write but no IRQ comes back.
>
> [  135.810802] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> [  135.810832] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [  135.810862] mmci-pl18x 48004000.sdmmc: op 34 arg 00000c00 flags 00000195
> [  135.811155] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000040
> [  135.811178] mmc0: req done (CMD52): 0: 00000000 00000000 00000000
> 00000000
> [  135.811202] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000000
> [  135.816487] mmc0: starting CMD52 arg 80000c08 flags 00000195
> [  135.816506] mmci-pl18x 48004000.sdmmc: op 34 arg 80000c08 flags 00000195
> [  172.150614] random: crng init done
> [  172.150642] random: 6 urandom warning(s) missed due to ratelimiting
> [  173.290565] INFO: task kworker/0:0:5 blocked for more than 20 seconds.
>
> Here is the same system, only with different (working) SDIO device on
> the same bus:
>
> [  495.654596] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> [  495.654628] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [  495.654658] mmci-pl18x 48004000.sdmmc: op 34 arg 00000c00 flags 00000195
> [  495.654996] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000004
> [  495.655017] mmc0: req done (CMD52): -110: 00000000 00000000 00000000
> 00000000
> [  495.655042] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000000
> [  495.660201] mmc0: starting CMD52 arg 80000c08 flags 00000195
> [  495.660222] mmci-pl18x 48004000.sdmmc: op 34 arg 80000c08 flags 00000195
> [  495.660549] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000004
> [  495.660567] mmc0: req done (CMD52): -110: 00000000 00000000 00000000
> 00000000
> [  495.660591] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000000
>
> Should it be expected, that invalid (probably non-responding) device on
> the SDIO bus
> causes it to be locked up forever ?
> Or is it bug in pl18x driver not handling the error correctly ?

Honestly, it's hard to tell without further debugging. It looks like a
bug in pl18x driver, but perhaps also on the SDIO device side.

Kind regards
Uffe
