Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899339DBC5
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316296; cv=none; b=NBUMj5UubqUdjuV+jR96CZUxKLoPxqIDpCsjIOhMCfuDsK441gQJPUNZDMq2gNSGeotIlaj3gvbQ0tjSKQGLVv4/Kd1ZmUBBNOtVgNRXUQ9Sg7WyDXCu6gLi7I5tzucnFMZSphfMLnmUIHanzA2clUjt4KeyA+IaOZCog6wMWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316296; c=relaxed/simple;
	bh=x4KuWlNHrtduk63fU3+VdfHxrBuqpPNzQe4+3S2TuTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MOxzZv1fYsnRsXkTO+8Ftb41kdn8/KO0KpkVmAvhUirUOn/x//iE8aTJ6BIBf1FJWMLrx88E4GL1ZVm7P+qOC30EJDv1EsjwweGKHSIf3ODUl3Bwxp26QKKX+9Znu3w0ngI56uhbZh4Wf1wb/s6DCpyBMcdeLoawLgVpyKX9nQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8R+kjoE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BcVSh0/b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8R+kjoE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BcVSh0/b"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LBq0tC1804178
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 12:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2MIiI46oA3KiUFcz+M9g7y
	WRn7DRTsn2+GC3whOOpjg=; b=d8R+kjoEtYyNUnAEyeg3wlPBQtXodgbKNEXN4T
	1qoHHPJwEMUqGZ5rLq06xtb+JzQ/uIuoTSr4XW4dZV0X1+YOe0OeQ9bUBu+tcdd/
	poYdp0wuCGfSbB2VApqA+i3B4N0+2fiVh4LnOr7Fh3F0HH6SJFlDbrjJS8YZoiOF
	G92gKtDUuEHTX7wnLZSVHxlnQWhPM8GSECvEfuWxOlF5hP7UTrFGEstM5EnMYvQ3
	BsJanFN4Gax7FwB266gimSXhZ/1XKK9v/BVLNeaEi3kcjgrt+yPczJ+Fl9U22s5x
	vrl9+6EmD6r7nRGOS9tBooX6hevQqrm7G74HNZDgMraOS82g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fbw9rrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 12:44:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-74748e3a5b6so853769137.1
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787316293; x=1787921093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MIiI46oA3KiUFcz+M9g7yWRn7DRTsn2+GC3whOOpjg=;
        b=BcVSh0/bBWe+Qpo/xIQ/pTAEZ/1c0o9x32eo3UTbUURVjYMjXwVNdVHWHx9NCHZlbM
         obQQyZ+souSaMzgyMeZT8hwgllkY/65R0Xp3O5iyyEQsXPS5n33qSYqiNZ2yeayddzV2
         jyUjy/yoIiiu3Rc+7f8wKfOJ8SkfSsIRLI5bmQyhHEmJPYrjaojr37HcMcY9GQcr5C0j
         LOedY6LgB/0N7hnDmuYFFjt7h1eNLbyRkQuSz2XJf+sEradDNJ/25IbI2YIywcBpnXmc
         Mi7Zb7i1qlyf26VyDZEhkuS1IWUuJXyOaGLbs1aZMifTEnv2vIttvqCWF8ATexkidoI4
         LSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316293; x=1787921093;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2MIiI46oA3KiUFcz+M9g7yWRn7DRTsn2+GC3whOOpjg=;
        b=FDcvUBrFc+c3lzUcs/Mhrae8Z8MuetuuiDmFAHojbN1cnT8H2g+no35muz/CUIhbco
         NsVMfp5+L90p0rqgyCfnUyc6XvjsP1OmhHUg+p1Lh3Zyl+G/QUh4M1tuIOcdvimsxofA
         qE06qmi212IZihtfuGBtHV66dcBUVMVum56kAlADId1KBmT5HhJreO+kBVzeiy8EsGU3
         Z3kgPgidsu2cQ5+4ghJHVOaNPuG1klGPcdKc1D4DAtCJz0jAPAtE4z7UlX5Fciz36UnJ
         XHm3HK/PboVrYMoZtG5SP6IXidw6fFCRxHMBPEu5O56GYxkKWviqpMGMl6gbwoFP6YRK
         XN2A==
