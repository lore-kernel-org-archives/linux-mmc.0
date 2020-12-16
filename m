Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE33C4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAB12313C
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLPJ6U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 04:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgLPJ6T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 04:58:19 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E1C061794
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2020 01:57:39 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id v3so5513598vkb.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2020 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8l/M62PtF0n4E+Kud8Gg3Jd1DOjZBf39zGElGBuB24=;
        b=AlXNurBzvCes2S+jJ6ZwyzsHWU1hC9h79/NVgkR3+pA2YUoEIzSqG8aT8oTBSjnBau
         Kog2h0BlmDosvDB6sfsv+3EMrP7Boq1vy7er7a6irCY6woskcZ24oCGUB/0d3B10CBp9
         7qnKLZyfD2zWyATd8IgvBvpNQjbNWDRsJxoLjwiSyY0lKku+1nJOC2eX9vV5s/OAqa61
         NAxSEKYpqCANH4Ih3voMhXmuWHVfFfBJPKCt1iKgKSFh2b+h1CPaJcgRV/5ISzaxFjSA
         GwTtBo9Igo8GAlwFEcy8oOwK42r0udYTSOBwfwvOiHiuyMVASOD1K7lyodfzSZrt7273
         LPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8l/M62PtF0n4E+Kud8Gg3Jd1DOjZBf39zGElGBuB24=;
        b=mDHyrx0j7hf9s/ESKEQpUPzXIVwl1WdNQEzYEaRjTqlC/7d4wIQWVsi9R/QD6ACRvJ
         znmmPW2EV4VaA4NoIXGp79KzWXGYJJU1fd8KqffrlM47mQBeCAUJqtck+RPolo0sFPx+
         yPVq3MKxaYdxxD3X0ldefTZ1hhdFg2ZSIxgstsjO7hedkVG0jmHPAONoCg2IRIaeZ1nY
         5gNZ34aJfweaQl4UHKZ+G08oI8YszxSVpabqeGy9kG/dZW9zBIskadkWkqGEFWTEW2EC
         AUUjpQUWYCTRayUmyiskvZfpx1TjjVHNaqAcg/1qwj7Jl+/T9fWqxl3A+U9yCai4L6Zd
         BH8Q==
X-Gm-Message-State: AOAM531oQK62YtvUfio+Ob85lLF+S0C4FBfzqOK33rf8VB/66Un0bpxk
        wdxcItrW6a5InqrxQspfe3yS+8PNZyeVDc3In3WpOg==
X-Google-Smtp-Source: ABdhPJx+FZqJiksVy6CgwhfBkpsL80w1Kco02FyzpBcsAo+m3en7wDsW+z+cvIWqAzoq7lHcn5Ofn/4zHVT0pBlf6I0=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr11891652vka.7.1608112658664;
 Wed, 16 Dec 2020 01:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com> <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com> <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Dec 2020 10:57:02 +0100
Message-ID: <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> >> >
> >> >It looks like the above I/O read/write interface for pstore is
> >> >intended to be used when the platform is up and running and not during a
> >panic, correct?
> >> >
> >> >If so, I don't get why it can't use the regular block interface, as
> >> >any other file system does, for example?
> >> >
> >>
> >> The pstore read and write operations are used as part of pstore file
> >> system mounting to retrieve the stored logs from MMC platform backend
> >> and to manage pstore read/write counters. Sleeping would be allowed
> >> during this time. Whereas, pstore PANIC write will be called if there happens
> >a crash in the system. Sleeping is NOT allowed at this time.
> >>
> >> It seems you are mixing the sleeping paths of the mmcpstore with that of
> >atomic path.
> >
> >No, I am not mixing them, but questioning them.
> >
> >For the non atomic path, I don't understand why the pstore file system
> >mounting, etc, deserves to be managed through its own specific ops?
> >Are there any specific reasons for this that I am missing?
> >
>
> Seems generic way is undergoing some changes. Kees already ACKed
> the mmcpstore registration through block device registration.
>
> >In principle, for non atomic path, I would rather see that the pstore file system
> >should be able to be mounted on top of any generic block device partition -
> >without requiring the block device driver to implement specific pstore ops.
> >
>
> Scope to answer this is out of mmcpstore driver. Pstore/blk driver have to
> answer this.

Yep, I am open to discuss this more.

