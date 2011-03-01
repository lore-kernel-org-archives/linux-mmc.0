From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [linux-pm] [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue, 1 Mar 2011 21:06:09 +0100
Message-ID: <AANLkTik5HVxoOCH1ZVj50nUsCA5E04Y0J0RaWw7_KyKw@mail.gmail.com>
References: <AANLkTi=ogThxB_2bxANV4hUsLGZs04gzHSCyH90Bm87U@mail.gmail.com>
	<Pine.LNX.4.44L0.1103011454250.2034-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55992 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180Ab1CAUGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 15:06:10 -0500
In-Reply-To: <Pine.LNX.4.44L0.1103011454250.2034-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, Mar 1, 2011 at 8:57 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
> On Tue, 1 Mar 2011, Pierre Tardy wrote:
>
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
> It depends on the platform. =A0On systems with ACPI, PCI PME generate=
s an
> ACPI I/O event, which is handled by the ACPI and PM cores. =A0It does=
 not
> invoke the device driver's interrupt handler.
So, let's say, in the ACPI case, if the interrupt handler dont get
called, how would the driver know that he got a sdcard insert event,
and trigger a mmc_rescan() ?

Regards,
Pierre
