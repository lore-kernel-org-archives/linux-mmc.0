From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 17:37:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010121732370.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
 <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
 <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
 <alpine.LFD.2.00.1010112036540.2764@xanadu.home>
 <AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
 <alpine.LFD.2.00.1010121341490.2764@xanadu.home>
 <AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
 <alpine.LFD.2.00.1010121410150.2764@xanadu.home>
 <AANLkTi=K76xLSjMfYBn9VdhtaDjgP0DruPNhcAqZiq6D@mail.gmail.com>
 <alpine.LFD.2.00.1010121535460.2764@xanadu.home>
 <AANLkTi=ehRGN1QMD5pNFfChHUhp=oAbOueH9v+19GXcb@mail.gmail.com>
 <alpine.LFD.2.00.1010121630260.2764@xanadu.home>
 <AANLkTik1PPHgbvSEab6VQXUbCJrO91vgec6yb7+fWbBh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_mSRfEif4Y7+TxYfjqL5ycA)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:9031 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0JLVh7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 17:37:59 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA700DTR5FAB110@VL-MO-MR004.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 12 Oct 2010 17:37:58 -0400 (EDT)
In-reply-to: <AANLkTik1PPHgbvSEab6VQXUbCJrO91vgec6yb7+fWbBh@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_mSRfEif4Y7+TxYfjqL5ycA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 12 Oct 2010, Dmitry Shmidt wrote:

> > Please tell us more about the problem you are trying to solve, and in
> > what ways the current infrastructure is not achieving that goal.  Then
> > we might be in a better position to propose suggestions.
> >
> > But selectively ignoring upper suspend requests certainly feels wrong to
> > me.  If you need this, then the actual problem must be somewhere else.
> >
> > Nicolas
> 
> Let's assume we are talking about device that is not a laptop - and it
> is very power-consumption sensitive. Like smartphone...
> So you want to go to suspend very aggressively.
> And you want to keep connectivity. And you want to resume quickly -
> else it is very easy to be in the situation where
> you just suspending and resuming all the time.
> So it doesn't make sense on every suspend/resume rescan for alive sdio
> card. Makes sense ?

Yes, but in this case the suspend methods are inappropriate when the 
phone is in live usage.  They are meant to be used, say, when the phone 
becomes unused and its flap is folded.  Otherwise, what is supposed to 
happen when you actually want the SDIO card to be suspended if the 
suspend method is cut out?


Nicolas

--Boundary_(ID_mSRfEif4Y7+TxYfjqL5ycA)--
