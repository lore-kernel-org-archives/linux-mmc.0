From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] Port ricoh_mmc to pci quirk
Date: Mon, 01 Feb 2010 17:45:47 +0200
Message-ID: <1265039147.3785.9.camel@maxim-laptop>
References: <1264772255.4620.3.camel@maxim-laptop>
	 <1264886914-30179-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:61144 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0BAPpx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2010 10:45:53 -0500
In-Reply-To: <1264886914-30179-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Philip Langdale <philipl@overt.org>, Pierre Ossman <pierre@ossman.eu>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

On Sat, 2010-01-30 at 23:28 +0200, Maxim Levitsky wrote: 
> This patch solves nasty problem original driver had.
> Original goal of the ricoh_mmc, was to disable this device because
> then, mmc cards can be read using standard SDHCI controller,
> thus avoiding the need in yet another driver.
> However, the act of disablement, makes other pci functions that belong to
> this controller (xD and memstick) shift up one level, thus pci core has now wrong idea
> about these devices.
> 
> To fix this issue, this patch moves the driver into pci quirk section, thus it
> is executed before the pci is enumerated, and therefore solve that issue,
> also the same is preformed on resume for same reasons.
> 
> Also regardless of the above, this way is cleaner.
You probably didn't notice that patch, because I used git-send-email,
and forgot to set subject properly.
This meant to be next version of this patch.

Best regards,
Maxim Levitsky

