From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Tue, 07 Dec 2010 23:11:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012072305370.10437@xanadu.home>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
 <AANLkTinPbGcxOU8w_Wy3YVe-QOYpmQm+K7sgRHd-K2vp@mail.gmail.com>
 <D5829CF2-04F6-4FDD-A909-B18D41845FCA@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:42511 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0LHELF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 23:11:05 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LD300AH1CY2JP60@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 07 Dec 2010 23:10:50 -0500 (EST)
In-reply-to: <D5829CF2-04F6-4FDD-A909-B18D41845FCA@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 7 Dec 2010, Philip Rakity wrote:

> 
> On Dec 5, 2010, at 6:15 AM, Ohad Ben-Cohen wrote:
> 
> > That would obviously work but as you and Nicolas mentioned it's an
> > overkill: we don't really need random users to plug into this hook,
> > and using notifiers will just make the code less readable and harder
> > to debug, so it's better to try to find a solution that fits.
> 
> Would a solution toggling the  gpio line for power/reset work when doing a RESET_ALL or
> when power moves to off ?  This code could then be in the driver specific section where
> this might make more sense.

The problem is to find a good enough abstraction to keep the driver 
generic without cluttering it with platform specific implementation 
details such as which GPIO (if at all) should be flipped to reset the 
card.  Hence the idea to (ab)use the already existing regulator 
framework which can accommodate and abstract such details away quite 
nicely.


Nicolas
