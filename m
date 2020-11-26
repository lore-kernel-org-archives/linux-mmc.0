Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B3C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 12:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3CB20B80
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 12:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB/eWYAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKZMaa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 07:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgKZMaa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 07:30:30 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10524C0613D4
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 04:30:30 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id v185so422907vkf.8
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 04:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwfSmiW8wC4c8YEqJfMS6xstFSuOyZOshWT4MX1zhGw=;
        b=fB/eWYANKJ4wxGSbCsSpJCytDe0rDDyixlvaOxzI8MmJqZeJjvt9TGekmN0QbgDcxQ
         Bgw4wFZ7O3AEOE6/bEH8t2R31ONlQBS4SNeJQ7gUTloTh+A2TBl4SPMyulM/tWkI6BPq
         B6ZhMrX8yAcV2mjMJqZo3zOFZSdzaS8pGqZ6bD1iWbrxYtVrGWKgc63eBkFPi6C3Bd8m
         kS97lFU1a1nAU0aYS5qHWelQyXfxD+BXqEOYYORNZ26pyzfXoo1iZd/8I5DNMwI/yLnz
         RDVW46vJVidOrW/eOewDhOVnh3M9MNWjfrwC4+xxh3fx2QbZYG76juc0Md7VpY7at93a
         tENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwfSmiW8wC4c8YEqJfMS6xstFSuOyZOshWT4MX1zhGw=;
        b=ly7aMu1F6HXOQEcsV/wdN8pmNcJHmIga5yucJSJR5mNWcJTZsXg1lRTCKZBMsKglv+
         o+rm3BNSwdEPzboGwjLiiu1ZU8ecUhRxwHsdPIBYk3UeWFLcdL1SMrwHglbp8OaKD/k8
         n9hqzppTdWi2jlCbndT8TlQzf8eqfSGiApUFh2vUXoqYs1KdKnYSGBWmjIOg/juVBnXp
         UMYuJFK8U1HOr22MnaTNl8OteJUmww31BhAEgtRVq+CUWR2y4vHzZ0WJsp4CxpJ4irS6
         wWvdaYADzapaUD9Tbd9d4RSDpdihwMYMcMJOoEQt1ybax9FvnAWbfNGyqeVL3ENVXZsN
         reFA==
X-Gm-Message-State: AOAM5320fTuHexfgGkojCKoZ+vcVjnOwmyDL++NvTnvIGeaCU+gkE14B
        9tuMyCQTv4/9NiicERP8C6epyth5tuYWMzCd+7KfSQ==
X-Google-Smtp-Source: ABdhPJwZN0eDGbKeVzoN1m8Rus6o4ajev7s0qab4LrVpDTTnfpneHD0T4F6OhdJc5Tzm3h4fXgnjgGfbZ45u9nfA3ZQ=
X-Received: by 2002:a1f:5e0b:: with SMTP id s11mr1568478vkb.8.1606393829211;
 Thu, 26 Nov 2020 04:30:29 -0800 (PST)
MIME-Version: 1.0
References: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
 <a646a587-25ae-2395-a169-3742ba7f9723@alum.wpi.edu> <X76svnTHv34FJaHI@kroah.com>
 <1760357a038.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <X79ZH+COJbxqd+eJ@kroah.com>
In-Reply-To: <X79ZH+COJbxqd+eJ@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Nov 2020 13:29:52 +0100
Message-ID: <CAPDyKFpnp_JfpxtkM3MTjTi2S7jiDp0QXY_ists7cNAmfAAsUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdio: Move SDIO IDs from rtl8723bs, driver to
 common include file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "Brian O'Keefe" <bokeefe@alum.wpi.edu>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Nov 2020 at 08:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 26, 2020 at 07:57:23AM +0100, Arend Van Spriel wrote:
> > On November 25, 2020 8:13:07 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >
> > > On Wed, Nov 25, 2020 at 01:33:00PM -0500, Brian O'Keefe wrote:
> > > > Macro names were derived from the Windows driver, as that was the best
> > > > available source.
> > >
> > > Why move these?  What does this help with?
> >
> > Hi Greg,
> >
> > Most if not all SDIO-based (wifi) drivers in mainline have their venid and
> > devid definitions in that header file. So seems like a good idea to me, but
> > maybe not so for a staging driver?
>
> If the driver ever gets moved out, maybe do it then as part of that
> effort.  I haven't seen that happening, so I would recommend just
> leaving this alone for now.

+1

Kind regards
Uffe
