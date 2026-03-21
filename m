Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC0372B3C
	for <linux-mmc@vger.kernel.org>; Sat, 21 Mar 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106711; cv=none; b=OQyCq62JWIojENJS6c/+4wtDxCQyJpklsJN9TT+EYzR8YkUTv5eSgrunmU+dZ6JuoJW9pZZ0Nb/JJO8im2yexE0EGPzbtc67JX/WgCbplhaKWuEsDrv5CAGvu8THbfZ8KdjRXURGmd62pgGtDWa8i7FetbalnViXBXaGC7WBmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106711; c=relaxed/simple;
	bh=eSNSiENy4XxPdpwIgLMnhvXnkEFO7/OoDXFskgT0OVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apSKnpEQ8N0zMc6wWfY28mnwEtrrRdmM/nkLjMFMW0JggP+hh4qb1DQROb5eHqGp+aR8uwZexbnRf9oQeCKfK+mepiFCRj3b6GNIYXozRuvXdsxuputJlDxWJXT7Evxdf1Xm92mCHC3davsXCGod3IT4BA94zAdAHF/fdR2eYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb3KvRm4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb3KvRm4"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a8e873ca1so20429287b3.1
        for <linux-mmc@vger.kernel.org>; Sat, 21 Mar 2026 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106709; x=1774711509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JkAYp0DNEaYYYhz89+V8K6QwiW4PneT255dfXH2k2o=;
        b=Vb3KvRm4f85d8HHhCZ1kYfaHXnesF8QjDUTBuKwPEAawYVBaeX0DAtDTakq35mZNpG
         IkS4PGq2QK8VVtIKl/KGG737Sgv9LD6jUngjQWAmr9BmEolReWOZlPHOdCskdCaEceSW
         pS5ZD7OHj+cB0bQkwqHTnrf0wHLnhcbyaap3w9a4JMuUB8ZNqzjtf2p0NykjjXyAsLpB
         mx25GJ94nU897tHRMdu6cb6Dm9z9YlkR7TJ46sQONB5PBDPtoHQLjAllq4ZW4ptP2/so
         wOX+RqJbaK90QnetzB/NhkmkjP5UoTRKOK5Kd6bDHjQXr2Z7SLY0Ir64M7/C3V/G8RoS
         lz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106709; x=1774711509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JkAYp0DNEaYYYhz89+V8K6QwiW4PneT255dfXH2k2o=;
        b=iVYpHoKEvBWuKdtehAcZv1PCDPl/juhn0UjvbI/pSqw70K3PWybTLKCvUt+PK2OImw
         JmlaLtDFWto2Fq5gDLB28+akzgiXbVzvPg16dW6W94rKKPBrFW9QW1HyBroLlCYOypKK
         d4X8rbCs3zXGXhDMh+bU67+17q+Pcvl4L44nBYDvYa0NAYumu/+ggvdbVQ+gsad19l/A
         UMRrls0BtR0z4mnjbcBN6fZ6gCa7ZRJFEleeEpmHRF4QYQyqhlD2EUhBjCNHE5ianC4Y
         ON9AvV0MhglI0Oy7j3fHicUXo0Nn8wkn2wzHxpDdym8BCG/2C33KgXe+CmBG3pZL2K06
         tMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo9ZrYgSfT2osJkceBl/ud9WF5w1C4SBl7Cx7cAbTBQ2pUKUK8+napWMxv0mPY19DkXWkKraIW1HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8Jw7/cU3ZTTk5ux4qMFs9TuHQ5ghNRxMpGEp/EFoMJlWgPl/
	e6kri0CvVT9s8EkQQDX0mYNhI/vlrF09CgOIKkKqSQL3xWoy9Gco3fLz
X-Gm-Gg: ATEYQzyDmpx38gLNjG+IGs1NITiU05XrPKaDpLeOrsMzDugPxv97Gn3Rb/xP31lWXL5
	0CZ6HkCTTU7e2fOVPNAeTN3ZMn4b3KN79AogPI5f3QQRPRVIdks69SA4PQ8FgR6+W0nm3T5TMYr
	bNT5q86P13YkUJcET3z9pXKrFjXzKc/NXx9kiMI5O6/iQjs4NieWbzLOLWqGVrucDqXdiW4aDA3
	lcMOUeuzrIlzKz1aEAfhyrtLDotIZ82WnTKBIQt9n3rnOMhrcxxxGCTlZYliEa9qPeR3cqUxlnu
	7UZeNWqd/xiL3uPVr30LSJSFL1HHOso0gegp04BljVG8/nIApU6n/zMSiBEQaEhCmh75UO0xfo1
	whyhOOYTCWFismg+VlAiQb5xrf+IvXfzxy1PWTtlHIyHsnNM4PgDGh5EB+mD5V3ZvlS4o5Axybr
	kShIQ2mkGUYYD+3vptGxHepADAs3AS31FzhMqQH5ejztVG/MyKjQ==
