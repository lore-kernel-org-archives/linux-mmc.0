From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH v2 2/3] sdhci-pci : Enable runtime PM support
Date: Sun, 13 Feb 2011 11:42:01 +0100
Message-ID: <AANLkTi=iZ3dzAoRuRdpvQ=uBp4u8O8LtMuu2XdSWeZwr@mail.gmail.com>
References: <cover.1297014479.git.pierre.tardy@intel.com>
	<6722fa7986194808f4d69a1e5ba6d3f163b77da9.1297014479.git.pierre.tardy@intel.com>
	<20110210043718.GA7585@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60986 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab1BMKmD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 05:42:03 -0500
In-Reply-To: <20110210043718.GA7585@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pierre Tardy <pierre.tardy@intel.com>, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Yunpeng Gao <yunpeng.gao@intel.com>

> On Sun, Feb 06, 2011 at 07:02:49PM +0100, Pierre Tardy wrote:
>> From: Yunpeng Gao <yunpeng.gao@intel.com>
>>
>> Follow the kernel runtime PM framework, enable runtime PM support of=
 the
>> sdhci host controller with pci interface.
>>
>> Note that this patch implements runtime_pm but now actually detects
>> activity.
>> It relies on higher level (childrens) to do actual waking up
>> Activity detection is put in following patch
>
> Testing this patchset in linux-next-20100208 gives:
>
> [ =A0 10.829223] sdhci: Secure Digital Host Controller Interface driv=
er
> [ =A0 10.829548] sdhci: Copyright(c) Pierre Ossman
> [ =A0 10.883906] sdhci-pci 0000:0d:00.0: SDHCI controller found [1180=
:e822] (rev 1)
> [ =A0 10.884533] sdhci-pci 0000:0d:00.0: PCI INT A -> GSI 16 (level, =
low) -> IRQ 16
> [ =A0 10.885189] sdhci-pci 0000:0d:00.0: Will use DMA mode even thoug=
h HW doesn't fully claim to support it.
> [ =A0 10.886176] sdhci-pci 0000:0d:00.0: setting latency timer to 64
> [ =A0 10.886819] Registered led device: mmc0::
> [ =A0 10.887281] mmc0: SDHCI controller on PCI [0000:0d:00.0] using D=
MA
> [ =A0 10.887724] sdhci-pci 0000:0d:00.0: Unbalanced pm_runtime_enable=
!
> [ =A0 10.888498] sdhci-pci 0000:17:00.0: SDHCI controller found [1180=
:e822] (rev 1)
> [ =A0 10.889179] sdhci-pci 0000:17:00.0: PCI INT A -> GSI 19 (level, =
low) -> IRQ 19
> [ =A0 10.889876] sdhci-pci 0000:17:00.0: Will use DMA mode even thoug=
h HW doesn't fully claim to support it.
> [ =A0 10.890924] sdhci-pci 0000:17:00.0: setting latency timer to 64
> [ =A0 10.891387] Registered led device: mmc1::
> [ =A0 10.891900] mmc1: SDHCI controller on PCI [0000:17:00.0] using D=
MA
> [ =A0 10.892280] sdhci-pci 0000:17:00.0: Unbalanced pm_runtime_enable=
!
>
> (Note the last line above.)

I never have seen this before. I'm not testing those patches on
mmc-next, as our platform is not totally upstream yet, and do not boot
on 2.6.37+ based kernel.
However, we backported the pm_runtime patches from 2.6.37. Is there
some differences in very latest patches on default enablement of
runtime_pm?

>
> I then removed the card and reinserted it, but there's no dmesg outpu=
t
> related to the reinsert, only to the card removal:
>
> [ =A0 65.381047] mmc0: card d555 removed
>
> So, card insertion is broken. =A0I then did rmmod sdhci-pci && modpro=
be
> sdhci-pci, and it picked up the card again.

So what you have here is non working card-detection when device is in P=
CI_D3.
This sounds like a HW limitation in you platform.

D3 is originally meant for suspend to ram, so it sounds logic that
some HW wont support wake on card detect.
it sounds like we need a SDHCI_RUNTIME_PM_CAP, so that we can properly
describe which HW can be safely put D3 at runtime.
Also, maybe on some HW, D1 will support wake on card detect. I dont
know how can the driver hint pci subsystem that it should go D1 rather
than D3 in the runtime_pm flow.
Maybe Rafael can advice on this.

Regards,
Pierre
