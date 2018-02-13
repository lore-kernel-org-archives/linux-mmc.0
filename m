From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 3/3] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 12:38:44 +0100
Message-ID: <20180213113843.enfk3jhjgpfvvlsc@verge.net.au>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-4-horms+renesas@verge.net.au>
 <20180207222143.mscy7c2gi63jbvtc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47890 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934190AbeBMLis (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Feb 2018 06:38:48 -0500
Content-Disposition: inline
In-Reply-To: <20180207222143.mscy7c2gi63jbvtc@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Feb 07, 2018 at 11:21:44PM +0100, Wolfram Sang wrote:
> 
> > +	/* Reset HS400 mode */
> > +	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
> > +			sd_ctrl_read16(host, CTL_SDIF_MODE));
> > +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
> > +		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
> > +			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
> > +			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
> > +
> 
> This looks like code duplication. Can't we simply call
> renesas_sdhi_reset_hs400_mode()?

Yes, thanks for noticing. I will make that so.

I think that the previous few lines, not added by this patch,
can also be consolidated into a renesas_sdhi_reset_scc() function
and re-used in renesas_sdhi_reset_scc().