X-Received: by 2002:a05:690c:c1e:b0:79a:535e:75ae with SMTP id 00721157ae682-79a90313bb5mr68362407b3.9.1774106708762;
        Sat, 21 Mar 2026 08:25:08 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a905ba0a9sm31469167b3.46.2026.03.21.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:25:08 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: hansg@kernel.org
Cc: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Date: Sat, 21 Mar 2026 10:25:01 -0500
Message-ID: <20260321152501.6162-1-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <23a36448-9006-47c4-9709-615a889ebd95@kernel.org>
References: <23a36448-9006-47c4-9709-615a889ebd95@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Mar 21, 2026 at 12:17:42PM +0100, Hans de Goede wrote:
> Can you try running:
> ls -ld /sys/bus/pci/devices/0000:00:12.0/firmware_node
> and if that exists do:
> cat /sys/bus/pci/devices/0000:00:12.0/firmware_node/status
> I wonder if the PCI "slot" does have a ACPI companion-node
> and if that has a status attribute, and if yes to both what
> the status attribute says.

Done. Results below, collected on Debian vanilla, Fedora Live
without Secure Boot, and Fedora Live with Secure Boot enabled.
The results are identical across all three.

firmware_node:

    ls -ld /sys/bus/pci/devices/0000:00:12.0/firmware_node
    lrwxrwxrwx 1 root root 0
        /sys/bus/pci/devices/0000:00:12.0/firmware_node ->
        ../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/80860F14:01

    cat /sys/bus/pci/devices/0000:00:12.0/firmware_node/status
    0

ACPI device status (identical across all three boot environments):

    80860F14:00  status: 15  (eMMC controller, working)
    80860F14:01  status:  0  (SD slot companion, disabled)
    INT33BB:00   status: 15  (present)

Identity of 80860F14:01:

    hid:  80860F14
    uid:  3
    path: \_SB_.PCI0.SDHC
    adr:  0x00120000
    hrv:  1
    physical_node -> ../../../../pci0000:00/0000:00:12.0

Identity of INT33BB:00 for comparison:

    hid:  INT33BB
    uid:  2
    path: \_SB_.PCI0.SDHB
    adr:  0x00110000
    hrv:  2

The adr fields are notable. 80860F14:01 has adr 0x00120000 which
maps to PCI 00:12.0, the SD slot. INT33BB:00 has adr 0x00110000
which maps to PCI 00:11.0, a different device. INT33BB:00 does
not appear to be the ACPI companion for the SD slot.

80860F14:01 at path \_SB_.PCI0.SDHC with physical_node pointing
directly to 0000:00:12.0 appears to be the correct disabled
companion for the SD slot.

Regarding the BIOS mode test: the N22 was booted into Fedora
Workstation 41 Live both with Secure Boot disabled and with
Secure Boot enabled. In the Secure Boot run, dmesg confirmed:

    secureboot: Secure boot enabled
    Kernel is locked down from EFI Secure Boot mode
    integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA
    2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'

I did not observe any BIOS mode switch. The ACPI device status
values were identical across all three boot environments.

Fedora dmesg shows the same broken sequence as Debian vanilla:

    [   14.272600] mmc0: SDHCI controller on ACPI [INT33BB:00] using ADMA
    [   14.285627] mmc1: SDHCI controller on ACPI [80860F14:00] using ADMA
    [   14.375047] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
    [   14.456554] mmc0: Failed to initialize a non-removable card
    [   14.457130] mmc1: new HS200 MMC card at address 0001
    ... sdhci-pci 0000:00:12.0 repeating, BusMaster- throughout

The full acpidump (233KB) is available at:

    https://pastebin.com/PVmW1Lkr

Given that 80860F14:01 is present with physical_node pointing to
0000:00:12.0 but disabled with status 0, would enabling it via
the override_status_id mechanism in drivers/acpi/x86/utils.c be
the right direction? And would that alone be sufficient to let
the correct ACPI path own the SD slot, or would INT33BB:00 still
need to be handled separately?
