Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C512C4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB1123356
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgLPKxd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgLPKxd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 05:53:33 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D4C061794
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2020 02:52:52 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id u7so12669086vsg.11
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2020 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcdgUIQqjs3RtDACLXfZjl4mmwIoYl81Jwxqo+UNCiM=;
        b=CpKF2QRGJ9/+xPrIUghOQ1TwlBNr4/OA6GaIcoRO7a8YsSkJu8dbyrG2nJxEoGeYWC
         JFuyMFM8e12AvhHCo3UZqN1LbolpVx0TNxPPQCdiluy64/QbXFIbIzUdPWnw26LMfUzR
         v50qXRzTwVj+rZDjM1EHkhWZrERbY551D3orOTuiYmp21wYIcSqL7v9lHaF7n4IauflA
         oHFVA9Q9gybjyYKFySENSFIq2s0XEptu3gpWXcqOpiLQuL2pp0hTcpQTs90VZ+dr7ant
         gLv7Jxk/QyXY9OX67JMB2fEn39dPUIbNpIRaHqtT1w3D0lq0ciUMl8s2ZxUDYH6q+Y5C
         AXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcdgUIQqjs3RtDACLXfZjl4mmwIoYl81Jwxqo+UNCiM=;
        b=pGYRtvukNcJaVsU6E/2OH1q2Py69/e0oVhoWdG/K2g0TSHLbykfPS72MKIPOQuln3I
         MW1vHIYGAvsfSkHJewG+OAKrDygNcSssYiSxPS4C7cLEVXvhdhqFj4Qgy3yUl0MF3FVY
         M3uO39jZezv0nUFdnKVX75X8gxSQRqSCgt/s5idL9Bb+Zw/TcyPz5fj+3QyMHz4RotQR
         Hu2opObdVz14ZuAcvSlmck5UbQCzJYN/InsyP7RAGZCAtbZW6rB7rHGBbCSR4gzna7dw
         NEb++6SaGqeRgYQoGcmoTt5QPPYVl+QV4Ys/hGtJAZ1svFyZlDtThuFFQMODlMXfbzQ9
         2y0w==
X-Gm-Message-State: AOAM531zO98FBs3TJPC7lR07I0/qBDIeKWglUAU2QQuDTYcO8pVQNQXC
        xuApIjx14zrIwOi56szis5cflK0u/+L6vodkr2Hrzg==
X-Google-Smtp-Source: ABdhPJyK8dJGL5HyKczS71lN0bZuwXImCPPf/CUpMVSCT4DSSRjV1o4K+skZ2KoaoA0JUOs/UBqxA2LUlx4iFI0Y04Y=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr29650848vsr.19.1608115971860;
 Wed, 16 Dec 2020 02:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com> <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com> <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Dec 2020 11:52:15 +0100
Message-ID: <CAPDyKFoWh8Ms3hqgWwkQgx2a9PZa+GLcYhgXX68K0ZC5JJAzHw@mail.gmail.com>
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

> >>
> >> Agree. Seems I need to create an alternate path to forcefully gain
> >> access to the host for the case of panic write. As you pointed out
> >> mmc_claim_host(), mmc_release_host() and runtime PM can create issues.
> >>
> >> >The question is, can/should we rely on mmc_claim_host() to succeed in
> >> >this path? Maybe it will work, in cases when there is no ongoing
> >> >request, as it means the host should be available to be immediately
> >> >claimed. Although, then the problem ends up with runtime PM, as if
> >> >the host is available for claiming, it's likely that the host is runtime
> >suspended...
> >> >
> >>
> >> An extra check can be added to see if host was runtime suspended ahead
> >> of panic write attempt.
> >
> >What if that is the case, should we just return an error?
> >
> Yes.
>
> >Moreover, even the device belonging to the mmc card can be runtime
> >suspended too. So if that is the case, we should return an error too?
> >
>
> Yes, same here.
>
> Assuming ->req_cleanup_pending() properly terminates the ongoing DMA transfers,
> mmc_claim_host() and mmc_release_host() can be dropped in panic write case
> as it has then exclusive access from then on.

Again, I think you have misunderstood how it works from the core point of view.

->req_cleanup_pending() will never be able to terminate a request in a
proper way, without involving the mmc core's knowledge about the
eMMC/SD protocol.

Yes, it could clean up from an ongoing DMA transfer, but that doesn't
bring the eMMC/SD card back into a state where it can accept new
requests.

>
>
> >[...]
> >
> >> >> >[...]
> >> >> >
> >> >> >Having said the above, I am not entirely convinced that it makes
> >> >> >sense to support this, at all.
> >> >> >
> >> >> >Not only, will the support be highly fragile from the mmc core
> >> >> >point of view, but there is also a significant complexity for an
> >> >> >mmc host driver to support this (at least in general).
> >> >> >
> >> >>
> >> >> I am not sure if the comments on host driver complexity is true.
> >> >> Terminating ongoing requests and introducing polling functions on
> >> >> host drivers should be straight forward. None those would disturb
> >> >> the core functionality. They are completely independent.
> >> >
> >> >I think you are underestimating the part with terminating ongoing
> >> >requests. It sounds to me that you really haven't been terminating
> >> >any requests at all, but rather just doing a reset of the mmc
> >> >controller (which is what I observed in patch2).
> >> >
> >>
> >> No, it's not true. I am not doing any reset. Please point me to
> >> specific code snippet where you have observed this.
> >
> >I was looking at patch2 and the ->req_cleanup_pending() callback that you
> >have assigned to cvm_req_cleanup_pending().
> >
> >In there you clear a potentially running DMA job, which is *kind* of a reset of
> >the controller. More importantly, it's definitely *not* terminating an ongoing
> >request, in a way that you can expect the eMMC/SD card to be ready for new
> >communications afterwards. This is my main point.
> >
>
> I am not sure that clearing an ongoing DMA will reset the controller. These are host
> controller specific. The idea is: To drop ongoing transfers, whatever a host software
> has to do it will does through this cleanup function. We may not generalize this,
> providing a hook and letting each host controller handling it seems better.

I fully understand the approach, but again, it doesn't work. Sorry.

As I said, the only thing that *could* work is to call
mmc_claim_host() in the panic write hook -  and hope for the best. If
it succeeds, there is nothing to cleanup or terminate.

Kind regards
Uffe
