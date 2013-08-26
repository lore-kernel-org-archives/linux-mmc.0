From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
 system transaction
Date: Mon, 26 Aug 2013 11:36:43 -0500
Message-ID: <1377535003.3033.6.camel@snotra.buserror.net>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
	  <99E897753B6F7048BD8CCDB4661D02E13DF52C@039-SN2MPN1-022.039d.mgd.msft.net>
	  <521703AB.8030702@freescale.com>
	 <1377272410.20722.46.camel@snotra.buserror.net>
	 <521AA947.6080209@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:52032
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269Ab3HZQgv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2013 12:36:51 -0400
In-Reply-To: <521AA947.6080209@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun <B42677@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Wood Scott-B07421 <B07421@freescale.com>, Xie Xiaobo-R63061 <X.Xie@freescale.com>

On Mon, 2013-08-26 at 09:03 +0800, Zhang Haijun wrote:
> On 08/23/2013 11:40 PM, Scott Wood wrote:
> 
> > On Fri, 2013-08-23 at 14:39 +0800, Zhang Haijun wrote:
> > > Hi, Anton and all
> > > 
> > > Is there any advice on these two patches ?
> > > 
> > > [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last system 
> > > transaction
> > > [PATCH 3/4 V3] mmc: esdhc: Correct host version of T4240-R1.0-R2.0.
> > > 
> > > 
> > > [PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type detection
> > > This patch is Act-by Scott.
> > > Patch 4/4 is split to four patches and Act-by Anton.
> > > 
> > > 
> > > Thanks all.
> > > 
> > > 
> > > 
> > [snip]
> > > > > +	if (!(((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) == 0x10))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_REV(svr) == 0x10))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P1010) && (SVR_REV(svr) == 0x10))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P3041) && (SVR_REV(svr) <= 0x20))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P2041) && (SVR_REV(svr) <= 0x20))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P5040) && SVR_REV(svr) == 0x20)))
> > > > > +		return;
> > You need to include variants here.  If P5040 is affected, then P5021 is
> > affected.  If P2041 is affected, then P2040 is affected, etc.
> > 
> > -Scott
> > 
> > 
> Hi, Scott
> 
> This workaround is for CR:ENGR00229586: A-005055, Configs Affected
> only list these soc and its version.
> I was also wonder why only these boards?
> 
> But I can't add soc like P5021 as I think it should be. Maybe there
> are some difference between them.

The only difference between P5040 and P5021 is the number of cores
enabled.  It is physically the same silicon.  Likewise with a lot of
other variants.

-Scott



