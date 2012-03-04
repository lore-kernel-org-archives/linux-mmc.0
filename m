From: Chanho Park <chanho61.park@samsung.com>
Subject: RE: [PATCH] mmc: core: remove waiting time when clkgate_delay is set
Date: Mon, 05 Mar 2012 08:39:35 +0900
Message-ID: <015201ccfa60$0e72c9f0$2b585dd0$@samsung.com>
References: <1330494769-7558-1-git-send-email-chanho61.park@samsung.com>
 <m2aa3yn1vw.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48277 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab2CDXjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Mar 2012 18:39:37 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0D00I80WDX2T30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Mar 2012 08:39:35 +0900 (KST)
Received: from DOCHANHO61P01 ([10.254.103.57])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0M0D00MQCWDZBS20@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Mon, 05 Mar 2012 08:39:35 +0900 (KST)
In-reply-to: <m2aa3yn1vw.fsf@bob.laptop.org>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>

Hi,

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Saturday, March 03, 2012 6:12 AM
> To: Chanho Park
> Cc: linux-mmc@vger.kernel.org; Kyungmin Park; Guennadi Liakhovetski
> Subject: Re: [PATCH] mmc: core: remove waiting time when clkgate_delay is
> set
> 
> Hi,
> 
> On Wed, Feb 29 2012, Chanho Park wrote:
> > Since recent commit("mmc: core: Use delayed work in clock gating
> > framework":597dd9d79cfbbb1), we always wait "unnecessary" default
> > clock delay(8 cycles). Actually, we don't need it if clkgate_delay
> > (unit:ms) is set because we already wait sufficient time to change the
> > clock due to delayed_workqueue.
> > This patch removes duplicated waiting time when clkgate_delay is set.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/core/host.c |    7 +++++--
> >  1 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > c3704e2..d710ce0 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -109,8 +109,11 @@ static void mmc_host_clk_gate_delayed(struct
> mmc_host *host)
> >  	 */
> >  	if (!host->clk_requests) {
> >  		spin_unlock_irqrestore(&host->clk_lock, flags);
> > -		tick_ns = DIV_ROUND_UP(1000000000, freq);
> > -		ndelay(host->clk_delay * tick_ns);
> > +		/* wait only when clk_gate_delay is 0*/
> > +		if (!host->clkgate_delay) {
> > +			tick_ns = DIV_ROUND_UP(1000000000, freq);
> > +			ndelay(host->clk_delay * tick_ns);
> > +		}
> >  	} else {
> >  		/* New users appeared while waiting for this work */
> >  		spin_unlock_irqrestore(&host->clk_lock, flags);
> 
> Have you seen Guennadi's patch?
> 
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=63871
> af54a0f0053de6534afe8da101b988b86b6

I'd already seen the patch. There is no problem if a user didn't set a clkgate_delay.
However, if he wants to set a "clkgate_delay", a "clk_delay" is no longer needed.
Because, clk_delay(basically 8 cycles) always fall within "clkgate_delay".
I remove this "duplicated" wait.

Best regards,
Chanho Park

> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

