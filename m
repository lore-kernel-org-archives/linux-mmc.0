Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E7C5518B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A96420774
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q91bHmJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDVQE0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDVQE0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 12:04:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0891C03C1AA
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 09:04:25 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id s5so2204652uad.4
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R6uBiNfit5YCO191/wwIsaUUqzxSLO/g5l1s37v3Z3w=;
        b=Q91bHmJwQtHKONLOIZVoVWCWA8wv4FJ6D+5JbGFlH88Y+/P8I6LlZJbyat1zNpYnaf
         r9JaIC2uFsoEs8V9fc21pNnrEnBTY0z4mPbLva9ly4DlnJCI1pxsfQi5Qf874n/YBWXp
         P6OzTz4nF2sutRlKNThQUqe+3ohrfIMiGWGbk/+l+YxGCV+2ATZ8bK8jV/D6rCN/17ja
         05VW2Ria5KGkfQS3EngD394SpfJwwdv2/Ps+LXsLN29JPBGNyGewMdFTTABE14T4A4yC
         4FASMLFN6kKn19Mg17U9anWakRdEGFgCyYqTvdEdi8pWvqQQpmzFhTBHb+r8UUDTIxGJ
         nqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R6uBiNfit5YCO191/wwIsaUUqzxSLO/g5l1s37v3Z3w=;
        b=LeYJGdrN85UEZ935/eLH3vgS8w3p4GQ8j0PehHXYyxA9Gr1+INs6hlcWuDgLnsM+hl
         ITdUmttkyPNCfpi4uJndM1ell7pWV+t8ZmlKi1xrnCaoY7saCwrR5xubh984VeL7UxsR
         0mV2R6/fodn6MXUjCfyV0nIeKD2bkTbOPLUjF1+hxDJ3lwOrB7yoQRoiV3U93bm3Yclj
         xVi8TOQChTA9z67Ig1/2Z6PeY7w2F+jBJD86KwcCTHlWk/UCBVqf+q9h05kmzOU2CbI/
         E4ConR/Rq9kbTuQcIt7qDnhw5iSs/Xnm4ZtlRh87IDQ5NfG3UIfzvOtoN08Q0GoYSCjv
         /VRQ==
X-Gm-Message-State: AGi0Pub5ErGHZxVfJmRDdToU1FkzP9RHA6Wr6bU0ab3J3owFRJS0qS0o
        PRpi8AKwnfIdS464C/FmucXaZYqvc+G5J7QTj4Y8lg==
X-Google-Smtp-Source: APiQypLRD/Imtj1vYufqpjP3oiW2KCXvoVlKWsNAdbd7j7U51hZYh0PP2WQvQ0URi1Cr71o91VK7Yv/5O96ZLwzvEtY=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr20427811vso.200.1587571464862;
 Wed, 22 Apr 2020 09:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200420161831.5043-1-ludovic.barre@st.com> <CAPDyKFqC3fdnQ9CMYhS-=5MiCET=r5Az2S5oFoA2v1gdDeGO3w@mail.gmail.com>
 <CAPDyKFrHcoVd=GKPB70gOFE8STOnTJrJbcZzE_DEgFWh1Vhszg@mail.gmail.com> <1d9cefd1-aaed-1eb5-92f2-b1f45b4da2ac@st.com>
