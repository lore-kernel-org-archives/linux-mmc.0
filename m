Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFCF1E4AF;
	Sat, 21 Mar 2026 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774109688; cv=none; b=Iz1zJqOkIKFmHLT/q3TA5vmEU7YfooDy3HFOWvvFst7R6T8uyH8Yf6lpjUtyE7IGWh57S/2yoohUcEowH+KfUmUcuyr4rEZrc2oVzz6N3MJqlDIf2w3L49RX2Z3hXV01GkscSUeiGe7SXDEadR61n9hqdl46snJUo2PA57cAHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774109688; c=relaxed/simple;
	bh=+S/1YWs+sIWTwrRFPOlsiBrV88+hSWaol9aPcwvpdhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgbB0cRmraLlpXV6Cxdlt5MqE1pdGcFX7PtU6dhZ34e2/WgmDqB4bpAFh05vYyIuK+JhQjakfuOrIGz+MLqUbQWt3XTM6+A7m148C3qGBX51vSkFz1vgcvXFUaS+WqwRD2qnSkP9ZV9kQK27qX0V0afIVR9oGHP2IHFvJZEGXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0ZfwZ5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0ZfwZ5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F56C19421;
	Sat, 21 Mar 2026 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774109688;
	bh=+S/1YWs+sIWTwrRFPOlsiBrV88+hSWaol9aPcwvpdhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L0ZfwZ5W8xyKCIhXWne9YnyuyOkl9mb5tflH954BeaEjAdznbxJ1Y41fWFjAoZAS7
	 yXhYE5S3DfPsWVXLYJUpVvwqa4ARPQZvSwidbo8U2JQX9I7ddp8qr1XC7Pyl0OLZbt
	 Xq90JCW8VOvstgFs+hSU+7WmFj/iVIER1E6WYv5C5WoQt1IVZ+/xI7uTiEnqgflIP7
	 QO/Xb2Siq3xzcgI6+cO5F6zwQPOvQFpjKjM6EZg/6g8/mPz0mmN8+8QF/pTsuNY+6P
	 NvW8Fqd+t5ML2Flv+QdTH5KRAM1Nfhr5KTJR1OwdnIkO6+SEiXJCmCEE+II5l5PBhd
	 EciwvOclLXNLQ==
Message-ID: <1bc36cd4-0a8c-4ce2-9852-43ff1cb17a08@kernel.org>
Date: Sat, 21 Mar 2026 17:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
To: Nelson Johnson <nzjfr547@gmail.com>
Cc: andriy.shevchenko@intel.com, adrian.hunter@intel.com,
 ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <23a36448-9006-47c4-9709-615a889ebd95@kernel.org>
 <20260321152501.6162-1-nzjfr547@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260321152501.6162-1-nzjfr547@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Mar-26 16:25, Nelson Johnson wrote:
> On Sat, Mar 21, 2026 at 12:17:42PM +0100, Hans de Goede wrote:
>> Can you try running:
>> ls -ld /sys/bus/pci/devices/0000:00:12.0/firmware_node
>> and if that exists do:
>> cat /sys/bus/pci/devices/0000:00:12.0/firmware_node/status
>> I wonder if the PCI "slot" does have a ACPI companion-node
>> and if that has a status attribute, and if yes to both what
>> the status attribute says.
> 
> Done. Results below, collected on Debian vanilla, Fedora Live
> without Secure Boot, and Fedora Live with Secure Boot enabled.
> The results are identical across all three.
> 
> firmware_node:
> 
>     ls -ld /sys/bus/pci/devices/0000:00:12.0/firmware_node
>     lrwxrwxrwx 1 root root 0
>         /sys/bus/pci/devices/0000:00:12.0/firmware_node ->
>         ../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/80860F14:01

Ok, interesting so the 80860F14:01 gets seen as a companion
to the 0000:00:12.0 PCI slot/function. Even though it looks
like 80860F14:01 should simply be a standalone ACPI
enumerated SD card controller and 0000:00:12.0 should not
be visible on the PCI bus at all.

Note both PCI 0000:00:12.0 and 80860F14:01 point to
the same hw, but typically only one of the ways of seeing
the hw is enabled for the OS. Well I guess that is the
case here since 80860F14:01 reports _STA = 0.


