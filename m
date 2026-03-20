Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033C2EC0AE
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048033; cv=none; b=UThICpHmzOvLL3XN4+SdmRpYuYP8p0xHKrAfwtJAXXTq/lvNeTxeUFS3nsA+xOICBIWyB+57LHa8M1YypLiNM6nfV6acTo3o/NZ+VMdAPqTvLwPkmmMTJWeGAhby7HkuY996fm7q+50SnEgQnwwz6HWOcrF7Zu+VS+LSWwhS66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048033; c=relaxed/simple;
	bh=/xOopYFRCYcYFC1cEQcAs45V8mZtcpzGipALuKLSM5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7QJlv/egbFBJZyC1NOFMTN5in5AzlazZCwm2hQXOOdVNwTXWJEIFVX2s9POZ91FFqOc/mj1vnE9jMlSZY4VNQoCJIti1VjkQT3LCfy/rWazyJY82mQoh4rkk0+jJdCv0um6Mxzr7PXyZtys3JJrIL0u72o0851fQdZ2xRhtQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei7WJE78; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei7WJE78"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a4e5caad6so26905737b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774048031; x=1774652831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/AGxbL20S6dIlae3JMf3cMtITIBgBqCIllzp1bbe8g=;
        b=ei7WJE78SV1rbrKxK4iti9r8iTLm5TvwRLQ0jc1+N9gN4QglASbSyondfAF/ZjiOHb
         F+RW+zl9AX1iK1p+h+Bk8Be33RAzwfxgeC9gKzIXO19U0fARfw61PggPEo3xRllw9sEf
         mJVw15i3ptyxN0+nelsp38r2Ift9+gDxUaGQEljcEbi/YFiKYtElr1xsfxYqrsystE/E
         0iBbjCSD214kSoVQFuAtkE0q9s4o08LeYgXNUgaYIKw1mAr30ng3BXqwcnUmN7lpKiNF
         eiI3gxfTkAqni5MQ2346mbtZPw8DDQmu57dKjjrTk4MLYN/vXK76wlPGtT/cia3gRGvM
         wzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774048031; x=1774652831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/AGxbL20S6dIlae3JMf3cMtITIBgBqCIllzp1bbe8g=;
        b=NIZ89ONfaGi9T4aXX5POCnI3Amh7dsLGk28WAbLAO1e45QhALjUgkRCjeE0CPgTLat
         tuoI4ufc5c4j3x8DDq4b+HSPvvQaokr2IznxNK5cy60W2vdNOoGHqBzrmQoxB9qY2nWh
         gq9+qklAm0aNDQbpEMHYs1sbo0q0HMhQWNvB5tdV6x6EeTH3ZOJO3TrvTFgUHfRlPxYf
         e0mQsseZPf7/0opaeoyihgI895cEMNf1WKSqTKARwGuJxgFBKCcxRMR1taRohn1nkwCr
         vGTt90ZTVx07wKltCr0Kxo/BZNrIEg0ioXsEDL5GehwgUor2I0sDAg+bdp2/YSA3wljD
         lRBg==
X-Forwarded-Encrypted: i=1; AJvYcCU9bl0SJAgTHv9Wwc3Pofv4t4+KMNbruzvVzoivNttVfJxyqf4vKi3jLQ9esdSB5D6dgqJDyLEfcLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWw2eUr8tPhqBEd+d1KXOTdB8oxmnZiuMe23oPwoBhN5vcuXE
	up2XnE9D37d4a0U04PIncLDNPOOcvyNAJ6ZZPiro8TI4FwZHE5qcjDu2
X-Gm-Gg: ATEYQzy0zkniRNRBNFAwofwjTrlopIOpVP5yKO8iLQ/zNsagwlNAtG+mAMYnOQdRQbi
	+jnD8YdngxXDa+WYwVBS8nDXslntji9XewO8i3pqIcSQ9xesnS8JIAFVEEikHLdYOKElHoHbV3e
	1u13ZulIE8zOCUyOgfFiEuRWZ6CQmN0YACBAn/fkuFD2rbt1UXlLkkIIbTO4aZFNMJC7GVbzGUm
	qM7m5Bxm6SATv7DxXRLkbSP6+UZSpOqCQ733P9PVN0iT52eu2a08MzE3dYfxuEas2FUeHNL3eKD
	7Ty4K3qYafCIAEnV5V3lIaw7fmcxWkPN104jQVWqEMNpP0zs4yBI8rjqGoeJZJKaitLapQheelN
	msnC0ET3cc/D8aUXeFqhhciItoxBg0iyrXcja/HEudVKhM7C0gD+mXDm1UTGOvmOJtK6vZUBCeT
	N4TLnbYQ/UA1uIsLmY1qhIkEgKe2LSJoTd8ix+Nmn2usIRZka2Ag==
