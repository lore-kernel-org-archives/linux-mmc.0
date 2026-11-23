Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445615;
	b=D4WWbCdmaPZlcs0tD59lwV1DgoYYLMA5RQ/XCYiQUlOecXT1KGX34cjrX0xoiXKVhw79
	 yzULoKi70Uwdw16eH/OuVEtzgf+JjRwej2LtPISJNevAYZeqXtievi7dg0YGGigmKre28
	 bwbeS6QtNyJmgpVunqopHUtebkK8rqoiMpdB7xCioHWaIVAf23oJF1LdK+hMxu6wPft9l
	 2tXLRsq8pZMWr/Vz4gCQRI+U6B8RWAaPx63t3nZ+0aEqGIJ9u1QItCsOKEGOZoj4xtFN+
	 zDtrtA3la7asDNWR6CoprhwsUoCZ9nIRhY6hP5zBkEftq7uOXIvyw9k0Gwn1oHO27tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lA6oYuprAkHK4elm//iRd0jX7g4QWezwyzygSAeIMm4=;
	b=2OQLld/lGcVHoj7myVlqvpAy+O3KKfUui3lrucqxceAm7UxklNIlh9BoAYVPKEZdt23y
	 aoysHjWqGfhU/HrgMdWeh4x/YKgXWi48Bq+LBAP7PSZvwZpU25hgmp8BMKkpFisYkATNc
	 jBfHmQAjhUFrBL0fVAy923kx0Re2uOKdp4OQXAJ6hpWrbUScDmOZHGJoFeBrVuuwW1bS7
	 dYNOlvYGUQCdlsg+2r+mJDgrd9OftAZ+TDVLq8iZ4/h5Td2jPHi89xgYCBznrD2fsFoV/
	 6XEMehH6tYFk7XhDIRWhyh/ZuGe8wLNEw5z7jRn1rg46gUSOllZuAV9TyKpHLAbdIgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CB8Ph7HX;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7C606A321
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 14:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CB8Ph7HX
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so31150425e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795445613; x=1796050413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lA6oYuprAkHK4elm//iRd0jX7g4QWezwyzygSAeIMm4=;
        b=CB8Ph7HX5v4FLIDCkrhrAMiKlxsuMGiM4MlTI3b2rryQE0MyQaps9LzthZnMRqQbdK
         mk1wyE7JLhlANoYCek8V70kIxf73baE7VAcMV32bVnBFJmf67wwZ7jJ95zbrLdQ/aIlN
         5DJLAnHvMumwoyEpTaqOm/maBrQ3e5sh+XDsIoqMzAAMdCkh3zkVvYp3XJwaSTHx8zdC
         GLBTSASgW5hqUY2+QITiDLGl055H0U48/vFd5Jf357+bdLmeLrLTUg54kefc+mvae1+5
         2YzUUWa+8uitJwRYx0+MEV0JlJzDSmRwVQ90vCaGU9TetY5bRrqjC1JkFmRJmknq3VgE
         dRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445613; x=1796050413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lA6oYuprAkHK4elm//iRd0jX7g4QWezwyzygSAeIMm4=;
        b=sg35H39qi8ZKvBiTubU36rKK4g4DoyQVS4NI1ix3N6Lq8Fac23GfwKW+LsiG8cx9Al
         3/GyvtcQw5kNBOdzpKmgm6Io/hCHA4Snw73M3giKIVSbpC3kO2tsWfWd30rjlDKm2PxH
         kadgYGC0nVKT4q8iA85p9dc1jXX6BI63l61vHRqTTXMiFWl06cnpkWrx7N2u3PKhCqdx
         /WFyXs3/5iunr3J0t0apiCaXEI9roo/FfvYvRqikEB+GJjLgWOyOB83K2PHLPEwvVCLV
         mv5hXcy7GuWnkyx+bHy8egUp2FtcYidJcTcF1TwD/KwboQEt7gPzUazSqqPzxCuOOtGe
         BulA==
