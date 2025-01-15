Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF920764C;
	Wed, 15 Jan 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933740; cv=none; b=EriUDcF9DKOsp9UnIfzRHG2IkTnEG+OWYYoJ66iQsska2t4AqSRa+T7VsbGnn0kOF81Yz3tmA3yak93RHvHZInPCY43buEq/9rq4gefpZbpzgPel+Yrcmu8ip8BEjLuVWbNJPT/ZG+0GeP/joTv1r8/NKPiwF0yLTE8TX/fDwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933740; c=relaxed/simple;
	bh=hSoXZbHeOatVgnXPU6wXXJ9z8menycEfNUikfVdwris=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0h4kVpY/kFqGvswTuIXvqE54kALb220SE7RDTFu0SVaKsSWsGNYb3Ngn4ssQ1ubIQl8qGgR9G4i2aTTEX21upDnQVXTBiNCRK4EL53opXeo4yT9KzS9z6OVv+lBFjnglLv83NuHP2kuilr7L97jRHl0DWBse3q+Z+eYo/TyPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtZFcOv8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtZFcOv8"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so5312290f8f.1;
        Wed, 15 Jan 2025 01:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736933736; x=1737538536; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bJlS2BHE74secUz9CB0R8O3ilQB+OB3FuTYckR6ubFM=;
        b=EtZFcOv8RMBjxB1pwcF0oQjDNpf+Cetaf365RNKcALyoJnd0fXNOjKH++hYHh/Q9FH
         e9pWiIYKoMj81CD3yri6ikS6kIfdE3gqknSn87bJYdsDgwZB01o29y+knTY80h9votAO
         wuOgpUDqenUArt2mAb5gU8NiX7StFB+iD/23BDRBl97EwqGmUVe45mt73cjNHnq2yjxj
         xJ4vegkms3X3waqr9FUxxh7pv7Yy35JrJAgtqmQGvVkc/hlQqRWqKd0BvHPancFZojZo
         MWdv38kx2PyM8DujtkyBV5VM3fX4pcqc4CnAoMS+bUp9KHrRgHIYBuvUo0WV+k/DyEO7
         greA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736933736; x=1737538536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJlS2BHE74secUz9CB0R8O3ilQB+OB3FuTYckR6ubFM=;
        b=iNmFicjgTBIwYdSudc/uei6SQN2jsbEGdHONeelAnbdc4NJqScvaFPhB50kE7VJitq
         pOJ6f3KtF2w7OeInTq/PSAIxYBOy3/7aBPo3L4PgozVN6YeSwHyavYCWgDDQyhp4WNBe
         R2v6YIDbRykLp6j08Vfi8cfqtuAzfKtJSkXTYfBfOoRZjsJmkLP47W43BuK1Qm5H/AOP
         nsdmEHifYfNwJdpqzbdNUHdKDjgAmrLSqop3MgKqhJb15pGUuk7eGP85eM/aRTWV7lIg
         wBV5DcjuguEYEBO5mpG+oyvM3zVTYP1eqzJy6Lq5TSSqPpcsyDnrnCDlIAXwF5518S1N
         Aufg==
X-Forwarded-Encrypted: i=1; AJvYcCUKV4DUQGel49LaPO87OtxSFtftQpzYy8rX8kTG3jRCh4+f2lVpTO3EzqzSx88cZeawX75Z57HzIZbW@vger.kernel.org, AJvYcCWsYMPJKfFB03e+gTnPg6Mt9DLqR1t7J7RGx96C+1src6TYAw1+hy/gu2ntFnn7LgZEQvtJ0cZzH1SQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxJGTH1mjgOinq1+Wq8QCPiExBPkQR1EOZF6WC4a7n8gxSwYz0i
	CHmK3HzUbrXoAd2S6hMsX+6wV2JtlUwr6aL0K11DYi8jALpzO8tB
