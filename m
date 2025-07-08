Received: from mx.olsak.net (unknown [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02A2E540D;
	Tue,  8 Jul 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994710; cv=none; b=r8y1U+sLeo5bCBe89k3qWIi88vlvLoGyA6XcT803sxc33w0d7muFW8Jk/vnr7zNMBsnEviWooqeGLihpsij4C/jDRW7KfVNW/AhWRN5nMOD3OQJyFBrkwGX0GRrfHNFunuyGJ0O7maQuvx7hHLJvLSj3pk+q1a4+3lchYUVdaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994710; c=relaxed/simple;
	bh=JFTT8bq/bZbMEFb8Wo1H7sbnNlTM94hswdG5zFgN+TY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gF0YI2eg58eLEvMPN1llNBjJy8ggcZVyQHow8Am7DfDELZFCIgp3jpKuEOTdmj3jla4ug+ddL/XT+jcg3fzhJi2Lv6Fg2kiojwT+8xInyP5MM4GhH60J7yCW8Foa0rynxLUeT+akSpBJqyHGPxbi4f3Pt7DehNxH302mnxlb+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=DLL+xhY1; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="DLL+xhY1"
DKIM-Signature: a=rsa-sha256; bh=PaMuZUADww5bxGzycsmsAnLaEiuKISbhlNb/kMRK5ZA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1751994597; v=1; x=1752426597;
 b=DLL+xhY1DElFkYnJVvBD0aGFXx/tl3CPwPLaPWF0lZ5cL8gLfp79vXOojRWLR3JH8toKqxag
 yM/5ROeFw3B3xLjz2GWXBrTLDYK36dFVcWVWQnxPI762ji/oxApwLTfuJLUjTAcKEt7caGa8djL
 5omTIr6IYN4ntfPTEogPORTMI4YbxtVg4VMORshjky8D9V4wQ0zy+MZcqFBPto6akvr/fSTbjZw
 dRRkfBuaRUFG90X7dQRwYkJuzLPpLMn840L5zQxbQLYAxH6AgBVDqcKp741Hhiwal1P3QOAdAv9
 4JdKEHTBbP157zfuMESgX1CbuKlUo5HWXnMkPljP1OF0w==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 7737eb4b; Tue, 08 Jul 2025 19:09:57 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v16 0/5] Initial Marvell PXA1908 support
Date: Tue, 08 Jul 2025 19:09:45 +0200
Message-Id: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANlQbWgC/4XSzU7cMBAH8FdBOder+fIXJ94D9eDEdjdlYVECE
 RXad69D1U0YDhxt6Tczmvm/d3OZxjJ3tzfv3VSWcR7PT+2B7sdNNxzT069ixtw+OgJiCMDm+S1
 hhGBOD48n4wJDCTmJHXzXyPNU6vj2Ue/+Z3sfx/nlPP35KL/g+vuvkCckBBA6EFq2Bk1+/V0Oj
 2NreV7G4W5+OJ/K4Th1a5WF9tKjowjx4IDxO8gbDCCfZ1/YgAlFQh0Se4hRWdlbr6w0O/QcfPb
 ciyVl7c4iKWubTTZbjOxLYVHWXS0CgrKu2Z5qgUgCQw3Khv9WAL/Y0GwtybuQbBSv+8bNCuiZY
 7NkEwCXwIOryiLsMOlFt0nAsBty7W0QrHrTiJv2rMdGXHtj7nsuFHxkrWnTgVhrWi81cMrJYl9
 60PoaEWmBRK3XjLg+Jl+d1JiK1teQ2LZwq/WakiA+k1R2ziat7ablS8RwzUnbdqktBzXK/l6Xy
 +UvRhGB1LsDAAA=
X-Change-ID: 20230803-pxa1908-lkml-6830e8da45c7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 soc@lists.linux.dev, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7967;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=JFTT8bq/bZbMEFb8Wo1H7sbnNlTM94hswdG5zFgN+TY=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm5AY9Dzy9RE7ZzWbtflDui3f2Pj/5t2QufS1jrck7nr
 VQ5o3a1o5SFQYyLQVZMkSX3v+M13s8iW7dnLzOAmcPKBDKEgYtTACai5MDIsOuRtFut5PzgLVHJ
 Xn0LucxKPE7Z1026JTSz7yHDk8ye84wMzVe72/kPSSXXFdzKb/Nik+TP/8e4g/d7ZOdUhwePPjz
 hBgA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This series adds initial support for the Marvell PXA1908 SoC and
"samsung,coreprimevelte", a smartphone using the SoC.

*Important note*: There is a regression on all of the v6.16 RCs where
the board does not boot unrelated to the patches in this set. See:
https://lore.kernel.org/regressions/3367665.aeNJFYEL58@radijator/

USB works and the phone can boot a rootfs from an SD card, but there are
some warnings in the dmesg:

During SMP initialization:
[    0.006519] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
[    0.006542] CPU features: Unsupported CPU feature variation detected.
[    0.006589] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
[    0.010710] Detected VIPT I-cache on CPU2
[    0.010716] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
[    0.010758] CPU2: Booted secondary processor 0x0000000002 [0x410fd032]
[    0.014849] Detected VIPT I-cache on CPU3
[    0.014855] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
[    0.014895] CPU3: Booted secondary processor 0x0000000003 [0x410fd032]

SMMU probing fails:
[    0.101798] arm-smmu c0010000.iommu: probing hardware configuration...
[    0.101809] arm-smmu c0010000.iommu: SMMUv1 with:
[    0.101816] arm-smmu c0010000.iommu:         no translation support!

A 3.14 based Marvell tree is available on GitHub
acorn-marvell/brillo_pxa_kernel, and a Samsung one on GitHub
CoderCharmander/g361f-kernel.

Andreas Färber attempted to upstream support for this SoC in 2017:
https://lore.kernel.org/lkml/20170222022929.10540-1-afaerber@suse.de/

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v16:
- Small device tree cleanups (warnings, hardcoded initrd)
- Fix device tree path in MAINTAINERS
- Update my email address
- Rebase on v6.16-rc5
- Link to v15: https://lore.kernel.org/r/20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr

Changes in v15:
- Update trailers
- Move device trees to mmp/ subdirectory
- Remove excess newline in board dts
- Add soc@ to Cc list
- Drop tree from MAINTAINERS
- Rebase to v6.15-rc1
- Link to v14: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr

Changes in v14:
- Rebase on v6.13-rc7, dropping everything except DT
- Link to v13: https://lore.kernel.org/r/20241001-pxa1908-lkml-v13-0-6b9a7f64f9ae@skole.hr

Changes in v13:
- Better describe the hardware in bindings/arm commit message
- Rebase on v6.12-rc1
- Link to v12: https://lore.kernel.org/r/20240823-pxa1908-lkml-v12-0-cc3ada51beb0@skole.hr

Changes in v12:
- Rebase on v6.11-rc4
- Fix schmitt properties in accordance with 78d8815031fb ("dt-bindings: pinctrl: pinctrl-single: fix schmitt related properties")
- Drop a few redundant includes in clock drivers
- Link to v11: https://lore.kernel.org/r/20240730-pxa1908-lkml-v11-0-21dbb3e28793@skole.hr

Changes in v11:
- Rebase on v6.11-rc1 (conflict with DTS Makefile), no changes
- Link to v10: https://lore.kernel.org/r/20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr

Changes in v10:
- Update trailers
- Rebase on v6.9-rc5
- Clock driver changes:
  - Add a couple of forgotten clocks in APBC
    - The clocks are thermal_clk, ipc_clk, ssp0_clk, ssp2_clk and swjtag
    - The IDs and register offsets were already present, but I forgot to
      actually register them
  - Split each controller block into own file
  - Drop unneeded -of in clock driver filenames
  - Simplify struct pxa1908_clk_unit
  - Convert to platform driver
  - Add module metadata
- DTS changes:
  - Properly name pinctrl nodes
  - Drop pinctrl #size-cells, #address-cells, ranges and #gpio-size-cells
  - Fix pinctrl input-schmitt configuration
- Link to v9: https://lore.kernel.org/20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr

Changes in v9:
- Update trailers and rebase on v6.9-rc2, no changes
- Link to v8: https://lore.kernel.org/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr

Changes in v8:
- Drop SSPA patch
- Drop broken-cd from eMMC node
- Specify S-Boot hardcoded initramfs location in device tree
- Add ARM PMU node
- Correct inverted modem memory base and size
- Update trailers
- Rebase on next-20240110
- Link to v7: https://lore.kernel.org/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr
  and https://lore.kernel.org/20231102152033.5511-1-duje.mihanovic@skole.hr

Changes in v7:
- Suppress SND_MMP_SOC_SSPA on ARM64
- Update trailers
- Rebase on v6.6-rc7
- Link to v6: https://lore.kernel.org/r/20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr

Changes in v6:
- Address maintainer comments:
  - Add "marvell,pxa1908-padconf" binding to pinctrl-single driver
- Drop GPIO patch as it's been pulled
- Update trailers
- Rebase on v6.6-rc5
- Link to v5: https://lore.kernel.org/r/20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr

Changes in v5:
- Address maintainer comments:
  - Move *_NR_CLKS to clock driver from dt binding file
- Allocate correct number of clocks for each block instead of blindly
  allocating 50 for each
- Link to v4: https://lore.kernel.org/r/20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr

Changes in v4:
- Address maintainer comments:
  - Relicense clock binding file to BSD-2
- Add pinctrl-names to SD card node
- Add vgic registers to GIC node
- Rebase on v6.5-rc5
- Link to v3: https://lore.kernel.org/r/20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr

Changes in v3:
- Address maintainer comments:
  - Drop GPIO dynamic allocation patch
  - Move clock register offsets into driver (instead of bindings file)
  - Add missing Tested-by trailer to u32_fract patch
  - Move SoC binding to arm/mrvl/mrvl.yaml
- Add serial0 alias and stdout-path to board dts to enable UART
  debugging
- Rebase on v6.5-rc4
- Link to v2: https://lore.kernel.org/r/20230727162909.6031-1-duje.mihanovic@skole.hr

Changes in v2:
- Remove earlycon patch as it's been merged into tty-next
- Address maintainer comments:
  - Clarify GPIO regressions on older PXA platforms
  - Add Fixes tag to commit disabling GPIO pinctrl calls for this SoC
  - Add missing includes to clock driver
  - Clock driver uses HZ_PER_MHZ, u32_fract and GENMASK
  - Dual license clock bindings
  - Change clock IDs to decimal
  - Fix underscores in dt node names
  - Move chosen node to top of board dts
  - Clean up documentation
  - Reorder commits
  - Drop pxa,rev-id
- Rename muic-i2c to i2c-muic
- Reword some commits
- Move framebuffer node to chosen
- Add aliases for mmc nodes
- Rebase on v6.5-rc3
- Link to v1: https://lore.kernel.org/r/20230721210042.21535-1-duje.mihanovic@skole.hr

---
Duje Mihanović (5):
      dt-bindings: mmc: sdhci-pxa: restrict pinctrl to pxav1
      dt-bindings: marvell: Document PXA1908 SoC and samsung,coreprimevelte
      arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
      arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
      MAINTAINERS: add myself as Marvell PXA1908 maintainer

 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         |  36 ++-
 MAINTAINERS                                        |   8 +
 arch/arm64/Kconfig.platforms                       |   8 +
 arch/arm64/boot/dts/marvell/Makefile               |   2 +
 arch/arm64/boot/dts/marvell/mmp/Makefile           |   2 +
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 331 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       | 300 +++++++++++++++++++
 8 files changed, 676 insertions(+), 16 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20230803-pxa1908-lkml-6830e8da45c7

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

