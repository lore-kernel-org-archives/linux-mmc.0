From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/11] Sort out sdio_uart - stage two
Date: Tue, 03 Nov 2009 14:58:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911031401170.13333@xanadu.home>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:59071 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZKCT6G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 14:58:06 -0500
In-reply-to: <20091103141525.31032.45206.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Tue, 3 Nov 2009, Alan Cox wrote:

> With the bugs Nicolas reported hopefully now nailed.

Progress, but still not there yet.

I'm still using the same "cat /dev/ttySDIO0" test with a GPS card.

Yanking the card out does terminate the cat process properly.  Inserting 
the card back in and restarting cat always fails with:

	cat: /dev/ttySDIO0: Input/output error

The same thing occurs if I terminate cat with ^C instead of pulling the 
card out.

>From what I can see, sdio_uart_open() and sdio_uart_activate() are 
called on the first cat invocation, and then sdio_uart_close() and 
sdio_uart_shutdown() when cat is stopped with ^C.  However neither 
sdio_uart_open() nor sdio_uart_activate() is ever called anymore with 
any subsequent cat invocations until a reboot.  Some upper layer must 
have taken upon itself to return -EIO to user space.


Nicolas
