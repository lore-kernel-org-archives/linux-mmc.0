Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925922F7EF5
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143096; cv=none; b=lYcu+WvmMFMtbP+vcPrvzrrlJrXLmhPPVNQS3njVgX743yWhr5ikeKOBJ22xdxZ/pHBedFSs5njPcm3gAAnmepvNJQZbyVTKj/mMpkvDRnQ9kosa0yXcuhbZfUoNR//qb94bjZjxExRl7XkRSWv0bvVx+XgJUkQchJ0Zim1KFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143096; c=relaxed/simple;
	bh=cPFqibzt05U7+9OKSx2BqYF0uQt/jBSuHJMI1cCiTy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR27FbgQlWuACT3fBg7LwB6rIvxr0I0EQqoSnfwjhzjCTpc5U/onsUm9K9x2JlZIvKpm8VV6KA7b9vy7f78uKkBSVXMU/RuvAhUjv2IV7c1yRfI+XPe5jWzDh1kbyzzrAUWcyXdd/IbzjH7b0XYxfyYNTB8OzZFXA3kOjajP4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7niZGEm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7niZGEm"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so1151663b3a.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779143095; x=1779747895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7/YzMatW7mhE2BJtzNdI6oIt+QsL1Oe6mroM0UQHvQ=;
        b=J7niZGEmCg03fsxKJeg48nCrrvZUfvpswtv6fQz/Wec9bh8a0xRMR94ZaUZo8R3lLR
         MADpJBcORi9TNnN8Pupq6w3n5mgzN+qLh724J+S9YP5Y3E8cNTD4jx+GtnSoSv/26D/Q
         G886NvJx1bBPacZjq0wF3SPgyN/7ct1XHl7yijqCjXPOb9pds/XOi1s1pX7/0aN2rB0y
         oPG+vA+kDFsnhwnF0xTuVrfvlZ8QaspXBN15lj9AXewawdH2qFEJXEauSfhGZEkHsCDo
         muXAJGHfCiCausxqTXufrXfY9AqG/T58b4s0Z9E1EBaMP255pEitCVW0e4jHeeEOFLKz
         oVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779143095; x=1779747895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7/YzMatW7mhE2BJtzNdI6oIt+QsL1Oe6mroM0UQHvQ=;
        b=Vl/xUqbifCv7EZebXTPlWbRd4tOO3w0EORs43NnI6tn2cBCAcbk7ek6nmSUSDGhVe0
         1L7mZKHlQICpsgGGxsRlnBEexdPL0eiA5IzjX8eqNWCL7r/lZFbDt3D61wsFRrWLuzgs
         eBPQveHK/YNfb+ip6FovvS7GW3gKfXcCCq8HRuaSJ+3ge05B4PHi+R4bweheBA7iLNX5
         qmurNxNnuas6majvBQmUiGS1Lsln9sp0JofRB+EbwrSnqYGJ9ixmH7XyAoRL9PtD7uK5
         zlKbBkQ0Rp0q1H2a7QzRR9tGQhJh1PljdfMSq9yZmznLtEr2Kl2DKGNWb3rorXu0TJ4R
         ytcw==
X-Forwarded-Encrypted: i=1; AFNElJ+uLDg6+4Yb7BmO/qZbjb+LLZ+5zn0/ld3laAhOrQHkFTM4B+0RniiOlOdloDZ0CeLBycfajD4u7zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tvlN7iRARcn8pJnHIML3uzyv/bFij6BxN5I3rrsye3r2RXvR
	3vTCANnUvJzkzBvGDS+4lbcBlu5bRg8wMvHjwoKZaA31gcF/Jh3JuiAe