X-Gm-Gg: ASbGncsaWaVq+eNx7E10X7ciaC7ZyrInHcfaj9o/WDn4jSSqqo2bCtSfxBQv9ZYY5+H
	k5/qUPXv8Kjj9CxSkmoXuipXCmMuFIpXy+k9TVOgoiPd2HfCS2ZJJrHS5fwIqigvdIYH+tqq79C
	liT/6ExvozoJ9ZgiAtQPUidy+2JV0QIeZlyi++WgcRpT4k1QcFEYCaEnrAK1VxKwgFdK9mVrLQ6
	3jWlc5AhBwnz4Z39JSwkckMNsTY14yXa1bXzuMw6/CSy5GO9bFHbqugmM7i61tlO5se6c9DqkwM
	qz8FALzkTwJm
X-Google-Smtp-Source: AGHT+IH2JuWof//uVdkBpA3QQVNZsi6lClPHa+2DDtdHWYts1qlYQ7sw3xXHB+R64tKJpk2Eii7oWg==
X-Received: by 2002:a05:6000:1542:b0:38a:a047:6c0b with SMTP id ffacd0b85a97d-38aa0476d5amr17286510f8f.35.1736933736287;
        Wed, 15 Jan 2025 01:35:36 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c16ba82csm21964055e9.1.2025.01.15.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:35:35 -0800 (PST)
Message-ID: <67878167.050a0220.9eba5.7501@mx.google.com>
X-Google-Original-Message-ID: <Z4eBZlZnSRjlhKen@Ansuel-XPS.>
Date: Wed, 15 Jan 2025 10:35:34 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Chaotian Jing =?utf-8?B?KOS6leacneWkqSk=?= <Chaotian.Jing@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	upstream <upstream@airoha.com>
Subject: Re: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
 <20250115073026.31552-2-ansuelsmth@gmail.com>
 <a00c76b9752410ea86d6cac0f774d5d1ea45891d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a00c76b9752410ea86d6cac0f774d5d1ea45891d.camel@mediatek.com>

