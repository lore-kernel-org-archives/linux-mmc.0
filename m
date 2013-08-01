From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Fri, 02 Aug 2013 01:26:06 +0400
Message-ID: <51FAD26E.2020704@cogentembedded.com>
References: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44336 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab3HAV0C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 17:26:02 -0400
Received: by mail-la0-f50.google.com with SMTP id fn20so1783364lab.37
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2013 14:26:00 -0700 (PDT)
In-Reply-To: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, cjb@laptop.org
Cc: linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

Hello.

On 08/02/2013 01:17 AM, Sergei Shtylyov wrote:

> I'm testing SH-Mobile SDHI driver in DMA mode with a  new DMA controller  using
> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
> to PIO but all commands time out after that.  It turned out that the fallback
> code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
> to them cleared, so that the function bails out early instead  of clearing the
> DMA bit in the CTL_DMA_ENABLE register.  Fixing the RX/TX channel check so that
> it takes place only when enabling DMA helps with the PIO fallback.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Forgot to mark the patch for stable. The bug was introduced by commit 
162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock) back in 
2011 -- should probably have mentioned that in the changelog too.

WBR, Sergei