X-Forwarded-Encrypted: i=1; AL+hErGzHT6Ho+j8ix0GPakE7IrM7VkOHaHCDRETqRfcIAAPWoAx0o22pBPb3lemMaY/I4285/hu+6b8abM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x41l9Inr+RjK03ak9oNK55NIckKnaBZQXocevfTPpB9itRrac
	L59cDlD+/AKS+Cnj/nyN/80t3UAxAYmaUiunKaaVtVXEZxvTjTkJAN7Kgfopmp0Q/iE=
X-Gm-Gg: AZFdTZd+I4q05Ap+jO0ACFgeBlthSRuql4GVwBZVMmG8TYNAVpH0kpz4i1898+BlUdr
	S5Xot6cpsR1DC8Vb9tzYIGUQCoIJC5X1PntiPlRttEh1umBKvkzEsXsUgU4lmIjZjq2Oa6j2C+q
	KmDEHk131Sa0sXhZLXcsnjtxdJlPZbDBdvKR+C/e8DxWGGMQhHI+MhOUUGnRsXZz+je4zCBWn9k
	l5cf3mzioIZUiaxHtTRtQ8HRb0+BL7D4wj2P3EfSeHchhIUHztAgc4mnKdnrDsbttrrZQIINWBg
	ISXXtmyRchotuE0i2IxOzR+Is2JFSZffptxA7+H7u7bZXOKPKnO+ldRMVoOMnUXEyA6wQZrFDEg
	UCnJaoIPvcttnVbl5lT9uVbAwJdDzpRgO4fmvrSPXz2gOCj9IWGy36TTxaUt+i8iaIEWFoQjACN
	/bkAovwZdtrqY8LzOnTWFUibVyMBu1YGjb4KUurToJ2dk5WNhJYdEZvdYQlimclumeoQDwzLMRq
	1qyf7hsHjgqzAFdz/0DGf71aQGQmtfTrcsZt1t2HKB0uv4TE0PSvJgTJRqVDfJnweyOmnlHlDwC
	A/OqC0lTplk9lN2L/XSB8ufRxreH
X-Received: by 2002:a05:600c:4e4c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4bb88938d2dmr220141985e9.32.1795445613020;
        Mon, 23 Nov 2026 06:53:33 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm142773895e9.3.2026.11.23.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:53:32 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v3 00/28] dmaengine: bcm2835: add BCM2711 and BCM2712 40-bit DMA support
Date: Mon, 23 Nov 2026 15:56:38 +0100
Message-ID: <20261123145728.29082-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the whole memory of a Pi 4, and the BCM2712 has 6 of them. This
series adds support for them to the bcm2835-dma driver, on top of the
platform abstraction from Stefan Wahren and some features from the
downstream Raspberry Pi kernel.

The main change since v2 is the handling of the slave (peripheral)
addresses, as requested in the v1/v2 discussions [1][2][3]: instead of
hardcoding the 0x4_0000_0000 offset of the 40-bit channels and relying on
clients passing pre-translated VideoCore bus addresses, the clients now
pass CPU physical addresses and the DMA driver translates them with
dma_map_resource(). Since the conversion of dma_map_resource() to
dma_map_phys() with DMA_ATTR_MMIO, the dma-direct implementation honours
the dma-ranges of the device, which was the open question raised by
Robin in [1].

To keep old device trees working (they only describe the RAM in
dma-ranges), the driver detects at probe time whether the peripheral
window is described in dma-ranges, by looking up its own registers, and
otherwise falls back to reverting the translation given by the ranges of
the parent bus, as suggested by Dave in [3]. Addresses outside of the
ranges are passed through, so that out of tree clients still providing
bus addresses keep working with old device trees. The same fallback
works for the BCM2712 40-bit channels, whose bus maps the peripherals
1:1, while the BCM2711 40-bit channels see the peripherals 16 GiB above
their VideoCore bus address, which cannot be derived from the ranges:
they require dma-ranges, which all the device trees describing them
(the downstream ones and the one added here) provide.

Structure of the series:

  1-5:   preparatory patches and features from downstream (per-channel
         flags, wide accesses, bursts, abort fixes)
  6-7:   generic dma-channel-mask property
  8-13:  hardware abstraction (Stefan Wahren)
  14-19: slave address translation with dma_map_resource(), conversion
         of the clients (spi, mmc, ASoC, vc4 HDMI) and dma-ranges
  20-23: BCM2711 40-bit channels
  24-26: BCM2712 40-bit channels
  27:    DMA flags for the HDMI audio of BCM283x
  28:    HDMI audio on BCM2712 through the 40-bit channels

