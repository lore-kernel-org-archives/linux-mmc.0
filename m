From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 11 Dec 2010 00:59:57 +0200
Message-ID: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
References: <201012100100.58224.rjw@sisk.pl> <Pine.LNX.4.44L0.1012101202040.2521-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:51259 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0LJXAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Dec 2010 18:00:18 -0500
Received: by iwn40 with SMTP id 40so6025245iwn.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Dec 2010 15:00:17 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1012101202040.2521-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On Fri, Dec 10, 2010 at 7:24 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
>> On Friday, December 10, 2010, Ohad Ben-Cohen wrote:
>> > When pm_runtime_put_sync() returns, the _put operation is complete=
d,
>> > and if needed (zero usage_count, children are ignored or their cou=
nt
>> > is zero, ->runtime_idle() called pm_runtime_suspend(), no
>> > runtime_error, no disable_depth, etc...) the device is powered dow=
n.
>> >
>> > This behavior is sometimes desirable and even required: drivers ma=
y
>> > call pm_runtime_put_sync() and rely on PM core to synchronously po=
wer
>> > down the device.
>
> That would be a mistake. =A0The "sync" in pm_runtime_put_sync means t=
hat
> _if_ a runtime_suspend call occurs, the call will occur synchronously=
=2E
> It does not guarantee that a runtime_suspend call will occur.

This is clear; that's why I explicitly mentioned that all the
conditions are met in the very beginning of my description.

>
>> > This is usually all good, but when we combine this requirement wit=
h
>> > logical sub-devices that cannot be power-managed on their own (e.g=
=2E
>> > SDIO functions), things get a bit racy, since their parent is not
>> > suspended synchronously (the sub-device is rpm_suspend()'ed
>> > synchronously, but its parent is pm_request_idle()ed, which is
>> > asynchronous in nature).
>> >
>> > Since drivers might rely on pm_runtime_put_sync() to synchronously
>> > power down the device,
>
> Drivers should never do this.

Think of a device which you have no way to reset other than powering
it down and up again.

If that device is managed by runtime PM, the only way to do that is by
using put_sync() followed by a get_sync(). Sure, if someone else
increased the usage_count of that device this won't work, but then of
course it means that the driver is not using runtime PM correctly.

> What if the device's usage_count was larger than 1? =A0Then
> pm_runtime_put_sync() wouldn't cause a suspend in any case.
>
> It sounds like the reinitialization is done at the wrong time. It
> should occur when the parent is resumed, since we are assuming the
> parent controls the device's power. =A0Then if the device doesn't get
> powered down because the parent's suspend was cancelled, there would =
be
> no reinitialization and nothing would go wrong.

This can't always be done; sometimes the driver _must_ know if the
power was taken down or not, because it completely reset the device's
state: after powering the device down and up, you might need to load
it a new firmware, reconfigure it, notify the stack above you about
this event, etc..

After reseting the device, the driver will behave completely
different. If it chose to power the device down, it must be able to do
that deterministically.

Naturally this is only possible if runtime PM is used very accurately,
without letting random entities increasing the device's usage count
behind the driver's back.

You could say "don't use runtime PM" of course, but the device belongs
to the MMC bus, which does employ runtime PM, for all the good
reasons: runtime PM provided it the entire plumbing required to
achieve power control of its devices. Not using runtime PM would
basically mean duplicating big parts of runtime PM's code into
SDIO/MMC core (reference counts, locking, device hierarchy, exposed
API, etc..).

>> > A different, bolder solution, will always call pm_runtime_idle ins=
tead
>> > of pm_request_idle (see below): when a device is runtime suspended=
, it
>> > can't be too bad to immediately send idle notification to its pare=
nt,
>> > too. I'm aware this might not always be desirable, but I'm bringin=
g
>> > this up even just for the sake of discussion:
>> >
>> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/run=
time.c
>> > index 02c652b..9719811 100644
>> > --- a/drivers/base/power/runtime.c
>> > +++ b/drivers/base/power/runtime.c
>> > @@ -407,7 +407,7 @@ static int rpm_suspend(struct device *dev, int=
 rpmflags)
>> > =A0 =A0 =A0 =A0 if (parent && !parent->power.ignore_children) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
>> >
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_request_idle(parent);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_idle(parent);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
>> > =A0 =A0 =A0 =A0 }
>>
>> I acutally think we can do that. =A0If the parent cannot be suspende=
d,
>> pm_runtime_idle() will just return, which is fine. =A0Right now I do=
n't see
>> any big drawback of this.
>>
>> Alan, what do you think?
>
> I don't like this change quite so much. =A0It can give rise to unboun=
ded
> nested suspend sequences: we suspend the device, then call the parent=
's
> runtime_idle routine which suspends the parent, then we call the
> grandparent's runtime_idle routine, etc.

Yes, that's why I thought this might not be desirable, but I wasn't
quite sure why would it be wrong; if a context is willing to
synchronously suspend a device (either a driver using put_sync() or
the PM worker), what do we gain by deferring the idling of the parent
and not synchronously suspending as much ancestors as possible in the
same context ?
