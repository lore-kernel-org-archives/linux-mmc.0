Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5201DE8BE
	for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777166045; cv=none; b=btlXvHwRVE46sXuEwXzatdoM9E/P/GndvlKrh4KTIBHpZ9WuAlPkBT0dhB79Al/PnIdTCL8oGsMsasIUwKAwzF0CTQkyHB8eGCZACevt83Pe+RGds+GunEJ74sq8ksHhnDgONA1sfaOvk6Wb5SdBWXEtFGAyvAmNVQMWuAdtDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777166045; c=relaxed/simple;
	bh=LMEYiuTHUxBVUNlCSiGyL7X3QyORbXgi9HOV3k15oW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRRTWIk3u3SL0riVfONec1ZuOowkOuhNtFgqkwpnFQ+AmR4GDn4NIourMw9EKlclqL/Cc1UI+f0ultWhZo1kgMz/39pTxHZG26jP67WIOjX6NBbqoD5nuJRtMv0VcROc2QUmfbhChBgY+hOJwwU2wGceggjR5/3MLX2Vlc3LYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLVuZV84; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLVuZV84"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2429f98d0so53032585ad.2
        for <linux-mmc@vger.kernel.org>; Sat, 25 Apr 2026 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777166043; x=1777770843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdHw7CqZVYULzvQHcmJctGPHRqkIKbc4D3SQwtavlTk=;
        b=CLVuZV8484KiLZ5MEC6R7vu16w1Z743mL3CFm9/UJdY5U1Bo9B/JDBShrj9q5DeBh6
         fMJsG9oQq5SRp+tW0poLmVEWNLWLaLtFR1F8XsiYEfFigwDzXTx0s40/JER6PemyUEwM
         G9EG7R6OuvQ1eE1qZZGMExsxC8H5tQWhu22jFItVCHyxyvzfc3OTA0+288KCfebvzigl
         GjnbP8QlL15hsFXQluHM2Cru6Ep/O4oi8y17xgzB3iPF3Jpl1KGbkYhSM3rPLHT4+M2j
         dWc5e7hpKvMGkzjJwSj70Kvf3mmEaDcaAE/tFQej51du3NV58TEHojfYunj7Qptlbzs9
         BSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777166043; x=1777770843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdHw7CqZVYULzvQHcmJctGPHRqkIKbc4D3SQwtavlTk=;
        b=hFO8K853TD/jJeIPTEHrSQrjdIv3ii+3eYqJvNSdWvG66mFmdLnpDW6F9fYgS75+N7
         +jUps/4Wco8qRW7ry+v5PE3mFKuJK+vqfMnMY+qqh59qZmBn4+9VecCkO7XvhFqqYG/F
         puq7K+qHDKvBIwj+IKO6mPri2KpgWmj6sTt9tdrTn2J/j2lsL4Z1/Jy98YDpb+SzrmEN
         yy1/vkibmD85Uojqj1KnRwmvSgi2NfRm7qMp0XVJw6K28HZHogfQkDWeFnYy1Cx/6560
         tMM3orHVbQdlz+LgOSLYMmLEG2K7dpvq3DBJsSrt/zynRHbMIsf5SUXfnWW3/koC1gmN
         K4xA==
X-Forwarded-Encrypted: i=1; AFNElJ9oUtstNBV7lTxiSaguuMLXdy0TvqqGLvIF6/uMtxigOKfBoRaxqrSaHyyX8cenm1iardvjRfzvFTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrrMTxs/fnnLGffYdipIDBl02V5hZ73+JBDMeyxd6bfXPe8LO
	FbS+jNrmCUNwxtV6MBxoroukQv0oglMNzxoWIdO/jtqZeGxfCI7DMQop
