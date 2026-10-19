Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B74E77E8
	for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409669; cv=none; b=fJ/zcmGgDO7vziv374VlwuyJvcrqef4++3J7kGwTS8sLqWOZzeYfvWQX6f+ymF9V/pZb4Bf3fy7FWK43dLG9tHvP173Iy2AitpVHPlB/SkB7ykN+v1LNC5NqGhMrRsRTeyYY826G0uM6GyRBCLeWwJhTD4vpltqWw9DKExsGbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409669; c=relaxed/simple;
	bh=Lt3ii6eB1D89xJsVplbWR4wuGBxg4Iw/+SvTpHwYNvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETSC8XPkde8y3XIg4M7nGNWQNLmVadm4atnzitqsectZz4dlmgFzeNdv32PIdX24pTAqNYjxFaygT1OvPUUeuyMqLByVdm42tirrB7yVP+xH/de3L0EIWYv2D/sHf6RrWPuAa64CRqP7k1rh4UEEHU0rJLmN1ae6svR0o6JXiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=avUdBo8b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N6vPCxZS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="avUdBo8b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6vPCxZS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Ot5u1348215
	for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 11:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tT+zcc5XaW+x8YKOmYn4nNdNGEaba1CF/fy
	mymdhyO4=; b=avUdBo8bW4YKwvlbxT6q7YpPZycV/qey/n6ym/HC6zICKLiXU9t
	PjrbaJN/DaLESDpDPmRlEOzsUFhl/nLEV/Z3As0XvCtFzfrN6P43Vvz4YURosAOa
	qTSxztRytDxaBexz0GGU7j7UvNYXoZ4PIaimRlEck1lWvXKfIl/XntTa6UY84h8W
	wwSi4PVnqBJYEz6BrG49IijzWzEZ1E2cq7vd5OZcb9JlhRLHAZZqygvIxEGJYmb4
	EDaCI07f1qS/RPlJO4K/ffjTrN6Ed2KhFLKdktMoa2hKVTwxpouhwXtQwTrU/YD/
	tOdNoBvcngWYSdKbPBs8vLUG3+m9hiRENEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgud1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 11:34:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f32050e72so568411085a.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 04:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409661; x=1793014461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tT+zcc5XaW+x8YKOmYn4nNdNGEaba1CF/fymymdhyO4=;
        b=N6vPCxZS8CgOCo19PELjjDBPqagiig9v5htXr5tjJVOgsAnGIjIhQhsoKQO3aCUuke
         YXqaqmJYhL31qDthzttHPNrFobTgb4V0XbHa5QNCuSha09tZpsn9PCYOl8hgDRbn/gr2
         wGTXlKgDLlar9g1PZDH+JKdYouBFbReenF6uxPA7qY7Y8Nmc3OUEdBBTspgHKqZe6+W+
         MgeWSP+bsJNrtK9CUw65LxQRHE5bGC1M28VR4OU7aD8jJomjhwLHvz5cQ7o/v8N/p+Tr
         WO5xTEvA7DbqSwAxcLsaue1NtVkv2Qc15cvJ7bP9BVKyPf4GTXA3cujaCdWaRspSEfkK
         qkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409661; x=1793014461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tT+zcc5XaW+x8YKOmYn4nNdNGEaba1CF/fymymdhyO4=;
        b=zno8htaQ8zeTGxPDD74jiMAsgahLkdXEMqX/2B9s1Bc00TwtHK6/kULu7XA5IH/y0N
         EydV+96vVnkGKXrJBUk6Y73rJ6j+C0C8PWDh78oz2NNlS7E265TTaF/X+gAcqCVCeCI2
         gDi1IAgXZflPGcRJ9TIyS7DWnUDoHTMYiEKRRRvP21fUXI0pnXkg7l3Pd1OqaARb1tCx
         cDujmdzk3KhAZ/arwCiC7iuNxwjpu2dkkyDVSSLae33516/dIYny/SIM6/ZeOTwoQCOs
         m80ZzEx8T/1Ih2ouS/1Ynjx/uZNzNvnCgzZBuSUWearbvDF1BWXk/vP4t/uO52ayLvNp
         Uhjg==
