From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [linux-pm] [RFC, PATCHv3 3/3] mmc: sdhci: handle wake-up from runtime_pm
Date: Tue, 1 Mar 2011 21:01:50 +0100
Message-ID: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
References: <b01ca43311e25bf24c6e60e9f6d6d7b91ae3a130.1298820826.git.tardyp@gmail.com>
	<Pine.LNX.4.44L0.1103011448430.2034-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54503 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1CAUBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 15:01:51 -0500
In-Reply-To: <Pine.LNX.4.44L0.1103011448430.2034-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

>> + =A0 =A0 if (pm_runtime_suspended()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->waking_up =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Note that we disable temporarly the int=
errupt until we do the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* resume. If we don't then we'll get co=
nstantly interrupted
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* until we actually resume.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* as the irq is shared, this might not =
be very friendly to our
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* irq sharers but the pm_runtime workqu=
eue should really be
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* called soon.
>
> Instead of disabling the IRQ, would it be possible to tell the device
> to stop generating an interrupt request?

Well, the device is power gated, so any access to it will cause a bus
timeout (depending of the platform)

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get(host->mmc->parent);
>
> Does this pm_runtime_get() have a corresponding pm_runtime_put()? =A0=
I
> didn't notice one anywhere.
oups, forgot to add the corresponding snippet in sdhci_runtime_resume:
if (host->waking_up) {
    pm_runtime_put();
    host->waking_up =3D 0;
}

>>
>
> Surely this doesn't belong in the patch.
yep sorry, I should stop doing git commit -a...

Pierre
