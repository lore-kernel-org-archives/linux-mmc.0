From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 11:03:30 -0600
Message-ID: <001901cab0bc$4bf61880$544ff780@am.dhcp.ti.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com> <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com> <001b01cab031$0f34e010$544ff780@am.dhcp.ti.com> <4B7D2F72.2070307@csr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34134 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758720Ab0BRRD4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Feb 2010 12:03:56 -0500
In-Reply-To: <4B7D2F72.2070307@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'David Vrabel' <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: David Vrabel [mailto:david.vrabel@csr.com]
> Sent: Thursday, February 18, 2010 6:16 AM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
> 
> Madhusudhan wrote:
> >
> > My question was more related to the idle path. In a scenario where
> > you start using the SDIO functionality and after some time you leave
> > the SDIO card idle, does the FCLK still remain enabled? Or do you see
> > that sdio_irq_thread exits and disables the FCLK?
> 
> What do you mean by "leave the SDIO card idle"?
> 

I meant a state where the SDIO card is not doing any active transfers. Does
it work that way?

Regards,
Madhu

> David
> --
> David Vrabel, Senior Software Engineer, Drivers
> CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
> Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England
> and Wales, registered number 4187346, registered office Churchill House,
> Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom

