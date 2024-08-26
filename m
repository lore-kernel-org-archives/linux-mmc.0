Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012A153BF0;
	Mon, 26 Aug 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683203; cv=none; b=mTMIutlJ6MdUPPw2MOTlcEWhgj4yApPy6j+IALPkLuF4UNnhljJN+D+RVoNkGKjz/X1PCqwPpFMI+bdjAO5g+bkCcROFFQb/tpX5GdA1GCUuyb2UiDMBg7b1eJrYg3LpG0DFproB+wNZZVBYKmdCmvBZ0so/SSzTycbuFZTt4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683203; c=relaxed/simple;
	bh=6QqRtusFTtN8x9zQ3WPokWT+mxvMX0sl4jYRvDAY/Qg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mHJ69CwbQGJ+YaPciG4/r9g9RA74iEDqVejUxdpjKBVnt9UVhVPRqApD27QAPx9EmX+VhhH+UGTvPyG3DsnwPIiTcio07AGXiGqyrsKGVoP+F2fhBVbkl2FCyEk6riItnEoQpJL6VgU2MaRjszu1yaszGb90WFw3m8EPLvzsoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lW9zvN9G; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lW9zvN9G"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724683199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmMRUhyOgg88OhrzC6Uhvrv9RgV9YppTUbN6J/fxSrc=;
	b=lW9zvN9Gf5Kx5jIRwfiuIyIZJxbIvSNPLpqbGUUmM9llR7hDYXRTnbaZmrR+Hpmt3a1cLH
	43/XXmujj6DXlZ0yUjC+W+p0VNKd+HmTx1MhnkWNYZ0WHJMApCg2lE1TPABCOsOoJV8pCY
	9GL5U0H9Bm0RqTlpP/xm1Nt6IcTcIEscrR032NJcGKnPm2VqpMQt/CWbVOOOjwtfs3ilL7
	mUj8OmUQnjC8bHNQwaWJ5NrMvmSWoRLZEYotqR4OwPl0XKZaCNYBGndN0wDeqf6O3/TIC7
	snv5iTwABUY+ek2R1y2V5pzUE2MZ9urN28xTZkh8NmOlF+DFX4rTijdOBGxCNg==
Date: Mon, 26 Aug 2024 16:39:58 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com, Shawn Lin
 <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 2/4] mmc: dw_mmc-rockchip: Add internal phase support
In-Reply-To: <4943132.31r3eYUQgx@trenzalore>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-3-detlev.casanova@collabora.com>
 <f0f5dec4a5403616fa25c6ed754f6050@manjaro.org>
 <4943132.31r3eYUQgx@trenzalore>
Message-ID: <b57017bca1a4a5fe558556142a9cec3d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

On 2024-08-23 15:34, Detlev Casanova wrote:
> On Friday, 23 August 2024 01:41:44 EDT Dragan Simic wrote:
>> Hello Detlev,
>> 
>> Please see a comment below.
>> 
>> On 2024-08-22 23:15, Detlev Casanova wrote:
>> > From: Shawn Lin <shawn.lin@rock-chips.com>
>> >
>> > Some Rockchip devices put the phase settings into the dw_mmc
>> > controller.
>> >
>> > When the feature is present, the ciu-drive and ciu-sample clocks are
>> > not used and the phase configuration is done directly through the mmc
>> > controller.
>> >
>> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>> > Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
>> > ---
>> >
>> >  drivers/mmc/host/dw_mmc-rockchip.c | 171 +++++++++++++++++++++++++++--
>> >  1 file changed, 160 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>> > b/drivers/mmc/host/dw_mmc-rockchip.c
>> > index b07190ba4b7a..2748f9bf2691 100644
>> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> > @@ -15,7 +15,17 @@
>> >
>> >  #include "dw_mmc.h"
>> >  #include "dw_mmc-pltfm.h"
>> >
>> > -#define RK3288_CLKGEN_DIV	2
>> > +#define RK3288_CLKGEN_DIV		2
>> > +#define SDMMC_TIMING_CON0		0x130
>> > +#define SDMMC_TIMING_CON1		0x134
>> > +#define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
>> > +#define ROCKCHIP_MMC_DEGREE_MASK	0x3
>> > +#define ROCKCHIP_MMC_DEGREE_OFFSET	1
>> > +#define ROCKCHIP_MMC_DELAYNUM_OFFSET	2
>> > +#define ROCKCHIP_MMC_DELAYNUM_MASK	(0xff <<
>> > ROCKCHIP_MMC_DELAYNUM_OFFSET)
>> > +#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC	60
>> > +#define HIWORD_UPDATE(val, mask, shift) \
>> > +		((val) << (shift) | (mask) << ((shift) + 16))
>> >
>> >  static const unsigned int freqs[] = { 100000, 200000, 300000, 400000
>> >
>> > };
>> >
>> > @@ -24,8 +34,143 @@ struct dw_mci_rockchip_priv_data {
>> >
>> >  	struct clk		*sample_clk;
>> >  	int			default_sample_phase;
>> >  	int			num_phases;
>> >
>> > +	int			internal_phase;
>> >
>> >  };
>> 
>> It might be good to declare internal_phase as "unsigned int
>> internal_phase:1",
>> i.e. as a bit field, which isn't going to save some memory in this
>> particular
>> case, but it would show additional attention to detail.
> 
> In that case, I would go with a bool instead of int, that makes things
> even clearer.

My suggestion to use "unsigned int internal_phase:1" actually takes
inspiration from the ASoC code, in which such bit fields are used
quite a lot, even when using them actually doesn't save space.

In this particular case, using plain bool would make sense, but I
still think that using an "unsigned int internal_phase:1" bit field
would fit better, because it would show the intention to possibly
save a bit of RAM at some point.  OTOH, I don't think that using
bool with such bit fields would actually work cleanly, because bool
actually resolves to int that's a signed type.
