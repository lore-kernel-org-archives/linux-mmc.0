Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AD174EF8;
	Tue, 28 May 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918108; cv=none; b=KFPOVa5NqMAnkHqYbJzEUdR+4ExnEE6bYKXoynATRBWjL1tOPp1j9ewCy/fFWwsmpubL/aRZ6NELrKTtNtCIy9ZbqPG5cHETT5pUXtQlVqG2cHykNVhDRebB3msUNgnnqoJgvuBIHOX1xBxVUmvarpZ5w2EfE0XDsOv2gW3hvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918108; c=relaxed/simple;
	bh=aZ/M4Kox57b9SCW3adnB7WGyvUjb68HFU+1lzkXsWaU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CBCDytnIcs2QnoOrdbp2o5ot9Gj8pNT0zmPDfZM3KjLU+gN0OXY2jDkBU4Dg1XDvAtimrN+vrKKGqHJYssZrguvlBAy919tgC0r07Y+7UsIclZx/fXrBuIkSa5+uW1bZ7ctD3bS7KW8pS9rFAY7qCC8PQDqq6qzWk6bNDaM3T+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdwTKaUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdwTKaUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C4DC32789;
	Tue, 28 May 2024 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918108;
	bh=aZ/M4Kox57b9SCW3adnB7WGyvUjb68HFU+1lzkXsWaU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OdwTKaUnWVVxvwZTm1Wm0EUOyhQwo64UbyUtvMgNepMqUZnATiCXiOFCtqzRkV1+Z
	 Mq6EDGg+y7niNOD9fZYkTN883P6djAt6rN4zGNJHiX/ynqYBYLDXHc6a8Mi/lY/z/D
	 bU0X+blzE6q0idTfuBSnymO3atgHkzYcmj4SDIfNCymHbAN6ekXcq+AtQxYwPOS3+T
	 3TuXZ9K2vqCxoAZD0zXE6QoU2+omhUvfPVlK2ThSovioaPgdGaCp91Sfxz5UjzwBD/
	 XlIG7oYG7+t4AUWPAWTR0cKKG6hA8+mEBFoNzrhYnDnNJX//lXJyBctUqPgR0Jd6pf
	 Zzw2bfq7LIzAg==
Date: Tue, 28 May 2024 12:41:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Ray Jui <rjui@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-rpi-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, 
 Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
 Kamal Dasu <kamal.dasu@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
In-Reply-To: <cover.1716899600.git.andrea.porta@suse.com>
References: <cover.1716899600.git.andrea.porta@suse.com>
Message-Id: <171691793522.1180760.2293792941244342911.robh@kernel.org>
Subject: Re: [PATCH v4 0/4] Add minimal boot support for Raspberry Pi 5


