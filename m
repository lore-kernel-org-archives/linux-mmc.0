From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 13/20] mmc: avoid getting CID on SDIO-only cards
Date: Thu, 19 Aug 2010 15:57:05 -0700
Message-ID: <20100819155705.0d8f91c0.akpm@linux-foundation.org>
References: <201008192113.o7JLDaGh008701@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59855 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751283Ab0HSW5M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2010 18:57:12 -0400
In-Reply-To: <201008192113.o7JLDaGh008701@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org, david.vrabel@csr.com, linux-mmc@vger.kernel.org, mirq-linux@rere.qmqm.pl

On Thu, 19 Aug 2010 14:13:36 -0700
akpm@linux-foundation.org wrote:

> From: David Vrabel <david.vrabel@csr.com>
> 
> The introduction of support for SD combo cards breaks the initialization
> of all CSR SDIO chips.  The GO_IDLE (CMD0) in mmc_sd_get_cid() causes CSR
> chips to be reset (this is non-standard behavior).
> 
> When initializing an SDIO card check for a combo card by using the memory
> present bit in the R4 response to IO_SEND_OP_COND (CMD5).  This avoids the
> call to mmc_sd_get_cid() on an SDIO-only card.
> 

argh, crap, sorry, please drop this one - Michal found a bug in it.