In-Reply-To: <1d9cefd1-aaed-1eb5-92f2-b1f45b4da2ac@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Apr 2020 18:03:48 +0200
Message-ID: <CAPDyKFpri4VBnH9nbqUa4L=3o_h+fSZ052v7AG_9MhJX2gKgCQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci_sdmmc: fix power on issue due to pwr_reg initialization
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Apr 2020 at 15:40, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Le 4/21/20 =C3=A0 11:38 AM, Ulf Hansson a =C3=A9crit :
> > On Tue, 21 Apr 2020 at 11:25, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >>
> >> On Mon, 20 Apr 2020 at 18:18, Ludovic Barre <ludovic.barre@st.com> wro=
te:
> >>>
> >>> This patch fix a power-on issue, and avoid to retry the power sequenc=
e.
> >>>
> >>> In power off sequence: sdmmc must set pwr_reg in "power-cycle" state
> >>> (value 0x2), to prevent the card from being supplied through the sign=
al
> >>> lines (all the lines are driven low).
> >>>
> >>> In power on sequence: when the power is stable, sdmmc must set pwr_re=
g
> >>> in "power-off" state (value 0x0) to drive all signal to high before t=
o
> >>> set "power-on".
> >>
> >> Just a question to gain further understanding.
> >>
> >> Let's assume that the controller is a power-on state, because it's
> >> been initialized by the boot loader. When the mmc core then starts the
> >> power-on sequence (not doing a power-off first), would $subject patch
> >> then cause the
> >> MMCIPOWER to remain as is, or is it going to be overwritten?
>
> On sdmmc controller, the PWRCTRL[1:0] field of MMCIPOWER register allow
> to manage sd lines and has a specific bahavior.
>
> PWRCTRL value:
>   - 0x0: After reset, Reset: the SDMMC is disabled and the clock to the
>          Card is stopped, SDMMC_D[7:0], and SDMMC_CMD are HiZ and
>          SDMMC_CK is driven low.
>          When written 00, power-off: the SDMMC is disabled and the clock
>          to the card is stopped, SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK
>          are driven high.
>
>   - 0x2: Power-cycle, the SDMMC is disabled and the clock to the card is
>          stopped, SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are driven low.
>
>   - 0x3: Power-on: the card is clocked, The first 74 SDMMC_CK cycles the
>          SDMMC is still disabled. After the 74 cycles the SDMMC is
>          enabled and the SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are
>          controlled according the SDMMC operation.
>          **Any further write will be ignored, PWRCTRL value
>          will keep 0x3**. when the SDMMC is ON (0x3) only a reset could
>          change pwrctrl value and the state of sdmmc lines.
>
> So if the lines are already "ON", the power-on sequence (decribed in
> commit message) not overwrite the pwctrl field and not disturb the sdmmc
> lines.

Thanks for the detailed information, much appreciated!

>
> >>
> >> I am a little worried that we may start to rely on boot loader
> >> conditions, which isn't really what we want either...
> >>
>
> We not depend of boot loader conditions.
>
> This patch simply allows to drive high the sd lines before to set
> "power-on" value (no effect if already power ON).

Yep, thanks!

>
> >>>
> >>> To avoid writing the same value to the power register several times, =
this
> >>> register is cached by the pwr_reg variable. At probe pwr_reg is initi=
alized
> >>> to 0 by kzalloc of mmc_alloc_host.
> >>>
> >>> Like pwr_reg value is 0 at probing, the power on sequence fail becaus=
e
> >>> the "power-off" state is not writes (value 0x0) and the lines
> >>> remain drive to low.
> >>>
> >>> This patch initializes "pwr_reg" variable with power register value.
> >>> This it done in sdmmc variant init to not disturb default mmci behavi=
or.
> >>>
> >>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> Besides the comment, the code and the approach seems reasonable to me.
> >
> > Another related question. I just realized why you probably haven't set
> > .pwrreg_nopower for the variant_stm32_sdmmc and variant_stm32_sdmmcv2.
> >
> > I guess it's because you need a slightly different way to restore the
> > context of MMCIPOWER register at ->runtime_resume(), rather than just
> > re-writing it with the saved register values. Is this something that
> > you are looking into as well?
>
> Yes exactly, the sequence is slightly different. I can't write 0 on
> mmci_runtime_suspend, and can't just re-writing the saved register.

So, it seems like you need to use the ->set_ios() callback, to
re-configure the controller correctly.

Just tell if you need more help to make that work, otherwise I am here
to review your patches.

In regards to $subject patch, I have applied it for next, thanks!

Kind regards
Uffe