X-Gm-Gg: AeBDiesHea5ghvzxKiEWSZhjWfsqDK0KEI/iAtJRWJ4BN0lrgmAjQIrLcCikfDY2UAa
	TMSjtbPnCBvjZz/Uq3sErdlwWyqVnwRMS0p+arGODrImvcKtDCyZaOBIhl0rD9pDAGzmdkhpuBJ
	uVLEI0dcsREWa9uFr2z0rfTfucjzLK5v4cadZCbFUQDgUvcl7dz1m8EqEzywRx4I/8cF+viCH6t
	z9XCqgRLKXDmq43b3kT81k2DDEznZHh6Y7H0IotCCh+Yk8q6/kmfAIW2cxxFZE8LlR23NyMiN/0
	OYE1xqWWznQ0EHAvfTO2HSdOLIKcOtrXhBKq/KtlDnnpsSHx5Xla/mAui2pqGZ5fNyxsoLzAKzI
	1LatuBKWnGfD7W3f/FCxOqwa7OznAnuua8TTwBKj9HKagUBnhhJUYmDk09v4EbnPVkjluQkdNV8
	KyLbIWfamA3A57b1ROdP+yf4qDH2qfs3/5WQ==
X-Received: by 2002:a17:903:907:b0:2b2:42b1:adac with SMTP id d9443c01a7336-2b5f9e7707fmr401674315ad.3.1777166042579;
        Sat, 25 Apr 2026 18:14:02 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa494e1sm263402365ad.35.2026.04.25.18.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 18:14:02 -0700 (PDT)
Date: Sun, 26 Apr 2026 09:13:58 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, 
	Joel Stanley <joel@jms.id.au>, Kamil Rakoczy <krakoczy@antmicro.com>, 
	Paul Mackerras <paulus@ozlabs.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <ae1ms3rVwOZhCVuC@inochi.infowork>
References: <20260424013615.470325-1-inochiama@gmail.com>
 <aeuIVeIGV2Wc9sY2@errol.ini.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeuIVeIGV2Wc9sY2@errol.ini.cmu.edu>

On Fri, Apr 24, 2026 at 11:12:21AM -0400, Gabriel L. Somlo wrote:
> Hi,
> 
> Thanks for the patch!
> 
> On Fri, Apr 24, 2026 at 09:36:14AM +0800, Inochi Amaoto wrote:
> > The litex_mmc driver assumes the card is already probed in the BIOS
> > and skip the phy initialization. This will cause the command fail
> > like the following when the old card is unplugged and then insert
> > a new card:
> > 
> > [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> > [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > 
> > Add required clock settings and initialization for the CMD 0, so it can
> > probe the new card.
> > 
> > Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> > Change from v1:
> > - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> > 1. use fsleep to replace udelay
> > ---
> >  drivers/mmc/host/litex_mmc.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> > index d2f19c2dc673..ac0b47604c02 100644
> > --- a/drivers/mmc/host/litex_mmc.c
> > +++ b/drivers/mmc/host/litex_mmc.c
> > @@ -68,6 +68,9 @@
> >  #define SD_SLEEP_US       5
> >  #define SD_TIMEOUT_US 20000
> > 
> > +#define SD_INIT_DELAY_US  1000
> > +#define SD_INIT_CLK_HZ    400000
> > +
> >  #define SDIRQ_CARD_DETECT    1
> >  #define SDIRQ_SD_TO_MEM_DONE 2
> >  #define SDIRQ_MEM_TO_SD_DONE 4
> > @@ -99,6 +102,8 @@ struct litex_mmc_host {
> >  	bool app_cmd;
> >  };
> > 
> > +static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq);
> > +
> 
> Instead of the forward reference, can you simply move the entire
> `litex_mmc_setclk` function definition to this location in the file?
> (i.e., add a separate, "cosmetic" patch simply cut'n'pasting the
> function body from one place to another, with a commit blurb stating
> that it's in preparation for the idle-clock fix, and that it contains
> only cosmetic, no functional changes)?
> 
> The idle-clock fix patch can then contain nothing but the
> "#define SD_INIT_*" lines and the hunk below:
> 

Thanks, it is fine for me. I will send a new version for this.

Regards,
Inochi


> >  static int litex_mmc_sdcard_wait_done(void __iomem *reg, struct device *dev)
> >  {
> >  	u8 evt;
> > @@ -128,6 +133,12 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
> >  	int ret;
> >  	u8 evt;
> > 
> > +	if (cmd == MMC_GO_IDLE_STATE) {
> > +		litex_mmc_setclk(host, SD_INIT_CLK_HZ);
> > +		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> > +		fsleep(SD_INIT_DELAY_US);
> > +	}
> > +
> >  	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
> >  	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
> >  		      cmd << 8 | transfer << 5 | response_len);
> 
> Thanks much,
> --Gabriel
