Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A5524F
	for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919712; cv=none; b=QhLtI0xm8R0rPTcnqT1LJvpv2oCXsKAZUAGYyFvfDdAgyEDYe+rnpSIkXzTC1Hrn9pJ0UtakDLw635mGF0DspKsj5nLry/AvC+IZambBz+1lFnYAbCvggluXytFczFxrph4brv4JjcKH3xwppOUy8K67yCuveI5xhVDAXSOhBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919712; c=relaxed/simple;
	bh=IIUGO/dEbzBpZ78hDxZU7VRxbR2Zz8U9O9qbR0A0xAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MVvPc1YeVvDAL0mtNB9syJkiWwkfhvLNzMyI4q9F5/8sTuC1prYeolcsPajnhAM2hinaBL1aMvtGxDOUqinRyLQnrtsuv0+wxG2PsQlf/GYgskJ1yu9Rb7SXhjyOMn7lSvvdrt6aGwmckksJ0hv8YihzC4BgGiYmDgZiTD1Qnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b53Eb5oY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b53Eb5oY"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso3639199e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757919709; x=1758524509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqtUFtQXqrY0eT8Jyx/HTyjcTDqiPb75irXtglfsEWg=;
        b=b53Eb5oYpuBSsOx2ParcturEh72/nb3ofTLo/DK42iVJLmgHX1sDFdq5u9YN2aALKk
         ag2EyRDeZ45viEIBTLiBfdXsieaT1LviW2aM4cvsbcY8C0LL1dsdy2whg8ImEqAA+pGX
         KURGaQKWjf39Z0qfoiZvBKOxdMkLfOedoPa3iKgpQ0Bq+I0hx1pyqdme/fn9/TIP4lf0
         tA5u2xfY8MH+JRI/uz7WsWp0DjhmlM6ThRkC8CegY+x5qdxSyWhqEnWVW6bSSXsK2ueP
         HElmdsRVkdPWT6NpX6bcHm1vmuzXTaMuzmauG72wSTfHHqlkn4BtQbP6bfYJRKPmI8SV
         BTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919709; x=1758524509;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqtUFtQXqrY0eT8Jyx/HTyjcTDqiPb75irXtglfsEWg=;
        b=ver1bZnKIQnz1hDfIuHcr9Hg0kGxF3oiG8phv7ScTROwL79v2sa0N03QhvDYERmZPy
         wGqdFOSUq67hwXP2OtfN69eyNqYVKyk6nB7ujvO3m+mPZ8/7zClaPDsRY/7x5oiYi/It
         gVLZN6JgOwn7gWSUrXxgDGROJ0/iWnkstgO4mndPEXm2oyXupAb529CD6xO//H3bWxsr
         C2DW7dxJZf/Dl8urrs3HdECZko0++VOfPW2cPbu/RKKalfXLf0vjiPiLG9wbIQDyMJAa
         bWLDWVMXlWQN83UHyETw5CQQW6XkgRN9sId4U2lL5FTn6HLR/VgeJnVFGUv01umgumJf
         acmQ==
X-Gm-Message-State: AOJu0YzW6TKEyw4Tvvs5W4VgycD48eMkzYpK6IexNTB+rYosTGjtL42c
	F+Cz6mSIxQEriUZzwVGB78/ajHw8XVWKEwUhWBbQrHsbCpijc/zVUI2X4KBRDADDS28=
X-Gm-Gg: ASbGncuQ/Ty1KNYmKO+TaD7nwLKWkIPlsPSHFY6sCiKmlkmyBPP+mV5GyjA39kvGDbR
	CBXcvJrOzNgjxkezY31BTSj8uAx5mjr1YklPhrq/k1eGYT9zpmb+xG0xXaZrndRAA16EtlJKi1U
	O+9Ue8l8Qhi+6g6Pxzd2bfdtO+D+olMGXPXOUPE42zO4AGp9aBZpNSrewFAAJSJu7LZJobII3qc
	l0mOaSh17m/pzOao4xLdNkZhbI/cJtMbJzPTw4LKjUHumg+s+fgeMc3RHPnJ5w2PugKQWstQEEd
	Bki6ylmKLiYCPV0wTuvJWtmsugeZ2iubzq4uqZ4Rv2EA7JBaSUNEHOgA3Lsuj/gLjt+pUMhunjh
	OIUcT2l50ISHWbaRbOo2kqrCoZ3LnZf3pqVO9Gk2WVBaTVDeV5ZI6cvI=
X-Google-Smtp-Source: AGHT+IFBdmNQEzyswHDpGv1SoR2koTptT4AXtjV5Z/8TKUtFo7V4yBDALIrdg96iQz/TMcSidgZeMw==
X-Received: by 2002:a05:6512:79a:b0:55f:3f25:f036 with SMTP id 2adb3069b0e04-5704fb86967mr3095602e87.34.1757919708816;
        Mon, 15 Sep 2025 00:01:48 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5cf300b7sm3394559e87.45.2025.09.15.00.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:01:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:01:46 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yixun Lan <dlan@gentoo.org>, zhoubb.aaron@gmail.com
Subject: Re: [PATCH v3 3/4] mmc: remove COMPILE_TEST from MMC_LOONGSON2
Message-ID: <aMe52k8wtQBU-eyN@nuoska>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f09322b-6bc5-437b-88b5-dec306748d80@loongson.cn>
 <413a49f5-91f3-4334-9128-29297293f953@app.fastmail.com>

Hi,

On Fri, Sep 12, 2025 at 04:50:38PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 12, 2025, at 16:22, Mikko Rapeli wrote:
> > It fails to link due to undeclared dependency
> > to regmap which is not enabled for COMPILE_TEST:
> >
> > ERROR: modpost: "__devm_regmap_init_mmio_clk"
> > [drivers/mmc/host/loongson2-mmc.ko] undefined!
> 
> Nice catch! I assume my normal randconfig builds never
> run into this because there is always something selecting
> REGMAP_MMIO.
> 
> >  config MMC_LOONGSON2
> >  	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> > -	depends on LOONGARCH || COMPILE_TEST
> > +	depends on LOONGARCH
> >  	depends on HAS_DMA
> 
> I would instead add 'select REGMAP_MMIO' here, which is what
> we do for other drivers using this.

On Sat, Sep 13, 2025 at 12:58:00PM +0800, Binbin Zhou wrote:
<snip>
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1113,7 +1113,7 @@ config MMC_OWL
> >   config MMC_LOONGSON2
> >   	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> > -	depends on LOONGARCH || COMPILE_TEST
> > +	depends on LOONGARCH
> 
> How about add `select REGMAP_MMIO` instead.

Sorry, my bad. I just checked drivers/base/regmap/Kconfig for COMPILE_TEST
and since it was not found thought that it's not supported with
COMPILE_TEST.

I will add the REGMAP_MMIO dependency instead in v4.

Cheers,

-Mikko
