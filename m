Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F14313557
	for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444840; cv=none; b=cVD6uyD709VARqQTGgKyZ8jRaNj8LETQncL4CX8/PadBNZ1svxI2nSBOea9QOfKj3Te0QYZCeAk/kEuXrAcCTSwUwq32959937Y3Lm+nF8p263x9iZUph4yUqLh0EpGSV56BULAbVB4eM4YG7jL0/oKSiKCUGwA6X8yaoWbCNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444840; c=relaxed/simple;
	bh=UpiGm1rT9EBDp1/84eMBMTQZvXgS8tY9SKg2mGiKuq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/t089i/DAfP1/cgHa8T8DPEgnmGLdkDXSO/GC5ZgMX2Mmt85Bop4Dr/Jml0gBrXhyswaXawNQ5NDGvD1EXACxUGiHVnAX3Ouz/wL83OVK0hT+e9hwnSfI8MRU+PMfiIeds2BVRjuB9uGYkTQkD7jpV7hJ+1TEp6hfzQOS3Z6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZg3VAbg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZg3VAbg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e5980471eso28747925e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760444836; x=1761049636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjHopu1UwDxsV5IdNPvI1jrj2EChfALYrLzFCq9lMBc=;
        b=NZg3VAbgYfyuhhHWEl8X/2XvmJHHHRVPSgPCcXTIHGLuCpv/nfLkznKXKjUHy7sYCp
         +zb9IY6o+xvxizK0KHyyvv88aXXbQXdlWwl51Dw3G9h3+zNvgmUyGPrwGcsb94x2tg0k
         eQh2DQHWYpagg7TdYtBHFF+71BCf3p4MWHusQbbaIOi+KoSGrCUgPsk71+GtV1VFF9At
         J5t30adq0S54wUrl1GPFekg9ABQqP0+7+lrkjseLMggs3oHcJuKIXGlaW+sZNx8r9dQq
         5s8L0vt/i/MWt2PToWydqgmcmtHw1RqNn/wB0mxgugCiQSNdlMRUN1Flpz8nBWv6nA/y
         icBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444836; x=1761049636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjHopu1UwDxsV5IdNPvI1jrj2EChfALYrLzFCq9lMBc=;
        b=FNUiJTrc4auOYli7SuzUs+xxDk2kGk+lDgoFVJjo396KwM/ZxTklIcLRzMLwzAsoa6
         j1qt6lPeWN2VmgOVzQ0aK0XRZodLZrKJ5jTWWRyB+3N+wTjRDzT9znhgeRU4kIlfJNP0
         z+Ji8ph4Au036HPHMEZU+8pVGjS1Wr8yWvA6uOXsMeTP7L+DBqQi9UroeM0dlHxc2NuN
         5zrK4rBajcmyTQyzpTaBID7J5+IcJ+V1HX7PpT1cMloOaqCUPPjf1LX9Vy1wSKoBfo7v
         iuFuIXzeA/H8KSCkOttH70oIFgZzEbbEPrF+cioX9T+tPxnW/gJltZlVcA21A1uHy4JV
         CNxA==
X-Forwarded-Encrypted: i=1; AJvYcCUufVFsD+97q+xKgwenarvmm/TJ2ptY6xLKOxVrPYXdbdgivlgHmZvvZ1yLWgSmlTtwt3pWuWZWZhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/rFwwrlMqHGcv+ogw9QYdgjWcKG9UhyT2axfZ/d23O9b4rLy
	1JKp2P2OZtk1Y+VnJJlTQEC02Nv5LWEi6T2fZg5rKsR+F/ON2wxJgrqZWVYqpwp5nbY=
X-Gm-Gg: ASbGncumIo5TU0LMtNt/vbzMkWnDVywsgwOctBin32ZUTzS5Nvs+4pCy9frmLj2H3mS
	Qc/zX4B9JKNa75hB5iakfTMb82ZaviN+KbRSrehFv3s5KGdovxED8A0oGSReJUWc1pVDsl5S8Gf
	9kLjD1jqgVC5+k1L9k1h0yaBB1u/MY6RMGmptrjRMsEZ5nbrT/JAnTX/SBIFxs3CQNd0HF5Htxb
	pxUrisC3yJfPPTcubsZ/QsiPyxP4BJ93QJYZSC5Wn38vp8bfIzN/SSHXICxvGwXnz6XVoorg5Ui
	31JdBG/H7iv25F+n6At2cswSD38PZyzx6G6Drk5IUzrwZOLcnsD8Pcq/oIeNPcaXC4Znjvfu7Y1
	+KbNegehgnhj/yKp6jZs13hGTbm5CTj7xH7sxLmZFzCka9p+2Wv8qXYFrUizfjw==
