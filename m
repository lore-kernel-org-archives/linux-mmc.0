Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3814C594;
	Mon, 13 May 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606825; cv=none; b=X4Qf+XqMDWZLo/XdUhp9k8GLesvMZfa5De7CYhH6iyQXLzFAZ7YlWjwqiuPCRl1+6t1rFK88vbo8pIOOHOfiNrqUi9GFu+ORipVyJw/eaJ34JSvj6mYcnIhflHOg1oXveh5pOHtJev07LREaHfcB6Fb7rcW29X5AePHt5tBmVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606825; c=relaxed/simple;
	bh=10lk38XyzErIUEli139gJKZDzm+Z8ZSe1J18NuIyxBY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KwzCGFXVonR5fLCFyifUasW3Gbf2G3JIGTs1w1N5F5lSHj8dnHPYLjPQyJ3/uKc1JEiTh0S9O/adKE7cibwdgfqccHwRmu1468KBYXBOc3DgUT5v/OZTR3gt4FqQcGaVVUkqsGsdVi0uhHUW5Il0jZU9WA885xTcO+854rXjz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrjtQW9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrjtQW9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452E2C32781;
	Mon, 13 May 2024 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715606824;
	bh=10lk38XyzErIUEli139gJKZDzm+Z8ZSe1J18NuIyxBY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YrjtQW9iczUk6tYsPzkrupLm9sjLXnQxc9ZhtcYH0JYWot5fYjYaM1aio/TBbPt6i
	 O6ufYBh99bu6VnJCaUuqrw9XPFsV5ON2raukMLdtLABZqlzrXoLs/U0m/Keo5vxYa/
	 SSYqR9BOx+nsoMFjN+r0Lt5o9orPqQvVYFNlx1jK/opiB3+ZYPvSqAYjm9h1vqYgAr
	 iefdJ5vcEZeTjRQdkJwnAFWENZJ0upbjM6wNImtnqy2bEva1/EB/U1ebPrXJwcJHdU
	 FJ9nvfJuuqtgJjytAZgO679PbCPfOs9UNuzKu2z/ELvjVgDQbqf5sqRnbaFMMHva2F
	 gheNSCz+D0LPw==
Date: Mon, 13 May 2024 08:27:02 -0500
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
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Eric Anholt <eric@anholt.net>, 
 Scott Branden <sbranden@broadcom.com>, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Stefan Wahren <wahrenst@gmx.net>, 
 devicetree@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-rpi-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <cover.1715332922.git.andrea.porta@suse.com>
References: <cover.1715332922.git.andrea.porta@suse.com>
Message-Id: <171560671443.2464066.440073842827214763.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Add minimal boot support for Raspberry Pi 5


On Fri, 10 May 2024 16:35:26 +0200, Andrea della Porta wrote:
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
> Changes in V2:
> 
> - the patchshet has been considerably simplified, both in terms of dts and
>   driver code. Notably, the pinctrl/pinmux driver (and associated binding)
>   was not strictly needed to use the SD card so it has been dropped.
> - dropped the optional SD express support patch
> - the patches order has been revisited
> - pass all checks (binding, dtb, checkpatch)
> 
> Many thanks,
> Andrea
> 
> References:
> - Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/
> 
> Andrea della Porta (4):
>   dt-bindings: arm: bcm: Add BCM2712 SoC support
>   dt-bindings: mmc: Add support for BCM2712 SD host controller
>   mmc: sdhci-brcmstb: Add BCM2712 support
>   arm64: dts: broadcom: Add support for BCM2712
> 
>  .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  23 ++
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
>  drivers/mmc/host/sdhci-brcmstb.c              |  81 +++++
>  6 files changed, 475 insertions(+)
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for cover.1715332922.git.andrea.porta@suse.com:

arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/timer@7c003000: failed to match any schema with compatible: ['brcm,bcm2835-system-timer']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/local-intc@7cd00000: failed to match any schema with compatible: ['brcm,bcm2836-l1-intc']





