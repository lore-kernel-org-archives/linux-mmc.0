Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DE1885AB;
	Mon, 26 Aug 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683951; cv=none; b=sKwpnGP/r13RHYGabrkBzxOXVTkIpHSOQJeicvyPi4XOtxBlNpey6AO5x1Y/Qzr2l9JIYSUR3yZe8hs9/DEuglbjrfkRcs/S5wVwf8+FTxvLj5Gk2XjgiOcJhxNlmeTZNEHaZrQBIE3pTghrJanoWeOWrR0wi4Veqi9JPp2f+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683951; c=relaxed/simple;
	bh=/9EeEP59BswQPSml+vUqcK0oINO/fcMcdI7TpggEe9I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rC9YbJEZ6PxUPb6Iwxse8VK13jVgcFNRB5P6GuI2DRPQ+wKBjPavTsr1fM2/Kb9s+KZvs/Wnu5CoMdXj8jom8jE+JKqPnkdNw7JYJ3ZZXiFQkGwB3bEb5rlj8nd6l2G/MnIsbliOHgEvp2UMmgOkjRaab5gXbiueA86DFqy7Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KRxz8lzt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KRxz8lzt"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724683947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsLtJ21GMVO6oT89oMRfFsmwIaUm0tSl7H1ZIrPPfoM=;
	b=KRxz8lztdXHXbtlweF6zWPEUz3/LYc5LCCYGpTLWet9hzCUGjVOSHLYu4qybICQEuaY9sB
	LUbubrSZmp8tX6JmvyVNLgq7T6VgCznLzlGLjgSRRVrwTLtP7LepB5icYthDXO/OgMo8NY
	ym9WDi8UAiNyYV39jrkE1vP+gLhH6KL9I9+LVFO01XT1zV8IUC3dG3Kyk4I+fLHAKRTVH/
	AaqXcbVlmRZ+fAvSumcRJPJRuhZPSYuNqg+KPqbeU6XXgAMQo4gEQntJkF29tj/eKdYiKm
	4J3U02Hx8av6IURlPGOEylBjk3yjWNpJEJSqiD9YVZGNC9efCtWJP9HSCsFtFA==
Date: Mon, 26 Aug 2024 16:52:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com, Shawn Lin
 <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 3/4] mmc: dw_mmc-rockchip: Skip all phases bigger than
 270 degrees
In-Reply-To: <1894989.tdWV9SEqCh@trenzalore>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-4-detlev.casanova@collabora.com>
 <711f2561ac3d84bcd5bbe26723869b47@manjaro.org>
 <1894989.tdWV9SEqCh@trenzalore>
Message-ID: <38952ff6affa5929612aaabbae3ca996@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

On 2024-08-23 15:59, Detlev Casanova wrote:
> On Friday, 23 August 2024 01:45:07 EDT Dragan Simic wrote:
>> Hello Detlev,
>> 
>> On 2024-08-22 23:15, Detlev Casanova wrote:
>> > From: Shawn Lin <shawn.lin@rock-chips.com>
>> >
>> > Per design recommendation, it'd better not try to use any phase
>> > which is bigger than 270. Let's officially follow this.
>> 
>> Would it be possible to provide a reference to the actual design
>> specification?  This change affects all users of the dw_mmc-rockchip
>> driver, so in case any regressions are found later, having as much
>> detail as possible can only be beneficial.
> 
> I don't have the reference and only trusting rockchip on this. This 
> could be
> specific to rockchip hardware.
> Anyway, the drivers works well on my side on my rk3576 armsom sige5 
> without
> this patch, so I'm willing to drop it completely.

I think it would be better if you'd drop it in this series, and submit
it later separately, as a follow-up patch, to reduce the chances for any
possible regressions.  Maybe we'll also have more background information
available by then, who knows.

>> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> > (cherry picked from commit 2a53aab5cfa43065b2e979959d727332a8a03c03)
>> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>> > ---
>> >
>> >  drivers/mmc/host/dw_mmc-rockchip.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>> > b/drivers/mmc/host/dw_mmc-rockchip.c
>> > index 2748f9bf2691..1458cb5fd5c7 100644
>> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> > @@ -310,6 +310,9 @@ static int dw_mci_rk3288_execute_tuning(struct
>> > dw_mci_slot *slot, u32 opcode)
>> >
>> >  	/* Try each phase and extract good ranges */
>> >  	for (i = 0; i < priv->num_phases; ) {
>> >
>> > +		/* Cannot guarantee any phases larger than 270 would
> work well */
>> > +		if (TUNING_ITERATION_TO_PHASE(i, priv->num_phases) >
> 270)
>> > +			break;
>> >
>> >  		rockchip_mmc_set_phase(host, true,
>> >
>> >  				       TUNING_ITERATION_TO_PHASE(
>> >
>> >  						i,
