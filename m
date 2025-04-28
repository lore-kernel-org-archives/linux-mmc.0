Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F425E828
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834354; cv=none; b=fiqjBvf/daHVAYXoWA2A6Cw92w4+D84xzIREwRnEslnBvS+sB6tNa6gmoF+MdCrdivm7XpLrQfofIzBIM1zCstIFO+UkzjEG/gAMspouzWHhh/+dxp6Cy+UqHQS6lsGDoaphtM6ZKZJgFtHn+TiCdM18p6NbGME8PNYcshton44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834354; c=relaxed/simple;
	bh=NnpDnaecEjaxgC/9EoeWEeuNxdMbouz16eL8rW7sxFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKlKRVFUyOtgRfAq6g4qUxaqSsqZReWW18JYOpgpvmDs9mUBDKCGMIs9+8mxE7ZZp8ZxzlBlweBWePs4p430OvoTs14Q6ajOVc2MbLJRkloqzDelft4x3lXqRUM0cU5sZwOvDl0QEESt0yUfYIxrHApXuFFo81gU65N2W1D1rgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2xZJeLH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2xZJeLH"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e730b8d934aso3090912276.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745834350; x=1746439150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgHog5j3bHubplZHipHB2WxTh+7XYb3lCIW6vc6Lfpk=;
        b=K2xZJeLHgVf3Sd5eVouWDptnISu9bfHgNEp+GAMvTwnSj+YITypzptgv5Bubi6Ja/X
         3tE/WrPX/C39HvzmAoKVo5d/517GkISPG3yzH/qPs+sfjg8uVbEQFXFpTOof3OaZ5Lw2
         Dore7O4wOIDq57p8aRvtivif2D1kvFHog4t3kjHO4gKo9bVg7uoIb03KT6x3ix3+j7mI
         Wjni7RscgwcKneQ8BJTnFB5y6PXde/TY+x6H77S2OkKf5Seb18GySoZ9p3mGwXxR0cK7
         7jWOv8V00iMqV9STkqwZf1j6yweNdmRhbxFB7R5H/MgUg7H+pbBnIXNrK6BybKGVv1Pz
         UAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745834350; x=1746439150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgHog5j3bHubplZHipHB2WxTh+7XYb3lCIW6vc6Lfpk=;
        b=lbgWxcofD4xpyyBsw9P+3sn67K5gdrS3coxYtBs1kQL/828qixTgCx3iH1cELdtMck
         Wc6mj3g6WhJFRjuacdC8J0pbYZ/VFQ5+CY2q2JWxaS6H2I3pAuePwds/MEkvrV+aC1st
         HetQ3mLqPuVX8MNNR5yuxa0mBHsoPEnrxgewoSqS3qSsAZmRMDwpPrkVLV1B+JbMwTRY
         0GJGB7JDUvAhlfdU5VGILu1esYF6Ad9oLF9nnP+F7m/fRSF4XRhBzyS/5Sz/4foRIobl
         Y/0QCmGBQs2pYXZj7vIUP2r2h9M6VMVmVlj+w0TUEX+OqMi+FQmHME5ZJHBxJF/Yn5T2
         xc5A==
X-Gm-Message-State: AOJu0Ywj6E/zGobxNKSOCYqTVcYOHw8ykoUaqZmwKSDZzy80YKUH9hmt
	ir/DKoDYjSHQakLftVzuk2Bf5RHHbAV+pUgZZ4yCEfYogX0WvfZ0UkuloVWRSugIO/xK8hjLiL0
	uJVg+kN0w3Q0aNozEo1z7Qziq/H5B5ICC2Ll88g==
X-Gm-Gg: ASbGncu4evi/f6WTcKuMS/bmvwObizXnm04fplN0QKwjx3ym07Qaf3YjAagFKLkW8HJ
	j5tdyJHjprA7RrrgwtxL2s+OcEUbGS/EWgFyHuWutw1rmBG7omZDPML0QsjpJQC5lG+TmSj1CwR
	ydMS7GffHKpP3rRt6n80fPyO8=
X-Google-Smtp-Source: AGHT+IGzqA988NBw7sdHyV2pa28mJrkNSc68Mx4LZTYc3yj0PJhv5acQ0zBwmMN9hv6uRI1W/EgLr/AniunkS+8k1Ek=
X-Received: by 2002:a05:6902:2e05:b0:e6d:f157:c601 with SMTP id
 3f1490d57ef6-e7316aa4b6cmr12912739276.17.1745834350357; Mon, 28 Apr 2025
 02:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 11:58:34 +0200