X-Gm-Gg: Acq92OFLhlRGVB2WDlbe74A2QB2yZOsCMioYn8/pyKUrQAa9166dOd2WSvdAo6dXZFs
	kdeJnb10LUkjLCZ+Kq8ZZmHXIV0ahHiyAZiAyGQe5oUXV5DhVOHTDeyQZ3XbgW208Aarsv4ZhEB
	z9UDO+0ueTWuqRDQu09UgL22g3ZXFxQETWPLr9blktdEQbKYzZKEt1C0/XuZVdM9QK2FeFkMvaD
	ZWbAhgkmF7D181uO9ZJHZihp8NfZ9L2M1lFoRCknekbawhb3gKWwlAdVHSMG+l77W+SoDBMLZ36
	wu1yRy5yQxKyy2h6Sh0fuvC9eCJHFAn874ScfHW+//aeO/AIie7ERcaoi4jhwKGj1gNCGEoCtvd
	BST3i/JUWj/z9rHhK+Dythxwtt4icJy7VdJgnvBealARmj1GsUxMeD57CVWrDaAYCuX0gy65Lyr
	e+i6NDbjVBM4ogL9QurJ6Gr78=
X-Received: by 2002:a05:6a20:a12b:b0:3aa:f9cb:d435 with SMTP id adf61e73a8af0-3b22e67fceemr18950707637.11.1779143094823;
        Mon, 18 May 2026 15:24:54 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82da93df0dsm7926182a12.19.2026.05.18.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:24:54 -0700 (PDT)
Date: Tue, 19 May 2026 06:24:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Joel Stanley <joel@jms.id.au>, 
	Kamil Rakoczy <krakoczy@antmicro.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <aguRU9Ces7ruBbRY@inochi.infowork>
References: <20260517015323.264179-1-inochiama@gmail.com>
 <aguQwccX_ujIoARX@errol.ini.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aguQwccX_ujIoARX@errol.ini.cmu.edu>

On Mon, May 18, 2026 at 06:20:49PM -0400, Gabriel L. Somlo wrote:
> with this patch on top of today's latest (4d3a2a466b8d), I get
> (on 64-bit rocketchip with Litex):
> 
> [    6.475114] mmc0: invalid bus width
> [    6.477870] mmc0: error -22 whilst initialising SD card
> 
> Thanks,
> --Gabriel
> 

Hi, Gabriel,

Could you share the board link and build commands? I think I need to
take a look for why this occurs.

Regards,
Inochi

> On Sun, May 17, 2026 at 09:53:23AM +0800, Inochi Amaoto wrote:
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
> > Changed from v3:
> > - https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gmail.com/
> > 1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> > 2. Use set_ios() callback to apply the clock change.
> > 
> > Changed from v2:
> > - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
> > 1. Remove the added function forward reference and add a new patch
> >    for moving litex_mmc_setclk() function
> > 
> > Change from v1:
> > - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> > 1. use fsleep to replace udelay
> > 
> > Inochi Amaoto (2):
> >   mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> >   mmc: litex_mmc: Set mandatory idle clocks before CMD0
> > 
> >  drivers/mmc/host/litex_mmc.c | 37 ++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> > ---
> >  drivers/mmc/host/litex_mmc.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> > index d2f19c2dc673..65d5c728f536 100644
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
> > @@ -449,6 +452,9 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >  	struct litex_mmc_host *host = mmc_priv(mmc);
> > 
> > +	if (ios->chip_select == MMC_CS_HIGH)
> > +		ios->clock = SD_INIT_CLK_HZ;
> > +
> >  	/*
> >  	 * NOTE: Ignore any ios->bus_width updates; they occur right after
> >  	 * the mmc core sends its own acmd6 bus-width change notification,
> > @@ -459,6 +465,11 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	/* Update sd_clk */
> >  	if (ios->clock != host->sd_clk)
> >  		litex_mmc_setclk(host, ios->clock);
> > +
> > +	if (ios->chip_select == MMC_CS_HIGH) {
> > +		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> > +		fsleep(SD_INIT_DELAY_US);
> > +	}
> >  }
> > 
> >  static const struct mmc_host_ops litex_mmc_ops = {
> > --
> > 2.54.0
> > 