X-Forwarded-Encrypted: i=1; AKwUvBxgbilXzGcoxJszOY+pcyog8egsAeHCGcYdbm4IcMuHINe4+uBAKvsXU/rgXPq844MsFwQA/qfnPm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUcl/aJsjSYNPMUIVJarr14BKzHr20aGXSD9D7V2BcPCTVVDob
	h9+AuDp1GqDlA6VbYN/AP3MZmaXaiGXvamGw/fkZ7RuZ05Son8TpFlY+BNnsaA5ZqHvv1UU1oD9
	MIqrlAtXws4Gv19JLGw2plpPSxBzAMX5oQdJtI80r5hhR0je/otd+/igHdQzHd50=
X-Gm-Gg: AYBFou2EuJmKMjBLC/hJdlZk+KoYssveQFYKYxnHqu7abycWpdQs8eGQq59nUqxIudA
	VfmflTL5CRXjJSwVeKTE1YWpoGKGeC3O7zQplqmjbyNwyVbkGBuVRrSFREgFZfKWW/hXiugKvn7
	1YfhHcTa1SqrEx3GvkfD4jEApdHHlVXRXqvwDbEoFL2APteCXt6jsSMARX96a+AKewjxJg7HcyQ
	s+tA6Hr/zhHcz1Mo/b7JPnhYdMAJMWxlmPo3E0RJKbUECb9ZGZQ6sN6C5JFdGIE6EeDGtYpRxtI
	SIAtX2Biyi9CwqQRn84XYPpBtdwRuEY5oMDLyayznbbpnUZGxbNK9HxTcI2yZIbbNNyTX0qgRmQ
	R1lXM7V03P9D/1xPkcWVVSkQZ8E/VHhb0vGl1E8ZSzDUpM+hVXZSDT9egwg==
X-Received: by 2002:a05:620a:4551:b0:93e:869c:43e2 with SMTP id af79cd13be357-93f29d5a75bmr1182668885a.50.1792409661064;
        Mon, 19 Oct 2026 04:34:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4551:b0:93e:869c:43e2 with SMTP id af79cd13be357-93f29d5a75bmr1182665785a.50.1792409660537;
        Mon, 19 Oct 2026 04:34:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1d8b4csm3760297a12.26.2026.10.19.04.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:34:19 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC/MEMSTICK updates for v7.4
Date: Mon, 19 Oct 2026 13:34:17 +0200
Message-ID: <20261019113417.27994-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hRjvVcdQuKXec8kZHRH5stc6Obvqgq-o
X-Proofpoint-GUID: hRjvVcdQuKXec8kZHRH5stc6Obvqgq-o
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad6003e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=HqS2aciJiMUm7O0v5zsA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX5UnIFB4ztbG9
 quEeFhWCEWQzwDBlUdlEcfJgs8JterT48mn7KU67jiiOZ7xBD+BH0KhSKH/0Aq4fnz+QJS4MJef
 VRtp0t4ShGCJnyGNbVq04prTkLP3VR5np+ebOBrASSI2rp/Jc/cxNIQslWt1glpYNPWL1el/HKw
 HQtyO+d9mVBBr0Vw+XwQFj/cTlrECWCicM4huTVQDoZML9rKr2ZFzpdh9qp0sq3/bwvru4CIBjh
 N7bJeoOMIeDlkJ+PsN1TqZSJGZynZpALioy/NgKkk44NvlMz1pXweteg/wDUzeJj/PVI7IgtOU3
 Nq5nkdLNuhcSpmoPpbQTFCNYYhQcDlWJ8ILCFm742HvVnAx8hmTO9a7hKNXXvIdtNptuvmUmxYu
 oXXkh2C51iowkwRQexVjbw5gKN2RUd2x6qRztJf6Gwa02x6BRiPXSwCFORYL9kBFObsjVrFUzPk
 AotQgj3VFRrgQTYLExg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX+8GWn3Pw+519
 GTLwgGzOjRj2qU2JXp+kR06o7Krv40CWtTPrVRQG6FbeshDa1OBg7xnnIzOdnPd7xh05ReIzStI
 94Hd3C6ny9SJDDPROfRLkKquhSRuLk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045

