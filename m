From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Sun, 04 Aug 2013 18:10:39 +0400
Message-ID: <51FE60DF.400@cogentembedded.com>
References: <201308030233.29446.sergei.shtylyov@cogentembedded.com> <Pine.LNX.4.64.1308040026020.11632@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:53265 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab3HDOKo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Aug 2013 10:10:44 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so1469774lbf.32
        for <linux-mmc@vger.kernel.org>; Sun, 04 Aug 2013 07:10:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1308040026020.11632@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, cjb@laptop.org, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

Hello.

On 04-08-2013 2:36, Guennadi Liakhovetski wrote:

>> I'm testing SH-Mobile SDHI driver in DMA mode with  a new DMA controller  using
>> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
>> to PIO but all commands time out after that.  It turned out that the fallback
>> code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
>> to them cleared, so that the function bails out early instead  of clearing the
>> DMA bit in the CTL_DMA_ENABLE register. The regression was introduced by commit
>> 162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock).
>> Moving tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
>> tmio_mmc_start_dma_{rx|tx}() helps.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: stable@vger.kernel.org # 3.1+

> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> Not sure though how far back in stable this really has to go. We don't
> have any real-life problem reports with older kernels, do we?

    If we did, that error would have been fixed earlier, wouldn't it?

> I think
> approach to which patches should get into stable changed recently.

    Haven't heard about that (or seen any change in the policy). The issue 
with this bug is its catastrophic consequencies: you can hardly ^C or ^Z out 
of 'bonnie++' when it happens (in fact, you cannot ^C at all). IIRC you can't 
even kill it from another shell.

> Thanks
> Guennadi

WBR, Sergei

