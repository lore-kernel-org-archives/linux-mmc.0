From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V7] mxc : Add i.MX21 support to mxcmmc driver
Date: Fri, 27 Aug 2010 20:14:22 +0100
Message-ID: <20100827191421.GG20407@void.printf.net>
References: <20100213153617.21144.68460.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53306 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab0H0TOY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:14:24 -0400
Content-Disposition: inline
In-Reply-To: <20100213153617.21144.68460.stgit@srv002.fuzzey.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Fuzzey <mfuzzey@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>

Hi Martin,

On Sat, Feb 13, 2010 at 04:36:32PM +0100, Martin Fuzzey wrote:
> Even though the i.MX21 SDHC module has the same revision number as the i.MX27
> one there are a few differences!!
>         Some interrupt enables are inverted.
>         FIFO is only 16 bits wide.
>         The argument is written to 2x16bit registers (vs 1x32).
>         Interrupts must be acknowledged via the INT_CNTR register.
>         Card clock must be enabled for each request.
> 	For writes DMA must be enabled on command response not before.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>
> 
> ---
> Changes from V6 (April 2009):
> Minor stylistic changes suggested by Robby Cai:
>         factorize enables in mxcmci_set_int_cntr()
>         remove redundant local variable in mxcmci_push() and mxcmci_pull()
> Rebased to 2.6.33-rc8

Looks like this wasn't merged.  Are you interested in resubmitting it?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
