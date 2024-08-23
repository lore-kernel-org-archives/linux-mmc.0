Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACE14387B;
	Fri, 23 Aug 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420025; cv=pass; b=LgVWLfLI4eW8zV2S9oLUB7fTUG9QS19irnT/okNizxN/enOryTc0A8j5E1SY7aMlFZVDejcFoPhqu7B22f+T17MCEFik3/l6ZMNWyhmXTcKPPwBhfF0eAXOo7XncO54bhBYyrm4DQeObAw1irQPMbP+luNywNFVVNaDzMxQnn44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420025; c=relaxed/simple;
	bh=rRdCwS48CKNkgj97i9qRE+e39eqwYIb8ICcM+jB4j2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUQvW7CeKE6Itbzu4rX56gQtESXep1njr28DwngF/pzuc8CWWrqQ64KiqWSDgh2GTpxFtwE6HWqcIYs7d9m30NogiY4q1dl+DSy4Rp9fgbXa9HyrWyoV/7PNwPLzv2+Ja2uSzRz8zuaEHnA6b8pWtw2kqiG/oRlceyZkSuKulvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=atFOtoGt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="atFOtoGt"
ARC-Seal: i=1; a=rsa-sha256; t=1724419992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R4FmA1PJAod74vUer+LedjDR/DrbscZNJjJCxClrTvSD6Pe1MnSad3t0X2faZAtdU711LbKuuvISuQJESxUIR6cB4iPTPysyyADzwN9ol+qfeHI/s3NC//h1zMkpkiQQOH2LNYvVCFidzn2zVc72LpUI3crHZ5U3sP4+rRR1wZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724419992; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M10075zfY7i2BB74kKfhInpO04SsOI2soxqTCP1Y90g=; 
	b=fWl0pLJKKPN4z7+vDhEmY7K6YTjyFauWo0zpspqnPtXWeljEkaPDi195N5b7ooV2F2PAHUrUXbsMOQ1efKOl7w8oAnKAcWDdEg1M04bjxdNjVdk+5klBtVfJ7jm433BLnJTREGT9AVjycgJPSpDcppuJNk4s3kTNSTCHMANPm4c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724419992;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=M10075zfY7i2BB74kKfhInpO04SsOI2soxqTCP1Y90g=;
	b=atFOtoGtDJiU1h6/drb7a8qsRPpqeM32vczPd2jgUlErfqHbB1Uw0K4ofmM1UaXb
	Ho0ED0thMuDlgZAc+qyt2/ySCak77SSyc0XLswp53PCYomuMuQkkl+6vFgT3rGVinjL
	v0itjv+26cUgw4564uUzIRmjiNMRSJliG7e0XPHg=
Received: by mx.zohomail.com with SMTPS id 1724419991555189.99931184256172;
	Fri, 23 Aug 2024 06:33:11 -0700 (PDT)
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
Date: Fri, 23 Aug 2024 09:34:52 -0400
Message-ID: <4943132.31r3eYUQgx@trenzalore>
In-Reply-To: <f0f5dec4a5403616fa25c6ed754f6050@manjaro.org>
References:
 <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-3-detlev.casanova@collabora.com>
 <f0f5dec4a5403616fa25c6ed754f6050@manjaro.org>
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

On Friday, 23 August 2024 01:41:44 EDT Dragan Simic wrote:
> Hello Detlev,
> 
> Please see a comment below.
> 
> On 2024-08-22 23:15, Detlev Casanova wrote:
> > From: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > Some Rockchip devices put the phase settings into the dw_mmc
> > controller.
> > 
> > When the feature is present, the ciu-drive and ciu-sample clocks are
> > not used and the phase configuration is done directly through the mmc
> > controller.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> > 
> >  drivers/mmc/host/dw_mmc-rockchip.c | 171 +++++++++++++++++++++++++++--
> >  1 file changed, 160 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> > b/drivers/mmc/host/dw_mmc-rockchip.c
> > index b07190ba4b7a..2748f9bf2691 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > @@ -15,7 +15,17 @@
> > 
> >  #include "dw_mmc.h"
> >  #include "dw_mmc-pltfm.h"
> > 
> > -#define RK3288_CLKGEN_DIV	2
> > +#define RK3288_CLKGEN_DIV		2
> > +#define SDMMC_TIMING_CON0		0x130
> > +#define SDMMC_TIMING_CON1		0x134
> > +#define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
> > +#define ROCKCHIP_MMC_DEGREE_MASK	0x3
> > +#define ROCKCHIP_MMC_DEGREE_OFFSET	1
> > +#define ROCKCHIP_MMC_DELAYNUM_OFFSET	2
> > +#define ROCKCHIP_MMC_DELAYNUM_MASK	(0xff <<
> > ROCKCHIP_MMC_DELAYNUM_OFFSET)
> > +#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC	60
> > +#define HIWORD_UPDATE(val, mask, shift) \
> > +		((val) << (shift) | (mask) << ((shift) + 16))
> > 
> >  static const unsigned int freqs[] = { 100000, 200000, 300000, 400000
> > 
> > };
> > 
> > @@ -24,8 +34,143 @@ struct dw_mci_rockchip_priv_data {
> > 
> >  	struct clk		*sample_clk;
> >  	int			default_sample_phase;
> >  	int			num_phases;
> > 
> > +	int			internal_phase;
> > 
> >  };
> 
> It might be good to declare internal_phase as "unsigned int
> internal_phase:1",
> i.e. as a bit field, which isn't going to save some memory in this
> particular
> case, but it would show additional attention to detail.

In that case, I would go with a bool instead of int, that makes things even 
clearer.