X-Received: by 2002:a05:690c:c4e8:b0:79a:3a33:94f with SMTP id 00721157ae682-79a90be783cmr53568687b3.48.1774048031372;
        Fri, 20 Mar 2026 16:07:11 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90580d7csm23142097b3.37.2026.03.20.16.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:07:10 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: andriy.shevchenko@intel.com,
	hansg@kernel.org
Cc: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Date: Fri, 20 Mar 2026 18:07:06 -0500
Message-ID: <20260320230707.3122-1-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ab2NKT4uioc8O-7-@black.igk.intel.com>
References: <ab2NKT4uioc8O-7-@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Mar 20, 2026 at 07:08:41PM +0100, Andy Shevchenko wrote:
> Can you share ACPI DSDT excerpt (from DSDT table of firmware, you can
> get it by copying file from /sys/firmware/acpi/tables/DSDT and decode
> it with `iasl -d DSDT`) and output of `lspci -vv -n -s $SDHCI_SLOT`?
> Because it might be that the problem should be solved just by providing
> better fixes to GPIO detection or so.

Here is the requested data collected from the N22 on a vanilla
6.19.6+deb14+1-amd64 kernel with no patches applied.

DSDT INT33BB section (decoded from /sys/firmware/acpi/tables/DSDT):

    Name (_HID, "INT33BB")
    Name (_CID, "PNP0D40")
    Name (_DDN, "Intel(R) SDIO Controller - 80862295")
    Name (_UID, 0x02)
    Name (_HRV, 0x02)
    Name (_DEP, Package (0x01)
    {
        GPO1
    })
    Name (ABUF, ResourceTemplate ()
    {
        Memory32Fixed (ReadWrite, 0x00000000, 0x00001000, _Y04)
        Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive) { 0x0000002E }
        GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
            "\\_SB.GPO1", 0x00, ResourceConsumer, ,)
            {
                0x0005
            }
    })
    Method (_PS0, 0, NotSerialized)
    {
        PSAT &= 0xFFFFFFFC
        PSAT |= Zero
        If ((PSTS == Zero))
        {
            If ((^^^GPO1.AVBL == One))
            {
                ^^^GPO1.CWLE = One
            }
            PSTS = One
        }
    }
    Method (_PS3, 0, NotSerialized)
    {
        PSAT |= 0x03
        PSAT |= Zero
    }

Two things stand out in this description. First, the _DDN names the
device as "Intel(R) SDIO Controller - 80862295" rather than an SD
slot, and _UID is 0x02; in current sdhci-acpi.c, INT33BB UID 2 maps
to the SDIO slot profile rather than the removable SD profile. Second,
the GpioIo descriptor for pin 5 on GPO1 is IoRestrictionOutputOnly
with PullNone. My reading of the AML is that this looks more like an
enable/control line than a card-detect input, but that is an inference
from the firmware description rather than something I can prove from
the AML alone.

lspci -vv -n -s 0000:00:12.0 on vanilla kernel:

    00:12.0 0805: 8086:2296 (rev 21) (prog-if 01)
        Subsystem: 17aa:3807
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
                 ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
                >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 91315000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
                   PME(D0+,D1-,D2-,D3hot+,D3cold-)
            Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Kernel modules: sdhci_pci

Note BusMaster- on the vanilla kernel. With the patch series applied
BusMaster+ and Kernel driver in use: sdhci-pci.

Vanilla dmesg for SD/MMC:

    [    3.142590] mmc0: SDHCI controller on ACPI [INT33BB:00] using ADMA
    [    3.155518] mmc1: SDHCI controller on ACPI [80860F14:00] using ADMA
    [    3.356405] mmc0: Failed to initialize a non-removable card
    [    3.358473] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
    [    3.397615] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
    ... (repeated approximately 30 times over 30 seconds)
    [   30.066835] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)

The observed sequence on the vanilla kernel is:

  - sdhci-acpi binds INT33BB:00 and creates mmc0
  - mmc0 then fails with "Failed to initialize a non-removable card"
  - sdhci-pci repeatedly reports "SDHCI controller found [8086:2296]"
  - lspci -vv shows BusMaster- and no "Kernel driver in use" line
    for 0000:00:12.0 throughout

That seems consistent with the ACPI path binding the
firmware-described instance while the PCI path never reaches a
usable bound state.

Given the output-only GPIO descriptor and the current non-removable
SDIO mapping for INT33BB UID 2, does this point to a fixable ACPI /
GPIO-enumeration issue, or do you think machine-scoped exclusion of
the ACPI node is still the right direction for this firmware? I am
happy to test any suggested patch or approach on the hardware.