On Tue, 28 May 2024 15:32:37 +0200, Andrea della Porta wrote:
> Hi,
> 
> This patchset adds minimal support for the Broadcom BCM2712 SoC and for
> the on-board SDHCI controller on Broadcom BCM2712 in order to make it
> possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
> console through uart.
> Changes to arm64/defconfig are not needed since the actual options work
> as they are.
> This work is heavily based on downstream contributions.
> 
> Tested on Tumbleweed substituting the stock kernel with upstream one,
> either chainloading uboot+grub+kernel or directly booting the kernel
> from 1st stage bootloader. Steps to reproduce:
> - prepare an SD card from a Raspberry enabled raw image, mount the first
>   FAT partition.
> - make sure the FAT partition is big enough to contain the kernel,
>   anything bigger than 64Mb is usually enough, depending on your kernel
>   config options.
> - build the kernel and dtbs making sure that the support for your root
>   fs type is compiled as builtin.
> - copy the kernel image in your FAT partition overwriting the older one
>   (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
> - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
> - make sure you have a cmdline.txt file in FAT partition with the
>   following content:
>   # cat /boot/efi/cmdline.txt
>   root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
>   console=ttyAMA10,115200
> - if you experience random SD issues during boot, try to set
>   initial_turbo=0 in config.txt.
> 
> 
> Changes in V4:
> 
> sdhci-brcmstb.c:
> - dropped the last 4 lines of sdhci_brcmstb_cfginit_2712() function
>   to avoid setting the SDIO_CFG_CQ_CAPABILITY register. The rationale
>   behind this can be found in [4] and subsequent comments
> 
> DT-bindings:
> - simplified the compatible item list for 'brcm,bcm2712-sdhci' as per [5]
> 
> 
> Changes in V3:
> 
> DTS:
> - uart0 renamed to uart10 to reflect the current indexing (ttyAMA10
>   and serial10)
> - updated the license to (GPL-2.0 OR MIT)
> - sd_io_1v8_reg 'states' property have second cells as decimal instead
>   of hex.
> - root node has size-cells=<2> now to accommodate for the DRAM controller
>   and the address bus mapping that goes beyond 4GB. As a consequence,
>   memory, axi and reserved-memory nodes have also size-cells=<2> and
>   subnodes reg and ranges properties have been updated accordingly
> - ranges property in 'axi' node has been fixed, reg properties of sdio1
>   and gicv2 subnodes have been adjusted according to the new mapping
> - 'interrupt-controller@7d517000' node is now enabled by default
> - dropped 'arm,cpu-registers-not-fw-configured' as it is no longer
>   relevant on A76 core
> - l2 cache nodes moved under respective cpus, since they are per-cpu
> - dropped psci cpu functions properties
> - added the hypervisor EL2 virtual timer interrupt to the 'timer' node
> - splitted-lines url are now on a single line
> 
> sdhci-brcmstb.c:
> - simplified MMC_CAP_HSE_MASK leveraging already existing definitions
> - MMC_CAP_UHS_MASK renamed to MMC_CAP_UHS_I_SDR_MASK to better reflect
>   its purpose. Added also a comment.
> - sdhci_brcmstb_set_power() replaced with the already existing (and
>   equivalent) sdhci_set_power_and_bus_voltage()
> 
> DT-bindings:
> - removed the BCM2712 specific example, as per Rob's request.
> 
> 
> Changes in V2:
> 
> - the patchshet has been considerably simplified, both in terms of dts and
>   driver code. Notably, the pinctrl/pinmux driver (and associated binding)
>   was not strictly needed to use the SD card so it has been dropped
> - dropped the optional SD express support patch
> - the patches order has been revisited
> - pass all checks (binding, dtb, checkpatch)
> 
> 
> Many thanks,
> Andrea
> 
> References:
> [1] - Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/
> [2] - Link to V2: https://lore.kernel.org/all/cover.1715332922.git.andrea.porta@suse.com/
> [3] - Link to V3: https://lore.kernel.org/all/cover.1716277695.git.andrea.porta@suse.com/
> [4] - https://lore.kernel.org/all/ZlF5dQbNpZ921e66@apocalypse/
> [5] - https://lore.kernel.org/all/bc1eb98c-9d49-4424-ab89-16be6c67c3f5@gmx.net/#t
> 
> Andrea della Porta (4):
>   dt-bindings: arm: bcm: Add BCM2712 SoC support
>   dt-bindings: mmc: Add support for BCM2712 SD host controller
>   mmc: sdhci-brcmstb: Add BCM2712 support
>   arm64: dts: broadcom: Add support for BCM2712
> 
>  .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   1 +
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 292 ++++++++++++++++++
>  drivers/mmc/host/sdhci-brcmstb.c              |  60 ++++
>  6 files changed, 424 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> 
> --
> 2.35.3
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for cover.1716899600.git.andrea.porta@suse.com:

arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/timer@7c003000: failed to match any schema with compatible: ['brcm,bcm2835-system-timer']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/local-intc@7cd00000: failed to match any schema with compatible: ['brcm,bcm2836-l1-intc']





