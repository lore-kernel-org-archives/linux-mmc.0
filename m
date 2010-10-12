From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 13:55:08 -0700
Message-ID: <AANLkTik1PPHgbvSEab6VQXUbCJrO91vgec6yb7+fWbBh@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57730 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab0JLV6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 17:58:35 -0400
Received: by gxk6 with SMTP id 6so694740gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2010 14:58:34 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010121630260.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

> Please tell us more about the problem you are trying to solve, and in
> what ways the current infrastructure is not achieving that goal. =A0T=
hen
> we might be in a better position to propose suggestions.
>
> But selectively ignoring upper suspend requests certainly feels wrong=
 to
> me. =A0If you need this, then the actual problem must be somewhere el=
se.
>
> Nicolas

Let's assume we are talking about device that is not a laptop - and it
is very power-consumption sensitive. Like smartphone...
So you want to go to suspend very aggressively.
And you want to keep connectivity. And you want to resume quickly -
else it is very easy to be in the situation where
you just suspending and resuming all the time.
So it doesn't make sense on every suspend/resume rescan for alive sdio
card. Makes sense ?
Thanks,

Dmitry
