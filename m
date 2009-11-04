From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/11] Sort out sdio_uart - stage two
Date: Wed, 4 Nov 2009 00:54:32 +0000
Message-ID: <20091104005432.3cdc924f@lxorguk.ukuu.org.uk>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
	<alpine.LFD.2.00.0911031401170.13333@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51284 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751006AbZKDAwr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 19:52:47 -0500
In-Reply-To: <alpine.LFD.2.00.0911031401170.13333@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Alan Cox <alan@linux.intel.com>, linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

> >From what I can see, sdio_uart_open() and sdio_uart_activate() are 
> called on the first cat invocation, and then sdio_uart_close() and 
> sdio_uart_shutdown() when cat is stopped with ^C.  However neither 

I would have expected the cat to terminate when the port is unplugged
(and the uart remove method called - doing a hangup)

> sdio_uart_open() nor sdio_uart_activate() is ever called anymore with 
> any subsequent cat invocations until a reboot.  Some upper layer must 
> have taken upon itself to return -EIO to user space.

The first call into the driver is to sdio_uart_install which looks up the
port from tty->index and would blow up if for some reason the get method
failed.

Still digging.
