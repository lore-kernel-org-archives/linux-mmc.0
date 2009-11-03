From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/6] Clean up the sdio_uart driver and fix the tty code
Date: Tue, 03 Nov 2009 13:58:56 +0000
Message-ID: <4AF03720.5070506@csr.com>
References: <20091102164039.11877.88825.stgit@localhost.localdomain>	<alpine.LFD.2.00.0911021243040.13333@xanadu.home>	<20091102191604.010acbc9@lxorguk.ukuu.org.uk>	<alpine.LFD.2.00.0911021542520.13333@xanadu.home> <20091103120618.26b669be@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:55038 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbZKCOAE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 09:00:04 -0500
In-Reply-To: <20091103120618.26b669be@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Alan Cox <alan@linux.intel.com>, linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, dhowells@redhat.com

Alan Cox wrote:
> 
> The claim method takes the mutex, checks if it is NULL and acts
> accordingly but it releases the mutex, which makes it useless as the code
> then uses port->func. If I move the release of the mutex to the
> release_func method then that fixes almost all cases.
> 
> The one I'm stuck on is this
> 
> 
> 		CPU1				CPU2
> 
> 
> 	sdio_uart_irq
> 					sdio_uart_port_remove
> 					port->func = NULL;
> 	sdio_in
> 	BUG_ON

This is actually happening?  sdio_claim_host()/sdio_release_host() act
like a mutex so sdio_uart_port_remove() will wait in sdio_claim_host()
until sdio_uart_irq() returns (SDIO interrupt handlers are called with
the host claimed).

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