Hi Linus,

Here's the pull-request with the updates for MMC and MEMSTICK for v7.4.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c96ca94425b076dc398d929366e378d1e22ec794:

  memstick: rtsx_usb_ms: complete requests after eject instead of dropping them (2026-09-30 17:53:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.4

for you to fetch changes up to fd9af27f6c2319713bb23832066585f8a59a1771:

  dt-bindings: mmc: sun4i-a10-mmc: add Allwinner B288 (2026-09-30 18:02:57 +0200)

----------------------------------------------------------------
MMC core:
 - Add a power-off-delay-us DT property to support HW specific delays
 - Add mmc_send_tuning_timeout() to allow hosts to specify a timeout
 - Enable hosts to control the re-programming of the crypto keys

MMC host:
 - dw_mmc: Add a common watchdog and convert the various timeouts to use it
 - dw_mmc: Expose the watchdog state in debugfs
 - dw_mmc-rockchip: Use a tighter per command tuning timeout
 - greybus-sdio: Convert to devm_mmc_alloc_host()
 - meson-gx: Enable the bus pipeline clock on T7
 - rtsx_usb_sdmmc: Start card power-up at 3.3V
 - sdhci-cadence: Add Altera Agilex5 SD6HC support
 - sdhci-cadence: Add Cadence SD6HC support
 - sdhci-msm: Add support for the MSM8952 and Maili variants
 - sdhci-msm: Use pm ops to better manage restoring of crypto keys
 - sdhci-of-dwcmshc: Disable CQE error halt request for Rockchip
 - sdhci-pxav3: Disable clock inversion for SD HS cards
 - sunplus: Fixup initialization for DDR modes
 - sunxi: Add support for Allwinner B288
 - vub300: Remove the driver for the obsolete HW

----------------------------------------------------------------
Alper Ak (1):
      mmc: sdhci-pci: Replace deprecated PCI functions

Andrew Gaylard (1):
      mmc: sunplus: initialise rd_crc_dly=1 for DDR modes

David Laight (1):
      mmc: core: Replace strcpy() in loop with memcpy() outside

Geert Uytterhoeven (2):
      mmc: meson-gx: Make sure clk_init_data is fully initialized
      mmc: sdhci-of-arasan: Make sure clk_init_data is fully initialized

Hemanth Selam (1):
      mmc: fix typos in comments

Judith Mendez (2):
      dt-bindings: mmc: Add power-off-delay-us property
      mmc: core: Add power-off-delay-us support

Linus Walleij (1):
      CREDITS: Add Pierre Ossman

Lucas Tanure (2):
      dt-bindings: mmc: amlogic,meson-gx-mmc: document the T7 pipeline clock
      mmc: meson-gx: enable the bus pipeline clock on T7

Muzaffer Kadir (1):
      dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible

Neeraj Soni (1):
      mmc: core: Allow host driver to control the re-programming of crypto keys

Nitin Rawat (1):
      dt-bindings: mmc: sdhci-msm: Document the Maili compatible

Pablo Mazzini (1):
      dt-bindings: mmc: sun4i-a10-mmc: add Allwinner B288

Peng Fan (1):
      mmc: use assign_bit() where applicable

Ram Prakash Gupta (1):
      mmc: sdhci-msm: Use pm ops instead of macro to restore crypto keys

Rosen Penev (2):
      mmc: sdhci-pxav3: disable clock inversion for SD HS cards
      mmc: sdhci-pxav3: avoid of_node

Sean Rhodes (1):
      mmc: rtsx_usb_sdmmc: start card power-up at 3.3V

Shawn Lin (11):
      mmc: dw_mmc: add central watchdog and convert CTO onto it
      mmc: dw_mmc: convert DTO onto the central watchdog
      mmc: dw_mmc: absorb CMD11 timeout into the central watchdog
      mmc: dw_mmc: expose the watchdog state in debugfs
      mmc: dw_mmc: remove unused slot member
      docs: mmc: document eMMC health status support in mmc-tools
      docs: mmc: fix stale async request documentation
      mmc: core: fix stale mmc_start_req() references in comments
      mmc: sdhci-of-dwcmshc: Disable CQE error halt request for Rockchip
      mmc: core: add mmc_send_tuning_timeout()
      mmc: dw_mmc-rockchip: use a tighter per-command tuning timeout

Tanmay Kathpalia (5):
      dt-bindings: mmc: add Cadence SD6HC binding
      mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
      mmc: sdhci-cadence: refactor driver structure for V6 controller support
      mmc: sdhci-cadence: add Cadence SD6HC support
      mmc: sdhci-cadence: add Altera Agilex5 SD6HC support

Ulf Hansson (12):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: vub300: Remove the driver for the obsolete HW
      staging: greybus: sdio: Convert to devm_mmc_alloc_host()
      mmc: core: Turn mmc_alloc|free_host() into static functions
      mmc: cavium-thunderx: Drop redundant calls to get|put_device()
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

bui duc phuc (3):
      mmc: meson-gx: Handle errors from optional IRQ lookup
      mmc: davinci: Handle errors from optional IRQ lookup
      mmc: davinci: Handle optional IRQ return value correctly

 CREDITS                                            |    5 +
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |    2 +
 .../bindings/mmc/amlogic,meson-gx-mmc.yaml         |   29 +-
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml        |  105 +
 .../bindings/mmc/mmc-controller-common.yaml        |   10 +
 .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    |    2 +
 Documentation/driver-api/mmc/mmc-async-req.rst     |   64 +-
 Documentation/driver-api/mmc/mmc-tools.rst         |    1 +
 MAINTAINERS                                        |   12 +-
 drivers/memstick/core/ms_block.c                   |    2 +-
 drivers/memstick/host/r592.c                       |    2 +-
 drivers/mmc/core/block.c                           |    2 +-
 drivers/mmc/core/core.c                            |    8 +-
 drivers/mmc/core/core.h                            |   10 +-
 drivers/mmc/core/crypto.c                          |    2 +-
 drivers/mmc/core/host.c                            |   39 +-
 drivers/mmc/core/mmc.c                             |    2 +-
 drivers/mmc/core/mmc_ops.c                         |   22 +-
 drivers/mmc/core/sdio_cis.c                        |    5 +-
 drivers/mmc/host/Kconfig                           |   31 -
 drivers/mmc/host/Makefile                          |    2 +-
 drivers/mmc/host/atmel-mci.c                       |    5 +-
 drivers/mmc/host/bcm2835.c                         |    2 +-
 drivers/mmc/host/cavium-thunderx.c                 |    5 +-
 drivers/mmc/host/davinci_mmc.c                     |    6 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |    2 +-
 drivers/mmc/host/dw_mmc.c                          |  316 ++-
 drivers/mmc/host/dw_mmc.h                          |   18 +-
 drivers/mmc/host/meson-gx-mmc.c                    |   31 +-
 drivers/mmc/host/mvsdio.c                          |    2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |    5 +
 .../host/{sdhci-cadence.c => sdhci-cadence-core.c} |  303 ++-
 drivers/mmc/host/sdhci-cadence-phy-v6.c            |  975 ++++++++
 drivers/mmc/host/sdhci-cadence.h                   |  118 +
 drivers/mmc/host/sdhci-msm.c                       |   34 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |    4 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   13 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |    2 +-
 drivers/mmc/host/sdhci-omap.c                      |    2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |    8 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   13 +-
 drivers/mmc/host/sdhci.h                           |    2 +-
 drivers/mmc/host/sunplus-mmc.c                     |    5 +
 drivers/mmc/host/ushc.c                            |    5 +-
 drivers/mmc/host/vub300.c                          | 2493 --------------------
 drivers/staging/greybus/sdio.c                     |   11 +-
 include/linux/mmc/host.h                           |    6 +-
 47 files changed, 1825 insertions(+), 2918 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (67%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h
 delete mode 100644 drivers/mmc/host/vub300.c
