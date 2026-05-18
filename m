Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D99289340
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144331; cv=none; b=OeTdThdXA1rxRVBfoDIHHDalZ6clgPLHGh/qraIe6/2A7Wp+apLoLLnunikmn0DV8ikhh/Bs/dLLOnWY3BoFWM0+4qlt+6/7AnmLiishESq9+lHgOl07FqhP39FGYrvOVzlXgMOrUMqw8SNOY7TPW74JoQSS15ztCb7gQCKnhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144331; c=relaxed/simple;
	bh=pifblWiQ1TLHefG1Q0nop1imYuvqSMxnWw1DlyKUUPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJqeqa8ogNu3ECXQBNBMARiPGkXXBiJ2H+stz6Y6LEWFPeVBta+hUVWdB16IVTsy4mCeyvmGqwjHeBkvghCwjcC0PPOLsJDT6zFNQXBMgCVzDdGxoFcA60fQ2tAky8kEGxyJh3BkR8Qf6/vd/uDFICHjAL2vl9uGAhWZArknc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7L7sLFt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7L7sLFt"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e97863425so33237711cf.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779144329; x=1779749129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YY12qmAw/YvXItWxKFuE6zrhQE3wG3PQZuik94qWjms=;
        b=Z7L7sLFtp5kF702DQsJawmyR6vr9g2yOhaju5S+IQepqIjECreeKoPdMo6AVSK+XH/
         CfZoneznLEx65QEAzXSNGnhXXQcjqGFunERKEgU93qXARGW2uGQ69nF3RXKMlzL2rEJ7
         N4TzUOIbRMt1nDTelCBZGFvQUu/iyIkGqnYfT706/Pr8PWrdU0vU072KZZTslZz4zgt5
         Rs0Q1pv7abcP/dowDctud8hHK2CDvSGlP0pbyoqDHFOebldQay+g1mub4cJYDIYMLlpM
         QBPSsBGG6lzK+g5KBEwQdZY320Axf09oFcmfan5uEX2VNkfV93nc7Vq8Wxf0ZMICHwj8
         RxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144329; x=1779749129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YY12qmAw/YvXItWxKFuE6zrhQE3wG3PQZuik94qWjms=;
        b=q8ja4T4Tksc6Ci0VojjoRBCMb7EsjrHChqljlgrHFw9YTQZJhqfTWUtYb5+ic8zcy2
         VgurDatNIuosQgSlCLiP0BxdOR0kBcZIBbeavEpsIaXPKdHvYCdgvFXdBTMSqI9J1lgl
         2lLjtffvt7H5U0MDPh3gj1ic/U5veiekTe4DtBu9h+FOMhUYcKA2JoGFRg5mInpf4z9d
         AeYX0cnXIM5rWQMAqNA9xRd/stk9WGGp4v6kMzBCM2XWzfdMKpqPKejhLGt5zvb8/Y16
         UI3nnnTnboaFmBl7jj/MPbkl7qKgTz6SgC5cvZ95zdTRDXoulYWkzzC+BjZcY0ytiZSu
         YXcw==
X-Forwarded-Encrypted: i=1; AFNElJ+xeOPKcrNMgl78pEDKKo9Nfc3TJa4l+mF9RqPnvz7BBba3mXXhP0fN2Fhd97k4Xyfi2iWlyUHmz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDP6sXZd7gNJg+aK82gA4jjUX54gSXT8d6gD8HIplh+iRvly9
	//y5D5lQmbNTiqpSuZmQDN7q7m1rj7H0U5uZqDZ6cXkjOs9ACcM5DqnL
X-Gm-Gg: Acq92OEEf8Wy00Nw3J12OoP5Jmgs81srooWrzM0j5/eSZXXVjSajJZ3cfAqlGSdYeNi
	ZYHyFc6I89vpSxUMZ/ztb/dkzNHVf7unmBy5S4wX+fPvhn2lUUKVcm+Vw/46DmkTTC7YYOpxSKH
	1fLsbPQuCEcgJ3t1xK+6F+NwzdRnhNPu+LhpiuQM6dzV7p4MOGKO/FhOFhu9m+j6Rhiuu/2RJUp
	V8QFa3NWi6AqRI/KDT95yEPd9LkbaXqATKWjg+7jLy6LQiloyADgCDec5CMbenlwRkM+uDe1nu7
	T1vvjoSyjywSthakVuG5t2JCHQe8+VSBBZCBJLe/tr/m3/T/AzakQtqM7xui/qSSf7A8VL3W90K
	cwF3CzlITrAa41ImDH7mbwDQ6mSelBsSlpdkgF3iDK9DvejSQXZaNaOYhqLg/cJl+Qu44GWRQbc
	r/s7HY1qHlUl1tM4xO8xwXtBTz3JnyO/+RZkJusEeGP5PnU+fvHZvughudlyDCOJ9esUZLW8+/z
	axTwasnwVm5
