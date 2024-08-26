Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609327F7FC;
	Mon, 26 Aug 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697915; cv=pass; b=MvwlzpyzxAXDFFjy1C43kKkuBGf+TjZ9BKOe46oCL1Y3S+muse0afAOFNBBrPJRuIOODsTQeRttdlfCd/FHzXAmrrYzPa0ZCLXO26TqQVTPFeDFSs1eCLZFWkIONnmdpi11x+/zxvuWsxOSgEIIf2XwAYG+01weB58t39ezBUrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697915; c=relaxed/simple;
	bh=iwXcvEdMp95hUF7bQpTZJXgamO6d4IeH0JOuuyaviW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBHZXIcwy1tqTFoeOgRWCM+pBrVnWJVt82YQF8CrmJGTK17Q/CWWuU4bfm1qNefYRzxQAEllpbxcpkW5ifEjmE8lyOImIRfWxhQphdZvveYSVsm19HbXnwF2d/Kc+VpqN4nYkXSeazAnthjQyq4/uLHk6XQXeBBXldbKfkwTKNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=QOFT4k+Z; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="QOFT4k+Z"
ARC-Seal: i=1; a=rsa-sha256; t=1724697879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bgQwwXn15Aoufd+BzwNeginJ3mhUEPOciGcomXfAvREr2GMq/xAv7D1LEyhS8YFautIqkFkJZ1KeT7tdIVDwkmktmut5MwAlHlsx+GXw9WV145sVCs+CjXzqDb0OfPeYppW5lts6l6usoLa5uGhrqxZ7cSmEDbSAbwpPJP2nfwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724697879; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mlnYUtGPIbd9GPhhmlk+YwVhJr5+Jj0FaWL8g6QYGw8=; 
	b=L5emk3qgbcXwjbvIy5cjN2Lw/xK8eQqkVSiyLGtGcz16XGNGwyRWF5A71fdxVZ/pMOGr3VAi1c5YKYqjuaIG3ajwLbDRv1i+c49dWs9S/6xttUCs+FhePz3q31ADQvx/T39x4g3RAoval1VybBY30tf98wjCMoWTUQ/omBzgdS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724697879;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=mlnYUtGPIbd9GPhhmlk+YwVhJr5+Jj0FaWL8g6QYGw8=;
	b=QOFT4k+ZE6zA8KdK0rDSS8lu2HnhpP6tbxo+AU3GzG+c/C1fvz5juyyXxAe1YDke
	Wspd5eYM/u3H437m7kRjNe+hSNqw9mhf+USIVhtTLhiDjn6lt5WVYltwxi99PMwTuvD
	Dq2GGn04YSJK2wOHMvtqkM0E4bEtFdsnQaG9Iy18=
Received: by mx.zohomail.com with SMTPS id 1724697878497938.876702576403;
	Mon, 26 Aug 2024 11:44:38 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 2/4] mmc: dw_mmc-rockchip: Add internal phase support
Date: Mon, 26 Aug 2024 14:44:36 -0400
Message-ID: <1999169.usQuhbGJ8B@bootstrap>
In-Reply-To: <b57017bca1a4a5fe558556142a9cec3d@manjaro.org>
References:
 <20240822212418.982927-1-detlev.casanova@collabora.com>
 <4943132.31r3eYUQgx@trenzalore>
 <b57017bca1a4a5fe558556142a9cec3d@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Monday, 26 August 2024 10:39:58 EDT Dragan Simic wrote:
> Hello Detlev,
> 
> On 2024-08-23 15:34, Detlev Casanova wrote:
> > On Friday, 23 August 2024 01:41:44 EDT Dragan Simic wrote:
> >> Hello Detlev,
> >> 
> >> Please see a comment below.
> >> 
> >> On 2024-08-22 23:15, Detlev Casanova wrote:
> >> > From: Shawn Lin <shawn.lin@rock-chips.com>
> >> > 
> >> > Some Rockchip devices put the phase settings into the dw_mmc
> >> > controller.
> >> > 
> >> > When the feature is present, the ciu-drive and ciu-sample clocks are
> >> > not used and the phase configuration is done directly through the mmc
> >> > controller.
> >> > 
> >> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >> > Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> > ---
> >> > 
> >> >  drivers/mmc/host/dw_mmc-rockchip.c | 171 +++++++++++++++++++++++++++--
> >> >  1 file changed, 160 insertions(+), 11 deletions(-)
> >> > 
> >> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> >> > b/drivers/mmc/host/dw_mmc-rockchip.c
> >> > index b07190ba4b7a..2748f9bf2691 100644
> >> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> >> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> >> > @@ -15,7 +15,17 @@
> >> > 
> >> >  #include "dw_mmc.h"
> >> >  #include "dw_mmc-pltfm.h"
> >> > 
> >> > -#define RK3288_CLKGEN_DIV	2
> >> > +#define RK3288_CLKGEN_DIV		2
> >> > +#define SDMMC_TIMING_CON0		0x130
> >> > +#define SDMMC_TIMING_CON1		0x134
> >> > +#define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
> >> > +#define ROCKCHIP_MMC_DEGREE_MASK	0x3
> >> > +#define ROCKCHIP_MMC_DEGREE_OFFSET	1
> >> > +#define ROCKCHIP_MMC_DELAYNUM_OFFSET	2
> >> > +#define ROCKCHIP_MMC_DELAYNUM_MASK	(0xff <<
> >> > ROCKCHIP_MMC_DELAYNUM_OFFSET)
> >> > +#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC	60
> >> > +#define HIWORD_UPDATE(val, mask, shift) \
> >> > +		((val) << (shift) | (mask) << ((shift) + 16))
> >> > 
> >> >  static const unsigned int freqs[] = { 100000, 200000, 300000, 400000
> >> > 
> >> > };
> >> > 
> >> > @@ -24,8 +34,143 @@ struct dw_mci_rockchip_priv_data {
> >> > 
> >> >  	struct clk		*sample_clk;
> >> >  	int			default_sample_phase;
> >> >  	int			num_phases;
> >> > 
> >> > +	int			internal_phase;
> >> > 
> >> >  };
> >> 
> >> It might be good to declare internal_phase as "unsigned int
> >> internal_phase:1",
> >> i.e. as a bit field, which isn't going to save some memory in this
> >> particular
> >> case, but it would show additional attention to detail.
> > 
> > In that case, I would go with a bool instead of int, that makes things
> > even clearer.
> 
> My suggestion to use "unsigned int internal_phase:1" actually takes
> inspiration from the ASoC code, in which such bit fields are used
> quite a lot, even when using them actually doesn't save space.
> 
> In this particular case, using plain bool would make sense, but I
> still think that using an "unsigned int internal_phase:1" bit field
> would fit better, because it would show the intention to possibly
> save a bit of RAM at some point.  OTOH, I don't think that using
> bool with such bit fields would actually work cleanly, because bool
> actually resolves to int that's a signed type.

I wouldn't use bool with a bit field of course. I've always considered using 
bit fileds only for structs that must have a certain format, like a header 
format definition.

For me, it is better to use "bool internal_phase" so that it is obvious that 
the feature can be on or off when reading the code.

When using bit fields with a struct that is not marked as "__packed", I 
immediately think that there could be a bug there and wonder why the bit field 
is used, not really thinking "the dev wanted to show they cared about memory 
usage".
But I guess that is all about preferences. In the end, it won't change how it 
works.

Detlev.


