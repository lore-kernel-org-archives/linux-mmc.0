Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B377105;
	Tue, 21 May 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296036; cv=none; b=qR79nB2dtYvLJme9GYWWOhFlybBki9XRJaTz+aovaaBjZYuachI4NKsQR6+wlTI1STIjqjAa5PWbSxaY8jFkAOeyumEUhQCfrsOvA6Tjj4XN9x/nacqP5kmhIm29ckmJabqEltFEGNbPkfm0W4OclqWUAkWyEiWV/MnbccDJBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296036; c=relaxed/simple;
	bh=bHWVfPjiG9qirlPuLIEODCMQdreEVTnQ/MJ3n930jPM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tzCfRIoAUK+CvR7PvskdVutjJmefvWHFD4dp1vG7WDLY0o7CjXrNx6elt41Em5ksats0pNa9AelUEEjpkBG9W+3NoEzpWZ7jrDaZX6EaU0gAzblutQWCxsxBcCxsVxiIxrsoT84yG49HTIy64n4mWIYW2h2IH896zP09ztoBQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObxGvXC6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObxGvXC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88E1C4AF08;
	Tue, 21 May 2024 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296035;
	bh=bHWVfPjiG9qirlPuLIEODCMQdreEVTnQ/MJ3n930jPM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ObxGvXC6euM7NRtoCG0VaWhVcxCubshpTNRXO5DJ+2y9urauuFfflWybr7CexVvdN
	 j8wFezLYf/myhbt6yIzakK+JLVyXNiaUauCGUecSErcAL4g0nq9I+un+y7vSMF8Mjp
	 h1SMhr0Tp7odZcnMrmcujStkACZP8bEGVnPvjLkwmFpPAoxYeSUzKyI8GLrqviO481
	 +QiRrZ2zqHgdqZn2Vjb45xWxeQK/SYeU88WMnuuB+tSlLqwm0rVPIWOVehH+lEX5uP
	 drJhwsMN58+6y5Pxg3ItUsxKePK+wNA5plmjAvLaBNQ/x2A09eBt0GgaFkIdyBAa7R
	 dSXCTGNmtgqnw==
Date: Tue, 21 May 2024 07:53:54 -0500
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
Cc: devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, linux-rpi-kernel@lists.infradead.org, 
 Marc Zyngier <maz@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, 
 linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
 Kamal Dasu <kamal.dasu@broadcom.com>
In-Reply-To: <cover.1716277695.git.andrea.porta@suse.com>
References: <cover.1716277695.git.andrea.porta@suse.com>
Message-Id: <171629597687.3545865.4863152518186639767.robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Add minimal boot support for Raspberry Pi 5


On Tue, 21 May 2024 10:35:12 +0200, Andrea della Porta wrote:
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
> - Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/
> - Link to V2: https://lore.kernel.org/all/cover.1715332922.git.andrea.porta@suse.com/
> 
> Andrea della Porta (4):
>   dt-bindings: arm: bcm: Add BCM2712 SoC support
>   dt-bindings: mmc: Add support for BCM2712 SD host controller
>   mmc: sdhci-brcmstb: Add BCM2712 support
>   arm64: dts: broadcom: Add support for BCM2712
> 
>  .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   4 +
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 292 ++++++++++++++++++
>  drivers/mmc/host/sdhci-brcmstb.c              |  65 ++++
>  6 files changed, 432 insertions(+)
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for cover.1716277695.git.andrea.porta@suse.com:

arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/timer@7c003000: failed to match any schema with compatible: ['brcm,bcm2835-system-timer']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/local-intc@7cd00000: failed to match any schema with compatible: ['brcm,bcm2836-l1-intc']





