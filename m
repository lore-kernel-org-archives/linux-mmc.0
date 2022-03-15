Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6C1C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 12:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiCOMcR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348252AbiCOMcQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 08:32:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6553730
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:31:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z26so26228258lji.8
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EP3v0YhMrRhXTUJ35foov+w4W51d6KLAhPxddwMa04=;
        b=nq1DMVP6hE2O+kD8xCjGnyCTNXdYXUYAsNgHl2v9LGiGmpG46mIq7evyy1JPWLx6uo
         B9KuiVuGwEKUc1/jIbEX7Iranm1sGADyKOz2e7fjkQFBifQD+Jnj1IyYybXnsVBXDDP1
         2mxcb11F57ruvATZ79ItBouwpbbOT9zW+MadE86sZ7FJDXRVtF0RcWEutf/Qn9VdJPCL
         akWXjAfNQ/LhzB60Zwr+y22psu6wRoFyF758ozY7teqwU2xR09Y9Jmb61GR+CLYG0tmq
         6m9qDHnJwN293HAB4qapwlMuNR36bFykRE5fHVoffaU5lvCEBef6i/geA7g4Lpl9LRZ9
         tSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EP3v0YhMrRhXTUJ35foov+w4W51d6KLAhPxddwMa04=;
        b=c0sIuRJFu9qC4t1eVUVAdf9osSIqPXP+ZXRYVa7T93Iss20aILJsQrpJhBQCAcRox1
         x/JOAUFgw/Y8H7csyTDyVWRWOVrIJ507T/mlRwLLm53SXgYtJO0hJPvaWtZQZ6XrqiKp
         zWOhgsf0iofVBarBejCshYAqhr1RAUHrpT/FqRjbSE/c7qG0QHm1FkFjRWYzo7gs/KrC
         ETfS9n/Rx/p/5JxO47bUctLp6qmMMQwQJBy6dq7IuQiJdrLEPrpCTeCCa5y3iX1gz3O4
         vGes0oNAUDxLKfTBLG8WYpwx9UnuUdpM3EPneWyHpWEku12YnhHY+yYMqUGGXcMrKkBJ
         dC7g==
X-Gm-Message-State: AOAM531kljYk942+86hx7Zs3W1wpRbsnC1iviVpjyT2kXRCVsJwyBSTX
        BbfD+tPgynm9+OLjpmH178/nQWYu9++U1GA+cZ5D+g==
X-Google-Smtp-Source: ABdhPJy8D5j/Opz5opxfQCblocWzZ3bktNGS5YOn5/kFVwoiaENtQx2jP9FVs/TZheAUyO+56uySEWgea+BikcXVQkY=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e90 with SMTP id
 e9-20020a2e5009000000b00247d7383e90mr17329760ljb.229.1647347463153; Tue, 15
 Mar 2022 05:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
 <20220314125554.190574-1-yann.gautier@foss.st.com> <CAPDyKFruN9Xwk4uqFumwBdcn4SjKQcSQVBbALa3kVxY4mVzOnQ@mail.gmail.com>
 <9e4fbf6a-1309-3aee-fcb0-be7c2c683892@foss.st.com> <CAPDyKFq2Du1UWpvRFpVF_qL65SP0DfEV872U9Xe-9i7xKxXhqg@mail.gmail.com>
 <ce29e53a-59ff-000a-6b88-0b7ae538c515@foss.st.com> <CAPDyKFq29+nwxXkV-Fyn91WD62-6REk+5UryVAK6XC4xKhcsfg@mail.gmail.com>
 <c6972c78-a4eb-02ec-7b35-e473b66df821@foss.st.com>
In-Reply-To: <c6972c78-a4eb-02ec-7b35-e473b66df821@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:30:26 +0100
Message-ID: <CAPDyKFoJpxFOzJVRVF=R2UXuwBPfuegmaZ==-ohhw98dMgpk+Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Mar 2022 at 11:08, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/15/22 10:07, Ulf Hansson wrote:
> > On Mon, 14 Mar 2022 at 17:52, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>
> >> On 3/14/22 17:18, Ulf Hansson wrote:
> >>> On Mon, 14 Mar 2022 at 15:34, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>>>
> >>>> On 3/14/22 14:03, Ulf Hansson wrote:
> >>>>> On Mon, 14 Mar 2022 at 13:56, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>>>>>
> >>>>>> Add a disable_keep_power field in variant_data struct. The
> >>>>>> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
> >>>>>> It is only set to true for stm32_sdmmc variants.
> >>>>>>
> >>>>>> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
> >>>>>> It doesn't correctly support low power on this board. The Wifi chip
> >>>>>> awaits an always-on regulator, but it was connected to v3v3 which is off
> >>>>>> in low-power sequence. MMC_PM_KEEP_POWER should then be disabled.
> >>>>>
> >>>>> Just to make sure I get this correct.
> >>>>>
> >>>>> Why can't the regulator stay on during system suspend? The point is,
> >>>>> we don't need an always on regulator to cope with this.
> >>>>>
> >>>>> Kind regards
> >>>>> Uffe
> >>>>
> >>>> Hi Ulf,
> >>>>
> >>>> This v3v3 regulator powers most of the devices on this board. So we need
> >>>> to switch it off to gain power in suspend mode.
> >>>
> >>> I see. Thanks for sharing that information.
> >>>
> >>> The MMC_PM_KEEP_POWER flag is there to describe what is supported by
> >>> the platform/host. It doesn't mean that the card *must* stay powered
> >>> on during system suspend. Instead that depends on whether system
> >>> wakeup for the SDIO/WiFi is supported too - and if that is enabled by
> >>> userspace. If not, the regulator will be turned off for the SDIO card
> >>> during system suspend.
> >>>
> >>> Assuming the regulator is implemented as a proper regulator and can
> >>> remain on during system suspend, the right thing would be to keep the
> >>> MMC_PM_KEEP_POWER flag around.
> >>>
> >>> Kind regards
> >>> Uffe
> >>>
> >>
> >> OK, but in the wifi driver we use on this platform (brcmfmac), the
> >> suspend/resume functions (brcmf_ops_sdio_suspend/brcmf_ops_sdio_resume)
> >> use the flag to check regu was off, and then call probe function during
> >> resume, to re-init Wifi chip and reload its firmware.
> >
> > I had a closer look at the brcmfmac driver, thanks for the pointers.
> >
> > In my opinion, I think we should change the brcmfmac driver, so it
> > decides to power off the SDIO card, unless the WiFi chip is configured
> > to serve us with system wakeups.
> >
> > I can send a patch for brcmfmac that we can try, unless you want to
> > send it yourself?
> >
>
> Hi Ulf,
> If you already have an idea of the patch in the brcmfmac driver, can you
> propose something?

Sure, I will post a patch as soon as I can.

> We'll be able to test it at our side.

Great, I will keep you posted!

[...]

Kind regards
Uffe
