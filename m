Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4A11FCFD6;
	Mon, 27 Jan 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978122; cv=none; b=aA2FGhoUnCFUXt9CKRfN/d81T6meKAyglJq7HBJwNuZreG5RQlGKzyJOyHr3Qlr5i6qARc3zDG5BhM5C9a494w0cI23e2GbvP9lLr06H8sqPSdS8AjBpJPNDjZdGNBhrjNI2c8Uc28l8hNNV8pqA/AhG6l14GoLysp7XhbazKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978122; c=relaxed/simple;
	bh=goT3WBI7pp4r3z9WIExLGlvsSSTxo+zsrJwAPYYUzX0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWPWayF/xuXTAfJKghiCJ5O8sQdvmRHzpKG1oT5yYdQXcf+YHUZe80aickWOUyRmHkehkuBrU2vvj2Jx+reTQ9ncNCROX5LZxL99iUrRdwcRuwvO89T6fxcCIQNbBprXhaDmBhj1M6/3yWRUxPofTQnS+payHOArcIDGQZlxTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUWIM3yv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUWIM3yv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso45922745e9.2;
        Mon, 27 Jan 2025 03:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737978118; x=1738582918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XtVNyFhaDmOtGa9H3CTt03pn8J/z5TYUVA8y1OEQh4=;
        b=GUWIM3yvL3IH4dmJBJC5Mv9NLUYuaStPNcg86r2UDDXhIoW7KRv/5wm+dbl3bvbBAM
         IWVT+CAMGDU1wHJB+aH08UZ+OkiaJerzRuFNQaQa+VQiE90WE2oaJI7bVGPC5WMOSi6A
         1oZUC2HjWf2ceqI868LpOXmz7Rp2CV7HvsviNQ4kGcrU4ve25td944KeTZZ3y7zxH4Wt
         6G6Bg5/YYRLkwx+cjXwRSJD32IIz7GFomaWlpvo3hBA1MSzZ6OOfOXa4+ZmQUDtNHCPx
         yfzCB2nLMMA0jetqwrxhM9CvO+YkceWP7UD2JtwvtUHrHYkSJnvv7416Thuf9xbFda8f
         2P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737978118; x=1738582918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XtVNyFhaDmOtGa9H3CTt03pn8J/z5TYUVA8y1OEQh4=;
        b=n6QjxiXncFO6zxyiORukSI0+tob+L7aOXAzxG/9wdI0OdFPkEXQGXCP8c8l7nIQ+4Q
         rAkaO1athfg/Tyx3flXgWi0hGlxD5S/Qf+gJhKYei1mk/rHBTJe0uk2NWy3uWk8fYfci
         30I4VSmPwD/kWUQOoDjRQXkkGwgXYFTI6XRC5ctytQbOh8D4+1YsdAHJMLM3nDURaM2z
         4UorcoFQcvMm6f3DVpYV6Z2mfesUWQh7B91j2+Wav1kkLW3jDiwulQUdM54T+UnFLKEb
         FtSk4977xRBJVFDp/g/pBsDnBT1ya/hnT8LqKaqek66Hijlic2OhCLEEUwdDj0rddOYK
         eGnA==
X-Forwarded-Encrypted: i=1; AJvYcCUPjRQblY6itfcm/ujUY3wBYa978791WM4VfXK2RKrciqXOivpvXvB+X8A4X9F77iZ8A+931pUyYZ/J@vger.kernel.org, AJvYcCWYYh3fAU83yjmDarLny7s2IofQ13JYOpxfEijqZ5EuHlXv2GEv2RUxeU/ZtBS84h3uZj9x0gkfiMMU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgt18DmWHgIUUvE0Ok9vHNwBGgvOnXf4BZgczO8QZ15bfL7mrW
	A2DTW8o89SLaKw/XWANvN7rJOKx52+TsF1UcCUQIPFgyuc4H70pR
