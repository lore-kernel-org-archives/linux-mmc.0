From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 11 Dec 2010 03:17:14 +0200
Message-ID: <AANLkTi=67vtfiQMQHTijx6DMo2y2-b9BfOq1nx-zG7TU@mail.gmail.com>
References: <201012100100.58224.rjw@sisk.pl> <Pine.LNX.4.44L0.1012101202040.2521-100000@iolanthe.rowland.org>
 <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38277 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab0LKBRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Dec 2010 20:17:34 -0500
Received: by iwn9 with SMTP id 9so6427419iwn.5
        for <linux-mmc@vger.kernel.org>; Fri, 10 Dec 2010 17:17:34 -0800 (PST)
In-Reply-To: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On Sat, Dec 11, 2010 at 12:59 AM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
>>> > A different, bolder solution, will always call pm_runtime_idle in=
stead
>>> > of pm_request_idle (see below): when a device is runtime suspende=
d, it
>>> > can't be too bad to immediately send idle notification to its par=
ent,
>>> > too. I'm aware this might not always be desirable, but I'm bringi=
ng
>>> > this up even just for the sake of discussion:
>>> >
>>> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/ru=
ntime.c
>>> > index 02c652b..9719811 100644
>>> > --- a/drivers/base/power/runtime.c
>>> > +++ b/drivers/base/power/runtime.c
>>> > @@ -407,7 +407,7 @@ static int rpm_suspend(struct device *dev, in=
t rpmflags)
>>> > =A0 =A0 =A0 =A0 if (parent && !parent->power.ignore_children) {
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock)=
;
>>> >
>>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_request_idle(parent);
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_idle(parent);
>>> >
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
>>> > =A0 =A0 =A0 =A0 }
>>>
>>> I acutally think we can do that. =A0If the parent cannot be suspend=
ed,
>>> pm_runtime_idle() will just return, which is fine. =A0Right now I d=
on't see
>>> any big drawback of this.
>>>
>>> Alan, what do you think?
>>
>> I don't like this change quite so much. =A0It can give rise to unbou=
nded
>> nested suspend sequences: we suspend the device, then call the paren=
t's
>> runtime_idle routine which suspends the parent, then we call the
>> grandparent's runtime_idle routine, etc.
>
> Yes, that's why I thought this might not be desirable, but I wasn't
> quite sure why would it be wrong; if a context is willing to
> synchronously suspend a device (either a driver using put_sync() or
> the PM worker), what do we gain by deferring the idling of the parent
> and not synchronously suspending as much ancestors as possible in the
> same context ?

By allowing nested suspend sequences we even squeeze some more power
by suspending devices earlier, and saving some CPU cycles (due to the
avoided context switches), so it sounds like a win-win...

But of course I may be overlooking a real problem this may pose.. I
haven't spotted any, but it does feel like a significant behavior
change, hence the cautious approach :)

Thanks,
Ohad.

>
