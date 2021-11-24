Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD303C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 15:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhKXPRm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhKXPRm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 10:17:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70285C061714
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2021 07:14:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b40so8074148lfv.10
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2021 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yh9xoOuRaAJaKPW0jaTHe+4M3+KDpw2IcSI6hj23fJM=;
        b=GBof6E+0Gw3K8zrHDaQGHMJnQz8w+W2GZLPn7BHTMiwc6ITlkuTF1OEV9OQsc40mKx
         RtRz7bKBuVzmm2RSm31gHNx7+9acY2KRGBqu55rCXmRMhmL9fvLQN6WqvW5S7o2fAhXx
         G9GJlV5PacmgEKwuX6IK+fQvrt1GzXMuSQC2AtXIpmeXyS5PKmXj0qInc8lxlkCCKh6M
         +hl5cnByZa9xiE7B1ShyrQ2+vGSWqpCJRwDpUCyBdeyAEA9hBUKJ2UkklJavptMuXdwj
         WwG6Dh5YFhSvyIYKhacFnMfEThrDobO55JQX6iOR9OH8tiR8uuMp95efEyUMuZJOq16m
         hiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yh9xoOuRaAJaKPW0jaTHe+4M3+KDpw2IcSI6hj23fJM=;
        b=XPF7xvi/W2+t4eia1u61T9PeXOzmmaC6B3Kd/FYmcL1rBGe3oO3DpToL4Z41FwUe8f
         xSDUuFsYSJjb4Pw05og6wf58MYGxKGMiOzKueMZfHcvwxZKqIBFzOwbCeuW1ofFzkIGM
         8nWJYkJwTGnYy1VmihZmdZQuxTQyiwkinFZwRra0cfjBMVQMzvHvp47Z3c/sF0fURj/b
         PjqKs76FHSB0uZyq5p1PXhL/IYWpuJLHyHhGrRbtRdy0UrNZzZMwysoTHxKaXMXWnL6I
         1yYMxwOEXq8ZL4pX7677w81eCp58XrZPsbZy/eYNg2T7L1AtmRDpYa6WUT/6L+L4c4m/
         Xtmg==
X-Gm-Message-State: AOAM5339oKnZc2oiM/JKGvx11JXCFau54yW1sKCzHyWlcGvJrH+mRRUA
        pNZMh79mU2l084XkvZzueAY6ScS8wBlIUqitKNx5keuvnQHMAg==
X-Google-Smtp-Source: ABdhPJzNHVBwEhKAjZxgHBhiKcUY54rgPx2CslP5nbiVgbQJZVuekP1z2micFZS+P43WqeGDYm4YxRjmnOs3kwzhyo4=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr15601143lfg.373.1637766870290;
 Wed, 24 Nov 2021 07:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20211116190244.1417591-1-john@metanate.com> <20211116190244.1417591-3-john@metanate.com>
 <CGME20211123193506epcas1p49d0d0a2d66c6e560ee26077da9c0202b@epcas1p4.samsung.com>
 <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>
 <315972c2-2253-ad10-b712-2d2c96b3da26@samsung.com> <YZ4wQOcHEDHdCGlY@donbot>
In-Reply-To: <YZ4wQOcHEDHdCGlY@donbot>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Nov 2021 16:13:54 +0100
Message-ID: <CAPDyKFoweEnqRWRBUsBgmApKoY30QuNp1C7f9gW5uCJbBk6A4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
To:     John Keeping <john@metanate.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Nov 2021 at 13:29, John Keeping <john@metanate.com> wrote:
>
> On Wed, Nov 24, 2021 at 06:54:12PM +0900, Jaehoon Chung wrote:
> > On 11/24/21 4:34 AM, Ulf Hansson wrote:
> > > On Tue, 16 Nov 2021 at 20:02, John Keeping <john@metanate.com> wrote:
> > >>
> > >> The standard stem for MMC aliases is "mmc" and this is used by the MMC
> > >> core to set the slot index.
> > >
> > > This isn't the correct description of the mmc aliases. The below text
> > > is copied from the DT doc:
> > >
> > > "It is possible to assign a fixed index mmcN to an MMC host controller
> > > (and the corresponding mmcblkN devices) by defining an alias in the
> > > /aliases device tree node."
> > >
> > >>
> > >> Use this in preference to the non-standard "mshc" stem when setting the
> > >> controller ID to avoid needing two aliases for each MMC device in order
> > >> to cover both the core and dw_mmc-specific functionality.
> > >>
> > >> The old "mshc" lookup is kept for backwards compatibility.
> > >
> > > The mshc alias is really weird!
> > >
> > > It looks like some leftover from when the dw_mmc controller supported
> > > multiple slots. This support was dropped a long time ago, simply
> > > because it never really worked - and it was not worth trying to. Only
> > > one slot per controller is supported.
> >
> > As Ulf mentioned, dw_mmc controller can be supported multiple slot.
> > But I didn't see its case to use multiple slot. And I had been done to drop a long time ago.
> >
> > mshc was used because of Mobile Storage Host Controller.
> >
> > >
> > > Rather than re-using the mmc alias in the same weird way as the mshc
> > > alias, I suggest we try to remove parsing of the mshc aliases
> > > completely. By looking at the corresponding code and in combination
> > > with the DTS files, it certainly looks doable to me. Do you want to
> > > have a look at it?
> >
> > If possible to remove mshc, it's best.
> > I will check that removing mshc parsing in dw_mmc.c.
>
> Unfortunately it doesn't look like it's easy to remove as there is some
> behaviour depending on this via dw_mci_drv_data::caps, as well as
> different timing setup in dw_mmc-k3.c which uses
> dw_mci_of_alias_get_id() to identify SD and SDIO hosts.
>
> Looking across the dw_mmc-*.c files that use dw_mci_drv_data::caps to
> set capabilities per host controller:
>
> - dw_mmc-exynos.c sets additional capabilities for mshc0, although both
>   MMC_CAP_1_8V_DDR and MMC_CAP_8_BIT_DATA should be set via DT (in fact
>   in some cases it looks like device trees are setting bus-width = <4>
>   so MMC_CAP_8_BIT_DATA seems wrong!); I can't see any device trees
>   setting mmc-ddr-1_8v for these devices at the moment though, so
>   removing that is a change in behaviour

Of course we need to be careful to not break anything. But having some
clever fallback methods could work.

For example, for an SD/SDIO card slot it shouldn't matter if
MMC_CAP_8_BIT_DATA gets set. But I didn't look that closely if that
could be an option.

>
> - dw_mmc-k3.c sets different capabilities for mshc2 and, as mentioned
>   above, uses the alias index to select timing parameters and change
>   voltage switching behaviour

Yeah, the timing thingy looks harder to get rid of for the k3 variant.

Although, if we could limit the alias parsing to the k3 variant, that
would still be a nice cleanup and improvement.

As a next step we could look at introducing some new DT properties for
k3, to specify the timing thingy - and then make the mshc alias
deprecated.

>
> - dw_mmc-hi3798cv200.c and dw_mmc-rockchip.c set the same caps for all
>   slots, so can easily remove the dependency on the alias

Great.

>
>
> I'm mostly interested in Rockchip myself, which is one of the easy ones,
> so I'm not that familiar with Exynos or K3 - I'd guess the Exynos
> version can remove its dependency on the mshc alias pretty easily, but
> the use in dw_mmc-k3.c looks much more difficult given that I can't see
> any other way to derive the necessary info from the current device
> trees.

Right. I will try to get some time to help clean this up.

>
>
> Regards,
> John

Kind regards
Uffe
