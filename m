From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Date: Fri, 22 Jun 2012 08:30:10 +0900
Message-ID: <20120621233009.GD7034@verge.net.au>
References: <1340171905-12534-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1206200845590.20254@axis700.grange>
 <20120620070227.GN20030@verge.net.au>
 <A389CA2909F7E548A28A6A30A9446C0903651FAAD5@REAMBX.NA.RTA>
 <20120621004751.GB10003@verge.net.au>
 <A389CA2909F7E548A28A6A30A9446C0903651FAF81@REAMBX.NA.RTA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50046 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759629Ab2FUXa1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 19:30:27 -0400
Content-Disposition: inline
In-Reply-To: <A389CA2909F7E548A28A6A30A9446C0903651FAF81@REAMBX.NA.RTA>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Brandt, Chris" <Chris.Brandt@renesas.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Thu, Jun 21, 2012 at 07:11:42AM -0700, Brandt, Chris wrote:
> > At least for the sh7757 and sh7372.
> Also for the sh7724 (ie, only the sh7757 can run at full bus speed by setting CLKDIV=0xF which no other part can....yet)

Thanks.

> But, with this new patch applied:
> 
> >  	if (!ret) {
> >  		host->clk = clk_get_rate(host->hclk);
> > -		host->mmc->f_max = host->clk / 2;
> > +		host->mmc->f_max = p->sup_pclk ? host->clk : host->clk / 2;
> >  		host->mmc->f_min = host->clk / 512;
> >  	}
> 
> Then there's no need to check for p->sup_pclk in sh_mmcif_clock_control() because if (clk == host->clk) then p->sup_pclk can be assumed to be set.
> 
> -	if (p->sup_pclk && clk == host->clk)
> +	if (clk == host->clk)
> 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
> 	else
> 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
> 				((fls(DIV_ROUND_UP(host->clk,
> 						   clk) - 1) - 1) << 16));
> 
> 
> But, that's probably more along the lines of driver cleanup I guess.

Thanks, I'll add that.
