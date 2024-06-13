Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FB1448E5;
	Thu, 13 Jun 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286029; cv=none; b=e4//FKztHDopa6z6/ExV5RV6XIU3NBZZKwfye+gT50WaN4CFb15FQOeHE/SiI9jxYRiEOeSvMs22kZV+NwKFKLOkRB/pYyDCpy7FSqojvQlUTv4G4VL8eqo+pBlLM0rCBJTAokHgYIRVfHQys8hRkllFyIcSrwavOhCKZw4tQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286029; c=relaxed/simple;
	bh=m5QYFdAL+feMVH2MyIxXOPX2B5GR+B9Lzkpomys7T0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRZo6axezFolQXOqviyHdbx0+s8O+8tT/DuSlD9gZ3844un2s/WTFtcDWEu0CYpgkBxUhNdZLVatiA72rxLyg+TJF/f/aEIVwV3mXrsW9NgNSKDUoFdwQ2/6TMU/T+T9UmDS4NEHrevPTouGehy8wROIB0yUVTRleVSrxUfK7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0lfE3IM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0lfE3IM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CEC2BBFC;
	Thu, 13 Jun 2024 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718286028;
	bh=m5QYFdAL+feMVH2MyIxXOPX2B5GR+B9Lzkpomys7T0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0lfE3IMyfPRo/fEuZj//DfvwmChfaVwJtt7MWWguxlpXtAP8pfRITgz/TSDtJLxC
	 99HT8TGmCjrAs5DsXQsKJpcsjZPSePj0Eavv0J3I9uXagFy31pSGRqNVrlhjYaR0kq
	 sAmTmjY07VInHqmOQ5m3vfyvP5eJN+XRPLyN7rhvfdhrYWOx7WYikaNDa+ZbckbCJZ
	 ZjKIWVEamUEVaDmZYoPybFdt6dzXdx3BB4DLFrPUHMXBfFTKbNu3wHFOz5TJo8bhQl
	 tu9JNRbVzmwxOqthBRrGJjgzVwu8cLasXJ2O81OgIJ4FZ1t4H2kDLv3CCdHavOHlya
	 iOHeWAAfYetEQ==
Date: Thu, 13 Jun 2024 21:26:37 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use inverted-wp quirk for CV18xx
 and SG200x SoCs
Message-ID: <ZmrzjWQgKzlQqVVv@xhacker>
References: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <Zmrt-dcPR_ZXlYH-@xhacker>
 <Zmrw_egJomoF0Tf3@xhacker>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zmrw_egJomoF0Tf3@xhacker>

On Thu, Jun 13, 2024 at 09:15:50PM +0800, Jisheng Zhang wrote:
> On Thu, Jun 13, 2024 at 09:03:24PM +0800, Jisheng Zhang wrote:
> > On Fri, May 31, 2024 at 02:13:47PM +0000, Haylen Chu wrote:
> > > MMC controller integrated in Sophgo CV18xx and SG200x SoCs has an
> > > inverted write-protect flag, causing SDCards misdetected as read-only.
> > > So set SDHCI_QURIK_INVERTED_WRITE_PROTECT to make write protection work
> > > correctly.
> > 
> > No, I would rather set cd-inverted property in dts.
> 
> wp-inverted

hmm, if I read the SCH correctly, there's no wp pin at all, so
disable-wp is better

> 
> > > 
> > > Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
> > > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > > ---
> > >  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > index 39edf04fedcf..62b7f28de54f 100644
> > > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > @@ -962,7 +962,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> > >  
> > >  static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
> > >  	.ops = &sdhci_dwcmshc_cv18xx_ops,
> > > -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> > > +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> > > +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> > >  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> > >  };
> > >  
> > > -- 
> > > 2.45.1
> > > 
