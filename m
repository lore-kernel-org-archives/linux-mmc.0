Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CDC63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DE120715
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBr9ORJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgKXOx2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbgKXOx2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:53:28 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DAC0613D6;
        Tue, 24 Nov 2020 06:53:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gj5so28897518ejb.8;
        Tue, 24 Nov 2020 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEUKuLpjCuuXItWkksOTBx3RDvxi7jvrhOsxyZoWmi4=;
        b=sBr9ORJyasxV3qB6qzPsLZdyoergeUwBTSBHF6ZFV85hF/MBtXGC96NgDlCn7+hJXT
         ln5htt0pYtst7Bb0ai+5CBm9wkLA6cgUIRGekdKVvSfSAWT2s1+VaikYJL5aBJZexbTc
         tYfDFHhhf4QQvbUol73GtehxBxgHm/PKBBq9msiDXU2WzJ8fvhYJMf6Jyh4H2itlxAlZ
         kuOebPSFbVpMcESr229BmSgedhbO8itTkjKDtxGEbrLHULQTJIVtY5iLedV8vOBRAI2I
         emgZKEzPSRZpju5ZDsXFry5laO9LQDnxOZnAl8O0bFhvoQXL+7RbUfmpUuJEuzehCpS0
         7/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rEUKuLpjCuuXItWkksOTBx3RDvxi7jvrhOsxyZoWmi4=;
        b=sMZwV2vP6y/XF3uiDBHYGdngq3+DlWPt0KVc1Jc9aiJwRx1NS7cKnOTPn1fU00BzeA
         bi5PG+enKSHJt0Zei5rmX2q5Eguo4rjdSLW4Ql+w0MN4QYZoYVtlP2fB3cfSCVbxFpZh
         gPKgWpIpkr+lkDxdvqtmvV3F6mN2KKYZXHQspO5m3pdBPPFjmYp1Xd9Kk3GS2IIZ0yQO
         rI8gYEzXm3hLSLCrtxWfV4cRMS04RDHY9gcq87i1MJTtXIhSQRYvKm0/I9lY+MoZus/t
         OpLmMnP4mKeOqUu50CkZ4kpgvp53lIdDRNkrfaB2pWt1Y2CL69nINyuaff5sY0gwA5a9
         dWcQ==
X-Gm-Message-State: AOAM5301pEOStSi21mPVJx4WCirSCD84kdEqLGP5H9d3gTctAHYsQ46x
        dmzfXFpt6okqcs5zITZR+c4=
X-Google-Smtp-Source: ABdhPJyaVJenZZeGBaqJ01kMB58aUbsK780xB4sToUBFLH500309P3SDPHkLrJpAPswyd24bZkxd4Q==
X-Received: by 2002:a17:906:680d:: with SMTP id k13mr4364048ejr.482.1606229606600;
        Tue, 24 Nov 2020 06:53:26 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id qx6sm6934310ejb.10.2020.11.24.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:53:25 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:53:23 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 09/18] arm: dts: owl-s500: Add MMC support
Message-ID: <20201124145323.GA598837@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
 <CAPDyKFrBaiqmHbx0MKTv0uusDdLeeAwQuN8NMiVKgaAQBK0x1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrBaiqmHbx0MKTv0uusDdLeeAwQuN8NMiVKgaAQBK0x1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 24, 2020 at 03:25:15PM +0100, Ulf Hansson wrote:
> On Fri, 20 Nov 2020 at 00:56, Cristian Ciocaltea
> <cristian.ciocaltea@gmail.com> wrote:
> >
> > Add MMC controller nodes for Actions Semi S500 SoC, in order to
> > facilitate access to SD/EMMC/SDIO cards.
> >
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 

Thanks for the review!

Regards,
Cristi

> 
> > ---
> >  arch/arm/boot/dts/owl-s500.dtsi | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> > index b16172615db0..7af7c9e1119d 100644
> > --- a/arch/arm/boot/dts/owl-s500.dtsi
> > +++ b/arch/arm/boot/dts/owl-s500.dtsi
> > @@ -241,5 +241,38 @@ dma: dma-controller@b0260000 {
> >                         clocks = <&cmu CLK_DMAC>;
> >                         power-domains = <&sps S500_PD_DMA>;
> >                 };
> > +
> > +               mmc0: mmc@b0230000 {
> > +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> > +                       reg = <0xb0230000 0x38>;
> > +                       interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&cmu CLK_SD0>;
> > +                       resets = <&cmu RESET_SD0>;
> > +                       dmas = <&dma 2>;
> > +                       dma-names = "mmc";
> > +                       status = "disabled";
> > +               };
> > +
> > +               mmc1: mmc@b0234000 {
> > +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> > +                       reg = <0xb0234000 0x38>;
> > +                       interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&cmu CLK_SD1>;
> > +                       resets = <&cmu RESET_SD1>;
> > +                       dmas = <&dma 3>;
> > +                       dma-names = "mmc";
> > +                       status = "disabled";
> > +               };
> > +
> > +               mmc2: mmc@b0238000 {
> > +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> > +                       reg = <0xb0238000 0x38>;
> > +                       interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&cmu CLK_SD2>;
> > +                       resets = <&cmu RESET_SD2>;
> > +                       dmas = <&dma 4>;
> > +                       dma-names = "mmc";
> > +                       status = "disabled";
> > +               };
> >         };
> >  };
> > --
> > 2.29.2
> >
