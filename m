Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076F18562A;
	Fri, 23 Aug 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419183; cv=pass; b=ciD03yCrPDZXJ2867FuT6VA4fSlSpB6U+8b9rPc+M9hHbhEo8Xgn2DQ86rjD364wiNqj6lQqR5lcnu/qzlfxMSf+TCteIBFjbQ6LI63o27fKniHjfnHnzZc6vNSDffeefBTWo+upLoDe4p38da+vT6VbLiYptuhF4A/q9q8E62Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419183; c=relaxed/simple;
	bh=Vy6+x51p1S7kTEcTlXe6/7SsOO5i45PUg87sjGHGunE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxzXw8BETrX4dzg40BhgaYc86XusL3oH56fFviw3q70n8nv3rr7LY+EuHsu1vnT82N0jwGbsiqvptzM2foKqgy9FfgyRWF5VONbr9Phsf6ERmxP1pQUcJYmg1q86fixvaNuZFXZGrBKh+gKk5bK1cnKdkMmE8aBqFvMVl9IYraU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=g0HtSX6i; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="g0HtSX6i"
ARC-Seal: i=1; a=rsa-sha256; t=1724419152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CP6mR9nhLYaIveKpyLaeZ46q9sUT63lbSfiMIuaWfs7yx9M+FNNim+JoIotArBcgoed75YdHxptkraEtr19QO/CcqQArxJfW93c3amEoan5N/e/2pu1AsDKlPd6KKbMPLyvqkRzPPQPHjj5LMHrCtzV0dWyrkprbdJF5aUalctw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724419152; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hZhy927uMS7MJX4gbRwhbG85sBlv12sTezrKNZF+Sjo=; 
	b=a6JpAMOErhsOFMfZlM+H4x08BtZKGRkFsCGjhOiu3744h0qPwB4XIgU7hEEFkPdWm20KoJwNqK5sS4/v6xrzvuwa5weoFH5ICsohdVfuQvdoqMzod0YuzHhfSfEvHUXxnkI8mr/63f6w8AS2WL8TRBdTU5IWrf9EKSHXKkzLAIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724419152;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=hZhy927uMS7MJX4gbRwhbG85sBlv12sTezrKNZF+Sjo=;
	b=g0HtSX6iROSiuef6fVy/H2/AVyaw27pgU7AiuzuYnBVDsvfDHPdrlums9H7gC0tQ
	PjS2YqPH00fG1/6Dha5knVdpJy9nUnISGH3CSCb3gE1LioE1z+x0hzBizXynA7a2Nwm
	SnjueHAAxM5G9HSRGeXZj03yVaWJKXNV4GFcKe8M=
Received: by mx.zohomail.com with SMTPS id 1724419149648671.8521035840524;
	Fri, 23 Aug 2024 06:19:09 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 4/4] mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
Date: Fri, 23 Aug 2024 09:20:50 -0400
Message-ID: <5808226.DvuYhMxLoT@trenzalore>
In-Reply-To: <26fe259f390a8015c3f08c6dc027711c@manjaro.org>
References:
 <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-5-detlev.casanova@collabora.com>
 <26fe259f390a8015c3f08c6dc027711c@manjaro.org>
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

On Friday, 23 August 2024 03:00:57 EDT Dragan Simic wrote:
> Hello Detlev,
> 
> Please see a comment below.
> 
> On 2024-08-22 23:15, Detlev Casanova wrote:
> > On rk3576 the tunable clocks are inside the controller itself, removing
> > the need for the "ciu-drive" and "ciu-sample" clocks.
> > 
> > That makes it a new type of controller that has its own dt_parse
> > function.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++++----
> >  1 file changed, 43 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> > b/drivers/mmc/host/dw_mmc-rockchip.c
> > index 1458cb5fd5c7..7c8ccf5e71bc 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
[...]
> > @@ -435,13 +451,25 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci
> > *host)
> > 
> >  	if (IS_ERR(priv->sample_clk))
> >  	
> >  		dev_dbg(host->dev, "ciu-sample not available\n");
> > 
> > -	host->priv = priv;
> > -
> > 
> >  	priv->internal_phase = false;
> >  	
> >  	return 0;
> >  
> >  }
> > 
> > +static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
> > +{
> > +	struct dw_mci_rockchip_priv_data *priv;
> > +	int err = dw_mci_common_parse_dt(host);
> > +	if (err)
> > +		return err;
> > +
> > +	priv = host->priv;
> > +
> > +	priv->internal_phase = true;
> 
> Defining priv, assigning it and using it seems rather redundant,
> when all that's needed is simple "host->priv->internal_phase = true"
> assignment instead.

Yes, that's what I did at first, but host->priv is declared as void*, which 
means it needs to be cast to struct dw_mci_rockchip_priv_data * and I felt 
that 

((struct dw_mci_rockchip_priv_data *)host->priv)->internal_phase = true;

is not very pretty and harder to read.

> > +
> > +	return 0;
> > +}
> > +
> > 
> >  static int dw_mci_rockchip_init(struct dw_mci *host)
> >  {
> >  
> >  	int ret, i;
> > 
> > @@ -483,11 +511,21 @@ static const struct dw_mci_drv_data
> > rk3288_drv_data = {
> > 
> >  	.init			= dw_mci_rockchip_init,
> >  
> >  };
> > 
> > +static const struct dw_mci_drv_data rk3576_drv_data = {
> > +	.common_caps		= MMC_CAP_CMD23,
> > +	.set_ios		= dw_mci_rk3288_set_ios,
> > +	.execute_tuning		= dw_mci_rk3288_execute_tuning,
> > +	.parse_dt		= dw_mci_rk3576_parse_dt,
> > +	.init			= dw_mci_rockchip_init,
> > +};
> > +
> > 
> >  static const struct of_device_id dw_mci_rockchip_match[] = {
> >  
> >  	{ .compatible = "rockchip,rk2928-dw-mshc",
> >  	
> >  		.data = &rk2928_drv_data },
> >  	
> >  	{ .compatible = "rockchip,rk3288-dw-mshc",
> >  	
> >  		.data = &rk3288_drv_data },
> > 
> > +	{ .compatible = "rockchip,rk3576-dw-mshc",
> > +		.data = &rk3576_drv_data },
> > 
> >  	{},
> >  
> >  };
> >  MODULE_DEVICE_TABLE(of, dw_mci_rockchip_match);




