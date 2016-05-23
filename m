From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC v2 2/3] mmc: sh_mobile_sdhi: Add tuning support
Date: Mon, 23 May 2016 10:34:27 +0900
Message-ID: <20160523013427.GG25562@verge.net.au>
References: <1463727743-7567-1-git-send-email-horms+renesas@verge.net.au>
 <1463727743-7567-3-git-send-email-horms+renesas@verge.net.au>
 <87eg8tsijz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39638 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcEWBe3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 May 2016 21:34:29 -0400
Content-Disposition: inline
In-Reply-To: <87eg8tsijz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Mon, May 23, 2016 at 12:57:41AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > 
> > Add tuning support for use with SDR104 mode
> > This includes adding support for the sampling clock controller (SCC).
> > 
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> (snip)
> > +static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host, bool *tap)
> > +{
> > +	unsigned long tap_num, i;
> > +	int ok_count;
> > +
> > +	/* Clear SCC_RVSREQ */
> > +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
> > +
> > +	/* Select SCC */
> > +	tap_num = (sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL) >>
> > +		   SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
> > +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
> > +
> > +	/*
> > +	 * Select clock where three consecutive bock reads succeeded.
> > +	 *
> > +	 * There may be multiple occurrences of three successive reads
> > +	 * and selecting any of them is correct. Here the first one is
> > +	 * selected.
> > +	 */
> > +	ok_count = 0;
> > +	for (i = 0; i < 2 * tap_num; i++) {
> > +		if (tap[i])
> > +			ok_count++;
> > +		else
> > +			ok_count = 0;
> > +		if (ok_count == 3)
> > +			break;
> > +	}
> 
> As I pointed on [1/3] patch, having "tap_array_size" on this function,
> and check tap_num <-> tap_array_size is nice idea IMO.

We could also provide the array parameter and
not read tap_num using sd_scc_read32() here at all.
Which do you feel is best?
