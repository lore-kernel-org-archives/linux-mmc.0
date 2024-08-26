Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6255192D72;
	Mon, 26 Aug 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687189; cv=pass; b=uk2TWap3q7S7uZ0e2aSY1gBKahLbKEhgJxNxB83P1BZlQqLNQ22UBWFAKAPWKNhakRM2nHoGhYv1Ak+PFFQq2uE5GdjmxUzd2KFBSrQtoPdaqmy1vJJ1ygAgcAsYvZSRlf4qbnjWcnKelLi05ayWlrZ0JvH7YiOfUPLwUQeRxU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687189; c=relaxed/simple;
	bh=Do/+VwEJy4aWUGWjEXhuMvlmv5HouVa8Jk5LAZfggUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8SIIL6l9XcIsRIX01ZadzElhNB8aHVyOvnf1TcT/43mMjxryLJtkk82Fm/VyM5QnyEpaHMLkeMnWqQqz6WZwxPauxBYpW1uIFmOZunKwDPs4iZNAoXnAqUB7wkvb55TqsbyM5vRBiGfzZODfbEbQRjbSLM8rKgCnoyas7X1JsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=LqkQDUsf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="LqkQDUsf"
ARC-Seal: i=1; a=rsa-sha256; t=1724687153; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NSgXOg6pf4JTqCqBfaJlETE1ElqADA9SVLQWBaTLNnLv8aaUYzY2wN3OZmLIQDFpOk8gkdZN7hhG2j0/vKC7QChgmuu7O2vgQ4JnhQe5+JcioXS/0GvGuHa5izNnNOEcUUXuOHmh58Whvkrve4BvvExUbLG+Dmi6vC0W91B8bAo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724687153; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zb074lKrTAv50HX1CILzyo6P0szhW30i/SFCvBy70Lk=; 
	b=a+PNdjk2Ikz8JSGRfSPu9uRgnrY4Z6SXSoMtp1CmhnfWCvZiv5Zl/xLkVZplKNx6tDMpsmnMncbAfoWbwwi3gbfvcyuxmcw+IMA435ShP6VNtP8f/ZfJ8cP2I/fN4gPjrU3F3VZGXzouX5biSAWFdfQWC43gGGH/fzlAgKMjDzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724687153;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=zb074lKrTAv50HX1CILzyo6P0szhW30i/SFCvBy70Lk=;
	b=LqkQDUsf/LZqRncbELqVpYqBjZmUZkn4+1sPZ7OmW5TWlkzZw52pQyEAJAh47NOe
	7eguSKUZhr8IB1Pg+Y3Gb1+4h6ecDm1ONzIj29ScB78qRhlY1qsUt1xBA2a6vaUIJNz
	gkFaCSLvnyrusBKjAU1Ilrkivai6hO6uHRgWw3j0=
Received: by mx.zohomail.com with SMTPS id 1724687151652297.5430112358182;
	Mon, 26 Aug 2024 08:45:51 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 4/4] mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
Date: Mon, 26 Aug 2024 11:45:49 -0400
Message-ID: <2196769.irdbgypaU6@bootstrap>
In-Reply-To: <dc77f6dbdfc68369d02005763143cdea@manjaro.org>
References:
 <20240822212418.982927-1-detlev.casanova@collabora.com>
 <5808226.DvuYhMxLoT@trenzalore>
 <dc77f6dbdfc68369d02005763143cdea@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Dragan,

On Monday, 26 August 2024 10:07:49 EDT Dragan Simic wrote:
> Hello Detlev,
> 
> On 2024-08-23 15:20, Detlev Casanova wrote:
> > On Friday, 23 August 2024 03:00:57 EDT Dragan Simic wrote:
> >> Hello Detlev,
> >> 
> >> Please see a comment below.
> >> 
> >> On 2024-08-22 23:15, Detlev Casanova wrote:
> >> > On rk3576 the tunable clocks are inside the controller itself, removing
> >> > the need for the "ciu-drive" and "ciu-sample" clocks.
> >> > 
> >> > That makes it a new type of controller that has its own dt_parse
> >> > function.
> >> > 
> >> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >> > ---
> >> > 
> >> >  drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++++----
> >> >  1 file changed, 43 insertions(+), 5 deletions(-)
> >> > 
> >> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> >> > b/drivers/mmc/host/dw_mmc-rockchip.c
> >> > index 1458cb5fd5c7..7c8ccf5e71bc 100644
> >> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> >> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > 
> > [...]
> > 
> >> > @@ -435,13 +451,25 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci
> >> > *host)
> >> > 
> >> >  	if (IS_ERR(priv->sample_clk))
> >> >  	
> >> >  		dev_dbg(host->dev, "ciu-sample not available\n");
> >> > 
> >> > -	host->priv = priv;
> >> > -
> >> > 
> >> >  	priv->internal_phase = false;
> >> >  	
> >> >  	return 0;
> >> >  
> >> >  }
> >> > 
> >> > +static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
> >> > +{
> >> > +	struct dw_mci_rockchip_priv_data *priv;
> >> > +	int err = dw_mci_common_parse_dt(host);
> >> > +	if (err)
> >> > +		return err;
> >> > +
> >> > +	priv = host->priv;
> >> > +
> >> > +	priv->internal_phase = true;
> >> 
> >> Defining priv, assigning it and using it seems rather redundant,
> >> when all that's needed is simple "host->priv->internal_phase = true"
> >> assignment instead.
> > 
> > Yes, that's what I did at first, but host->priv is declared as void*,
> > which
> > means it needs to be cast to struct dw_mci_rockchip_priv_data * and I
> > felt
> > that
> > 
> > ((struct dw_mci_rockchip_priv_data *)host->priv)->internal_phase =
> > true;
> > 
> > is not very pretty and harder to read.
> 
> Ah, you're right, and I somehow managed to ignore that.
> 
> I agree with your conclusions, although I'd suggest something like
> this, for slightly improved readability:
> 
>   +static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
>   +{
>   +	struct dw_mci_rockchip_priv_data *priv = host->priv;
>   +	int err;
>   +
>   +	err = dw_mci_common_parse_dt(host);
>   +	if (err)
>   +		return err;
>   +
>   +	priv->internal_phase = true;
>   +
>   +	return 0;
>   +}

That won't work either, because host->priv is initialized in 
dw_mci_common_parse_dt.