Changes in v3:
- Drop the hardcoded addr_offset, translate slave addresses with
  dma_map_resource() in device_config() and unmap them on
  reconfiguration and when freeing the channel.
- Convert spi-bcm2835, mmc/bcm2835, bcm2835-i2s and vc4_hdmi to provide
  CPU physical addresses, and describe the peripheral window in the
  dma-ranges of the BCM283x/BCM2711 soc bus.
- Put the BCM2711 40-bit controller in its own bus, whose dma-ranges map
  the peripherals at 0x4_7c000000, instead of the scb bus, to not change
  the DMA configuration of PCIe and GENET and to avoid refactoring the
  entire DTS to fit the cell size.
- Fix the abort sequences, which were swapped between the legacy and the
  40-bit channels, breaking terminate_all on all the Raspberry Pis.
- Fix the interrupt acknowledge of the 40-bit channels, which used the
  INTEN bit of the TI register instead of the INT bit of CS.
- Make the abort sequence a platform callback, drop the CS/TI masks only
  used by it.
- Keep the period handling of bcm2835_dma_create_cb_set_length(), which
  v2 changed to flag every control block of cyclic transfers.
- Use the platform cb_append_extra() callback for every control block,
  and convert every control block address with to_cb_addr().
- Preserve the width and burst settings of SRCI/DESTI when setting the
  addresses of slave_sg transfers.
- Fix the argument order of cb_init() in the patch introducing it, to
  keep the series bisectable.
- Fix the free_irq() cookie, which did not match the request_irq() one.
- Derive the first channel of an instance from the physical register
  address instead of the ioremap()ed one, initialize all the IRQ array
  entries, and split this into its own patch.
- Refuse to probe the 40-bit channels if dma_addr_t is 32-bit wide, and
  avoid shifting dma_addr_t by 32 bits.
- Include linux/bitfield.h, fixing COMPILE_TEST builds.
- Drop the unused bcm2835_dma_count_frames_for_sg(), resurrected by a
  rebase, and the dead code and duplicated defines of the 40-bit patch.
- Split out the style changes from the 40-bit patch (Stefan), reword the
  subject of the first patch (Florian).
- dt-bindings: sort the compatibles (Krzysztof), document the flags in
  the DREQ cell (Stefan), allow the generic dma-channel-mask, constrain
  the interrupts of the new compatibles. The Acked-by of v2 has been
  dropped because of the additional changes.
- Use the generic dma-channel-mask in the new nodes (Krzysztof).
- Use the DMA specifier flags for the HDMI audio channels of BCM283x,
  so that patches 2-4 have in-tree users (Stefan)
- Describe in the platform data which channels of the DMA block use its
  programming model and ignore the others, so that nodes describing
  channels with another model under the same compatible (as the
  downstream BCM2712 device tree does) are not driven with the wrong one.
- Add BCM2712 support.

Backward compatibility with installed device trees:
- Upstream device trees without the peripheral window in dma-ranges keep
  working through the ranges fallback, which yields the same bus
  addresses the clients used to provide.
- Downstream Raspberry Pi device trees already describe the peripheral
  window in dma-ranges (for both the soc and scb buses), and their
  40-bit controllers are handled through dma_map_resource().
- The node of the downstream BCM2712 device tree describing channels 0-5
  is rejected instead of being driven with the wrong programming model.
- The current upstream device trees do not describe any 40-bit DMA
  controller, so the new compatibles have no legacy to support. A
  brcm,bcm2711-dma node without dma-ranges makes the probe fail instead
  of programming wrong addresses.
- Older kernels booted with the new device trees are not affected: the
  extra dma-ranges entries do not change the DMA limits of the existing
  devices and the new nodes use compatibles unknown to them.

Not supported yet: No device tree consumer is converted to the 40-bit
channels either.

