From: Chris Ball <cjb@laptop.org>
Subject: Re: outstanding tmio patches
Date: Fri, 25 Mar 2011 10:01:44 -0400
Message-ID: <m3mxkjl2nr.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
	<m3k4folztx.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56474 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab1CYOFV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Mar 2011 10:05:21 -0400
In-Reply-To: <m3k4folztx.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 24 Mar 2011 22:05:14 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

Hi Guennadi,

On Thu, Mar 24 2011, Chris Ball wrote:
>> [1/2] mmc: tmio: Improve DMA stability on sh-mobile
>> [2/2] mmc: tmio: use PIO for short transfers

Thanks, these two are applied now.

>> [1/6,v2] mmc: tmio: split core functionality, DMA and MFD glue

But now we have a merge conflict here, since we just changed the
codebase that this patch moves around.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
