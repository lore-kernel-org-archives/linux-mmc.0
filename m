From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [linux-pm] [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Wed, 2 Mar 2011 00:40:09 +0100
Message-ID: <AANLkTinNG9ecqSGk+zDjd0A+nLXmwHQkRot0WZ18amsv@mail.gmail.com>
References: <cover.1298820825.git.tardyp@gmail.com>
	<Pine.LNX.4.44L0.1103011431400.2034-100000@iolanthe.rowland.org>
	<AANLkTi=ogThxB_2bxANV4hUsLGZs04gzHSCyH90Bm87U@mail.gmail.com>
	<201103012207.22798.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52460 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab1CAXkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 18:40:11 -0500
In-Reply-To: <201103012207.22798.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, Mar 1, 2011 at 10:07 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, March 01, 2011, Pierre Tardy wrote:
>> On Tue, Mar 1, 2011 at 8:33 PM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>> > On Tue, 1 Mar 2011, Pierre Tardy wrote:
>> >
>> >> Please find sdhci runtime_pm implementation.
>> >>
>> >> It uses clock gating fw as a tip to know when our chip is idle.
>> >> It implements wake up from card insertion/removal.
>> >>
>> >> This is RFC, please dont merge yet. I really would like to have d=
eep review
>> >> from PCI linux-pm guys.
>> >>
>> >> Opens are:
>> >>
>> >> 1/ Not sure if the pci configs in the driver in rpm_suspend/resum=
e flow
>> >> =A0are not duplicate from what the core is doing.
>> >
>> > There may be one or two small errors.
>> >
>> >> 2/ Wakeup from D3hot: I cannot find any driver that is implementi=
ng it in current upstream,
>> >
>> > Other drivers do it, but they use PCI PME# instead of interrupts.
>> Could you please elaborate?
>> My understanding is that PCI PME will generate MSI, which translate =
in
>> interrupt.
>
> Your driver won't get those interrupts.
>
> How it works is, basically, that when the device signals wakeup, it e=
ither
> causes a PME# signal to be raised (parallel PCI), or a PME Message to=
 be
> sent upstream (PCIe). =A0In the first case it will cause a platform e=
vent
> (eg. ACPI GPE) to occur and the handle of that event will resume your
> device (using pm_request_resume()). =A0In the second case it will cau=
se the PCIe
> root port handling the PME Message to generate an interrupt and the h=
andler of
> that interrupt will resume your device.
Thanks, that explain a lot how it works.
What I still dont understand is that the wake source I'll have (e.g.
sd card insert) is still an interrupt source.
So it is supposed to generate interrupt until the interrupt source is
acknowledged.
Are we supposed to mask that interrupt source while suspended to make
sure we have either wake or interrupt?

>
> In fact, there are a few drivers in the tree using this mechanism alr=
eady
> (r8169, e1000e, i believe PCI HCDs too).
Hope there will be more and more.

thanks,
Pierre
