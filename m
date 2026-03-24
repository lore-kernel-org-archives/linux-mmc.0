Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CB23C512
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312074; cv=none; b=kISmVHg3xzRo+/gYF3nicU85qEbcTokFj1VPrMzX23g/WtylJIFg718mz+777UTvaEWsKOdL7C5hvswxz5OIEXd1pseRmbXVkgUISEBrgVJlYir5PZ6hfPM3NW2OitZxU16QoVgZssizvPNqA9uYdeL55XH64MEABgPjAkpfgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312074; c=relaxed/simple;
	bh=nKLIDMyH74vv66nA2TVWfE70YKJT3stMgvQSqz6KfsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijgyA3CJs5vYxaGnz/dpe+LX6pDKU9zhgA8DZ5TT/Qyg9yGojuvk1ITHm6Q+3zTR9o43oDMAWYCm0bs0qFYNsEewP7VS5t1bGtJkPfuQv925Ac3TTqiXVOMV1hVpl4YKbut6xQToZUeJi5Z06fzEuYAqJamKqlsWashW1z5aKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sADEr++Y; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sADEr++Y"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad8435f46so4004696d50.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312072; x=1774916872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiL5BJoz6A3LeyTxNl1/0LnOcUHTWakkTU0Scrvg97g=;
        b=sADEr++YO7xSno6w7WocMbHYy4TZuGCcBF4jP4Xey9B8uUdRtNlXE30hgDnJgx3w3c
         uqAu3LmZKaVPdr4ugzt9CD1mbYovpZdfZUdXRASPLE432N553Syl0dfI3ptxhg2opYnF
         MyWZDYR4gpHrN6IMVOg7QW6eeiwHcM996oXtdvwHVIteJNTKRoRwIrwglpJXEOhi/L5S
         9X4fLXS/DQFqNSsfQ4ZXlb828eMw3Zh2Jv14BqBgsGadox0T79P+FNOYomJt6GHAyr5M
         l68R0gn9ZS38P7mjPLDSDQV0LDF9tFyK8WF/yzNKvWh4UBi+G1s5h8DwFhZILAZjrwaN
         XmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312072; x=1774916872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiL5BJoz6A3LeyTxNl1/0LnOcUHTWakkTU0Scrvg97g=;
        b=S3QWHfVGY5vLEb00q+RoBwSA0ZamifS29yTm6OCgE2qIn1KsPKZ9FrESy95YxSuc0w
         E46v4jNuC6nW5JuOHKJXSFZp/XgH77/lgvzJdpz0+8xBH6VV5UmwYBeA7SFZVSLRA0Cu
         Ehut8CuxI0/E3xZiLAkwcF05iR5M661SnnS7RFPzywxIoCeFz6xhJYGp62j0oDCqQk9r
         87HwDgXFCLrcL2Ugb9kY5j7N1VFyRRgC3L5LF+0/NtKHnL/T9HBN2Dau0AQ+pMqI3oRm
         pSF3kKL9WxId4f0dltt5Rb0NMOg9tADm2w5VuPokz9EXOa+BaR7GUmjMjVFoMBMdBpkS
         Z/mA==
X-Forwarded-Encrypted: i=1; AJvYcCUtCn3yP8QfP8rc67JlSLNzJQlgZRYwqkcUn/+3KwAiU8nU7n6F69lvxGz3eKFLEMNbYQ3WgO+KCu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0ps2bX6u6szXKzm8NXn9rvx1r9UWUk6hRx4aOW9xEgKE4Hc1
	a2VfZVyXMoaopuAl+g16GThz0D5UGB7oWL/qU4aD8JmZn39mUY9Dwt4W
