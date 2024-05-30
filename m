Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F87167DA4
	for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063914; cv=none; b=c72egIraLNeF1h4C1FR0SbHT3fRylQ8aZoTxsZxqkZe4dhBtmezHvhVYMqxZZFSKsq/MOLPmLGu9g77fBD/jPZpmkrcuDwbTl9B0HodWAuNRqAYecLGDZ3JiBh/JNfpFsGABM5X+yTeG9tcPPuZUhvmeFnh9NC5jEJ6GACppnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063914; c=relaxed/simple;
	bh=92/FkRio4/WYku6w5ld6Cy4lbH0kdpRAHSqAB0MsR34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECaE0CtB51nLNqkbFuttZKgE8xFgcFzP/TpnUFA+IgTgkfU81Sm28RYcfyAjDmV+OiqMdEc9pN07kHTWIOrJZXzXlotdujvt/bMABzKDv6WQ3/qBWl5R+KlqCiLdLyEqdmja1fCS+0DdBmONL9GQrCe0YCU5bo3EXgixsm7zz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NAnUriZG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NAnUriZG"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so504135a12.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717063910; x=1717668710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxB6vVIAxKAJRnWfHDwiheUcKLANimvzznXfGKQj6Bk=;
        b=NAnUriZG0gLKvDDis9XdftbiHPRbndNSK6RAxmFZAEgNYSOE70wqO7zV0k7ixVPVli
         hYuhBTfVnj6fU9v2ssgBrNlmfayNPjQfEkm7sCm/oBQ1PKYD96rh8rz/qiV4W3fdu9xX
         8tKxZs4xWLF+v7TSeHvr+f1uDOns7DhbL3TXyzxyzS655CKrr2yMTLrtdvHfWcX2BQRY
         +zShPYfefJwh+IV00RE6HKXIQaV8QdWbOIxlIQVGEIeoc/AR0XJ1woDV3Q3481yXkuQY
         3ET8FbdvZoQ5AJOd2r95YkrlftyIkRMJi1n05sPtYhhgCzC4HWY16hcCycx8aC2Q3vF8
         zB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063910; x=1717668710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxB6vVIAxKAJRnWfHDwiheUcKLANimvzznXfGKQj6Bk=;
        b=xBkUWiE9EYjr+gwZ0o+SVY5pH9s9IdHUD09Tj2PPuEP2ez12DLngdhLzPNasqcNNvd
         CcnV7/D45mf9xSgMOHG/0JQA0bN1j6DxbrSBDZneCh86zRAAp/+SK4grFQ2LOa+vXdnk
         n3/0DriijzQmMvRKNXnk8vdna8jWHsZlvpYk5aHG/lFbFR9qiFN9zGAOLnSQUhcryPAB
         NMGyjz8/mDWAucnOhyetIO6nzqYcild2jrK6VWFrJzo2SvEaW5GElBozzUden+By+ZQU
         mW5aKYkBuLV6RNyu6zj05Xznd1xYCUvf0drxT5Mqu3MY5idmH1Om17C8N6Y6IA4zCpaB
         oyTA==
X-Forwarded-Encrypted: i=1; AJvYcCXMmfFcyOBLr3nIBku2tjIX3Lg9Sr5wvBb4sqNMLw25QPo+5DS9hs5sOUxoFxPy+HrRGdri5WS7ljqBl0ekIi1cpwZ2gsK1Vh+A
X-Gm-Message-State: AOJu0YxIhJcwCauPRkI8TO6rpEuk7upckE3Awgk/19N/igJSyTLO64pD
	BqSZ5GUCbWsPq+NVhUcyQPO+M0rYXDHQMZU5/LseQr/Tb2RZEGJktyneGimFTVw=
X-Google-Smtp-Source: AGHT+IGAqVcwnQPl/3CgZD4XLSZ6kROjcJ3UsjrJVNy/fPCBJ8FCqFEl8EuImSsnZcB+tM1Cmf75Lg==
X-Received: by 2002:a50:9b57:0:b0:578:610d:b889 with SMTP id 4fb4d7f45d1cf-57a17806552mr1075945a12.24.1717063910225;
        Thu, 30 May 2024 03:11:50 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c3bbee4asm6727551a12.76.2024.05.30.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:11:49 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Add minimal boot support for Raspberry Pi 5
Date: Thu, 30 May 2024 12:11:57 +0200
Message-ID: <cover.1717061147.git.andrea.porta@suse.com>
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


Changes in V5:

DTS:
- axi node merged into soc node
- redefined the mapping ranges of the soc node to have proper translation,
  and a narrower address and size cell number for child nodes.Child nodes
  reg properties adjusted accordingly
- augemented the comment in 'gio_aon' node

sdhci-brcmstb.c:
- removed unused 'base_clk_mhz' variable


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
- removed the BCM2712 specific example, as per Rob's request


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
  arm64: dts: broadcom: Add minimal support for Raspberry Pi 5

 .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   1 +
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 283 ++++++++++++++++++
 drivers/mmc/host/sdhci-brcmstb.c              |  60 ++++
 6 files changed, 415 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi

-- 
2.35.3