X-Received: by 2002:a05:622a:6201:b0:50f:ade2:2d3 with SMTP id d75a77b69052e-5165a1ec441mr227885641cf.42.1779144329153;
        Mon, 18 May 2026 15:45:29 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-17-68-229.pitbpa.fios.verizon.net. [108.17.68.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm149069961cf.18.2026.05.18.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:45:28 -0700 (PDT)
Date: Mon, 18 May 2026 18:45:26 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Kamil Rakoczy <krakoczy@antmicro.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <aguWhuNsV1KKxMeQ@errol.ini.cmu.edu>
References: <20260517015323.264179-1-inochiama@gmail.com>
 <aguQwccX_ujIoARX@errol.ini.cmu.edu>
 <aguRU9Ces7ruBbRY@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aguRU9Ces7ruBbRY@inochi.infowork>
X-Clacks-Overhead: GNU Terry Pratchett

On Tue, May 19, 2026 at 06:24:19AM +0800, Inochi Amaoto wrote:
> On Mon, May 18, 2026 at 06:20:49PM -0400, Gabriel L. Somlo wrote:
> > with this patch on top of today's latest (4d3a2a466b8d), I get
> > (on 64-bit rocketchip with Litex):
> > 
> > [    6.475114] mmc0: invalid bus width
> > [    6.477870] mmc0: error -22 whilst initialising SD card
> > 
> > Thanks,
> > --Gabriel
> > 
> 
> Hi, Gabriel,
> 
> Could you share the board link and build commands? I think I need to
> take a look for why this occurs.
> 
> Regards,
> Inochi

Hi Inochi,

it's the digilent nexys-video board; the command line to build the
bitstream is:

litex-boards/litex_boards/targets/digilent_nexys_video.py --build \
  --cpu-type rocket --cpu-variant linux --cpu-num-cores 4 --cpu-mem-width 2 \
  --sys-clk-freq 50e6 --with-ethernet --with-sdcard --with-sata --sata-gen 1

(for more details see https://github.com/litex-hub/linux-on-litex-rocket)

I've added your patch on top of the LiteX kernel tree at
https://github.com/litex-hub/linux/tree/litex-rebase

and compiled it with:

make clean
make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- litex_rocket_defconfig
make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-

FWIW, your previous versions of the patch did work, and did fix the
issue you were trying to address (which I did notice being a problem
on my configuration :)

Thanks,
--Gabriel
 
> > On Sun, May 17, 2026 at 09:53:23AM +0800, Inochi Amaoto wrote:
> > > The litex_mmc driver assumes the card is already probed in the BIOS
> > > and skip the phy initialization. This will cause the command fail
> > > like the following when the old card is unplugged and then insert
> > > a new card:
> > > 
> > > [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> > > [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > 
> > > Add required clock settings and initialization for the CMD 0, so it can
> > > probe the new card.
> > > 
> > > Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > > Changed from v3:
> > > - https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gmail.com/
> > > 1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> > > 2. Use set_ios() callback to apply the clock change.
> > > 
> > > Changed from v2:
> > > - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
> > > 1. Remove the added function forward reference and add a new patch
> > >    for moving litex_mmc_setclk() function
> > > 
> > > Change from v1:
> > > - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> > > 1. use fsleep to replace udelay
> > > 
> > > Inochi Amaoto (2):
> > >   mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> > >   mmc: litex_mmc: Set mandatory idle clocks before CMD0
> > > 
> > >  drivers/mmc/host/litex_mmc.c | 37 ++++++++++++++++++++++--------------
> > >  1 file changed, 23 insertions(+), 14 deletions(-)
> > > ---
> > >  drivers/mmc/host/litex_mmc.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> > > index d2f19c2dc673..65d5c728f536 100644
> > > --- a/drivers/mmc/host/litex_mmc.c
> > > +++ b/drivers/mmc/host/litex_mmc.c
> > > @@ -68,6 +68,9 @@
> > >  #define SD_SLEEP_US       5
> > >  #define SD_TIMEOUT_US 20000
> > > 
> > > +#define SD_INIT_DELAY_US  1000
> > > +#define SD_INIT_CLK_HZ    400000
> > > +
> > >  #define SDIRQ_CARD_DETECT    1
> > >  #define SDIRQ_SD_TO_MEM_DONE 2
> > >  #define SDIRQ_MEM_TO_SD_DONE 4
> > > @@ -449,6 +452,9 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >  {
> > >  	struct litex_mmc_host *host = mmc_priv(mmc);
> > > 
> > > +	if (ios->chip_select == MMC_CS_HIGH)
> > > +		ios->clock = SD_INIT_CLK_HZ;
> > > +
> > >  	/*
> > >  	 * NOTE: Ignore any ios->bus_width updates; they occur right after
> > >  	 * the mmc core sends its own acmd6 bus-width change notification,
> > > @@ -459,6 +465,11 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >  	/* Update sd_clk */
> > >  	if (ios->clock != host->sd_clk)
> > >  		litex_mmc_setclk(host, ios->clock);
> > > +
> > > +	if (ios->chip_select == MMC_CS_HIGH) {
> > > +		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> > > +		fsleep(SD_INIT_DELAY_US);
> > > +	}
> > >  }
> > > 
> > >  static const struct mmc_host_ops litex_mmc_ops = {
> > > --
> > > 2.54.0
> > > 