X-Gm-Features: ATxdqUESjgj-C7jn03RVVXo_02Q8tUEdsDkHYmNdSurwgrXAz3FKSyh0hhQHxd4
Message-ID: <CAPDyKFqxHd85DsUH6eZVyoocTDrvwNu+wTLRBq-jUwDY+2iFTg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: rename mmc_retune_* to mmc_host_retune_*
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Aubin Constans <aubin.constans@microchip.com>, Ben Dooks <ben-linux@fluff.org>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Hu Ziji <huziji@marvell.com>, 
	imx@lists.linux.dev, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 13:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> As discussed previously[1], here is the next set of MMC core function
> renaming to indicate if an action is relevant for the host or for the
> card. Local build tests went fine, buildbots were happy too.
>
> [1] https://lore.kernel.org/r/CAPDyKFpsJpLre2bO9T7gsSthsta9f3JXoXTGZbjTjWVXH47gCw@mail.gmail.com
>
> Wolfram Sang (11):
>   mmc: rename mmc_retune_enable() to mmc_host_retune_enable()
>   mmc: rename mmc_retune_disable() to mmc_host_retune_disable()
>   mmc: rename mmc_retune_hold() to mmc_host_retune_hold()
>   mmc: rename mmc_retune_release() to mmc_host_retune_release()
>   mmc: rename mmc_retune() to mmc_host_retune()
>   mmc: rename mmc_retune_pause() to mmc_host_retune_pause()
>   mmc: rename mmc_retune_unpause() to mmc_host_retune_unpause()
>   mmc: rename mmc_retune_clear() to mmc_host_retune_clear()
>   mmc: rename mmc_retune_hold_now() to mmc_host_retune_hold_now()
>   mmc: rename mmc_retune_recheck() to mmc_host_retune_recheck()
>   mmc: rename mmc_retune_needed() to mmc_host_retune_needed()
>
>  drivers/mmc/core/block.c           | 16 +++++++-------
>  drivers/mmc/core/core.c            | 28 ++++++++++++------------
>  drivers/mmc/core/host.c            | 34 +++++++++++++++---------------
>  drivers/mmc/core/host.h            | 22 +++++++++----------
>  drivers/mmc/core/mmc.c             |  8 +++----
>  drivers/mmc/core/mmc_ops.c         | 12 +++++------
>  drivers/mmc/core/mmc_test.c        |  4 ++--
>  drivers/mmc/core/sdio.c            |  6 +++---
>  drivers/mmc/core/sdio_io.c         |  4 ++--
>  drivers/mmc/host/sdhci-acpi.c      |  4 ++--
>  drivers/mmc/host/sdhci-esdhc-imx.c |  6 +++---
>  drivers/mmc/host/sdhci-of-arasan.c |  2 +-
>  drivers/mmc/host/sdhci-of-at91.c   |  2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
>  drivers/mmc/host/sdhci-omap.c      |  2 +-
>  drivers/mmc/host/sdhci-pci-core.c  |  6 +++---
>  drivers/mmc/host/sdhci-pltfm.c     |  2 +-
>  drivers/mmc/host/sdhci-pxav3.c     |  4 ++--
>  drivers/mmc/host/sdhci-s3c.c       |  4 ++--
>  drivers/mmc/host/sdhci-spear.c     |  2 +-
>  drivers/mmc/host/sdhci-st.c        |  2 +-
>  drivers/mmc/host/sdhci-xenon.c     |  2 +-
>  drivers/mmc/host/sdhci.c           |  2 +-
>  drivers/mmc/host/sdhci_am654.c     |  2 +-
>  drivers/mmc/host/tmio_mmc_core.c   |  4 ++--
>  include/linux/mmc/host.h           |  2 +-
>  26 files changed, 92 insertions(+), 92 deletions(-)
>

Sorry if my suggestion was unclear. I only had the MMC_CAP|CAP2_*
related functions in mind. I think we should leave the mmc_retune*
functions as is as they are not "can" functions.

mmc_host_cmd23, mmc_host_done_complete, mmc_boot_partition_access,
mmc_host_uhs. All in drivers/mmc/core/host.h

According to your earlier renaming series, we should rename these function too:
mmc_host_can_cmd23, mmc_host_can_done_complete,
mmc_host_can_boot_partition, mmc_host_can_uhs

Does this make sense to you?

Kind regards
Uffe
