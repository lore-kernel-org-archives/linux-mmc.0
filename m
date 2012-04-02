From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 3/3] mmc: atmel-mci: add support for odd clock dividers
Date: Mon, 2 Apr 2012 08:52:46 +0200
Message-ID: <20120402065246.GC3082@ldesroches-Latitude-E6320>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
 <1332344483-3915-4-git-send-email-ludovic.desroches@atmel.com>
 <4F6B3BD0.4060702@atmel.com>
 <87mx6wm7yu.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:40561 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2DBGxA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 02:53:00 -0400
Content-Disposition: inline
In-Reply-To: <87mx6wm7yu.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com

Hi Chris,

On Sat, Mar 31, 2012 at 11:44:41PM -0400, Chris Ball wrote:
> Hi,
> 
> On Thu, Mar 22 2012, Nicolas Ferre wrote:
> > On 03/21/2012 04:41 PM, ludovic.desroches@atmel.com :
> >> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >> 
> >> Add an odd clock divider capability available from v5xx. It also involves
> >> changing the clock divider calculation.
> >
> > Also tell here that you have changed the way that the switch/case
> > directive has been implemented.
> >
> >> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> > Otherwise:
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks, pushed to mmc-next for 3.4 with a rewording:
> 
>     Add an odd clock divider capability available from v5xx. It also involves
>     changing the clock divider calculation, and changing the switch-case
>     statement to use top-down fallthrough.
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

Thanks for rewording the commit message.


Regards

Ludovic