X-Forwarded-Encrypted: i=1; AHgh+RppzjWj/erzE9xHBeabxWEUC2ZBAkVHQD6HNVmQu1VL3rPfTy2wLLvG4BcLtPwV6mYZgkfqaDb4e6s=@vger.kernel.org
X-Gm-Message-State: AFuF++n+KnEkJ8Uo2EoBroq2zGiauSTpe12EP2rL2ConOinka/NY5FfW
	JDX1e2rXUNrKoLmdPkkAfRsz96coFY8Jbuou2Rd+nWa3i4ZbD+gIyr3L/0I/Oqey/Qnd3r+6Sca
	yxTq8DPJdYf+yR2RDgilhU0ZqpMqj3VKlSmfGUn5u561XRTat3f5KFZF+bQFMmIQ=
X-Gm-Gg: AR+sD10bbPv0nIceu4BVnpefIVpx8Xja6E9+S+P755qgLfZSxtgi59uGsrLIV7cDyjA
	Oap/tByGyE638y9WkR47E+0I6ngBu9lUVFn6xmP8wpLmvYAeMGeJ5icSrQDWJjd7EEJ3j79U1eN
	tY6zsaI1wk3CkO5M1jJJVtW6M+NUSm2n/FtlP1QGN/K94vKLTooz/yw15Q9id58iQRe+O9/ktoR
	+rIi4xwQuyIxIguGZ6xfNlhUZJdR9ph44vK/IBJAfTS1n/Q5LxZYiLhQH2bC6REcgU3Fto8BmxL
	1rE4LK33H7QEh/Jn3cgeBWj8zhaav3yu8Gie4HyGAIdek2DK/1v7zH6Q7wijDzPMSfArP+nwhKn
	eWgu9BdITl/erJiBWly3h6AKnRziZhkWELOh6WYNpxmtAUDrmlW74GNl43A==
X-Received: by 2002:a05:6102:325c:20b0:745:3eb9:8de8 with SMTP id ada2fe7eead31-778f37da7bamr2645381137.17.1787316292891;
        Fri, 21 Aug 2026 05:44:52 -0700 (PDT)
X-Received: by 2002:a05:6102:325c:20b0:745:3eb9:8de8 with SMTP id ada2fe7eead31-778f37da7bamr2645373137.17.1787316292434;
        Fri, 21 Aug 2026 05:44:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff177859sm6217027a12.27.2026.08.21.05.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:44:51 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC updates for v7.3
Date: Fri, 21 Aug 2026 14:44:46 +0200
Message-ID: <20260821124449.30450-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX65L9qTNiBpCa
 ePx6AIc5HNDwyhJbgttzCS41TANogicWCX5yD/jws7SalXgpmbFiL8p0wMNzCFk3uMcEnwx+YqU
 FtEpbSPCRTDWTflRvfUMhytGRSoeXkM=
X-Proofpoint-ORIG-GUID: JDqeuMfm0IYnf0m-Fs89Q61TLWktagNN
X-Authority-Analysis: v=2.4 cv=L9AtheT8 c=1 sm=1 tr=0 ts=6a884845 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QAJODBHuosm4ZC8Xu-0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX2MD4MrE77Uws
 1vFuwVBL37WTaYWq+0/L8KfzcDfxKgNWZeHkwti4Th9+aYQC7DMfqvAtrPQKG8iyIGpG6Rei1g3
 Czoxpke35tWD4zJVTbW75o0K2NfetBOXNbmZ9ZnzlezwYdZVWxJMWAD/wX+hoKhRocnUJbMRP+b
 kR5Id/707nx9eoFkZLzqTnpuq0rQMkg9S3DiKQEQ/mLj8+iHQngclAaDFx9tuj4yb71FhRp1b3Z
 vkWQ8AYBceGZ659vsqSfutcG+ZhXnv79y7qH9ST34KcQPl0QjbYlTyWJ5YdJxdFSqZe/DnKI1sT
 N297SAnx6j8om1JvjxHmFrO7aFAhH4mHEAt9xb94c1zBeJlzM9hCMs6kj3kcVtoeHCOKtUsoXBc
 bT8YR9DUR+6CGf2WOyoZH/53X6NzyjWseVe4Dgc1uUgqMTqxW2GVy96dvM150n+T+pWVkLeLYrS
 60j83BYx2DV4K6zR4+A==