On Wed, Jan 15, 2025 at 09:33:35AM +0000, Wenbin Mei (梅文彬) wrote:
> On Wed, 2025-01-15 at 08:29 +0100, Christian Marangi wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > Add support for AN7581 MMC Host. The MMC Host controller is based on
> > mt7622 with the difference of not having regulator supply and
> > state_uhs
> > pins and hclk clock.
> > 
> > Some minor fixes are applied to check if the state_uhs pins are
> > defined
> > and make hclk optional for the new airoha compatible.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 55 ++++++++++++++++++++++++++++++++-----
> > --
> >  1 file changed, 46 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index efb0d2d5716b..9d6868883c91 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -666,6 +666,20 @@ static const struct mtk_mmc_compatible
> > mt8196_compat = {
> >         .support_new_rx = true,
> >  };
> > 
> > +static const struct mtk_mmc_compatible an7581_compat = {
> > +       .clk_div_bits = 12,
> > +       .recheck_sdio_irq = true,
> > +       .hs400_tune = false,
> > +       .pad_tune_reg = MSDC_PAD_TUNE0,
> > +       .async_fifo = true,
> > +       .data_tune = true,
> > +       .busy_check = true,
> > +       .stop_clk_fix = true,
> > +       .stop_dly_sel = 3,
> > +       .enhance_rx = true,
> > +       .support_64g = false,
> > +};
> > +
> >  static const struct of_device_id msdc_of_ids[] = {
> >         { .compatible = "mediatek,mt2701-mmc", .data =
> > &mt2701_compat},
> >         { .compatible = "mediatek,mt2712-mmc", .data =
> > &mt2712_compat},
> > @@ -680,7 +694,7 @@ static const struct of_device_id msdc_of_ids[] =
> > {
> >         { .compatible = "mediatek,mt8183-mmc", .data =
> > &mt8183_compat},
> >         { .compatible = "mediatek,mt8196-mmc", .data =
> > &mt8196_compat},
> >         { .compatible = "mediatek,mt8516-mmc", .data =
> > &mt8516_compat},
> > -
> > +       { .compatible = "airoha,an7581-mmc", .data = &an7581_compat},
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> > @@ -1600,6 +1614,10 @@ static int msdc_ops_switch_volt(struct
> > mmc_host *mmc, struct mmc_ios *ios)
> >         struct msdc_host *host = mmc_priv(mmc);
> >         int ret;
> > 
> > +       /* Skip setting supply if not supported */
> > +       if (!mmc->supply.vqmmc)
> > +               return 0;
> > +
> >         if (!IS_ERR(mmc->supply.vqmmc)) {
> >                 if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_330 &&
> >                     ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
> > @@ -1699,7 +1717,9 @@ static void msdc_enable_sdio_irq(struct
> > mmc_host *mmc, int enb)
> >                                 dev_dbg(host->dev, "SDIO eint irq:
> > %d!\n", host->eint_irq);
> >                         }
> > 
> > -                       pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
> > +                       /* Skip setting uhs pins if not supported */
> > +                       if (host->pins_uhs)
> > +                               pinctrl_select_state(host->pinctrl,
> > host->pins_uhs);
> >                 } else {
> >                         dev_pm_clear_wake_irq(host->dev);
> >                 }
> > @@ -2036,6 +2056,10 @@ static void msdc_ops_set_ios(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> > 
> >         msdc_set_buswidth(host, ios->bus_width);
> > 
> > +       /* Skip regulator if not supported */
> > +       if (!mmc->supply.vmmc)
> > +               goto skip_regulator;
> > +
> If power_mode is MMC_POWER_UP, we need to execute the related flow.
> Now it will skip mmc_init_hw(host), which will cause problems.
> BTW, can this be implemented using a fix regulator? if ok, no need
> to modify here.

Yes I didn't think of that, I will test if this is possible and reply
back, thanks for the hint.

> >         /* Suspend/Resume will do power off/on */
> >         switch (ios->power_mode) {
> >         case MMC_POWER_UP:
> > @@ -2071,6 +2095,7 @@ static void msdc_ops_set_ios(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >                 break;
> >         }
> > 
> > +skip_regulator:
> >         if (host->mclk != ios->clock || host->timing != ios->timing)
> >                 msdc_set_mclk(host, ios->timing, ios->clock);
> >  }
> > @@ -2816,9 +2841,12 @@ static int msdc_of_clock_parse(struct
> > platform_device *pdev,
> >         if (IS_ERR(host->src_clk))
> >                 return PTR_ERR(host->src_clk);
> > 
> > -       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > -       if (IS_ERR(host->h_clk))
> > -               return PTR_ERR(host->h_clk);
> > +       /* AN7581 SoC doesn't have hclk */
> > +       if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
> > +               host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +               if (IS_ERR(host->h_clk))
> > +                       return PTR_ERR(host->h_clk);
> > +       }
> > 
> >         host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
> >         if (IS_ERR(host->bus_clk))
> > @@ -2926,10 +2954,13 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >                 return PTR_ERR(host->pins_default);
> >         }
> > 
> > -       host->pins_uhs = pinctrl_lookup_state(host->pinctrl,
> > "state_uhs");
> > -       if (IS_ERR(host->pins_uhs)) {
> > -               dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
> > -               return PTR_ERR(host->pins_uhs);
> > +       /* AN7581 doesn't have state_uhs pins */
> > +       if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
> > +               host->pins_uhs = pinctrl_lookup_state(host->pinctrl,
> > "state_uhs");
> > +               if (IS_ERR(host->pins_uhs)) {
> > +                       dev_err(&pdev->dev, "Cannot find pinctrl
> > uhs!\n");
> > +                       return PTR_ERR(host->pins_uhs);
> > +               }
> >         }
> > 
> >         /* Support for SDIO eint irq ? */
> > @@ -3010,6 +3041,12 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >                 dev_err(&pdev->dev, "Cannot ungate clocks!\n");
> >                 goto release_clk;
> >         }
> > +
> > +       /* AN7581 without regulator require tune to OCR values */
> > +       if (device_is_compatible(&pdev->dev, "airoha,an7581-mmc") &&
> > +           !mmc->ocr_avail)
> > +               mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > +
> >         msdc_init_hw(host);
> > 
> >         if (mmc->caps2 & MMC_CAP2_CQE) {
> > --
> > 2.45.2
> > 

-- 
	Ansuel
