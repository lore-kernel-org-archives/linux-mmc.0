From: "Brandt, Chris" <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Date: Wed, 20 Jun 2012 07:56:44 -0700
Message-ID: <A389CA2909F7E548A28A6A30A9446C0903651FAAD5@REAMBX.NA.RTA>
References: <1340171905-12534-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1206200845590.20254@axis700.grange>
 <20120620070227.GN20030@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:36811 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab2FTO5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 10:57:16 -0400
In-reply-to: <20120620070227.GN20030@verge.net.au>
Content-language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

> I would be very happy if someone with access to
> the documentation could shed some further light on this.

According to the SH7757 manual, setting the CLKDIV[3:0] in the CE_CLK_CTRL register 0xF selects Pck as the bus clock frequency. So, unlike other devices where Pck/2 (CLKDIV[3:0]=0) is the max bus speed, the SH7757 can run at Pck when CLKDIV=0xF.

- Chris


-----Original Message-----
From: linux-sh-owner@vger.kernel.org [mailto:linux-sh-owner@vger.kernel.org] On Behalf Of Simon Horman
Sent: Wednesday, June 20, 2012 3:02 AM
To: Guennadi Liakhovetski
Cc: linux-mmc@vger.kernel.org; linux-sh@vger.kernel.org; Chris Ball; Magnus Damm
Subject: Re: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic

On Wed, Jun 20, 2012 at 08:49:38AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> Thanks for addressing this issue.
> 
> On Wed, 20 Jun 2012, Simon Horman wrote:
> 
> > In 930f152cc9998388031af577843baae572ac8ab6 ("mmc: sh_mmcif: mmc->f_max
> > should be half of the bus clock") I changed the setting of mmc->f_max from
> > the bus clock to half the bus clock based on the manual for the sh7372 SoC.
> > 
> > Inspection of sh_mmcif_clock_control() reveals that it relies on
> > mmc->f_max being set to the bus speed in order to enable the supplementary
> > clock, a feature that does not exist on the sh7372.
> > 
> > Armed with this information implement the following heuristic for setting
> > mmc->f_max:
> > 
> > * Use bus clock if the supplementary clock feature is present
> >   - Assumed to work on the sh7757lcr board, the only board present
> >     in the tree which has the feature.
> 
> To be able to better understand this change: do we have access to the 
> sh7757 documentation and does it actually explain how the CLK_SUP_PCLK bit 
> in MMCIF_CE_CLK_CTRL functions? Does it actually set the MMC bus clock to 
> be equal to the host clock?

My understanding is that neither Magnus nor I have access to the
documentation for the sh7757. Thus we could only infer things from
examining the source code. I would be very happy if someone with access to
the documentation could shed some further light on this. In particular,
I would be happy if this heuristic was shown not to be necessary. But
in lieu of access to the documentation I think this patch is reasonable.

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
