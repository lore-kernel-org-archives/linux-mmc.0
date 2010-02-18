From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 10:43:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com> <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com> <4B7D3EAE.1010908@csr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42143 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578Ab0BRRn6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2010 12:43:58 -0500
In-Reply-To: <4B7D3EAE.1010908@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 18 Feb 2010, David Vrabel wrote:

> Paul Walmsley wrote:
> > 
> > Perhaps I'm misunderstanding what you're referring to, but it seems there 
> > is some confusion as to what target smart-idle mode does.
> 
> The TI OMAP 34xx TRM is the one of the most obtuse document I've had to
> read.  An even after multiple reads of relevant sections it still
> doesn't make sense.  Parts are contradictory, parts are poorly explained
> and some bit are just plain incorrect.

Yes.  TI needs to also release the functional specifications for each IP 
block; the information in the current TRM is generally insufficient to 
write high-quality drivers.

TI should also host a process, open to the public, to submit TRM revision 
and clarification requests, and to track their disposition.

> I don't have time to sort out any of this properly -- it works well
> enough for me.

Thanks very much for the SDIO patches.  They are appreciated.


- Paul
