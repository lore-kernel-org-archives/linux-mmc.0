From: Nicolas Pitre <nico@cam.org>
Subject: Re: BUG? a suspected race bug at sdio_irq_thread()
Date: Mon, 07 Sep 2009 22:30:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909072217160.6044@xanadu.home>
References: <2014bcab0909022048n2c937af4l5bd38c501469b1c7@mail.gmail.com>
 <2014bcab0909070315j67c5db31gff6bc70f0b6369a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_d7N3xyKGBqBDVaaMS36Pew)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:23201 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbZIHCbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2009 22:31:03 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPM00BLYSB2GH81@VL-MH-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 07 Sep 2009 22:30:38 -0400 (EDT)
In-reply-to: <2014bcab0909070315j67c5db31gff6bc70f0b6369a5@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?EUC-KR?Q?=C8=AB=BD=C5_shin_hong?= <hongshin@gmail.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_d7N3xyKGBqBDVaaMS36Pew)
Content-type: TEXT/PLAIN; charset=EUC-KR
Content-transfer-encoding: 8BIT

On Mon, 7 Sep 2009, È«½Å shin hong wrote:

> sdio_irq_therad() is spawned as a sdio_card_irq_get().
> This thread is stopped by sdio_card_irq_put().
> 
> sdio_irq_thread() finishes its do-while iteration
> when kthread_should_stop() returns true
> or a condition is satisfied (break statements at line 106)
> 
> For the later case, if sdio_irq_thread() is finished
> before kthread_should_stop() returns false.
> 
> In that situation, if other thread invokes kthread_stop(),
> the caller of kthread_stop() might have a problem (waiting indefinitely).

No.

First of all, you get one instance of sdio_irq_thread() for each card.  
And if a card has multiple functions, then multiple sdio_card_irq_get() 
and sdio_card_irq_put() are expected, and they should be balanced as 
well.

So, when the last user of SDIO card interrupt calls sdio_card_irq_put(), 
then kthread_stop() is called on the IRQ thread, meaning that the 
kthread_should_stop condition is made true and the thread awakened, and 
then its termination is waited for.  If the thread terminated itself 
then there is simply no waiting to do.


Nicolas

--Boundary_(ID_d7N3xyKGBqBDVaaMS36Pew)--
