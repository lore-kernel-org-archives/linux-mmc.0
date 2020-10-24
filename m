Return-Path: <SRS0=0cVg=D7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E7CC4363A
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Oct 2020 13:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8452226B
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Oct 2020 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJLV2tQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761676AbgJXNAZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Oct 2020 09:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761674AbgJXNAY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Oct 2020 09:00:24 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26365C0613CE
        for <linux-mmc@vger.kernel.org>; Sat, 24 Oct 2020 06:00:24 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a20so4018493ilk.13
        for <linux-mmc@vger.kernel.org>; Sat, 24 Oct 2020 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMu63H8W2tOxk9N6py+CEkxsMhVhmvIv71qqq4kYbk0=;
        b=vJLV2tQvRl+XZ7ACG7nz0hlpvaLOs1MJHr7gESPils51puiLEaFsYJ93tlNTQfSYli
         lTcXy8iTs7fHb8di4C4ZKCNTxi7/V3ZFbPyj6FAJ+3yGlWQg0ufXzhpTUwAMM9eh1ng/
         8nlLXUIPYUn44tGgxfzeW9cAWYQYBnl6ESRFvq3t+v5q4tNg9w5ODzLSfE+qUqsOw2fa
         OAqcdYNnQL+r1d9BqWJZcDiZwq+xIrgUx+ELKPYPdZ9kJV4/D/NOUPeO08Ag48E7i/8i
         IK6HbT1Rb1ABk0yFJZkD7rvWi3B8nyK22hOyTuA/cpzamk/+Es9M7mbPDWMTGvuBumL5
         WWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMu63H8W2tOxk9N6py+CEkxsMhVhmvIv71qqq4kYbk0=;
        b=f5OgE+44QbS/lG++Yhlt3ffeDNOY4ByJ1acTUd7uFIKct6c/XDmjnO8nzhJ3bBoZb4
         efRoIdAH3EEnGS+S0PvRJ8QyuLm9J0d0bxRgXbveh/pjeJXloM26+H7hBcOakIuR4gC9
         YXhqfqZfricDrObzhwtFd7z8Gp8DAo4pO/Is1EYq4N4c5qjIxBFd8k2h2D78pzC4SQY0
         jXAb87xKrIwuQVmuQcqYi/fvJ+8T89ZqQJvE36ED4fMmzAAtSS40ozSLKg5SseNtOxWY
         hJrr+slovfLel68A6h2VcAFqPOmLTj9RLxnQ8nR58EoejiskaHdwZ1o+sjwtSx+Kpa5m
         WWYg==
X-Gm-Message-State: AOAM533IIsEbHC6RKHvUDDvLtL5H1/sEz8RTtG0td4W0W/YSLtkaIcPs
        FX0KMDWNdL+qGuZpGRw/v+K2STNdxXnrpe363n4=
X-Google-Smtp-Source: ABdhPJzAhTgweMV7qdnq6D5m9I5PQh3sSLL9kNUfOJsBlxrgmGPPRtxY6WtctQHyR0i5o5qZ92Z7ZOpPPp16Z+BuHHA=
X-Received: by 2002:a92:a80f:: with SMTP id o15mr5230143ilh.118.1603544423226;
 Sat, 24 Oct 2020 06:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
 <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com>
 <20201022091337.3u5ya3jouhmaukcj@gilmour.lan> <CAJiuCcfyx734fo52VU4t5jF6pZ7vcg4VR1HhWMzg_UW9Xfaj8A@mail.gmail.com>
 <CAJiuCcd1O0OVeJSmqa=srOOzwuKciqKbm4Xbh+dn4XCycSbLAg@mail.gmail.com> <f9cab2ce-1155-217c-bfa4-95f66d5cbfad@inventati.org>
In-Reply-To: <f9cab2ce-1155-217c-bfa4-95f66d5cbfad@inventati.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 24 Oct 2020 15:00:12 +0200
Message-ID: <CAJiuCcckhT8rP_RGub=RdpgtLfPbm_37JGgAywKzO9EVB6bk8w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
To:     Philip Rinn <rinni@inventati.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Philip

<snip>

> >
> > I catched a slight difference between the mainline and vendor driver
> > in DDR mode.
> >
> > the phase is set to 1
> > case MMC_TIMING_UHS_DDR50:
> > case MMC_TIMING_MMC_DDR52:
> > dat_drv_ph = 1;
> > speed_mod = SM2_HSDDR52_DDR50;
> > break;
> >
> > Could you add a hack in DDR mode and see if it's working better ?
> >
> > Maybe line 738:
> >
> > #define SDXC_REG_DRV_DL (0x0140)
> > #define SDXC_DAT_DRV_PH_SEL BIT(17)
> >
> > rval = mmc_readl(host, REG_DRV_DL);
> > rval |= SDXC_DAT_DRV_PH_SEL;
> > mmc_writel(host, REG_DRV_DL, rval);
>
> I tried with this patch but no luck, see log below
>
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -230,6 +230,8 @@
>
>  #define SDXC_CAL_TIMEOUT       3       /* in seconds, 3s is enough*/
>
> +#define SDXC_DAT_DRV_PH_SEL BIT(17)
> +
>  struct sunxi_mmc_clk_delay {
>         u32 output;
>         u32 sample;
> @@ -718,6 +720,7 @@
>                                    struct mmc_ios *ios, u32 rate)
>  {
>         int index;
> +       u32 rval;
>
>         /* clk controller delays not used under new timings mode */
>         if (host->use_new_timings)
> @@ -736,6 +739,10 @@
>                 if (ios->timing != MMC_TIMING_UHS_DDR50 &&
>                     ios->timing != MMC_TIMING_MMC_DDR52) {
>                         index = SDXC_CLK_50M;
> +
> +                       rval = mmc_readl(host, REG_DRV_DL);
> +                       rval |= SDXC_DAT_DRV_PH_SEL;
> +                       mmc_writel(host, REG_DRV_DL, rval);
>                 } else if (ios->bus_width == MMC_BUS_WIDTH_8) {
>                         index = SDXC_CLK_50M_DDR_8BIT;
>                 } else {

Sorry this will not work, as H6 uses new timing mode the function will
return before setting the DRV_PHASE.

Could you retry with a patch like this :
https://github.com/clementperon/linux/commit/287a62a6e9ccda3ade9b407ce12ee7db0865b41b.patch

Thanks for your test,
Clement

<snip>


>
> Regards,
> Philip
>
> > Regards,
> > Clement
> >
> >>
> >> Regards,
> >> Clement
> >>
> >>>
> >>> Maxime
>
