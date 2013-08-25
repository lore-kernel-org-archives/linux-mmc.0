From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Sat, 24 Aug 2013 23:39:35 -0400
Message-ID: <87zjs6qw08.fsf@octavius.laptop.org>
References: <201308030233.29446.sergei.shtylyov@cogentembedded.com>
	<Pine.LNX.4.64.1308040026020.11632@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48369 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab3HYDjk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:39:40 -0400
In-Reply-To: <Pine.LNX.4.64.1308040026020.11632@axis700.grange> (Guennadi
	Liakhovetski's message of "Sun, 4 Aug 2013 00:36:50 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

Hi,

On Sat, Aug 03 2013, Guennadi Liakhovetski wrote:
> On Sat, 3 Aug 2013, Sergei Shtylyov wrote:
>
>> I'm testing SH-Mobile SDHI driver in DMA mode with a new DMA
>> controller using
>> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code
>> falls back
>> to PIO but all commands time out after that.  It turned out that the fallback
>> code calls tmio_mmc_enable_dma() with RX/TX channels already freed
>> and pointers
>> to them cleared, so that the function bails out early instead  of clearing the
>> DMA bit in the CTL_DMA_ENABLE register. The regression was
>> introduced by commit
>> 162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock).
>> Moving tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
>> tmio_mmc_start_dma_{rx|tx}() helps.
>> 
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: stable@vger.kernel.org # 3.1+
>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