This patchset has been tested on Rpi3/4/5 with both downstream and
upstream DTBs. The upstream DTBs have been customized to allow for several
peripherals (SPI, I2S, HDMI audio, mem2mem) to be tested against dma40,
an example of which can be found in patch 28.
Future patches will convert said consumer nodes to use the new dma
controller.

This version has been prepared with the help of an AI coding assistant
(Claude Opus 5.5).

[1] https://lore.kernel.org/linux-arm-kernel/ee19a95d-fe1e-4f3f-bc81-bdef38475469@arm.com/
[2] https://lore.kernel.org/all/CAPY8ntCcz7ysTq_78Rb8ohLLETTYZeoZ3DXdPFvDLAkPc9jPWw@mail.gmail.com/
[3] https://lore.kernel.org/all/CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com/

Previous versions:
v2: https://lore.kernel.org/all/cover.1710226514.git.andrea.porta@suse.com/
v1: https://lore.kernel.org/linux-arm-kernel/cover.1706948717.git.andrea.porta@suse.com/

Andrea della Porta (24):
  dmaengine: bcm2835: Fix coding style issues and a typo
  dt-bindings: dma: brcm,bcm2835-dma: Document dma-channel-mask and DREQ
    flags
  dmaengine: bcm2835: Support common dma-channel-mask
  dmaengine: bcm2835: move CB info generation into separate function
  dmaengine: bcm2835: move CB final extra info generation into function
  dmaengine: bcm2835: make address increment platform independent
  dmaengine: bcm2835: drop info parameters
  dmaengine: bcm2835: pass dma_chan to generic functions
  dmaengine: bcm2835: introduce multi platform support
  dmaengine: bcm2835: Use dma_map_resource() to translate slave
    addresses
  spi: bcm2835: Pass the CPU physical address of the FIFO to the DMA
    engine
  mmc: bcm2835: Pass the CPU physical address of SDDATA to the DMA
    engine
  ASoC: bcm2835-i2s: Pass the CPU physical address of the FIFO to the
    DMA engine
  drm/vc4: hdmi: Pass the CPU physical address of MAI_DATA to the DMA
    engine
  ARM: dts: broadcom: Describe the peripheral window in dma-ranges
  dmaengine: bcm2835: Support channel subsets in a controller instance
  dt-bindings: dma: brcm,bcm2835-dma: Add BCM2711 40-bit DMA
  dmaengine: bcm2835: Add BCM2711 40-bit DMA support
  ARM: dts: bcm2711: Add the 40-bit DMA controller
  dt-bindings: dma: brcm,bcm2835-dma: Add BCM2712 40-bit DMA
  dmaengine: bcm2835: Add BCM2712 40-bit DMA support
  arm64: dts: broadcom: bcm2712: Add the 40-bit DMA controller
  ARM: dts: broadcom: Set the DMA flags of the HDMI audio channel on
    BCM283x
  arm64: dts: broadcom: bcm2712: Enable HDMI audio

Dom Cobley (2):
  dmaengine: bcm2835: Support dma flags for multi-beat burst
  dmaengine: bcm2835: Fixes for dma_abort

Phil Elwell (2):
  dmaengine: bcm2835: Add support for per-channel flags
  dmaengine: bcm2835: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and
    DMA_WIDE_DEST flag

 .../bindings/dma/brcm,bcm2835-dma.yaml        |   88 +-
 arch/arm/boot/dts/broadcom/bcm2711.dtsi       |   40 +-
 .../arm/boot/dts/broadcom/bcm2835-common.dtsi |    3 +-
 arch/arm/boot/dts/broadcom/bcm2835.dtsi       |    3 +-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi       |    3 +-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi       |    3 +-
 .../boot/dts/broadcom/bcm2712-d-rpi-5-b.dts   |    9 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |   26 +
 drivers/dma/bcm2835-dma.c                     | 1229 ++++++++++++++---
 drivers/gpu/drm/vc4/vc4_hdmi.c                |   16 +-
 drivers/mmc/host/bcm2835.c                    |   20 +-
 drivers/spi/spi-bcm2835.c                     |   27 +-
 sound/soc/bcm/bcm2835-i2s.c                   |   19 +-
 13 files changed, 1229 insertions(+), 257 deletions(-)

-- 
2.51.0