> 
>     cat /sys/bus/pci/devices/0000:00:12.0/firmware_node/status
>     0
> 
> ACPI device status (identical across all three boot environments):
> 
>     80860F14:00  status: 15  (eMMC controller, working)
>     80860F14:01  status:  0  (SD slot companion, disabled)
>     INT33BB:00   status: 15  (present)
> 
> Identity of 80860F14:01:
> 
>     hid:  80860F14
>     uid:  3
>     path: \_SB_.PCI0.SDHC
>     adr:  0x00120000
>     hrv:  1
>     physical_node -> ../../../../pci0000:00/0000:00:12.0
> 
> Identity of INT33BB:00 for comparison:
> 
>     hid:  INT33BB
>     uid:  2
>     path: \_SB_.PCI0.SDHB
>     adr:  0x00110000
>     hrv:  2
> 
> The adr fields are notable. 80860F14:01 has adr 0x00120000 which
> maps to PCI 00:12.0, the SD slot. INT33BB:00 has adr 0x00110000
> which maps to PCI 00:11.0, a different device. INT33BB:00 does
> not appear to be the ACPI companion for the SD slot.
> 
> 80860F14:01 at path \_SB_.PCI0.SDHC with physical_node pointing
> directly to 0000:00:12.0 appears to be the correct disabled
> companion for the SD slot.

Right but the 80860F14:01 dev being disabled seems correct, since
it should only be enabled when PCI enumeration for  0000:00:12.0
is disabled.

Given that it is weird it has an _ADR ACIP field at all, since
it is not a PCI companion, it is another way to enumerate
the same hw when PCI enumeration for that "ip block" is
disabled.

> Regarding the BIOS mode test: the N22 was booted into Fedora
> Workstation 41 Live both with Secure Boot disabled and with
> Secure Boot enabled. In the Secure Boot run, dmesg confirmed:
> 
>     secureboot: Secure boot enabled
>     Kernel is locked down from EFI Secure Boot mode
>     integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA
>     2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> 
> I did not observe any BIOS mode switch. The ACPI device status
> values were identical across all three boot environments.

Ok, thank you for trying.

Have you looked for a BIOS update from Lenovo ? Also have you tried
to do "load setup defaults" or something similar in the BIOS ?

It is possible that the layout of (hidden) BIOS parameters has
changed between BIOS versions and the updater was not smart
enough to wipe the nvram. Then you're using a set of hidden BIOS
parameters meant for an older version which can wreck havoc.

Given how funky this all is, looking for a BIOS update +
doing load-setu-defaults + save in the BIOS would be one
of the first things I would try.

> Fedora dmesg shows the same broken sequence as Debian vanilla:
> 
>     [   14.272600] mmc0: SDHCI controller on ACPI [INT33BB:00] using ADMA
>     [   14.285627] mmc1: SDHCI controller on ACPI [80860F14:00] using ADMA
>     [   14.375047] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
>     [   14.456554] mmc0: Failed to initialize a non-removable card
>     [   14.457130] mmc1: new HS200 MMC card at address 0001
>     ... sdhci-pci 0000:00:12.0 repeating, BusMaster- throughout
> 
> The full acpidump (233KB) is available at:
> 
>     https://pastebin.com/PVmW1Lkr
> 
> Given that 80860F14:01 is present with physical_node pointing to
> 0000:00:12.0 but disabled with status 0, would enabling it via
> the override_status_id mechanism in drivers/acpi/x86/utils.c be
> the right direction? And would that alone be sufficient to let
> the correct ACPI path own the SD slot, or would INT33BB:00 still
> need to be handled separately?

I think that the whole INT33BB:00 device is a red-herring and
can simply be ignored. It uses SI0A as base address, where as
80860F14:00 uses SD0A as base address.

These Braswell chips have 3 SD/MMC controllers:

1. The eMMC controller, this seems to be ACPI [80860F14:00] on your hw
2. A SDIO controller for SDIO attached wifi, this seems to be
   ACPI [INT33BB:00] on your hw and is unused (Wifi attached over PCI?)
3. A SD card slot controller, this seems to be pci 0000:00:12.0 on
   your hw, that or ACPI [80860F14:01]. I suspect things might work
   better in ACPI [80860F14:01] enumeration mode, but that would require
   disabling the PCI enumeration otherwise things get even more funky ...

So I think the INT33BB:00 device describes the actual SDIO controller
and you don't need to disable it.

So the first thing to do would be to test your original patches without
the patch to disable the INT33BB probing in the sdhci-acpi code.

Once we've confirmed that that patch is not necessary we can look at
fixing the issues with the PCI enumerated sd-card slot controller.

And yes trying to override _STA for 80860F14:01 is an interesting
experiment, this will give the shdci-pci driver access to the sdcard
detect GPIO I believe. And also to some power-management functions,
so maybe that is enough to fix things.

Since Linux sees the 80860F14:01 as a PCI-companion it should not
instantiate a platform-device for it, so sdhci-acpi will not
try to use it.

But first do the bios-update (if available) + load-setup-defaults +
save thingie please.

Regards,

Hans


