From: Philip Langdale <philipl@overt.org>
Subject: Re: + ricoh_mmc-port-from-driver-to-pci-quirk-update.patch added to
 -mm tree
Date: Mon, 1 Feb 2010 13:01:44 -0800
Message-ID: <20100201130144.0da55d56@fido2.homeip.net>
References: <201002012024.o11KObAY010344@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:55551 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab0BAVB5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Feb 2010 16:01:57 -0500
In-Reply-To: <201002012024.o11KObAY010344@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, maximlevitsky@gmail.com, linux-mmc@vger.kernel.org, w.sang@pengutronix.de

On Mon, 01 Feb 2010 12:24:37 -0800
akpm@linux-foundation.org wrote:

> 
> The patch titled
>      ricoh_mmc-port-from-driver-to-pci-quirk-update
> has been added to the -mm tree.  Its filename is
>      ricoh_mmc-port-from-driver-to-pci-quirk-update.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your
> code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at
> http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: ricoh_mmc-port-from-driver-to-pci-quirk-update
> From: Maxim Levitsky <maximlevitsky@gmail.com>
> 
> This patch solves nasty problem original driver had.
> Original goal of the ricoh_mmc, was to disable this device because
> then, mmc cards can be read using standard SDHCI controller,
> thus avoiding the need in yet another driver.
> However, the act of disablement, makes other pci functions that
> belong to this controller (xD and memstick) shift up one level, thus
> pci core has now wrong idea about these devices.
> 
> To fix this issue, this patch moves the driver into pci quirk
> section, thus it is executed before the pci is enumerated, and
> therefore solve that issue, also the same is preformed on resume for
> same reasons.
> 
> Also regardless of the above, this way is cleaner.
> 
> You still need to set CONFIG_MMC_RICOH_MMC
> to enable this quirk
> 
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Philip Langdale <philipl@overt.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Philip Langdale <philipl@overt.org>

--phil
