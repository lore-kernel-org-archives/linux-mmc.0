From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: Question: kick SDIO irq when resume
Date: Mon, 31 Oct 2011 08:39:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110310824120.3307@xanadu.home>
References: <CAGA24MKE-FLRBk2zHk_Wy2Apg8-epC6Q38W2csTs7YSN1gHzhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62307 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934434Ab1JaMjb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 08:39:31 -0400
Received: by vcge1 with SMTP id e1so4695616vcg.19
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2011 05:39:30 -0700 (PDT)
In-Reply-To: <CAGA24MKE-FLRBk2zHk_Wy2Apg8-epC6Q38W2csTs7YSN1gHzhg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <niej0001@gmail.com>
Cc: Bing Zhao <bzhao@marvell.com>, frankh@marvell.com, yongd@marvell.com, tianfh@marvell.com, njun@marvell.com, linux-mmc@vger.kernel.org

On Mon, 31 Oct 2011, Jun Nie wrote:

> Hi Nico,
>     We are debugging fake SDIO irq when 8787 SDIO card resume and
> found below patch. The issue is that 8787 driver can not handle card
> irq if neither 8787 nor host trigger resume event in some cases. Do
> you remember what SDIO card need below patch? What's your idea on this
> issue? How about add a SDIO function flag to decide the irq thread
> kick off in resume?

This is needed because in some cases the card interrupt is already 
consumed for the wake-up event.  Kicking this thread shouldn't cause any 
issue though, as the card is just polled for the actual presence of an 
IRQ ...

... or maybe not.  In this case commit 06e8935feb "optimized SDIO IRQ 
handling for single irq" may certainly cause problems.

The fix here would be to clear card->sdio_single_irq before calling 
mmc_signal_sdio_irq() in mmc_sdio_resume() and restore its original 
value eventually, or better yet ignore that flag when the IRQ thread is 
ran for the first time after a resume.

In any case you may disable that optimization in the IRQ demux handler 
to see if this fixes your problem.


Nicolas