>
> >>
> >>
> >> >> +
> >> >> +static void mmcpstore_panic_write_req(const char *buf,
> >> >> +               unsigned int nsects, unsigned int sect_offset) {
> >> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> >> +       struct mmc_request *mrq = cxt->mrq;
> >> >> +       struct mmc_card *card = cxt->card;
> >> >> +       struct mmc_host *host = card->host;
> >> >> +       struct scatterlist sg;
> >> >> +       u32 opcode;
> >> >> +
> >> >> +       opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK :
> >> >MMC_WRITE_BLOCK;
> >> >> +       mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode,
> >> >MMC_DATA_WRITE);
> >> >> +       sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
> >> >> +       mmc_set_data_timeout(mrq->data, cxt->card);
> >> >> +
> >> >> +       mmc_claim_host(host);
> >> >
> >> >So, this will use several locks, which may be a problem, right?
> >> >
> >>
> >> No, as said above locks are present on host driver will be dropped in
> >> CONFIG_MMC_PSTORE path.
> >
> >Please have a look at the code implementing mmc_claim_host(). It's not just a
> >simple spin_lock, but there is also a wait_queue and runtime PM being
> >managed from there.
> >
> >>
> >> >Moreover, if there is an ongoing I/O request (or any other active
> >> >command/request for that matter), then the host is already claimed by
> >> >the mmc core. Normally, we would then wait for that request to be
> >> >completed, to trigger the release of the host and then allow us to claim it
> >here.
> >> >
> >> >However, because of the kernel panic, I assume it's quite likely that
> >> >any ongoing request will not be completed at all, as IRQs may not
> >> >work, for example.
> >> >
> >> >In other words, we may be hanging here forever waiting to claim the host.
> >> >Unless we are lucky, because of no ongoing request, although we would
> >> >still have to succeed walking through all the locking, etc, in
> >mmc_claim_host().
> >> >
>
> I agree with your concerns about spin_lock, wait_queue and runtime PM in
> mmc_claim_host(), but not the ongoing requests presence. They must
> have terminated cleanly through host->ops->req_cleanup_pending(host)
> before reaching mmc_claim_host().
>
> I will come up with something to address these in the next patch.
>
> >>
> >> host->ops->req_cleanup_pending(host) was introduced to clean up the
> >> host->ops->queued
> >> and ongoing requests/commands. Terminating ongoing requests is not a
> >> complicated thing for the host drivers.
> >
> >Well, I don't agree. Resetting the host controller should not be a big problem,
> >but I am more worried about what state this will bring the eMMC/SD card in.
> >
>
> I am not sure why are you saying host controller reset. No ware host controller
> reset was performed as part of these patches.
>
> >It sounds to me that the only option is to try to rely on the
> >mmc_claim_host() to actually succeed. This makes it certain that there is no
> >ongoing request that needs to be terminated. Otherwise, things will just fall
> >apart.
> >
>
> Agree. Seems I need to create an alternate path to forcefully gain access to the host
> for the case of panic write. As you pointed out mmc_claim_host(), mmc_release_host()
> and runtime PM can create issues.
>
> >The question is, can/should we rely on mmc_claim_host() to succeed in this
> >path? Maybe it will work, in cases when there is no ongoing request, as it
> >means the host should be available to be immediately claimed. Although,
> >then the problem ends up with runtime PM, as if the host is available for
> >claiming, it's likely that the host is runtime suspended...
> >
>
> An extra check can be added to see if host was runtime suspended ahead
> of panic write attempt.

What if that is the case, should we just return an error?

Moreover, even the device belonging to the mmc card can be runtime
suspended too. So if that is the case, we should return an error too?

[...]

> >> >[...]
> >> >
> >> >Having said the above, I am not entirely convinced that it makes
> >> >sense to support this, at all.
> >> >
> >> >Not only, will the support be highly fragile from the mmc core point
> >> >of view, but there is also a significant complexity for an mmc host
> >> >driver to support this (at least in general).
> >> >
> >>
> >> I am not sure if the comments on host driver complexity is true.
> >> Terminating ongoing requests and introducing polling functions on host
> >> drivers should be straight forward. None those would disturb the core
> >> functionality. They are completely independent.
> >
> >I think you are underestimating the part with terminating ongoing requests. It
> >sounds to me that you really haven't been terminating any requests at all, but
> >rather just doing a reset of the mmc controller (which is what I observed in
> >patch2).
> >
>
> No, it's not true. I am not doing any reset. Please point me to specific code snippet
> where you have observed this.

I was looking at patch2 and the ->req_cleanup_pending() callback that
you have assigned to cvm_req_cleanup_pending().

In there you clear a potentially running DMA job, which is *kind* of a
reset of the controller. More importantly, it's definitely *not*
terminating an ongoing request, in a way that you can expect the
eMMC/SD card to be ready for new communications afterwards. This is my
main point.

Kind regards
Uffe
