From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 23:47:59 +0200
Message-ID: <CAFEEs1kJ91ye-CGGFZ0C9E6cEE_7eNOi-H5tC=TNiLz3pv_mdg@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<loom.20111027T202726-264@post.gmane.org>
	<CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35352 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab1J0VsA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 17:48:00 -0400
Received: by vws1 with SMTP id 1so2910576vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 14:47:59 -0700 (PDT)
In-Reply-To: <CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Sebastian,

On Thu, Oct 27, 2011 at 10:51 PM, Sebastian Rasmussen <sebras@gmail.com=
> wrote:
> Hi!
>
>> This patch only starts BKOPS if it's urgent or critical.
>
> Almost, it starts BKOPS when it is urgent, which per spec means level
> 2 or 3, i.e. when performance is impacted or when it is critical.
> Better use the specs terminology as far as possible to relieve
> everyone of confusion.
>
>> I would be preferable to run bkops periodically and only when
>> the card is idle to minimize the risk of reaching URGENT.
>
> Well, you kind of need both.
Yes, this is what I mean. If the URGENT_BKOPS is set meaning (status 2
or 3) there is no escape, current solution will do fine.
Periodical check is a complement, not a replacement. Must BKOPS always
be deferred until performance is impacted?

About starvation.
What happens if the BKOPS never have time to finish because new writes
are coming in all the time. Is it possible to starve the
BKOPS-operation?
Will it come to a point when BKOPS must run without interruption?

> extent that the block device is never idling then you would definitel=
y
> require this patch, right? Otherwise you may end up wasting the time
> between the last command sent and when the device has been deemed to
> be idle for long enough.
>
> So basically the OP's patch fixes the case where, e.g. sustained
> (re-)writing, keeps the block device busy until and after it reaches
> the critical BKOPS level, while your proposal takes care of the other
> case where the block device is not accessed all the time.
>
>> The specs says:
>> -----
>> Hosts shall still read the full status from the BKOPS_STATUS byte pe=
riodically
>> and start background operations as needed.
>> -----
>
> Sure, if there is idle time to do it, then why not.
> If there is no idle time and URGENT_BKOPS is asserted, then the
> framework can not wait until the next idle period, but should issue
> BKOPS as soon as possible after the current command is finished.
>
>> I'm thinking of checking BKOPS_STATUS when the card is idle and then=
 run bkops
>> even if level is only 1 (Operations outstanding =96 non critical). W=
ould this make
>> sense?
>
> I guess this boils down to how you define idle..? Does it mean
> immediately after the current command has been fully serviced, or doe=
s
> it mean some arbitrary time after the last sent command has been full=
y
> serviced? My assumption is that you are refering to the latter, in
> which case certain access patterns may cause problems. So, how do
> _you_ define idle? :)
My first point was just to raise my concern and start a discussion
about this. If this turns out to be a good idea I be happy to look
more into the details.

One question is:
Is it worth running BKOPS if the BKOPS_STATUS is only 1? I could run
some tests comparing write performance when status is 0,1,2.

I don't know what the best place would be for a BKOPS_STATUS check.
What comes to my mind is to use the same credentials that are used for
power save. I need to look more closely into this in order to propose
a patch.
Suspend? if suspend is requested one might check BKOPS_STATUS and
return -EBUSY if BKOPS needs to be started.

Regards,
Per
