Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B81E9B20;
	Mon, 20 Jan 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394203; cv=none; b=Qpuhlt2k4v2Q175kZ4KKQc8z3098uspdfWIJVKXKKpOoaYlwRgp0hb2q4z01XHMKDU+203BBILgk+h+ZzK9hVmKp5WqVsDcvmHVIch/DrKNIVAy4PAVQY4RnIlIKWdaIniC+qtxFlHHGb7/P8GTBB2PEk4+BBLxvt+698TUb0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394203; c=relaxed/simple;
	bh=eouAKjbdwV0lWunpOfjckMljjwF5cb9Kx5eqdqL2gCk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSJ4H4FqFhmzHd+wojZ8SZtyEUvdcAr7BxXtOpUapGNXwxbbwOzX+SFNl7J7x9hmar5bPNKXKpX0ujTYTu2FAZQzDhYCl9+1tI2k9YruItOobfqGM+Kb9zjwukzq5co4sbMAE6uw5MeT6SjaXJ+pxbAelPIiX2KWJQQgpBZPHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drtoTYxQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drtoTYxQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so19973615e9.1;
        Mon, 20 Jan 2025 09:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737394199; x=1737998999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0B3gemxUmaJrs7DfKycRLMmy76Q0qp/FE8e2Q2hM4To=;
        b=drtoTYxQ/Am6ee5eeO0tRWBpYoD0NRSOV+QrTxkntnt8C7zyficqo0UiFNAx9AyV+s
         TvdeaP/2AZP+UZE6gF/rxw9GENpSheh4r73Va53jRNU72je1r438EGFUdJzOk2IpNOBw
         ldGGif8Oy5JlAW6ly8KQGxO7TbPaBBumqI8JMrXw4/VDQvkZDVN3XiY+Zxw4DTDIGvVt
         KjFsvTPZBTsaXMMlhnOhB2PO9pSdioQPUR6Fq/6Bw+0SFCwAlAx9OxX3tPHKad/+Nek7
         h7e9Oy89WnHlqzMNwk3TAyTM7Dt9inxY1m3pLkSNGVRmjfNOQGbtK6qDWKRwwAMOF+0F
         qncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394199; x=1737998999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0B3gemxUmaJrs7DfKycRLMmy76Q0qp/FE8e2Q2hM4To=;
        b=Ioex5DhVlAsdD2UCaFb4T51i8g4rC9pvZi4FfcI3daJuvi3d6S3YJPCnM1jiJZwUke
         IScf/VfYGdvyuNM4eX3l9JALH/tLrH0c+otNvjkZTq1LI5Z0TRRBScuLL5LjtRWme2Wa
         GqRX7WC2Wll+g0ljNc3GgMS2CfM/pyrWsyBqslTEV6233ha84Hqo/Hv07i+ORNPr2ZLw
         27SE99Qcu0dN+7CQVH0Rs2eBa6sJDbntjuJOYz+mmkH70kEJKJcs7VX2Iy2fuxF5RqyS
         1mme37bill5drnJfZbxLwJ3YrzL9YwUd61pgkWJAavYY0hX/c5NHFTZIHeb1aB4G2fNp
         cjew==
X-Forwarded-Encrypted: i=1; AJvYcCUWSWSNJIa+IAetAdwpg9m2NVQV2nURnaAQKr2PyIhGmouVkMRdrmR/2WxtVvIV4rddeR2kqZtM7eFG@vger.kernel.org, AJvYcCW2MfZOvkyaxIN00is/mEiK0ot8X97GQ76BoJ798hG4+NiC9XLw7f7BZiPeoBPnLGdV6JcfP4lzRgQq@vger.kernel.org
X-Gm-Message-State: AOJu0YyQALYCYD5ycTGY8kOwrVeaXU/xfLe+y/PKxk9wp4OXKFLM6E36
	mK59t/FiqvWwTNB8/KlooZTlidmn6W8LsO27nnZcPA0xktCRtfZJ
