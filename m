Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCEE6D1BC
	for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280513; cv=none; b=VGHR4eRc7U8p9GR3vL9J3tyQlkDWheripJPs+Hdr5IzUYgKZgdA3LwYYk8RNcGfZCSbmWc326B2Vk8RsgjXopH7Ok0Q9vkqCoFZLSeHVGXWwDs6bRTPJtjSYdNvDnqBWobL5k4aj11Fns777983ylqiyRC9lmqjwfU9XBPszALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280513; c=relaxed/simple;
	bh=NlwH4SiK0L+gpnBQwJDh1NjtO2j/huh8EReOYhlSk/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWqW/5E+L4oO8+mSGtZbWRsZBGNvIs6Ny3WnoCsT5tK81ZCtrY0dxng54IJIIZEdR7OWQBJ38V5WGMZ16q2zqtuWtNiXUlaSRDoWRSaCnUiU0sEiTPD8Xm7a1ZMOYkLMMOdke84XeM1XEY2AZpkznFQ4Zv3UtGNBENZABhSELkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fk867RZm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fk867RZm"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so11334224a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716280508; x=1716885308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vQHIjPxEVF2pY5wEilHDdYPpJmasWX2rT/NqjXEStQ=;
        b=fk867RZmCVaQXvgTMfM7zNOOJLl9jkcS6L4VJPjGQ58ozg81tJocOecSCbGzqsyDeg
         yNIZFRVELfNO5l2wxPry/bs3nMKxj6LoWs+iX3unfnFXh1i4Iq8qvD9GhGCC3Ybe17Jc
         bFHt9M1xhhLVXM5rXmu1/TvzpqTbE531AcxX8UmMxsvxjxxYRcAzlVsMbHtnMhR6sNLs
         H4y6SkXxMB/AC/DLSwpKzLQs/QDQGONm0g6l2h0De676vwLG1FQlm26VO2eVmXptlrXW
         ECLw2++u5ISKdHUCFQGQ+3vwCORzsqRlJdRgcWx9ws6DcrND5P2gi/5j0FioZn+yI6Dm
         sMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280508; x=1716885308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vQHIjPxEVF2pY5wEilHDdYPpJmasWX2rT/NqjXEStQ=;
        b=SyIU+vmsENS7J3uxUz/UjUkEd731cfk1vngFexrZTSz/neCtitZooubXfChKrW1Ims
         jg603OAl7IawHbIRNAn1iMAVuzgwP56UgpQWMVS4NzdogacITiRi3lQ4W0Uako2v9jPI
         qAV8iPE8YwUTX9KLBPzsM/8g+z16zdsKugCa0q9P03Sbr9YgM7kTQx6zOhZWs+RNSw3C
         1bBw9apRkMot84Krtf/cB5O0lpk/GpaKK+BpNBA0+gyh7n6i/2UKMegWAyIGhv9Zmyfc
         VJAdsYEgpF0xXJINClnhwaRnwesXR1T+rA2NBR8vGLXhNkf1o9AEtyf3pHT4Dl/R03u3
         tBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVydBnmCYs8x1sgGoZm4iPjZJ4hpR38r9es6xJziLTpOSIwLEHfsd2wy0zylIGllaSMt6dAHWCrPSOWY06Rq38lDGpfibmXO2oU
X-Gm-Message-State: AOJu0YwV5UhRMt8CyKWQFumv1iO1Tx2qMvECzXDZRX0AFqkwIUaGILVZ
	9QpkxhWiY8f3XSnTkBWvcxXYjomW/D90VjdUrIjPXoWOFWmfs/FmYtpvDym+cMw=
X-Google-Smtp-Source: AGHT+IFCxVzIMzseBlri9Hon45PvliI+L9gLB+9KrD/2MfBm36727haERcz0qRBqSpr70+AwqkXdaQ==
X-Received: by 2002:a50:9993:0:b0:571:bed1:3a36 with SMTP id 4fb4d7f45d1cf-5734d707663mr32792639a12.38.1716280508047;
        Tue, 21 May 2024 01:35:08 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575058cd7casm6870293a12.65.2024.05.21.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:07 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v3 0/4] Add minimal boot support for Raspberry Pi 5
Date: Tue, 21 May 2024 10:35:12 +0200
Message-ID: <cover.1716277695.git.andrea.porta@suse.com>
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
- Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/
- Link to V2: https://lore.kernel.org/all/cover.1715332922.git.andrea.porta@suse.com/

Andrea della Porta (4):
  dt-bindings: arm: bcm: Add BCM2712 SoC support
  dt-bindings: mmc: Add support for BCM2712 SD host controller
  mmc: sdhci-brcmstb: Add BCM2712 support
  arm64: dts: broadcom: Add support for BCM2712

 .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   4 +
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 292 ++++++++++++++++++
 drivers/mmc/host/sdhci-brcmstb.c              |  65 ++++
 6 files changed, 432 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi

-- 
2.35.3

