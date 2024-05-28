Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018516F833
	for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903181; cv=none; b=NozMHg68/+b9NLdElu1eAM2lfxesQS31QWZcIk8I8H8CJ7RTEQkHIBP+UsiXSVQHUtWs+3tb65Sml0cujlMcU/ogYpxN9pI6iqQPPL7CVqhgpGtSHBDOXKZD4GXOaHRx2mPY7zdCpbObbyB3J7Yyw5yXc8BTIfXDNJka9VOgAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903181; c=relaxed/simple;
	bh=Kx5PIBsi9TiJFzL5biKh0/43+r59JQLiy9MCVpZhWW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QycvxFOn8vTFgHwHbS4TfvNsuTwlK52B9CTDzg1L6LOSPCHWq60G4Oem722on+HlIRCvN1G729tCiQ3aUMyzgz3YKLhzfjp0+b1jJzNcP8Jrn6fD4MCGabXqJ+5iY4bK05pLAnxQDhqTNGFWq7OAca0Hkm0LgtPfScww2owcP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JrsCmhAm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JrsCmhAm"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a62db0c8c9cso93879666b.2
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716903177; x=1717507977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hV9/NpvQeVfS2FB9bvuiNpWNHm5hbztiDskWAIVLpAM=;
        b=JrsCmhAmVHTHJWBzDPisy2VCCTLEUCaWvnVg1tSDbV3wBybOB9/HBtPUERpXlA0KeG
         C21M6T9xssRemBmfXxuS4aMyDPBXvFbJETbXV/vD2CJ49aukzovRzehI33TQNO8KxYvR
         tc9bsfj+4Kh2PZ05J2tkIsFefZ/Y61++xyx3n5bve2hkWj0Ni+XgFx5LjpjaGj5EHezU
         FTuNMpaFHfPmT5xOBle2Eb3zqZsMrbWFVy0TPvJ968Ebn6Ma0+omjTVwg/4TNPtlQwlB
         lCJ9uieGYwfYurwEd++XjmBSmSiWqvMZjp5lApZzl9RNsd29g41wDzVtW28bZ7kF+hGD
         St9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903177; x=1717507977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV9/NpvQeVfS2FB9bvuiNpWNHm5hbztiDskWAIVLpAM=;
        b=PYUTn4Ls7aSTNO2vQM05iWt0tyDa+oZmvXDrmXMjxHaMM8apjCPhzEe+aVOwWxaIbo
         na67UbvprNLfym2hFmFI3AEV9XDG8WM269dZ/uMgeTe+IYj7MnP+sPw0jlYTep9Qc9Dr
         3qjp5jDymiRX8pK8mQw/aprIDlYuOzU3Es2AiiECSAIxZ+vWH0GRIsrcgkssdSEyA0tU
         ndbxdci95u/agIkyUpbSw69afSFP7INBStzPW5nLtdJN/y0taAJ49ss92J5Z0EfYJ4R+
         TucHE2rHfvaD9KM378Xl3H+fTtpsPpzt4WUUJGIf1GeVinJ2scch5x7/5ExoxcmRrXJW
         FIlw==
X-Forwarded-Encrypted: i=1; AJvYcCXj/YzdgXH4q9ttDWzwgyfRrGaYcOiaSRElwXWpwQ4leRLsJhRXXnsMHY4Tho8rmE6T2tu68K6vbTtYWUaI2SgJtBZZFo7tDLv6
X-Gm-Message-State: AOJu0YwF47bdeZOfbXz0a8Jg+bZFGizoKMxDAFJqR7pbBl0NkraHXGHX
	AQQU5btU0AmlZuTw5vAvBqy/Elf4xssghHrwBI6vOZ8C1l5vxPcLKQy0vRi1PIw=
X-Google-Smtp-Source: AGHT+IGOSdIe/yj7VDyhduAq9zG6uCm0MDb3anjNiJD7At0A+lJ6FKt2wWjOS0aW2FrATTzekEdYAQ==
X-Received: by 2002:a17:906:c106:b0:a63:598:88fd with SMTP id a640c23a62f3a-a6305989d03mr608236066b.62.1716903177354;
        Tue, 28 May 2024 06:32:57 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8a15esm622994666b.148.2024.05.28.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:32:57 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v4 0/4] Add minimal boot support for Raspberry Pi 5