X-Gm-Gg: ASbGnctJcPveUu0CmqNbApIkiMSVUL/3bcRB4APFqA0njQEu+5o+PkQADbby9wFQpc7
	xZ/wqdpZVt2yISK+g3JxKrqZBal9xiLXbKHnDCuqeelsvHdEassGJWoQb/Jrd2W/sEIOclu/PgQ
	G5qgkqu7eSVthJL6ImA5iMjwKisj1RaE7eYBrK/AtiPBLjqqcxEcZ6kzGYW2eY6AQilCAIkGZwj
	fMLG+qwuxIq6HmJQpG4tfI41i3U++nV4P9uUOvd0uQptuTp0KKlmpG55WSDE241LeVRJBPy6aHW
	PHe1PqxnbklbjOEjKgXLQz41FA==
X-Google-Smtp-Source: AGHT+IF1Ls2ZGh8+noLN6wNSkCbP/7nO9y+DgQ3y6uIFFRbvHCZR1LGZjFHMdzf8bf1nnMgw+5jwqA==
X-Received: by 2002:a05:600c:6a94:b0:434:f753:600f with SMTP id 5b1f17b1804b1-438914376b1mr117703705e9.19.1737394198893;
        Mon, 20 Jan 2025 09:29:58 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c0efccf7sm137517235e9.0.2025.01.20.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 09:29:58 -0800 (PST)
Message-ID: <678e8816.050a0220.b6bb9.f588@mx.google.com>
X-Google-Original-Message-ID: <Z46IEs6HyZJd3eHV@Ansuel-XPS.>
Date: Mon, 20 Jan 2025 18:29:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy-ld Lu =?utf-8?B?KOWNouS4nCk=?= <Andy-ld.Lu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
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
 <9e022bf13354f544962491cf8061ff3edb878c30.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e022bf13354f544962491cf8061ff3edb878c30.camel@mediatek.com>

