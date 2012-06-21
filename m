From: "Brandt, Chris" <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Date: Thu, 21 Jun 2012 07:11:42 -0700
Message-ID: <A389CA2909F7E548A28A6A30A9446C0903651FAF81@REAMBX.NA.RTA>
References: <1340171905-12534-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1206200845590.20254@axis700.grange>
 <20120620070227.GN20030@verge.net.au>
 <A389CA2909F7E548A28A6A30A9446C0903651FAAD5@REAMBX.NA.RTA>
 <20120621004751.GB10003@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:64601 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab2FUOOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 10:14:37 -0400
In-reply-to: <20120621004751.GB10003@verge.net.au>
Content-language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

> At least for the sh7757 and sh7372.
Also for the sh7724 (ie, only the sh7757 can run at full bus speed by setting CLKDIV=0xF which no other part can....yet)

But, with this new patch applied:

>  	if (!ret) {
>  		host->clk = clk_get_rate(host->hclk);
> -		host->mmc->f_max = host->clk / 2;
> +		host->mmc->f_max = p->sup_pclk ? host->clk : host->clk / 2;
>  		host->mmc->f_min = host->clk / 512;
>  	}

Then there's no need to check for p->sup_pclk in sh_mmcif_clock_control() because if (clk == host->clk) then p->sup_pclk can be assumed to be set.

-	if (p->sup_pclk && clk == host->clk)
+	if (clk == host->clk)
		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
	else
		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
				((fls(DIV_ROUND_UP(host->clk,
						   clk) - 1) - 1) << 16));


But, that's probably more along the lines of driver cleanup I guess.

-Chris


-----Original Message-----
From: Simon Horman [mailto:horms@verge.net.au] 
Sent: Wednesday, June 20, 2012 8:48 PM
To: Brandt, Chris
Cc: Guennadi Liakhovetski; linux-mmc@vger.kernel.org; linux-sh@vger.kernel.org; Chris Ball; Magnus Damm
Subject: Re: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic

On Wed, Jun 20, 2012 at 07:56:44AM -0700, Brandt, Chris wrote:
> > I would be very happy if someone with access to
> > the documentation could shed some further light on this.
> 
> According to the SH7757 manual, setting the CLKDIV[3:0] in the CE_CLK_CTRL register 0xF selects Pck as the bus clock frequency. So, unlike other devices where Pck/2 (CLKDIV[3:0]=0) is the max bus speed, the SH7757 can run at Pck when CLKDIV=0xF.

Thanks Chris,

please correct me if I am wrong, but that seems to indicate the heuristic
is correct. At least for the sh7757 and sh7372.
