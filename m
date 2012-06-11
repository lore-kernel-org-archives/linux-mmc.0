From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Mon, 11 Jun 2012 14:06:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206111402250.29799@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com> <20120518085749.GE24355@linux-sh.org>
 <20120518150417.GA4039@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1206111332310.29799@axis700.grange>
 <20120611115131.GM11439@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab2FKMGg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 08:06:36 -0400
In-Reply-To: <20120611115131.GM11439@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, 11 Jun 2012, Mark Brown wrote:

> On Mon, Jun 11, 2012 at 01:38:13PM +0200, Guennadi Liakhovetski wrote:
> > On Fri, 18 May 2012, Mark Brown wrote:
> 
> > > This is checking the value of regulator_get(), NULL is a perfectly valid
> > > regulator value to get passed back.
> 
> > Sorry, could you clarify, how it is valid? No, I'm not proposing to revive 
> > this patch, just curious, what exactly you meant by this. AFAICS NULL is 
> > never returned from regulator_get(). The value, that's returned by it is 
> > then directly dereferenced in other regulator API calls, for which you 
> > don't normally want a NULL. So, having a regulator pointer == NULL seems 
> > to be as valid to me as causing a BUG() is? :-)
> 
> The stubs return NULL and we could decide in future to use NULL for
> something else (though that seems unlikely).

Ah, sure, forgot about that, sorry. In fact, I was wondering, whether it's 
indeed a good idea to return success from functions like 
regulator_set_voltage() or regulator_get_voltage() when regulator is even 
not configured? Isn't it confusing for drivers to get a success from 
set_voltage(voltage > 0) and then get 0V back from get_voltage()?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
