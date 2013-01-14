From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH/RFC] mmc: sh-mmcif: simplify IRQ processing
Date: Mon, 14 Jan 2013 14:17:44 -0500
Message-ID: <87hamjtvzb.fsf@laptop.org>
References: <Pine.LNX.4.64.1212121540250.10522@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57757 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410Ab3ANTR6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:17:58 -0500
In-Reply-To: <Pine.LNX.4.64.1212121540250.10522@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 12 Dec 2012 15:45:14 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Wed, Dec 12 2012, Guennadi Liakhovetski wrote:
> The classical way to process IRQs is read out the status, ack all triggered
> IRQs, possibly mask them, then process them. Follow this simple procesure
> instead of the current complex custom algorithm.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Hi Chris
>
> Attention: this patch is __NOT__ for 3.8, please, let it simmer in -next 
> until 3.9. It modifies the driver's interrupt handling significantly, so, 
> we want to have it tested over a longer period.

Sorry for the delay, this is in mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
