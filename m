From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mmcif: remove unneeded clock connection ID
Date: Mon, 03 Dec 2012 14:24:57 -0500
Message-ID: <87d2yrhrau.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1211281006340.1710@axis700.grange>
	<20121130090224.GG4501@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56613 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab2LCTZC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:25:02 -0500
In-Reply-To: <20121130090224.GG4501@verge.net.au> (Simon Horman's message of
	"Fri, 30 Nov 2012 18:02:24 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Fri, Nov 30 2012, Simon Horman wrote:
> On Wed, Nov 28, 2012 at 10:24:27AM +0100, Guennadi Liakhovetski wrote:
>> MMCIF only uses one clock, all ARM and SuperH platforms register MMCIF
>> clock lookup entries with no connection ID, hence it can be dropped in
>> the driver too.
>> 
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
