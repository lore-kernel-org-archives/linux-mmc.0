Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2D417D7A;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202358; cv=none; b=h4HLyN5Q5GKtLIUnOthyGYfo0AybQIZuvQdDRwecbDLlpEaBYu9mB9Zmqeog8iQKVOo9OqsMNTFL9BtgOm2NqJrFYTJvDDj1/mXAGvgElEYh3qUa4QKUGZoytuMgjuqAIzYrpHyB56ZLUSH1WEDy6s8XLRy2+8UpHHEEorqJnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202358; c=relaxed/simple;
	bh=zcsT2WsSUKfYvvv37MpEslHcCdvPIO3pvHcnegCE+qM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IlodRnwOvB8344midohGLIK1Z3nOTkhRymnmxVunN8A8UmMARBvl2S4VXOa6NjJOCscK3iKxPyGO+lUTaVvH4qs+a76ijVcE/tnrwR/99J6DVYo/H9Fvn//9tRQYY8RNnKq/bKqZqxKHL35A+SEbRHFXRbqNUVzn/MKvm5e2kNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atPW3fKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atPW3fKM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1650C2BCF5;
	Sat, 12 Sep 2026 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202357;
	bh=zcsT2WsSUKfYvvv37MpEslHcCdvPIO3pvHcnegCE+qM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=atPW3fKM9VYAf2l+tlU5AU/I7NIeBIOFH7kVvzOvYL8QGfqnQXTI7bil2gXBQpjE4
	 UUpQ5be6sQDj8JQg5Oq39AECwdiaaxe+BaV12TAXEArxSjKyFG0wc7DencJFp46OZB
	 8jNXix3v54cKJL9uBWdouccxrbQ5SDDHxZgmRC1u+c6KxuQXndoryPlLgv8RIrRTBc
	 pyQkJMLshMUdsRL8P+n2FVsM9yL1LHRretB3R3eDRtTT9OiLS42mJ4/BA09NcVItNM
	 QPvHYN3kBaGdLYPZB+jU8Llqkz1HzCtL5dHBtOG+i0awmY9pqKF8XaDES3z3t4Rs0B
	 Z/vqj1VxqPvig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96197C79FB6;
	Sat, 12 Sep 2026 08:39:17 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Subject: [PATCH RFC 00/20] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
Date: Sat, 12 Sep 2026 11:39:09 +0300
Message-Id: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNL3dziXAtLUyPdzLzMkszEHN3i0oKC/KISXTODRANTy2SjVEPTVCW
 g7oKi1LTMCrDJ0UpBbs5KsbW1AD17XiRuAAAA
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=7018;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=zcsT2WsSUKfYvvv37MpEslHcCdvPIO3pvHcnegCE+qM=;
 b=0OftOSNYxVeMSqMsBbcp4XEEIolrL6nMaeLjXpSmhNJ46/YeqYJ9Se43dkv1r9wGOmkPcgGKq
 aSr2AXql2uoBl+co1GskJCCoJ8w2LPTOepI5H0n7ZLNl7JrbLv0c/dL
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

Storage itself works but something related to jbd2 journal commit fails later.
Possibly related to this report:
https://lore.kernel.org/linux-next/6a9c44cc.0a3344eb.391530.000c.GAE@google.com/

It should be unrelated to this series. So I will ignore it for now.
if someone wants to see the crash, here is the crash from ramoops:

[   31.437530] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   31.437572] Mem abort info:
[   31.437580]   ESR = 0x0000000096000004
[   31.437588]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.437597]   SET = 0, FnV = 0
[   31.437604]   EA = 0, S1PTW = 0
[   31.437611]   FSC = 0x04: level 0 translation fault
[   31.437619] Data abort info:
[   31.437626]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   31.437634]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   31.437643]   GCS = 0, Overlay = 0, DirtyBit = 0
[   31.437651] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000026578000
[   31.437660] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[   31.437679] Internal error: Oops: 0000000096000004 [#1]  SMP
[   31.437691] Modules linked in: extcon_usbc_tusb320 typec goodix_ts evdev libcomposite
[   31.437720] CPU: 6 UID: 0 PID: 582 Comm: jbd2/loop0p2-8 Not tainted 7.3.0-rc2-next-20260911+ #10 PREEMPT 
[   31.437736] Hardware name: General Mobile GM 5 Plus (shamrock) (DT)
[   31.437746] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.437757] pc : __bh_submit+0xa8/0x1b8
[   31.437775] lr : __bh_submit+0xa0/0x1b8
[   31.437784] sp : ffff8000841bbc10
[   31.437792] x29: ffff8000841bbc10 x28: 00000000ffffffff x27: ffff000023dfe8ac
[   31.437808] x26: ffff000026b21400 x25: ffff0000230ca780 x24: 0000000000009801
[   31.437823] x23: 0000000000000000 x22: ffff000025c15400 x21: ffff8000805a9704
[   31.437839] x20: ffff0000230ca780 x19: 0000000000000000 x18: ffff80008377d028
[   31.437855] x17: 0000000000001000 x16: 0000000026da3000 x15: 00000000268d6000
[   31.437871] x14: 0000000026da2000 x13: ffff0000225b2280 x12: 0000000000000110
[   31.437886] x11: 0000000000000000 x10: 0000000000000001 x9 : ffff800080661840
[   31.437902] x8 : 0000000000000000 x7 : ffff000023dfe800 x6 : 0000000000000000
[   31.437918] x5 : 0bf8e48cd3e9dd0e x4 : 00000000ffffffff x3 : 0000000000092800
[   31.437933] x2 : ffff0000222a4480 x1 : ffff80008153f2d8 x0 : ffff000025c15400
[   31.437950] Call trace:
[   31.437959]  __bh_submit+0xa8/0x1b8 (P)
[   31.437973]  bh_submit+0x24/0x30
[   31.437984]  jbd2_journal_commit_transaction+0x7cc/0x1a44
[   31.438000]  kjournald2+0xbc/0x218
[   31.438017]  kthread+0x124/0x154
[   31.438033]  ret_from_fork+0x10/0x20
[   31.438057] Code: 2a180102 9405f6a3 f9400a88 aa0003f6 (f9400108) 
[   31.438072] ---[ end trace 0000000000000000 ]---

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
Muzaffer Kadir (20):
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
      clk: qcom: smd-rpm: Add clocks for MSM8952
      drm: msm: mdp5: Add MDP5 configuration for MSM8952
      soc: qcom: ubwc: Add UBWC config for MSM8952
      dt-bindings: thermal: tsens: Add MSM8952
      thermal: qcom: tsens: Add support for MSM8952 tsens
      arm64: dts: qcom: Add initial support for MSM8952
      dt-bindings: input: touchscreen: goodix: Add binding for GT970
      arm64: dts: qcom: generalmobile-shamrock: new device

 Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
 .../bindings/clock/qcom,gcc-msm8952.yaml           |   56 +
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |    2 +
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
 .../dts/qcom/msm8952-generalmobile-shamrock.dts    |  426 +++
 arch/arm64/boot/dts/qcom/msm8952.dtsi              | 2257 ++++++++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   29 +
 drivers/clk/qcom/gcc-msm8952.c                     | 3576 ++++++++++++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |   81 +
 drivers/soc/qcom/ubwc_config.c                     |    1 +
 drivers/thermal/qcom/tsens-v1.c                    |   44 +
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 include/dt-bindings/clock/qcom,gcc-msm8952.h       |  219 ++
 26 files changed, 6745 insertions(+), 16 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260909-msm8952-initial-support-60a059c2e15e

Best regards,
-- 
Muzaffer Kadir <muzafferkadir@mainlining.org>


