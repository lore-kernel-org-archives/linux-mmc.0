Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF635F167;
	Sat, 21 Mar 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774091277; cv=none; b=mYgD7extJ9oB79V5A6YMj8LZOEHyXn+r7DmhuhR/9lhpcVEFaIAdQIxCWXoUsYZY9WF5HNqFJFKlbaGbkWbHrgz3enpq4+j8p3gMeOQST91xv4Dm4lRiEQahdQCq4Xl+FJPeUXuxviX/9S8tNwm/WlYFXrz7ZwgpnqpRQoJiw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774091277; c=relaxed/simple;
	bh=e/zLqybbmhZTMeQX/Dwe0EOyE5R9SSsC6KG/vDpG5ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw4Lw4GQS4FYXhDGIvFO18meUma8zpDTuziELySNX+lzI65NgXza8kI0AzEFpd7QuryNWkOo3PjSbOYKimcI4zsjqAse7womnzJqrs9rGfWz5c+LD+mn+ogMQwLcsvspiSWAd8fZQM+9ejf4A0VdNXxRhE+7lhzdNhumCi0zp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO27L0WE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO27L0WE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CFAC19421;
	Sat, 21 Mar 2026 11:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774091277;
	bh=e/zLqybbmhZTMeQX/Dwe0EOyE5R9SSsC6KG/vDpG5ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QO27L0WE6YXvIs+QWtAL5bmf0GT+6eU8ZXKCW9Sb12h1trRSxHwqfJQTdZqGM7jzL
	 MJEp57R6yxY5NpcU3dXwZbKqi80RuQPbHg5xPD/1jWsUeU0QAcVrd6boRl2IavvHbj
	 aDHO7vX/fHocBRou4wB5sN+pqYFOHIXuO5Ndw8UZbpEHNC4gvK8M6ibV2Mz7HIVdHK
	 pBw7Vq4VLR2VI41KvFKv9HB6VYfnOWdJgFNLff5kbg8qBTXWD4kViRx3pNzizuA9A8
	 vrmbWNx8xRUPXS9iZbuqxLjFSybGtbl46zFmAlGApOttHyd8Fz58tqE4/Tya4OliXU
	 +EYO8QzIKh7Yw==
Message-ID: <9b8cb543-f052-4a67-81ce-4cf8f467c57d@kernel.org>
Date: Sat, 21 Mar 2026 12:07:53 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
To: Nelson Johnson <nzjfr547@gmail.com>, andriy.shevchenko@intel.com
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <ab2NKT4uioc8O-7-@black.igk.intel.com>
 <20260320230707.3122-1-nzjfr547@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260320230707.3122-1-nzjfr547@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Mar-26 00:07, Nelson Johnson wrote:
> On Fri, Mar 20, 2026 at 07:08:41PM +0100, Andy Shevchenko wrote:
>> Can you share ACPI DSDT excerpt (from DSDT table of firmware, you can
>> get it by copying file from /sys/firmware/acpi/tables/DSDT and decode
>> it with `iasl -d DSDT`) and output of `lspci -vv -n -s $SDHCI_SLOT`?
>> Because it might be that the problem should be solved just by providing
>> better fixes to GPIO detection or so.
> 
> Here is the requested data collected from the N22 on a vanilla
> 6.19.6+deb14+1-amd64 kernel with no patches applied.
> 
> DSDT INT33BB section (decoded from /sys/firmware/acpi/tables/DSDT):
> 
>     Name (_HID, "INT33BB")
>     Name (_CID, "PNP0D40")
>     Name (_DDN, "Intel(R) SDIO Controller - 80862295")
>     Name (_UID, 0x02)
>     Name (_HRV, 0x02)
>     Name (_DEP, Package (0x01)
>     {
>         GPO1
>     })
>     Name (ABUF, ResourceTemplate ()
>     {
>         Memory32Fixed (ReadWrite, 0x00000000, 0x00001000, _Y04)
>         Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive) { 0x0000002E }
>         GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
>             "\\_SB.GPO1", 0x00, ResourceConsumer, ,)
>             {
>                 0x0005
>             }
>     })
>     Method (_PS0, 0, NotSerialized)
>     {
>         PSAT &= 0xFFFFFFFC
>         PSAT |= Zero
>         If ((PSTS == Zero))
>         {
>             If ((^^^GPO1.AVBL == One))
>             {
>                 ^^^GPO1.CWLE = One
>             }
>             PSTS = One
>         }
>     }
>     Method (_PS3, 0, NotSerialized)
>     {
>         PSAT |= 0x03
>         PSAT |= Zero
>     }
> 
> Two things stand out in this description. First, the _DDN names the
> device as "Intel(R) SDIO Controller - 80862295" rather than an SD
> slot, and _UID is 0x02; in current sdhci-acpi.c, INT33BB UID 2 maps
> to the SDIO slot profile rather than the removable SD profile. Second,
> the GpioIo descriptor for pin 5 on GPO1 is IoRestrictionOutputOnly
> with PullNone. My reading of the AML is that this looks more like an
> enable/control line than a card-detect input, but that is an inference
> from the firmware description rather than something I can prove from
> the AML alone.