X-Gm-Gg: ASbGncutwSYv7n0lI+d2tNgVBD7R0IFQi7WfLcAq/imvx1ViexaHjkHZVCv95ElFbMZ
	XKECV8PSUzTXEMMGXlpR7F6FgMX1WqG2FgD1h9jSoXzYV7qEAIjJFybcumCvw4D+4GIUzKbNTaH
	C6XtLlDsnZNwbSd78V19+A/1eKPhOI8SbbrMt6BHbpQ0v5GjfvMRc0/eQma2hI2geC8CVM2VTgz
	LhtzSVzvC2j6bpr2qj+/FXMq7xG/tg5ptDboPwE0wYSsXpnOqWAttJGBRDxEZrTV2XSOVNtVNXX
	AcF258Gpc8H8RWmxJqBYlM5MgbSg7zjcNS9R
X-Google-Smtp-Source: AGHT+IFkEpKLuquJccYvDwAEwxGeqNBcauAv7evGVg9hq70Hw+uxJTs5RhVwP2zKsQFI0XfZVHwkZA==
X-Received: by 2002:a05:6000:2c5:b0:37d:4647:154e with SMTP id ffacd0b85a97d-38bf5655bd3mr33567277f8f.9.1737978118107;
        Mon, 27 Jan 2025 03:41:58 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188bf5sm11019301f8f.50.2025.01.27.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 03:41:57 -0800 (PST)
Message-ID: <67977105.5d0a0220.3b7c2.faad@mx.google.com>
X-Google-Original-Message-ID: <Z5dxA8ZalXlWhzPr@Ansuel-XPS.>
Date: Mon, 27 Jan 2025 12:41:55 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy-ld Lu =?utf-8?B?KOWNouS4nCk=?= <Andy-ld.Lu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Chaotian Jing =?utf-8?B?KOS6leacneWkqSk=?= <Chaotian.Jing@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
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
 <9e022bf13354f544962491cf8061ff3edb878c30.camel@mediatek.com>
 <678e8816.050a0220.b6bb9.f588@mx.google.com>
 <eb064f0873fd47e7cbd07f8e403f11dd6060ff34.camel@mediatek.com>
 <6790bb32.5d0a0220.168b1e.7c5b@mx.google.com>
 <362d66661fcafc09c8d8d15be9e81823caa4ad1b.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <362d66661fcafc09c8d8d15be9e81823caa4ad1b.camel@mediatek.com>

