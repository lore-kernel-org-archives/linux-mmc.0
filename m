From: Attila Kinali <attila@kinali.ch>
Subject: Re: mmc: mxs: DEADLOCK
Date: Mon, 16 Jul 2012 14:07:20 +0200
Message-ID: <20120716140720.4af66a1b45375bc6b83dc986@kinali.ch>
References: <4FFC367A.8020100@bluegiga.com>
	<20120711060607.GE14060@S2101-09.ap.freescale.net>
	<20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
	<5003AD52.7070304@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.opencsw.org ([82.220.5.51]:51687 "EHLO mail.opencsw.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2GPMHW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Jul 2012 08:07:22 -0400
In-Reply-To: <5003AD52.7070304@bluegiga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Marek Vasut <marex@denx.de>, Koen Beel <koen.beel@barco.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Moin, Lauri,

On Mon, 16 Jul 2012 08:57:38 +0300
Lauri Hintsala <lauri.hintsala@bluegiga.com> wrote:

> 
> 
> Does this patch fix your issue?

A preliminary test shows that it at least fixes the oops at module loading.
I haven't had the chance yet to give it a full test, but i would say it
fixes it enough to be workable.

Thanks a lot!

			Attila Kinali



-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
