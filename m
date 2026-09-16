Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548850C28D;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568582; cv=none; b=LDyzWMeV/twHJeUlpAtRNwkwvmJrfm+XYHlai9nVKCahEYck0CDAuPIXespFb/xbhJ2j3CiNiVdY0RXo8O9km29PXQpLYDaJrXFcBeIs2E7nEaL1bMBBmlpdHL2IJmZekQKpQemo+GzUi0pgaDtW5+0R90e8i+N3qphxD24qrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568582; c=relaxed/simple;
	bh=APrimV7r9j/JDntzPd0f09aiQ+Q+YLOAvyz5vdDyQb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HdwWq1Mb6GkYa/xJdlPxyBeohu97kWnRpGIvYOH9zAN9lqbTHgql2BH/96nANTBw1gMo90HSIRzvCduz+uy36jJQpIHvMsd+h3aKD/T1a6Bi97QFJm3dDYGPBLY7KYsKTcfnIjl1LGqgoIdA7h/Fbw2Ws0UvyMi2rnEMwqJ0Zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssRLWlh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssRLWlh1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AA1AC2BCB3;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568582;
	bh=APrimV7r9j/JDntzPd0f09aiQ+Q+YLOAvyz5vdDyQb8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ssRLWlh1+Y+w+X+oyT8PAE5abljdmV7SggUBajixOAoECKjgze1fO46CaQ8CpApbX
	 nIuw9o9I7fICTkd/qxUoyuMkrKdrVUtJOgCUo3M1zYNZA+c4WbTizbQyVEDexpVMKw
	 qDgDweyClLksk8PzZkwoy76gnQBsu7+l+S+bC9TJDgmnwBMhXh/OS1DrfUCUG01tHT
	 h9wzMCztl33QrKyWi4XBo3/EhIyfYWpbO5SWldyQMP2OUX3LxAla9UpNXksj4yMSb2
	 457icuecQpdkCZkNiPrwv2+HYMAQBM5N+cR2T2MY5VWYms2RxmVAUVe8DBbdsUheES
	 NdeAchN1qt38g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE83C88E7D;
	Wed, 16 Sep 2026 14:23:01 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Subject: [PATCH v2 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
Date: Wed, 16 Sep 2026 17:22:05 +0300
Message-Id: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf8Xs2TXthgL15H8YDhVX2ARa0iLRE
 P7dSrx6fJOZNyskjsIJzocVIi+SJPgMdDxA2zvfMco9M5CiUlllcUxjbQ2heJnFDZie0xTijKV
 yytiWWBuGvJ4iP+S1m69N5l7SHOJ7P1r0N/05Nf11LhoVKq4KMlV9M1RcRid+yDXfnULsoNm27
 QMXm3EfwwAAAA==
X-Change-ID: 20260909-msm8952-initial-support-60a059c2e15e
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 iommu@lists.linux.dev, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568578; l=4824;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=APrimV7r9j/JDntzPd0f09aiQ+Q+YLOAvyz5vdDyQb8=;
 b=hxQTWuCmnN5RxaTfxCbRvKqSYfp1IkgodMwMDO5M+dIh8pOkb/NbEkdfS6Y+DnDxoID5n8Czt
 jiYXe7Dj3twA8ZSQOohs7Ew3vSH3o1Qln+Dg/iZ8hy5ZkZyMqCIqLpT
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.

Ported without uart connection. ramoops and usb
mainly used to debug.
USB is not enabled in this series because it
depends on the not yet upstreamed (and not developed by me)
pmi8950_smbcharger.

General Mobile shamrock display panel driver
is generated using MSM8916's mdss dsi panel
driver generator and tested with it. I didn't
include it.

The GCC and DTS files are derived from existing
Qualcomm source files. Original copyright notices
are retained.

GCC is based on msm8939's gcc file.
SoC device tree is based on MSM8937 file.

in some downstreams MSM8952 GCC is merged with
MSM8917 and MSM8937's. But upstreamed MSM8917 is
based on different GCC and different pll structure.
I have no way to verify MSM8952 pll so I am not sure
about how correct pll structure is.

Pinctrl driver was submitted and merged here:
https://lore.kernel.org/all/20260907-msm8952-pinctrl-v5-0-9a2d8d72ffdb@mainlining.org/

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
Changes in v2:
- Changed device dts file as David's and Konrad's suggestions
- Removed accidental duplicated clock assigments and fixed wrong gcc gp1,gp2
  and gp3 parent_maps
- Updated commit messages to make it wrapped at 72 character.
- Fixed spi1 tlmm node naming
- Added remaining spi and i2c nodes
- Wired up mpm
- Add mmio-sram to rpm_msg_ram
- Reformatted msm8952.dtsi
- Removed rpmcc-msm8952 driver entry and replaced it with rpmcc-msm8976
- Merged sdhci tlmm pins to single nodes, now it is similar to existing SoCs
- Rebased to latest linux-next, now storage works
- Removed polling-delay properties from tsens
- Link to v1: https://lore.kernel.org/r/20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org

---
Muzaffer Kadir (19):
      dt-bindings: clock: qcom: Add MSM8952 global clock controller
      clk: qcom: Add global clock controller driver for MSM8952
      dt-bindings: nvmem: Add compatible for MSM8952
      dt-bindings: power: rpmpd: Add MSM8952 power domains
      dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
      dt-bindings: vendor-prefixes: Add General Mobile
      dt-bindings: arm: qcom: Document MSM8952 SoC binding
      dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
      dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
      dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
      dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
      drm: msm: mdp5: Add MDP5 configuration for MSM8952
      soc: qcom: ubwc: Add UBWC config for MSM8952
      dt-bindings: thermal: tsens: Add MSM8952
      thermal: qcom: tsens: Add support for MSM8952 tsens
      arm64: dts: qcom: Add initial support for MSM8952
      dt-bindings: input: touchscreen: goodix: Add binding for GT970
      arm64: dts: qcom: generalmobile-shamrock: new device

 Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
 .../bindings/clock/qcom,gcc-msm8952.yaml           |   56 +
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |    5 +
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    3 +
 .../bindings/input/touchscreen/goodix.yaml         |   35 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |    1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../dts/qcom/msm8952-generalmobile-shamrock.dts    |  436 +++
 arch/arm64/boot/dts/qcom/msm8952.dtsi              | 2679 +++++++++++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-msm8952.c                     | 3550 ++++++++++++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |   81 +
 drivers/soc/qcom/ubwc_config.c                     |    1 +
 drivers/thermal/qcom/tsens-v1.c                    |   44 +
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 include/dt-bindings/clock/qcom,gcc-msm8952.h       |  217 ++
 25 files changed, 7123 insertions(+), 16 deletions(-)
---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260909-msm8952-initial-support-60a059c2e15e

Best regards,
--  
Muzaffer Kadir <muzafferkadir@mainlining.org>