Date: Tue, 28 May 2024 15:32:37 +0200
Message-ID: <cover.1716899600.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset adds minimal support for the Broadcom BCM2712 SoC and for
the on-board SDHCI controller on Broadcom BCM2712 in order to make it
possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
console through uart.
Changes to arm64/defconfig are not needed since the actual options work
as they are.
This work is heavily based on downstream contributions.

Tested on Tumbleweed substituting the stock kernel with upstream one,
either chainloading uboot+grub+kernel or directly booting the kernel
from 1st stage bootloader. Steps to reproduce:
- prepare an SD card from a Raspberry enabled raw image, mount the first
  FAT partition.
- make sure the FAT partition is big enough to contain the kernel,
  anything bigger than 64Mb is usually enough, depending on your kernel
  config options.
- build the kernel and dtbs making sure that the support for your root
  fs type is compiled as builtin.
- copy the kernel image in your FAT partition overwriting the older one
  (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
- copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
- make sure you have a cmdline.txt file in FAT partition with the
  following content:
  # cat /boot/efi/cmdline.txt
  root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
  console=ttyAMA10,115200
- if you experience random SD issues during boot, try to set
  initial_turbo=0 in config.txt.


Changes in V4:

sdhci-brcmstb.c:
- dropped the last 4 lines of sdhci_brcmstb_cfginit_2712() function
  to avoid setting the SDIO_CFG_CQ_CAPABILITY register. The rationale
  behind this can be found in [4] and subsequent comments

DT-bindings:
- simplified the compatible item list for 'brcm,bcm2712-sdhci' as per [5]


Changes in V3:

DTS:
- uart0 renamed to uart10 to reflect the current indexing (ttyAMA10
  and serial10)
- updated the license to (GPL-2.0 OR MIT)
- sd_io_1v8_reg 'states' property have second cells as decimal instead
  of hex.
- root node has size-cells=<2> now to accommodate for the DRAM controller
  and the address bus mapping that goes beyond 4GB. As a consequence,
  memory, axi and reserved-memory nodes have also size-cells=<2> and
  subnodes reg and ranges properties have been updated accordingly
- ranges property in 'axi' node has been fixed, reg properties of sdio1
  and gicv2 subnodes have been adjusted according to the new mapping
- 'interrupt-controller@7d517000' node is now enabled by default
- dropped 'arm,cpu-registers-not-fw-configured' as it is no longer
  relevant on A76 core
- l2 cache nodes moved under respective cpus, since they are per-cpu
- dropped psci cpu functions properties
- added the hypervisor EL2 virtual timer interrupt to the 'timer' node
- splitted-lines url are now on a single line

sdhci-brcmstb.c:
- simplified MMC_CAP_HSE_MASK leveraging already existing definitions
- MMC_CAP_UHS_MASK renamed to MMC_CAP_UHS_I_SDR_MASK to better reflect
  its purpose. Added also a comment.
- sdhci_brcmstb_set_power() replaced with the already existing (and
  equivalent) sdhci_set_power_and_bus_voltage()

DT-bindings:
- removed the BCM2712 specific example, as per Rob's request.


Changes in V2:

- the patchshet has been considerably simplified, both in terms of dts and
  driver code. Notably, the pinctrl/pinmux driver (and associated binding)
  was not strictly needed to use the SD card so it has been dropped
- dropped the optional SD express support patch
- the patches order has been revisited
- pass all checks (binding, dtb, checkpatch)


Many thanks,
Andrea

References:
[1] - Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/
[2] - Link to V2: https://lore.kernel.org/all/cover.1715332922.git.andrea.porta@suse.com/
[3] - Link to V3: https://lore.kernel.org/all/cover.1716277695.git.andrea.porta@suse.com/
[4] - https://lore.kernel.org/all/ZlF5dQbNpZ921e66@apocalypse/
[5] - https://lore.kernel.org/all/bc1eb98c-9d49-4424-ab89-16be6c67c3f5@gmx.net/#t

Andrea della Porta (4):
  dt-bindings: arm: bcm: Add BCM2712 SoC support
  dt-bindings: mmc: Add support for BCM2712 SD host controller
  mmc: sdhci-brcmstb: Add BCM2712 support
  arm64: dts: broadcom: Add support for BCM2712

 .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   1 +
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 292 ++++++++++++++++++
 drivers/mmc/host/sdhci-brcmstb.c              |  60 ++++
 6 files changed, 424 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi

-- 
2.35.3

