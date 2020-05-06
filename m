Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F4C4724C
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9C9208E4
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVnVRn4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgEFQgu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729768AbgEFQgt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 12:36:49 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6AC061A41
        for <linux-mmc@vger.kernel.org>; Wed,  6 May 2020 09:36:49 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id p5so835197vke.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2020 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEp/F3SbsRoDv1jpNGzhOxbfis7J4KDcT9P9z6XWkHg=;
        b=eVnVRn4S8Hb7sl1mAhlDpCkwg2p7TvzKWg0qVVe/dWs+kNzu0dkUnF12cuHSLRfxJA
         k1JsPhNHp6gpFvg3metDV/hPplaRlu3pQXHecw2lhBu91JqE8L0mSdp5Zmc9jNhUWqIB
         1xGIHjkcCR9gqoJXy85LS+19SdMWYi5+Ih9W8LUXfrQqUUPxnoOEUhmxOrI+MLwWHhr+
         E9RKn25uZiu4s/nZwk/EVD7PaM11znkaVIxenvyVhmirLDphTRgJue6k6ZZ0J3TwDTz6
         0ZY1n1k1WDVUIhczz4M4qBDev1+txdlb4jFvLkVck7EDsXiBjF4LLHsLj3SpxlVGryrw
         tIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEp/F3SbsRoDv1jpNGzhOxbfis7J4KDcT9P9z6XWkHg=;
        b=MK65Q92ZCcgoxt/U5zi4df2lmShfkAngwtsAPoNw6suBPOf6Pw5XmPR0WIAcqUba4e
         emrCeAjfvnF2Q452g1g9yB6mMgIE9abvzfGNLNlsuwAAmXVguOKJc1C/N8X0+3NRA0VX
         aA46suNF3cxJMCSSQB0USP943wI6FAP6fW3e1pSaHLX/nCf6xPXvAOJu7G/aQsLuaCY4
         1SoERmXUQmThb4YresCHhserhdiuNoc9CHxOdoluG4+kaQByzsu8/WwcOYSFeCPV1H0T
         7odKg+76rEw6TUeqitVk+et3e8BIcH049LwIemko2+i/m89eO9BJv3ALpj51KfC4mmad
         BY3w==
X-Gm-Message-State: AGi0PuaRhNM2hAVAkUsHKrgoq43i66803XXir/9xYP3ic9X1fi78NiJT
        ha6Th14CX2T8Fwvw377FnAdh3MAartA0fII7qbBXLQ==
X-Google-Smtp-Source: APiQypLm9f0btuKktuvMb+D03IME6dlX6dRX4NRiQ4NXE3O3t6sARzsGX6NfhfAe3VIx+4GZEIKh+9FQbLrJ4BJaBxM=
X-Received: by 2002:a1f:8ccf:: with SMTP id o198mr8122974vkd.53.1588783008587;
 Wed, 06 May 2020 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <1588031768-23677-1-git-send-email-chun-hung.wu@mediatek.com>
 <1588031768-23677-2-git-send-email-chun-hung.wu@mediatek.com> <9bc2454f-0b42-e256-7927-2564b56f369f@codeaurora.org>
In-Reply-To: <9bc2454f-0b42-e256-7927-2564b56f369f@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 May 2020 18:36:12 +0200
Message-ID: <CAPDyKFq7ffHeWg-S41tLvScg_BXCUULig=G=EzD_to1TG0NhVg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mmc: core: Extend mmc_of_parse() to parse CQE bindings
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 May 2020 at 15:01, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 4/28/2020 5:26 AM, Chun-Hung Wu wrote:
> > Parse CQE bindings "supports-cqe" and "disable-cqe-dcmd"
> > in mmc_of_parse().
> >
> > Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> > ---
> >   drivers/mmc/core/host.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index c876872..47521c6 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -302,6 +302,11 @@ int mmc_of_parse(struct mmc_host *host)
> >               host->caps2 |= MMC_CAP2_NO_SD;
> >       if (device_property_read_bool(dev, "no-mmc"))
> >               host->caps2 |= MMC_CAP2_NO_MMC;
> > +     if (device_property_read_bool(dev, "supports-cqe"))
> > +             host->caps2 |= MMC_CAP2_CQE;
>
> This change is breaking emmc driver on qcom platforms where this dt
> property is defined.
>
> [    1.543453]  cqhci_deactivate+0xc/0x38
> [    1.545627]  sdhci_msm_reset+0x40/0x58
> [    1.549447]  sdhci_do_reset+0x48/0x7c
> [    1.553180]  __sdhci_read_caps+0x7c/0x214
> [    1.556913]  sdhci_setup_host+0x58/0xce8
> [    1.560905]  sdhci_msm_probe+0x588/0x8a4
> [    1.564900]  platform_drv_probe+0x4c/0xb0
>
> So, we cant have this flag defined before sdhci_setup_host().
>
> I will have to clear this cap and re-enable it in our initialization.

Thanks for reporting! I have dropped all the four patches from
Chun-Hung, so we can figure out how to fix this.

Please help to review the next version of the series.

>
> > +     if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> > +             host->caps2 |= MMC_CAP2_CQE_DCMD;
> > +     }
> >
> >       /* Must be after "non-removable" check */
> >       if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {

Kind regards
Uffe