On Thu, Jan 23, 2025 at 01:42:03AM +0000, Andy-ld Lu (卢东) wrote:
> On Wed, 2025-01-22 at 10:32 +0100, Christian Marangi wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Tue, Jan 21, 2025 at 06:25:48AM +0000, Andy-ld Lu (卢东) wrote:
> > > On Mon, 2025-01-20 at 18:29 +0100, Christian Marangi wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > > 
> > > > 
> > > > On Thu, Jan 16, 2025 at 07:01:13AM +0000, Andy-ld Lu (卢东) wrote:
> > > > > On Wed, 2025-01-15 at 08:29 +0100, Christian Marangi wrote:
> > > > > > Add support for AN7581 MMC Host. The MMC Host controller is
> > > > > > based
> > > > > > on
> > > > > > mt7622 with the difference of not having regulator supply and
> > > > > > state_uhs
> > > > > > pins and hclk clock.
> > > > > > 
> > > > > > Some minor fixes are applied to check if the state_uhs pins
> > > > > > are
> > > > > > defined
> > > > > > and make hclk optional for the new airoha compatible.
> > > > > > 
> > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > ---
> > > > > >  drivers/mmc/host/mtk-sd.c | 55
> > > > > > ++++++++++++++++++++++++++++++++-
> > > > > > ----
> > > > > > --
> > > > > >  1 file changed, 46 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/mmc/host/mtk-sd.c
> > > > > > b/drivers/mmc/host/mtk-
> > > > > > sd.c
> > > > > > index efb0d2d5716b..9d6868883c91 100644
> > > > > > --- a/drivers/mmc/host/mtk-sd.c
> > > > > > +++ b/drivers/mmc/host/mtk-sd.c
> > > > > > @@ -666,6 +666,20 @@ static const struct mtk_mmc_compatible
> > > > > > mt8196_compat = {
> > > > > >     .support_new_rx = true,
> > > > > >  };
> > > > > > 
> > > > > > +static const struct mtk_mmc_compatible an7581_compat = {
> > > > > > +   .clk_div_bits = 12,
> > > > > > +   .recheck_sdio_irq = true,
> > > > > > +   .hs400_tune = false,
> > > > > > +   .pad_tune_reg = MSDC_PAD_TUNE0,
> > > > > > +   .async_fifo = true,
> > > > > > +   .data_tune = true,
> > > > > > +   .busy_check = true,
> > > > > > +   .stop_clk_fix = true,
> > > > > > +   .stop_dly_sel = 3,
> > > > > > +   .enhance_rx = true,
> > > > > > +   .support_64g = false,
> > > > > > +};
> > > > > > +
> > > > > >  static const struct of_device_id msdc_of_ids[] = {
> > > > > >     { .compatible = "mediatek,mt2701-mmc", .data =
> > > > > > &mt2701_compat},
> > > > > >     { .compatible = "mediatek,mt2712-mmc", .data =
> > > > > > &mt2712_compat},
> > > > > > @@ -680,7 +694,7 @@ static const struct of_device_id
> > > > > > msdc_of_ids[] =
> > > > > > {
> > > > > >     { .compatible = "mediatek,mt8183-mmc", .data =
> > > > > > &mt8183_compat},
> > > > > >     { .compatible = "mediatek,mt8196-mmc", .data =
> > > > > > &mt8196_compat},
> > > > > >     { .compatible = "mediatek,mt8516-mmc", .data =
> > > > > > &mt8516_compat},
> > > > > > -
> > > > > > +   { .compatible = "airoha,an7581-mmc", .data =
> > > > > > &an7581_compat},
> > > > > >     {}
> > > > > >  };
> > > > > >  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> > > > > > @@ -1600,6 +1614,10 @@ static int msdc_ops_switch_volt(struct
> > > > > > mmc_host *mmc, struct mmc_ios *ios)
> > > > > >     struct msdc_host *host = mmc_priv(mmc);
> > > > > >     int ret;
> > > > > > 
> > > > > > +   /* Skip setting supply if not supported */
> > > > > > +   if (!mmc->supply.vqmmc)
> > > > > > +           return 0;
> > > > > > +
> > > > > 
> > > > > Hi Christian,
> > > > > 
> > > > > I think here is no need. If you have not 'vqmmc' in the
> > > > > dts, IS_ERR(mmc->supply.vqmmc) would be -ENODEV and the
> > > > > corresponding
> > > > > flow would not be executed.
> > > > > 
> > > > > And another question, host->pins_default is just selected here,
> > > > > that
> > > > > would be lost.
> > > > > 
> > > > > >     if (!IS_ERR(mmc->supply.vqmmc)) {
> > > > > >             if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_330
> > > > > > &&
> > > > > >                 ios->signal_voltage !=
> > > > > > MMC_SIGNAL_VOLTAGE_180) {
> > > > > > @@ -1699,7 +1717,9 @@ static void msdc_enable_sdio_irq(struct
> > > > > > mmc_host *mmc, int enb)
> > > > > >                             dev_dbg(host->dev, "SDIO eint
> > > > > > irq:
> > > > > > %d!\n", host->eint_irq);
> > > > > >                     }
> > > > > > 
> > > > > > -                   pinctrl_select_state(host->pinctrl, host-
> > > > > > > pins_uhs);
> > > > > > 
> > > > > > +                   /* Skip setting uhs pins if not supported
> > > > > > */
> > > > > > +                   if (host->pins_uhs)
> > > > > > +                           pinctrl_select_state(host-
> > > > > > >pinctrl,
> > > > > > host->pins_uhs);
> > > > > >             } else {
> > > > > >                     dev_pm_clear_wake_irq(host->dev);
> > > > > >             }
> > > > > > @@ -2036,6 +2056,10 @@ static void msdc_ops_set_ios(struct
> > > > > > mmc_host
> > > > > > *mmc, struct mmc_ios *ios)
> > > > > > 
> > > > > >     msdc_set_buswidth(host, ios->bus_width);
> > > > > > 
> > > > > > +   /* Skip regulator if not supported */
> > > > > > +   if (!mmc->supply.vmmc)
> > > > > > +           goto skip_regulator;
> > > > > > +
> > > > > 
> > > > > No need too.
> > > > > 
> > > > > >     /* Suspend/Resume will do power off/on */
> > > > > >     switch (ios->power_mode) {
> > > > > >     case MMC_POWER_UP:
> > > > > > @@ -2071,6 +2095,7 @@ static void msdc_ops_set_ios(struct
> > > > > > mmc_host
> > > > > > *mmc, struct mmc_ios *ios)
> > > > > >             break;
> > > > > >     }
> > > > > > 
> > > > > > +skip_regulator:
> > > > > >     if (host->mclk != ios->clock || host->timing != ios-
> > > > > > >timing)
> > > > > >             msdc_set_mclk(host, ios->timing, ios->clock);
> > > > > >  }
> > > > > > @@ -2816,9 +2841,12 @@ static int msdc_of_clock_parse(struct
> > > > > > platform_device *pdev,
> > > > > >     if (IS_ERR(host->src_clk))
> > > > > >             return PTR_ERR(host->src_clk);
> > > > > > 
> > > > > > -   host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > > > > > -   if (IS_ERR(host->h_clk))
> > > > > > -           return PTR_ERR(host->h_clk);
> > > > > > +   /* AN7581 SoC doesn't have hclk */
> > > > > > +   if (!device_is_compatible(&pdev->dev, "airoha,an7581-
> > > > > > mmc")) {
> > > > > > +           host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > > > > > +           if (IS_ERR(host->h_clk))
> > > > > > +                   return PTR_ERR(host->h_clk);
> > > > > > +   }
> > > > > 
> > > > > devm_clk_get_optional could be used to instead here, no need to
> > > > > use
> > > > > compatible to distinguish.
> > > > > 
> > > > 
> > > > I can make the hclk optional but I think this would affect also
> > > > every
> > > > other compatible by hiding broken clock configuration.
> > > > 
> > > > > >     host->bus_clk = devm_clk_get_optional(&pdev->dev,
> > > > > > "bus_clk");
> > > > > >     if (IS_ERR(host->bus_clk))
> > > > > > @@ -2926,10 +2954,13 @@ static int msdc_drv_probe(struct
> > > > > > platform_device *pdev)
> > > > > >             return PTR_ERR(host->pins_default);
> > > > > >     }
> > > > > > 
> > > > > > -   host->pins_uhs = pinctrl_lookup_state(host->pinctrl,
> > > > > > "state_uhs");
> > > > > > -   if (IS_ERR(host->pins_uhs)) {
> > > > > > -           dev_err(&pdev->dev, "Cannot find pinctrl
> > > > > > uhs!\n");
> > > > > > -           return PTR_ERR(host->pins_uhs);
> > > > > > +   /* AN7581 doesn't have state_uhs pins */
> > > > > > +   if (!device_is_compatible(&pdev->dev, "airoha,an7581-
> > > > > > mmc")) {
> > > > > > +           host->pins_uhs = pinctrl_lookup_state(host-
> > > > > > >pinctrl,
> > > > > > "state_uhs");
> > > > > > +           if (IS_ERR(host->pins_uhs)) {
> > > > > > +                   dev_err(&pdev->dev, "Cannot find pinctrl
> > > > > > uhs!\n");
> > > > > > +                   return PTR_ERR(host->pins_uhs);
> > > > > > +           }
> > > > > >     }
> > > > > 
> > > > > Could you consider to set a dummy 'state_uhs' same as
> > > > > 'state_default'
> > > > > in the dts, that you could not use compatible to distinguish
> > > > > here.
> > > > > 
> > > > 
> > > > This is problematic, correct me if I'm wrong, you are suggesting
> > > > to
> > > > assign the emmc pins to both default and uhs? This is problematic
> > > > as
> > > > the
> > > > pinctrl driver would complain that such pins are already assigned
> > > > to
> > > > something. Also I don't think it's possible to assign these pins
> > > > to a
> > > > dummy pin.
> > > > 
> > > 
> > > Maybe I have not expressed clearly...What I mean is that you could
> > > set
> > > as below, and the content of &mmc_pins_uhs is just copied from
> > > &mmc_pins_default.
> > > 
> > > mmc@1fa0e000 {
> > >       ...
> > >       pinctrl-names = "default", "state_uhs";
> > >       pinctrl-0 = <&mmc_pins_default>;
> > >       pinctrl-1 = <&mmc_pins_uhs>;
> > > }
> > 
> > Ok my bad. I did declared the second pin to pinctrl-0 instead of
> > adding
> > pinctrl-1. With that it does work correctly.
> > 
> > > > > > 
> > > > > >     /* Support for SDIO eint irq ? */
> > > > > > @@ -3010,6 +3041,12 @@ static int msdc_drv_probe(struct
> > > > > > platform_device *pdev)
> > > > > >             dev_err(&pdev->dev, "Cannot ungate clocks!\n");
> > > > > >             goto release_clk;
> > > > > >     }
> > > > > > +
> > > > > > +   /* AN7581 without regulator require tune to OCR values */
> > > > > > +   if (device_is_compatible(&pdev->dev, "airoha,an7581-mmc") 
> > > > > > &&
> > > > > > +       !mmc->ocr_avail)
> > > > > > +           mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > > > > > +
> > > > > 
> > > > > Maybe you could use regulator-fixed in the dts and configure
> > > > > min/max
> > > > > voltage to get ocr_avail, no need to set hard code here.
> > > > > 
> > > > 
> > > > Also suggested by Wenbin Mei (梅文彬) and I just tried this.
> > > > 
> > > > This can't be done, fixed-regulator needs to have the same min
> > > > and
> > > > max
> > > > voltage or they fail to probe sooo fixed-regulator saddly can't
> > > > be
> > > > used
> > > > :(
> > > > 
> > > > I will send a new version of this with the other point corrected
> > > > but
> > > > I
> > > > think a compatible and these additional if is a must :(
> > > 
> > > If use the fixed regulator such as below, you will get the same
> > > ocr_avail as 'MMC_VDD_32_33 | MMC_VDD_33_34' through
> > > mmc_regulator_get_ocrmask().
> > > 
> > > vmmc_3v3: regulator-vmmc-3v3 {
> > >       compatible = "regulator-fixed";
> > >       regulator-name = "vmmc";
> > >       regulator-min-microvolt = <3300000>;
> > >       regulator-max-microvolt = <3300000>;
> > >       regulator-always-on;
> > > }
> > 
> > Ok the code was a bit confusing but yes I can confirm that a 3.3
> > fixed
> > regulator define those 2 flags so also this is OK.
> > 
> > There is still the discussion about clock. You are totally against a
> > new
> > compatible for the hclk?
> > 
> As the comment in the v2 patches, the better way is to add a bool
> variable like 'needs_not_hclk' in the compat data, which is just true
> for you, and use !host->dev_comp->needs_not_hclk as the condition to
> get 'hclk'.
> 
> But I would like to confirm if the 'fixed-clock' could be supported in
> your project, which is also used in mt7622.dtsi, you may align 'hclk'
> to a dummy fixed-clock... 
>

Thanks I implemented with dummy clock + dummy regulator + dummy state so
we don't need an additional compatible. Thanks for the suggestions!

> > > > 
> > > > > >     msdc_init_hw(host);
> > > > > > 
> > > > > >     if (mmc->caps2 & MMC_CAP2_CQE) {
> > > > 
> > > > --
> > > >         Ansuel
> > 
> > --
> >         Ansuel

-- 
	Ansuel
