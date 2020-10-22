Return-Path: <SRS0=TbaS=D5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267A0C55179
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0822463D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwx2uXhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368679AbgJVPje (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Oct 2020 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368656AbgJVPje (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2020 11:39:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94796C0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2020 08:39:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k21so2081224ioa.9
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2020 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F+r40Kqruwio7+oi3Sj5j+LP99aq74QK22UjEzJKS20=;
        b=Uwx2uXhSQ1TyqfTKd0Dy24HZ08+T9gXhkPLfzbkvkB3mVPoOST6rZcd83GQmcHTb/q
         04NDqNrPDa20fZxU7dnT3HZD6eeY80cBoLgKLvMu4VhhpVhX7ijL81dtdliuPwmKok69
         3O5w2iu2CxYnyGn8OusITT/E35Fag2HTjqw9I0L+sH97/CwzEyIGCgUMieBYT/1IyJ0w
         AcO8Vo0nwzESYq102XbEXo4qrm1Oo3OlS5VAu5A5RXEaksg+vHyFdPgI9EOGONUEeoiq
         PuFYF651m+8xMSkgnwyutV0qIy9zW8qHQAHoW5toUF74QDj4XXinRjFszaCt0OaAdObF
         cRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F+r40Kqruwio7+oi3Sj5j+LP99aq74QK22UjEzJKS20=;
        b=FOfQor7FunV4ewFksoWNSfY5a33heCYR4vrmIb8e65dxv8gGnzo9gh7G8Ax/CFTeQM
         8vFxlzQZFyTv5FlTCscyKDpSQ8C3zRfeSvylsDAiQ9xAYxk1ck/QnmDwIp250+GOnxiY
         JFciQsoPte+bVAXlD93zkFhbQ7x3Wcw/yXTWPUTf/WKIaUxbgjD35m7s6bTJNdkEveiw
         fwzwhd4qrcOX50ztG9hqjSnkYK8/zsrO2MK3/I01vL4+4bFKqOLQ1SCWogNYg4OPIMyp
         aJ6nMVN09oIm0vaS5sDpag7Mtskjllc/5XM4YMHhBBCeD50loaNhFJD2ot94QsfLVqES
         LDFA==
X-Gm-Message-State: AOAM532qkG5ZZ187OuuDOhAZjmKD9W1bBLrt3UZHf/tGkrqgxbE5ptGR
        cDf4+Dyd1ebxT8syx2K+PdKT4QqUfgFxFZeJs4o=
X-Google-Smtp-Source: ABdhPJyYIxIbYSyy0usd+l3f7T5dLH+AF6w6RYlvR9vaLXLjxDXT1gTOgk65L9Z52EgMDOKqfRFtvy7jzqzhX66/Hxk=
X-Received: by 2002:a6b:5019:: with SMTP id e25mr2342998iob.123.1603381171722;
 Thu, 22 Oct 2020 08:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
 <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com> <20201022091337.3u5ya3jouhmaukcj@gilmour.lan>
In-Reply-To: <20201022091337.3u5ya3jouhmaukcj@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 22 Oct 2020 17:39:20 +0200
Message-ID: <CAJiuCcfyx734fo52VU4t5jF6pZ7vcg4VR1HhWMzg_UW9Xfaj8A@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     rinni@inventati.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Maxime,

On Thu, 22 Oct 2020 at 11:13, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Thu, Oct 22, 2020 at 09:52:29AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Philipp,
> >
> > On Thu, 22 Oct 2020 at 00:10, Philip Rinn <rinni@inventati.org> wrote:
> > >
> > > Hi,
> > >
> > > the Olimex A64-OLinuXino board comes in various variants, three with =
eMMC.
> > > While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4GW=
) it
> > > doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have the
> > > third variant so I can't check if it works there).
> >
> > We got similar situations for Allwinner H6 (Beelink GS1 and Tanix TX6).
> >
> > There is definitely an issue in the MMC sunxi driver with HS-DDR mode
> > and it's not limited to "olimex,a64-olinuxino-emmc".
> >
> > Have a look at this this message posted by Jernej:
> > https://www.spinics.net/lists/arm-kernel/msg846093.html
> >
> > I think we should disable the HS-DDR mode for A64 / H6 like it's done
> > for H5 and not disable board per board until the issue is resolved.
>
> I'm not opposed to that on principle, but "it doesn't work on some
> board" is not a proper justification to do so. It does on some others,
> so surely there's more to it and this would just paper over whatever
> issue we have instead of properly fixing it.

Maybe the term board is not correct, maybe it's the eMMC chip which is
different.
I don't know if all Beelink GS1/Tanix TX6 use the same eMMC chip for
all the boards.

>
> > If you want to disable only for your board you can set in your
> > device-tree: mmc-hs200-1_8v; This will switch to HS200 mode without
> > using the HS-DDR mode.
>
> Sigh. Can we at least work on a fix instead of providing terrible
> workarounds?

I agree with you on this, but my board doesn't have this issue and I
tried to read the vendor kernel and spot a difference but didn't find
anything relevant.

Regards,
Clement

>
> Maxime
