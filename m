From: Chris Ball <cjb@laptop.org>
Subject: Re: my outstanding patches for 3.12
Date: Sun, 25 Aug 2013 00:13:08 -0400
Message-ID: <87y57qpfvv.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1308091507450.937@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37809 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab3HYENM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Aug 2013 00:13:12 -0400
In-Reply-To: <Pine.LNX.4.64.1308091507450.937@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 9 Aug 2013 15:30:48 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi,

On Fri, Aug 09 2013, Guennadi Liakhovetski wrote:
> Hi Chris
>
> There are still a number of MMC patches from me for 3.12, that still 
> aren't in next. Unless I'm missing anything, here's the list of patches 
> with their respective patchwork IDs:
>
> mmc: SDHI: add DT compatibility strings for further SoCs
> pw ID: 2828382
>
> mmc: sh_mmcif: move header include from header into .c
> pw ID: 2837887
>
> mmc: sh_mmcif: add support for Device Tree DMA bindings
> pw ID: 2770781
>
> mmc: sh_mmcif: revision-specific Command Completion Signal handling
> pw ID: 2825876
>
> mmc: sh_mmcif: revision-specific CLK_CTRL2 handling
> pw ID: 2825870

These are all in mmc-next for 3.12 now.  Thanks for the reminder!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