Thank you. Note it might still be useful to share the full output
of acpidump.

So the above indeed describes the SD-slot MMC controller in
ACPI mode. WhenAndy wrote: "When device is present in both PCI and
ACPI in accordance with ACPI specification, if I am not
mistaken, it should extend the existing PCI capabilities."

I believe Andy was talking about your typical PCI[-e] slot ACPI
companion fwnode / device, which adds some extra info about
the slot.

But in this case it indeed seems the whole SD-slot controller
is simply described in both ACPI and enumerated through PCI
which is rather broken. And it being marked as a SDIO slot
is also broken, so I think your ACPI tables are just quite
broken.

Still I wonder if you've looked into BIOS settings to fix this ?

Some Cherry Trail devices have a BIOS option to switch
the BIOS from a Windows compatible mode to an Android compatible
mode.  I've worked more with Cherry Ttail then with Braswell,
so I'm not sure if the same also applies to Braswell but this
might be worth a shot.

Can you try dd-ing a Fedora Workstation Live iso to an USB
stick and then hit the BIOS bootmenu key (F12?) and boot
from that? If this is indeed one of these double identity
BIOS-es it will see Fedora's shim is signed with microsoft's
key and switch to Windows mode. If it does this it will immediately
reboot into the new mode, so need to hit F12 a second time
and select the USB stick a second time.

And then under Fedora check if the sd slot is still seen
twice.

> 
> lspci -vv -n -s 0000:00:12.0 on vanilla kernel:
> 
>     00:12.0 0805: 8086:2296 (rev 21) (prog-if 01)

Ok, so at least on the PCI side this does have the SD slot
device-id and not the sdio-slot one.


>         Subsystem: 17aa:3807
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
>                  ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>                 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 18
>         Region 0: Memory at 91315000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [80] Power Management version 3
>             Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>                    PME(D0+,D1-,D2-,D3hot+,D3cold-)
>             Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Kernel modules: sdhci_pci
> 
> Note BusMaster- on the vanilla kernel. With the patch series applied
> BusMaster+ and Kernel driver in use: sdhci-pci.
> 
> Vanilla dmesg for SD/MMC:
> 
>     [    3.142590] mmc0: SDHCI controller on ACPI [INT33BB:00] using ADMA
>     [    3.155518] mmc1: SDHCI controller on ACPI [80860F14:00] using ADMA
>     [    3.356405] mmc0: Failed to initialize a non-removable card
>     [    3.358473] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
>     [    3.397615] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
>     ... (repeated approximately 30 times over 30 seconds)
>     [   30.066835] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
> 
> The observed sequence on the vanilla kernel is:
> 
>   - sdhci-acpi binds INT33BB:00 and creates mmc0
>   - mmc0 then fails with "Failed to initialize a non-removable card"
>   - sdhci-pci repeatedly reports "SDHCI controller found [8086:2296]"
>   - lspci -vv shows BusMaster- and no "Kernel driver in use" line
>     for 0000:00:12.0 throughout
> 
> That seems consistent with the ACPI path binding the
> firmware-described instance while the PCI path never reaches a
> usable bound state.
> 
> Given the output-only GPIO descriptor and the current non-removable
> SDIO mapping for INT33BB UID 2, does this point to a fixable ACPI /
> GPIO-enumeration issue, or do you think machine-scoped exclusion of
> the ACPI node is still the right direction for this firmware? I am
> happy to test any suggested patch or approach on the hardware.

If you look at drivers/mmc/host/sdhci-acpi.c you'll see an existing
sdhci_acpi_quirks[] mechanism with DMI quirks there. I wonder what
happens if you GPIO card detection there by adding a new
DMI_QUIRK_SDIO_IS_SD quirk for your model there and when that is set
use sdhci_acpi_slot_int_sd instead of sdhci_acpi_slot_int_sdio +
disable any use of GPIO for card-detect ?

I'm hoping that using the ACPI path will avoid the need for

"[PATCH 1/3] mmc: sdhci-pci: disable aggressive runtime PM for Braswell SD on Lenovo N22"

and we can use the same quirk to fix sdio -> sd to also force
polling.

I hope the PCI driver will then simply fail to probe due to
a resource conflict ...

Alternative if we do go the route of this v1 patchset you may want
to use the override_status_id mechanism in:

drivers/acpi/x86/utils.c

Adding a NOT_PRESENT_ENTRY_PATH match on the INT33BB device
to ignore it.

Hmm, I see that mmc1 is enumerated as 80860F14:00 I wonder
if there is a 80860F14:01 with a status of 0 and if we really
need to use that one instead of the INT33BB one.

Normally a single laptop/tablet uses either all PCI or
all ACPI enumeration for the MMC controllers and if using
ACPI it tends to be consistent wrt which ACPI HIDs it uses ...

Again having a full acpidump to look at would be good.

Regards,

Hans