X-Proofpoint-GUID: JDqeuMfm0IYnf0m-Fs89Q61TLWktagNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

Hi Linus,

Here's the pull-request with updates for MMC for v7.3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 00179ed9fbe07799676e2cb63c4e7f0e7cd80a5c:

  mmc: loongson2: Fix sg iteration in data reorder functions (2026-08-04 15:39:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3

for you to fetch changes up to 35e689fb79dcbaa8d69cc4a58a7ad4d0d7346e4a:

  ARM: PXA: Fix build error for PXA93x (2026-08-06 13:54:16 +0200)

----------------------------------------------------------------
MMC core:
 - Reject invalid perdev_minors for the block device before division
 - Document DT fixed-layout NVMEM provider support for eMMC cards

MMC host:
 - Convert a couple of plain text DT bindings to the yaml format
 - bcm2835: DMA mapping improvements
 - cqhci: Fix sparse warnings for endian conversions
 - dw_mmc: Stop and complete DMA also in busy state
 - dw_mmc-rockchip: Add support for the RV1106 variant
 - litex_mmc: Add dynamic bus width support
 - moxart: Propagate error for DMA completion timeout
 - pxamci: Remove PXA remnants for the PXA93x support
 - rtsx_usb_sdmmc: Avoid USB I/O in runtime autosuspend
 - rtsx_usb_sdmmc: Suppress false CD after init timeout
 - sdhci_am654: Add Judith Mendez as maintainer
 - sdhci-esdhc-mcf: Do not use readl()/writel() on ColdFire
 - sdhci-msm: Extend the DT bindings for ICE
 - sdhci-tegra: Add support for Tegra264/Tegra238 variants
 - sunxi: Add support for the Allwinner A733 variant
 - via-sdmmc: Clean up card detect work at remove and in probe error path

----------------------------------------------------------------
Ben Dooks (2):
      mmc: cqhci: fix to missed endian conversions
      mmc: dw_mmc: move declaration of dw_mci_pmops

Chanwoo Lee (2):
      mmc: core: Remove unused buffer allocation in sd_enable_cache()
      mmc: cqhci: Remove unused intmask parameter from cqhci_irq()

Charan Pedumuru (2):
      arm: dts: st: align MMC node names with established convention
      dt-bindings: mmc: st,sdhci: Convert to DT schema

Eduard Bostina (1):
      dt-bindings: mmc: Convert TI OMAP2420 MMC to DT schema

Ethan Nelson-Moore (1):
      ARM: PXA: remove remnants of PXA93x support

Fan Wu (2):
      mmc: via-sdmmc: stop card-detect handling on probe failure
      mmc: via-sdmmc: cancel card-detect work on remove

Greg Ungerer (1):
      mmc: sdhci-esdhc-mcf: do not use readl()/writel() on ColdFire

Inochi Amaoto (2):
      mmc: litex_mmc: Set width from linux request
      mmc: litex_mmc: Remove unused logic for the fixed bus width

Jerome Brunet (1):
      dt-bindings: mmc: sunxi: add compatible string for Allwinner A733 MMC0/1/2

John Garry (1):
      mmc: bcm2835: DMA mapping improvements

Judith Mendez (1):
      MAINTAINERS: Add myself to maintain TI AM654 SDHCI host drver

Loic Poulain (1):
      dt-bindings: mmc: Document fixed-layout NVMEM provider support

Marek Szyprowski (1):
      mmc: dw_mmc: stop and complete DMA also in STATE_DATA_BUSY state

Neeraj Soni (1):
      dt-bindings: mmc: sdhci-msm: add ICE phandle

Pan Chuang (1):
      mmc: host: Remove redundant dev_err()/dev_err_probe()

Pengpeng Hou (2):
      mmc: moxart: report DMA completion timeout
      mmc: sdhci-of-ma35d1: add missing MODULE_DEVICE_TABLE()

Prathamesh Shete (4):
      dt-bindings: mmc: tegra: Document Tegra238 SDHCI
      mmc: sdhci-tegra: Add Tegra238 SoC data
      dt-bindings: mmc: tegra: Document Tegra264 SDHCI
      mmc: sdhci-tegra: Add Tegra264 SoC data

Rosen Penev (2):
      mmc: moxart: use platform helpers for resource and IRQ
      mmc: omap_hsmmc: use platform_get_irq_optional for wake IRQ

Satyansh Shukla (1):
      mmc: sdhci-of-dwcmshc: Log eMMC reset calls

Sean Rhodes (2):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend
      mmc: rtsx_usb_sdmmc: suppress false CD after init timeout

Simon Glass (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add RV1106 compatible

Ulf Hansson (4):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      ARM: PXA: Fix build error for PXA93x

Uwe Kleine-König (The Capable Hub) (1):
      mmc: wbsd: Drop unused assignment of pnp_device_id driver data

Xu Rao (1):
      mmc: block: reject invalid perdev_minors before division

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   4 +-
 .../devicetree/bindings/mmc/mmc-card.yaml          |  23 +++-
 .../bindings/mmc/nvidia,tegra20-sdhci.yaml         |   6 +
 .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    |  95 ++++++++++-----
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   1 +
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 -----------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          | 105 +++++++++++++++++
 .../devicetree/bindings/mmc/ti,omap2420-mmc.yaml   |  60 ++++++++++
 Documentation/devicetree/bindings/mmc/ti-omap.txt  |  26 ----
 MAINTAINERS                                        |   7 ++
 arch/arm/boot/dts/st/stih407-family.dtsi           |   4 +-
 arch/arm/boot/dts/st/stih410-b2260.dts             |   4 +-
 arch/arm/boot/dts/st/stih418-b2199.dts             |   4 +-
 arch/arm/boot/dts/st/stih418.dtsi                  |   2 +-
 drivers/misc/cardreader/rtsx_usb.c                 |  26 +++-
 drivers/mmc/core/block.c                           |   5 +
 drivers/mmc/core/sd.c                              |   9 +-
 drivers/mmc/host/alcor.c                           |   3 +-
 drivers/mmc/host/bcm2835.c                         |  37 +++---
 drivers/mmc/host/cavium-octeon.c                   |  10 +-
 drivers/mmc/host/cqhci-core.c                      |  17 ++-
 drivers/mmc/host/cqhci.h                           |   3 +-
 drivers/mmc/host/dw_mmc-pltfm.h                    |   1 -
 drivers/mmc/host/dw_mmc.c                          |   1 +
 drivers/mmc/host/dw_mmc.h                          |   2 +
 drivers/mmc/host/litex_mmc.c                       | 131 +++++----------------
 drivers/mmc/host/meson-mx-sdio.c                   |   5 +-
 drivers/mmc/host/moxart-mmc.c                      |  40 +++----
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/mvsdio.c                          |   4 +-
 drivers/mmc/host/omap_hsmmc.c                      |  15 +--
 drivers/mmc/host/owl-mmc.c                         |   5 +-
 drivers/mmc/host/pxamci.c                          |   3 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |  13 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |   2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   2 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |  24 ++--
 drivers/mmc/host/sdhci-msm.c                       |   6 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   3 +-
 drivers/mmc/host/sdhci-of-ma35d1.c                 |   1 +
 drivers/mmc/host/sdhci-pci-core.c                  |   2 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |   2 +-
 drivers/mmc/host/sdhci-tegra.c                     |  32 ++++-
 drivers/mmc/host/sdhci_am654.c                     |   2 +-
 drivers/mmc/host/sh_mmcif.c                        |   8 +-
 drivers/mmc/host/via-sdmmc.c                       |  12 +-
 drivers/mmc/host/wbsd.c                            |   6 +-
 include/linux/rtsx_usb.h                           |   3 +
 include/linux/soc/pxa/cpu.h                        |  58 +--------
 50 files changed, 488 insertions(+), 460 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-st.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/st,sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/ti-omap.txt
