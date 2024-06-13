Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1089143C67;
	Thu, 13 Jun 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285378; cv=none; b=J60+33ur3AddKnut2nBptaMLHY97ObqpMxPgEv8uNtnXh9dXyOaYJeV0Es/Yl67/yPIfJMq/5m9X/jo6ZH+TMdFjnMp/zq3xmYnQaki+r+WA8UQYTS2pjRZzlpxgOuJv9/9LnZ1bAqTyDLTth5ysrjsvOOLpo/DSG34L8vykLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285378; c=relaxed/simple;
	bh=Smrfkl4omv8EWaCxAKTIU7F5mdrGTLS/0iCWoIy2Z/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5ECDVl3y/D8YAOBSTAKRF4L2nokk7D5BqfBy8ade80vN0JpMDr4mqDSPpuZ24IBJC+r7KQE+PVC7W78behPLAoqhIWZDw4P2S7IhToet+ty16ggnmXWV30pXWWUbWGw86N+RkBHv1IestzUkIjtek27StDbozqO6vzo/iJ1LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhM6QfgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhM6QfgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECAC2BBFC;
	Thu, 13 Jun 2024 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718285378;
	bh=Smrfkl4omv8EWaCxAKTIU7F5mdrGTLS/0iCWoIy2Z/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhM6QfgHF2vbPhF8Y/my+EWnMq7v4Km2+YqAqAQtZCPPAnIXGziY8eVImAanMt0Si
	 YVXeoDfIj1O+uHnOdctu4rE6NP7knrdcXl8nRpU+cXjx9xJHal7UxEhOj8MZDGZcm/
	 6eSkQWB/URV8uCCr4cWsHWeX9ebeuNLN0Mxoz13rcydsRd1yo4sqV9KPZ9LmNnqpzb
	 Ee9wV/RCryGa/sfokyMw4zHP5ZnuUilFXXP0KebmD4LvvVh6nfLzVKP9a6klEBLfBy
	 SlgApLhoj6Z/EeT/k7vTso/ocCeQKh5DSBxJx8upO07u0UMk1YzbItRRUBjCo7JO56
	 Dk90a4X1ZGrUA==
Date: Thu, 13 Jun 2024 21:15:41 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use inverted-wp quirk for CV18xx
 and SG200x SoCs
Message-ID: <Zmrw_egJomoF0Tf3@xhacker>
References: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <Zmrt-dcPR_ZXlYH-@xhacker>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zmrt-dcPR_ZXlYH-@xhacker>

On Thu, Jun 13, 2024 at 09:03:24PM +0800, Jisheng Zhang wrote:
> On Fri, May 31, 2024 at 02:13:47PM +0000, Haylen Chu wrote:
> > MMC controller integrated in Sophgo CV18xx and SG200x SoCs has an
> > inverted write-protect flag, causing SDCards misdetected as read-only.
> > So set SDHCI_QURIK_INVERTED_WRITE_PROTECT to make write protection work
> > correctly.
> 
> No, I would rather set cd-inverted property in dts.

wp-inverted

> > 
> > Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 39edf04fedcf..62b7f28de54f 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -962,7 +962,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> >  
> >  static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
> >  	.ops = &sdhci_dwcmshc_cv18xx_ops,
> > -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> > +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> > +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> >  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> >  };
> >  
> > -- 
> > 2.45.1
> > 