X-Gm-Gg: ATEYQzwId39Ho1n8FyMWM95lfFsqR7lKgxeWBR97YO722lBdVv/9G34SRXeOMFVacXZ
	IGMyhojhUXqSufJlOHFj/anyTZLahihYvCWVL7Dr6xkY/1cY0ZYQa0v8hVk97H8A3D8VL0reg1q
	VY+/xClhr7GyfC8G7zgwbburn2MPL98FybdyWYKi/8I5qCTjKxXJCtCAYYEWkB1lIc2QlV3PbhR
	u/8Sgsq/JeFQLBXPrJ04/FfZeNavqVYA/zUfJ1CPsGY1cI0a9l669+se2ZTsPrIbfz230so2J7J
	MSzV5LR629s6CTb4T46Y6UGlmsJUzqvpHSV8MBbh7jmFWOKxqfetlDcDnMfjkkGvhtLi+aRCqSM
	vzpKVWouNFC1yagdA5vBgQJ6Hlk/S2OAMnZHJQgFU1RfsRBJwfMV3DksZBP4h/7FKk+K9SvVoDI
	cfKUKlLuvhXwloFy33EaEgkMj5EAcd/6jT7aULhHUjR1fnjd1Nrg==
X-Received: by 2002:a05:690c:f08:b0:79a:8f2f:c86 with SMTP id 00721157ae682-79a90c12e78mr142294837b3.49.1774312072467;
        Mon, 23 Mar 2026 17:27:52 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903f4190sm65233507b3.15.2026.03.23.17.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:27:51 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: hansg@kernel.org
Cc: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Date: Mon, 23 Mar 2026 19:27:48 -0500
Message-ID: <20260324002748.21107-1-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1bc36cd4-0a8c-4ce2-9852-43ff1cb17a08@kernel.org>
References: <1bc36cd4-0a8c-4ce2-9852-43ff1cb17a08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Mar 21, 2026 at 05:14:44PM +0100, Hans de Goede wrote:
> Have you looked for a BIOS update from Lenovo? Also have you tried
> to do "load setup defaults" or something similar in the BIOS?
>
> So the first thing to do would be to test your original patches
> without the patch to disable the INT33BB probing in the sdhci-acpi
> code.
>
> And yes trying to override _STA for 80860F14:01 is an interesting
> experiment.
>
> But first do the bios-update (if available) + load-setup-defaults +
> save thingie please.

Results of all three tests follow.

BIOS update check:

The N22 is running BIOS version 0YCN26WW dated 2019-03-11. This is
the latest version available from Lenovo for this model — no newer
version exists. fwupd confirms no System Firmware updates are
available. Load Setup Defaults was performed and all visible BIOS
settings were reset. ACPI device status was unchanged after reset:

    80860F14:00  status: 15
    80860F14:01  status:  0
    INT33BB:00   status: 15

Stale NVRAM does not appear to be the cause. This BIOS was present
during all previous testing reported in this thread.

Patches 1 and 2 without Patch 3:

Tested on a kernel built from the vanilla 6.19.6 base with only
Patches 1 and 2 applied. The SD slot works correctly without
Patch 3. sdhci-pci binds 0000:00:12.0, BusMaster is enabled, and
the 128GB SDXC card is detected at UHS-I SDR104. INT33BB:00 still
fails to initialize as a non-removable card but does not prevent
sdhci-pci from owning the controller. Patch 3 is not necessary
on this machine.

    [    3.055743] mmc0: SDHCI controller on ACPI [INT33BB:00] using ADMA
    [    3.063153] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:2296] (rev 21)
    [    3.063881] mmc1: SDHCI controller on PCI [0000:00:12.0] using ADMA
    [    3.248057] mmc0: Failed to initialize a non-removable card
    [    4.007369] mmc1: new UHS-I speed SDR104 SDXC card at address aaaa
    [    4.179918] mmcblk1: mmc1:aaaa SD128 119 GiB

    Control: BusMaster+
    Kernel driver in use: sdhci-pci

override _STA for 80860F14:01 experiment:

Tested on a vanilla 6.19.6 kernel with a PRESENT_ENTRY_HID entry
added to the override_status_ids table in drivers/acpi/x86/utils.c:

    PRESENT_ENTRY_HID("80860F14", "3", INTEL_ATOM_AIRMONT, {
        DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
        DMI_MATCH(DMI_BOARD_NAME, "N22"),
    }),

The override did not change 80860F14:01 status. It remained at 0
after boot. sdhci-pci did not bind, BusMaster stayed off, and the
SD card was not detected. The broken behavior was identical to
vanilla. The override as implemented here did not take effect.

Given that Patches 1 and 2 alone restore full functionality, is
a two-patch v2 series the right next step, or is there something
further you would like to investigate first?