On Thu, Jan 16, 2025 at 07:01:13AM +0000, Andy-ld Lu (卢东) wrote:
> On Wed, 2025-01-15 at 08:29 +0100, Christian Marangi wrote:
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
> >  	.support_new_rx = true,
> >  };
> >  
> > +static const struct mtk_mmc_compatible an7581_compat = {
> > +	.clk_div_bits = 12,
> > +	.recheck_sdio_irq = true,
> > +	.hs400_tune = false,
> > +	.pad_tune_reg = MSDC_PAD_TUNE0,
> > +	.async_fifo = true,
> > +	.data_tune = true,
> > +	.busy_check = true,
> > +	.stop_clk_fix = true,
> > +	.stop_dly_sel = 3,
> > +	.enhance_rx = true,
> > +	.support_64g = false,
> > +};
> > +
> >  static const struct of_device_id msdc_of_ids[] = {
> >  	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
> >  	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> > @@ -680,7 +694,7 @@ static const struct of_device_id msdc_of_ids[] =
> > {
> >  	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
> >  	{ .compatible = "mediatek,mt8196-mmc", .data = &mt8196_compat},
> >  	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
> > -
> > +	{ .compatible = "airoha,an7581-mmc", .data = &an7581_compat},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> > @@ -1600,6 +1614,10 @@ static int msdc_ops_switch_volt(struct
> > mmc_host *mmc, struct mmc_ios *ios)
> >  	struct msdc_host *host = mmc_priv(mmc);
> >  	int ret;
> >  
> > +	/* Skip setting supply if not supported */
> > +	if (!mmc->supply.vqmmc)
> > +		return 0;
> > +
> Hi Christian,
> 
> I think here is no need. If you have not 'vqmmc' in the
> dts, IS_ERR(mmc->supply.vqmmc) would be -ENODEV and the corresponding
> flow would not be executed.
> 
> And another question, host->pins_default is just selected here, that
> would be lost.
>  
> >  	if (!IS_ERR(mmc->supply.vqmmc)) {
> >  		if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_330 &&
> >  		    ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
> > @@ -1699,7 +1717,9 @@ static void msdc_enable_sdio_irq(struct
> > mmc_host *mmc, int enb)
> >  				dev_dbg(host->dev, "SDIO eint irq:
> > %d!\n", host->eint_irq);
> >  			}
> >  
> > -			pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
> > +			/* Skip setting uhs pins if not supported */
> > +			if (host->pins_uhs)
> > +				pinctrl_select_state(host->pinctrl,
> > host->pins_uhs);
> >  		} else {
> >  			dev_pm_clear_wake_irq(host->dev);
> >  		}
> > @@ -2036,6 +2056,10 @@ static void msdc_ops_set_ios(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >  
> >  	msdc_set_buswidth(host, ios->bus_width);
> >  
> > +	/* Skip regulator if not supported */
> > +	if (!mmc->supply.vmmc)
> > +		goto skip_regulator;
> > +
> No need too.
> 
> >  	/* Suspend/Resume will do power off/on */
> >  	switch (ios->power_mode) {
> >  	case MMC_POWER_UP:
> > @@ -2071,6 +2095,7 @@ static void msdc_ops_set_ios(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >  		break;
> >  	}
> >  
> > +skip_regulator:
> >  	if (host->mclk != ios->clock || host->timing != ios->timing)
> >  		msdc_set_mclk(host, ios->timing, ios->clock);
> >  }
> > @@ -2816,9 +2841,12 @@ static int msdc_of_clock_parse(struct
> > platform_device *pdev,
> >  	if (IS_ERR(host->src_clk))
> >  		return PTR_ERR(host->src_clk);
> >  
> > -	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > -	if (IS_ERR(host->h_clk))
> > -		return PTR_ERR(host->h_clk);
> > +	/* AN7581 SoC doesn't have hclk */
> > +	if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
> > +		host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +		if (IS_ERR(host->h_clk))
> > +			return PTR_ERR(host->h_clk);
> > +	}
> devm_clk_get_optional could be used to instead here, no need to use
> compatible to distinguish.
>

I can make the hclk optional but I think this would affect also every
other compatible by hiding broken clock configuration.

> >  	host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
> >  	if (IS_ERR(host->bus_clk))
> > @@ -2926,10 +2954,13 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >  		return PTR_ERR(host->pins_default);
> >  	}
> >  
> > -	host->pins_uhs = pinctrl_lookup_state(host->pinctrl,
> > "state_uhs");
> > -	if (IS_ERR(host->pins_uhs)) {
> > -		dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
> > -		return PTR_ERR(host->pins_uhs);
> > +	/* AN7581 doesn't have state_uhs pins */
> > +	if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
> > +		host->pins_uhs = pinctrl_lookup_state(host->pinctrl,
> > "state_uhs");
> > +		if (IS_ERR(host->pins_uhs)) {
> > +			dev_err(&pdev->dev, "Cannot find pinctrl
> > uhs!\n");
> > +			return PTR_ERR(host->pins_uhs);
> > +		}
> >  	}
> Could you consider to set a dummy 'state_uhs' same as 'state_default'
> in the dts, that you could not use compatible to distinguish here.
> 

This is problematic, correct me if I'm wrong, you are suggesting to
assign the emmc pins to both default and uhs? This is problematic as the
pinctrl driver would complain that such pins are already assigned to
something. Also I don't think it's possible to assign these pins to a
dummy pin.

> >  
> >  	/* Support for SDIO eint irq ? */
> > @@ -3010,6 +3041,12 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >  		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
> >  		goto release_clk;
> >  	}
> > +
> > +	/* AN7581 without regulator require tune to OCR values */
> > +	if (device_is_compatible(&pdev->dev, "airoha,an7581-mmc") &&
> > +	    !mmc->ocr_avail)
> > +		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > +
> Maybe you could use regulator-fixed in the dts and configure min/max
> voltage to get ocr_avail, no need to set hard code here. 
> 

Also suggested by Wenbin Mei (梅文彬) and I just tried this.

This can't be done, fixed-regulator needs to have the same min and max
voltage or they fail to probe sooo fixed-regulator saddly can't be used
:(

I will send a new version of this with the other point corrected but I
think a compatible and these additional if is a must :(

> >  	msdc_init_hw(host);
> >  
> >  	if (mmc->caps2 & MMC_CAP2_CQE) {

-- 
	Ansuel
