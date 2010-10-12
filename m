From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 11:00:54 -0700
Message-ID: <AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
References: <loom.20101011T202734-842@post.gmane.org>
	<alpine.LFD.2.00.1010112005300.2764@xanadu.home>
	<AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
	<alpine.LFD.2.00.1010112036540.2764@xanadu.home>
	<AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
	<alpine.LFD.2.00.1010121341490.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42542 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0JLSAz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 14:00:55 -0400
Received: by ywi6 with SMTP id 6so1151613ywi.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2010 11:00:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010121341490.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, Oct 12, 2010 at 10:50 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Tue, 12 Oct 2010, Dmitry Shmidt wrote:
>
>> MMC_PM_KEEP_POWER is mostly related to mmc host controller - keeping
>> or not keeping power on suspend/resume.
>
> It is not "mostly related", it is _totally_ related and actually its
> purpose for existing.

Sorry, I tried to be polite... :)

>
>> MMC_PM_WAKE_SDIO_IRQ is not related to anything right now. Also in
>> most of the cases sdio irq can not be a wake source of the applicati=
on
>> processor.
>
> Why not? =A0I know about at least 2 host controllers which can be
> configured so a transition on DAT3 would wake up the host.

Sorry, that I was not clear - wake source is not related to the topic.

>
>> Imagine your device is keeping connection during suspend. You got pa=
cket -
>> wlan will wake application processor
>> through external irq line and linux starts resume. You can not find =
wlan
>> card again - it is too slow.
>
> What? =A0I'm not following you anymore.
>
> The Libertas firmware can be configured to filter incoming packets an=
d
> only assert the IRQ signal only when a specific packet comes in, just
> like wake-on-LAN for Ethernet devices.

This is not an issue of the ability to handle packets, but to handle
them quickly.
This is important for VoIP for example. If you need to recognize
device each time you are coming from suspend -
it is not a good idea sometimes.

>> Again, for mmc card it totally makes sense - mmc card is NOT an acti=
ve
>> device.
>
> But MMC cards still have operating states. =A0You cannot simply write=
 to
> them after a power disconnect, and leaving them powered on suspend is
> not very efficient either.

Agree 100%

> PS: common netiquette is not to top-post.
>
>
> Nicolas
>

Thanks,

Dmitry
