From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 14:46:45 -0700
Message-ID: <AANLkTi=-7ynxokzQjKJ+pOQuBoC5whGW2sg1FX3yrCLB@mail.gmail.com>
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
	<alpine.LFD.2.00.1010121732370.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62361 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab0JLVqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 17:46:46 -0400
Received: by gyg13 with SMTP id 13so180374gyg.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2010 14:46:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010121732370.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, Oct 12, 2010 at 2:37 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Tue, 12 Oct 2010, Dmitry Shmidt wrote:
>
>> > Please tell us more about the problem you are trying to solve, and=
 in
>> > what ways the current infrastructure is not achieving that goal. =A0=
Then
>> > we might be in a better position to propose suggestions.
>> >
>> > But selectively ignoring upper suspend requests certainly feels wr=
ong to
>> > me. =A0If you need this, then the actual problem must be somewhere=
 else.
>> >
>> > Nicolas
>>
>> Let's assume we are talking about device that is not a laptop - and =
it
>> is very power-consumption sensitive. Like smartphone...
>> So you want to go to suspend very aggressively.
>> And you want to keep connectivity. And you want to resume quickly -
>> else it is very easy to be in the situation where
>> you just suspending and resuming all the time.
>> So it doesn't make sense on every suspend/resume rescan for alive sd=
io
>> card. Makes sense ?
>
> Yes, but in this case the suspend methods are inappropriate when the
> phone is in live usage. =A0They are meant to be used, say, when the p=
hone
> becomes unused and its flap is folded. =A0Otherwise, what is supposed=
 to
> happen when you actually want the SDIO card to be suspended if the
> suspend method is cut out?
>
>
> Nicolas
>
"Flap is folded"... It is not the case for usual smartphones anymore. :=
)
Simple scenario - you are siting in chat, wait like 15 sec and your
screen goes Off, after another 5 sec kernel gets suspend command and
tries to suspend. And you are getting new message - you want to resume
quickly and process this packet with no delay.
Maybe what I am describing seems weird, but phone developers are
fighting for every mA.
And mmc card resume if usually deferred - to reduce tiem and save
power, but this is a different issue.

Dmitry
