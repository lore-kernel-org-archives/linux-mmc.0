Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF96C4363A
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2E920EDD
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 12:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNWB31mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370201AbgJWMM5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369895AbgJWMM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Oct 2020 08:12:56 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B864C0613CE
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 05:12:56 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id x26so342324uau.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zTD62MDEiFJvjUs/krlr6v9XPRox7+W7YH3FUt+tPU=;
        b=CNWB31mO34r8pQnTyPiSTEv4TUCv9alhApvdGjUQ4BFG2WTDboq/hCo0UJ/O+HsPVD
         DOCQ6guLf13fZHFYRMyRw5H2OmXiTOjTcD7J5L4/xMQSzoVovOr8FWGvLvTYALuWZ10m
         trV4cAKoYjHXTcB4dI6OEGu0PurOw+VvfgnStvE4nVm/feobsflEH2GKZCh1wSSSJDK3
         l0HKxLu5z9i1AKlEQwV/isD1GkFn7DQpq+H16f+RehrMZGRp2vWl3KipBEkXi2Ed+nvc
         Kc3RWRoZrSnoBn7N7f7ylzKJ1k8g+CD0F1F/knYZAf5y72Yy3taVrlyA1nXR9BYfjbwd
         mSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zTD62MDEiFJvjUs/krlr6v9XPRox7+W7YH3FUt+tPU=;
        b=cOxz5gBVvkRfzHHX3h7z7YQEwt1aY/uHFkM5a8zpgbpz9AEK0nH5UW7HNlHPEVI3fd
         fOB2UHfWHnp5+RIXyYnV88DR13coRcEQY0kVPSkj6qUGtmxDtQW4TZxTxTv5Du9Bo50a
         aBID5NuPtwHzXcgsCXyrdwsSp3I9XpexDroP/OWZ38BJ3AUSZw8afA7fHM+rw3US5cGj
         zpeuy0BAToU1yJ6Dg5qhS/aehsJE9wv1YARYSARmKzwYL516j1m7JP07Cyqf7nqYVW4z
         ehg44qLtnqv7Hrak65yUxk4PpLz6D/Sb16YSnJvI9nUR8Ji/Mt/pjnFaf6TWwoEVRyXh
         eC2Q==
X-Gm-Message-State: AOAM531mpXgj07L3sEmPVe758bx3wNd8I6/U/s46+ySDQeLv6kzyMM+/
        bQaQPhefYuIgeK7YuiJB4GQytNiDyQkGkJlEIg8Xyg==
X-Google-Smtp-Source: ABdhPJxEEn2qFAANDfknPq/hSUgw7fhW0Nfp6pn4UcrN0NmuRnugLBJcxZH8GyNIxK6Y5gMJXU8XwyQ7o+HoPh77w+4=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr968504uan.129.1603455175525;
 Fri, 23 Oct 2020 05:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
 <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
 <20201023091408.GA5201@lst.de>
In-Reply-To: <20201023091408.GA5201@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Oct 2020 14:12:19 +0200
Message-ID: <CAPDyKFpgEcEv8FH59ntmeQADEyCs6aiS8P0tEaru858DRQup=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 23 Oct 2020 at 11:14, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Oct 23, 2020 at 10:02:15AM +0200, Ulf Hansson wrote:
> > > > Is there no mechanism to support read-only PCIe/NVMe based storage devices?
> > > > If that is the case, maybe it's simply better to not support the readonly option
> > > > at all for SD express cards?
> > > >
> > > I think there's no mechanism to support read-only PCIe/NVMe based storage devices.
> >
> > I have looped in Christoph, maybe he can give us his opinion on this.
>
> NVMe namespaces can have a bunch of 'write protection' modes advertised
> by the controller, which Linux respects.  The controller in this case would
> be part of the SD-Card.  IMHO it is a quality of implementation issue
> of the SD-Card/Controller to have the the write protection mode of the
> namespace(s) match that of the SD interface, and the SD card spec should
> talk about that if it doesn't already.

Christoph, thanks for your reply.

SD spec mentions the write-protect switch on SD cards, while uSD cards
doesn't have one. In general, host drivers implement support for it
via a dedicated GPIO line routed to one of the pins in the SD slot.

In this SD controller case, which is based upon PCI, it works a bit
differently, as the state of the write protect pin is managed through
the PCI interface.

If I understand you correctly, you are saying that the controller
should be able to communicate (upwards to the block layer) its known
write protect state for the corresponding NVMe device, during
initialization?

My apologies if the questions sounds silly, but I have limited
knowledge about the NVMe protocol, sorry.

Kind regards
Uffe
