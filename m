From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 11:20:04 -0700
Message-ID: <AANLkTi=K76xLSjMfYBn9VdhtaDjgP0DruPNhcAqZiq6D@mail.gmail.com>
References: <loom.20101011T202734-842@post.gmane.org>
	<alpine.LFD.2.00.1010112005300.2764@xanadu.home>
	<AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
	<alpine.LFD.2.00.1010112036540.2764@xanadu.home>
	<AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
	<alpine.LFD.2.00.1010121341490.2764@xanadu.home>
	<AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
	<alpine.LFD.2.00.1010121410150.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34188 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab0JLSUF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 14:20:05 -0400
Received: by gxk6 with SMTP id 6so610648gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2010 11:20:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010121410150.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, Oct 12, 2010 at 11:13 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Tue, 12 Oct 2010, Dmitry Shmidt wrote:
>
>> On Tue, Oct 12, 2010 at 10:50 AM, Nicolas Pitre <nico@fluxnic.net> w=
rote:
>> >> Imagine your device is keeping connection during suspend. You got=
 packet -
>> >> wlan will wake application processor
>> >> through external irq line and linux starts resume. You can not fi=
nd wlan
>> >> card again - it is too slow.
>> >
>> > What? =A0I'm not following you anymore.
>> >
>> > The Libertas firmware can be configured to filter incoming packets=
 and
>> > only assert the IRQ signal only when a specific packet comes in, j=
ust
>> > like wake-on-LAN for Ethernet devices.
>>
>> This is not an issue of the ability to handle packets, but to handle
>> them quickly.
>> This is important for VoIP for example. If you need to recognize
>> device each time you are coming from suspend -
>> it is not a good idea sometimes.
>
> I simply don't see why you'd want to suspend while a VoIP session is
> active then. =A0Those methods you want to inhibit are meant for long =
term
> deep suspending, not for inter-packet power saving during a call.

You are right - there are other ways to resolve some issues. I just
wanted to add another option
that will be kernel-related and not application-related.

>
> Nicolas
>

Dmitry