X-Google-Smtp-Source: AGHT+IGpLJmj5ZZeE5vtmTg4lu6fLIqoCQTKP25wq9imxhpp1Co0qw1M1pvst4NVF+ct3P1g5F4ilQ==
X-Received: by 2002:a05:600c:c116:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-46fa9b17e16mr141372525e9.33.1760444836001;
        Tue, 14 Oct 2025 05:27:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb4989601sm232872755e9.9.2025.10.14.05.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:27:15 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:27:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Khalid Aziz <khalid@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>, chenhuacai@kernel.org,
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	lkp@intel.com, skhan@linuxfoundation.org, ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <aO5BnwkNNyv_GOGS@stanley.mountain>
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
 <20251012183804.15171-1-rakuram.e96@gmail.com>
 <6j7ix5yof7qmrp6cgxhqver7yimvmgj7dujqu4l7cnzbpjksfd@5sp7am47gigw>
 <8afff048-4fe1-440a-9739-e5a5ea43d6eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afff048-4fe1-440a-9739-e5a5ea43d6eb@kernel.org>

On Mon, Oct 13, 2025 at 04:54:13PM -0600, Khalid Aziz wrote:
> > @@ -703,20 +705,15 @@ static int pxamci_probe(struct platform_device *pdev)
> >   	platform_set_drvdata(pdev, mmc);
> > -	host->dma_chan_rx = dma_request_chan(dev, "rx");
> > -	if (IS_ERR(host->dma_chan_rx)) {
> > -		host->dma_chan_rx = NULL;
> > +	host->dma_chan_rx = devm_dma_request_chan(dev, "rx");
> > +	if (IS_ERR(host->dma_chan_rx))
> >   		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
> >   				     "unable to request rx dma channel\n");
> > -	}
> > -	host->dma_chan_tx = dma_request_chan(dev, "tx");
> > -	if (IS_ERR(host->dma_chan_tx)) {
> > -		dev_err(dev, "unable to request tx dma channel\n");
> > -		ret = PTR_ERR(host->dma_chan_tx);
> > -		host->dma_chan_tx = NULL;
> > -		goto out;
> > -	}
> > +	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
> > +	if (IS_ERR(host->dma_chan_tx))
> > +		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
> > +				     "unable to request tx dma channel\n");
> 
> We should still release DMA rx channel before returning here.
> 
> >   	if (host->pdata) {
> >   		host->detect_delay_ms = host->pdata->detect_delay_ms;
> > @@ -724,25 +721,21 @@ static int pxamci_probe(struct platform_device *pdev)
> >   		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> >   		if (IS_ERR(host->power)) {
> >   			ret = PTR_ERR(host->power);
> > -			dev_err(dev, "Failed requesting gpio_power\n");
> > -			goto out;
> > +			return dev_err_probe(dev, ret, "Failed requesting gpio_power\n");
> 
> Don't we need to release DMA Rx and Tx channels before we return from here?
> 
> >   		}
> >   		/* FIXME: should we pass detection delay to debounce? */
> >   		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> > -		if (ret && ret != -ENOENT) {
> > -			dev_err(dev, "Failed requesting gpio_cd\n");
> > -			goto out;
> > -		}
> > +		if (ret && ret != -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");
> 
> Same here
> 
> >   		if (!host->pdata->gpio_card_ro_invert)
> >   			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> >   		ret = mmc_gpiod_request_ro(mmc, "wp", 0, 0);
> > -		if (ret && ret != -ENOENT) {
> > -			dev_err(dev, "Failed requesting gpio_ro\n");
> > -			goto out;
> > -		}
> > +		if (ret && ret != -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed requesting gpio_ro\n");
> 
> and here.
> 
> Looking at Documentation/driver-api/driver-model/devres.rst,
> dma_request_chan() is not devres managed interface and thus will not be
> released automatically. Do you agree?
> 

The patch changes dma_request_chan() to devm_dma_request_chan().

regards,
dan carpenter

