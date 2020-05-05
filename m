Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B811C47247
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162EB2075A
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPwWy0x5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEEJPN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEEJPN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 05:15:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D864C061A0F;
        Tue,  5 May 2020 02:15:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so1796295wrn.6;
        Tue, 05 May 2020 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RY7cDlpTuaGYvklt0tq/lt5rHTsOTKpcG4DTTLgRMho=;
        b=uPwWy0x52Ah1Js8kGrNYWa1bV8vTY9V8wj/gnIm0oLsfc9a7C84/+siL9wcDzeQEvt
         bR8g0PkRXmeef2fThZbJVBQuOPnnFaOQ25VrMRzv6UGroAkA9LAyibmAb+uk7r753nSw
         rqsFlAK84KF/cvBfhqs6KfCX94ECh4MTwoMwyo5TpkNAR8+BfakNlbhRJzk/q2pGwM8i
         4ldkI3q6KtNwS7VLGbbhyBNMRDON0KZ8C1gN3sczSWbdaCf6qRAp7YAks+mh49lSlNTo
         NB/qoSCWJbyqWQECbaFqbKcTWlk752n/LuU7qZXeGOFNrvQL7znMOKzwh4G2b677k1hg
         KEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RY7cDlpTuaGYvklt0tq/lt5rHTsOTKpcG4DTTLgRMho=;
        b=NucGvITl8OIyp66GdUvEYeH3xS2zadtgZg38muSIU8IE8sv+unuHUnCbzQq+WQ3Aov
         Q9yzdNogzEzC3saPt/N6+YK/PlBanAref/8eOCDO4eZPWHl8hWOdKjAkf5GIn0PrTKHi
         Wo+heMxj+g9uf/7Siknybpv6LpXs98w2b7B73slDOX6hFlh4AS+r4F+xjqvNdisZQeS5
         GPdi7Ea/AEmO+I3TX3QFXQeVbbnDna76RMppAOgVrqS8yBLPGMYGIkrRjq5I70f4Z6Eq
         tLsPqP1xncdgyjZO4Z3gegJINZwtgwQmXYTSjNAB4wDIzjfXDqX/OjVg4w1udEqMadsP
         uX/w==
X-Gm-Message-State: AGi0PuYaD2c00SMVwc5Jg47mMFDxo37KWdYXhDikifAKBGc2+2eBSrNE
        c08XlqRNivYVDfv7RQcFZhsuP8vgnqBKG+IIaYs=
X-Google-Smtp-Source: APiQypK1Bz/oNmOaxggxrm9bETwKta2RG7Wk+wv6HGAiMkRo8VQGFQ/b3ZHRf9FsHJ2/gSb44gZE0s5+6DRgoFISKOY=
X-Received: by 2002:adf:eac6:: with SMTP id o6mr2475150wrn.297.1588670111614;
 Tue, 05 May 2020 02:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200504063957.6638-1-benchuanggli@gmail.com> <21b55731-388f-91ef-3f38-5896f7da9121@intel.com>
In-Reply-To: <21b55731-388f-91ef-3f38-5896f7da9121@intel.com>
From:   Grzegorz Kowal <custos.mentis@gmail.com>
Date:   Tue, 5 May 2020 06:15:00 -0300
Message-ID: <CABmMA7tf4fUTd9uOP7z=XyR9ukfL+DAd2Ry7f1yKuTCmyZif_A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix can not access GL9750 after
 reboot from Windows 10
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        renius.chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tested-by: Grzegorz Kowal <custos.mentis@gmail.com>

Thanks,
Grzegorz

On Mon, May 4, 2020 at 4:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 4/05/20 9:39 am, Ben Chuang wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > Need to clear some bits in a vendor-defined register after reboot from
> > Windows 10.
> >
> > Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> > Reported-by: Grzegorz Kowal <custos.mentis@gmail.com>
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index ce15a05f23d4..8170b659f2af 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -26,6 +26,9 @@
> >  #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
> >  #define   GLI_9750_DRIVING_1_VALUE    0xFFF
> >  #define   GLI_9750_DRIVING_2_VALUE    0x3
> > +#define   SDHCI_GLI_9750_SEL_1        BIT(29)
> > +#define   SDHCI_GLI_9750_SEL_2        BIT(31)
> > +#define   SDHCI_GLI_9750_ALL_RST      (BIT(24)|BIT(25)|BIT(28)|BIT(30))
> >
> >  #define SDHCI_GLI_9750_PLL         0x864
> >  #define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
> > @@ -122,6 +125,8 @@ static void gli_set_9750(struct sdhci_host *host)
> >                                   GLI_9750_DRIVING_1_VALUE);
> >       driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
> >                                   GLI_9750_DRIVING_2_VALUE);
> > +     driving_value &= ~(SDHCI_GLI_9750_SEL_1|SDHCI_GLI_9750_SEL_2|SDHCI_GLI_9750_ALL_RST);
> > +     driving_value |= SDHCI_GLI_9750_SEL_2;
> >       sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
> >
> >       sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
> >
>
