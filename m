Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9C17E01E;
	Mon, 26 Aug 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681276; cv=none; b=rjFYTFa+gqQ1Ff/m+Bp+IJFEX4BZtAEYeNTiCFpAdH6+2OwiqtPIZTEw/fU0AzXD/AGYc7qsxzCQj+Pq3x5XwTqIaPI/z1gjPqmMqabYDBzvyuTtPDZILGcHQw6Ae7C8QBtBe6cAtlnBt9bh93c/3XldyT2VYWg1QHRJX/0rHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681276; c=relaxed/simple;
	bh=xOgBRZPXDCPk/4kGTj33xlReBqvcCW/HiawLg1Vxuww=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hqkBxlaqWaIZyosnz9jQUE4joQRnYk2ztQ+WmVV6JttzaQzosm2lBXNvv62D7KEhbG4N/LUu2vVghJLEh8m1oby2Ad1NiZFLREBH59rMWeKL0EOknICio9e76QzI/xT/vHFxgAV+xHMo2CjtGQjVBm6UbxYS+3jDCq19YiJceCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Lv3hQkmY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Lv3hQkmY"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724681270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7u0W5LEnkH2sOZAmNO6zvSkVtZ3dx2voJoTAm3CKcA=;
	b=Lv3hQkmYGvuYXN9u4Feb//n8y/X8fQ8+7IjGikFSRN2GITBI4A51wFxRxvusbItAi1ANzR
	hcQtZDPR48ipibhiEKTtqBmOFIT7yzCeE8LBBfUCJjH6TplQ7fXJx+KiWFO2j+9oK0PckK
	hbEBoCMEB5AuPTOgswitAkUy2mp4my4abNHxWSPG5dQcbrAizx01SgcTuMBYnESx2ZmwvA
	Mb6tIfySWTjzhdQBDc3aIho8JflI1rp/8dxcWhrBzDqAnPczZDmJiIq+SBOgAym7l3ZO0Q
	W4W+bHqzV73jVcTutQDJyTrXAs+UdN77LwevsssYvieOZkW0Tlb3O1uQcZ9CFA==
Date: Mon, 26 Aug 2024 16:07:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 4/4] mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
In-Reply-To: <5808226.DvuYhMxLoT@trenzalore>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-5-detlev.casanova@collabora.com>
 <26fe259f390a8015c3f08c6dc027711c@manjaro.org>
 <5808226.DvuYhMxLoT@trenzalore>
Message-ID: <dc77f6dbdfc68369d02005763143cdea@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

On 2024-08-23 15:20, Detlev Casanova wrote:
> On Friday, 23 August 2024 03:00:57 EDT Dragan Simic wrote:
>> Hello Detlev,
>> 
>> Please see a comment below.
>> 
>> On 2024-08-22 23:15, Detlev Casanova wrote:
>> > On rk3576 the tunable clocks are inside the controller itself, removing
>> > the need for the "ciu-drive" and "ciu-sample" clocks.
>> >
>> > That makes it a new type of controller that has its own dt_parse
>> > function.
>> >
>> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>> > ---
>> >
>> >  drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++++----
>> >  1 file changed, 43 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>> > b/drivers/mmc/host/dw_mmc-rockchip.c
>> > index 1458cb5fd5c7..7c8ccf5e71bc 100644
>> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> [...]
>> > @@ -435,13 +451,25 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci
>> > *host)
>> >
>> >  	if (IS_ERR(priv->sample_clk))
>> >
>> >  		dev_dbg(host->dev, "ciu-sample not available\n");
>> >
>> > -	host->priv = priv;
>> > -
>> >
>> >  	priv->internal_phase = false;
>> >
>> >  	return 0;
>> >
>> >  }
>> >
>> > +static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
>> > +{
>> > +	struct dw_mci_rockchip_priv_data *priv;
>> > +	int err = dw_mci_common_parse_dt(host);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	priv = host->priv;
>> > +
>> > +	priv->internal_phase = true;
>> 
>> Defining priv, assigning it and using it seems rather redundant,
>> when all that's needed is simple "host->priv->internal_phase = true"
>> assignment instead.
> 
> Yes, that's what I did at first, but host->priv is declared as void*, 
> which
> means it needs to be cast to struct dw_mci_rockchip_priv_data * and I 
> felt
> that
> 
> ((struct dw_mci_rockchip_priv_data *)host->priv)->internal_phase = 
> true;
> 
> is not very pretty and harder to read.

Ah, you're right, and I somehow managed to ignore that.

I agree with your conclusions, although I'd suggest something like
this, for slightly improved readability:

  +static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
  +{
  +	struct dw_mci_rockchip_priv_data *priv = host->priv;
  +	int err;
  +
  +	err = dw_mci_common_parse_dt(host);
  +	if (err)
  +		return err;
  +
  +	priv->internal_phase = true;
  +
  +	return 0;
  +}
