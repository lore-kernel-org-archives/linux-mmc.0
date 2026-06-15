Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2953F1AC8
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527081; cv=none; b=pqwbqMneQabZZs2I18/sFIujApRlNesA+r2qB9VhSsOeCdJ0qczvrZT7V/ptuq0vjv+OV0XgLzva+83N8860WvB7SJwtc3TohikaQ6eD7PxhbizJ72ZaiUG5eX3l9t8SmYOElE/fYWi/DM4fn0QoYpeArLStbPkRsI8EvPsrmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527081; c=relaxed/simple;
	bh=x294RGqAkOcbKNqTh76t8CTqOMgjMj57y62JLaI9tnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DRg/8s9vXFJUL77twk+bSN5ej0MJDQvb0JRvJLHvWCuP8J4NufMKQMXC5Slgzzy5IurKU2O+tAL6LM8DrRa7Kj/5UiBla4oBvQFTBIZf+TCldenHMz6ZfGOFVVJNAHCtxhHsk8g2jnT+AMUX0nPJRZO/U7KBY+BIyF8cuZls6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8crMhwj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LDYsDKcG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8crMhwj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LDYsDKcG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZDke022053
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 12:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I6fVp7jYcAZmrwzaUnaM3f
	qB1+h+mZJ/JXaPdRH08Dg=; b=e8crMhwjqCVWkfMOyGH+rLWJ25r4eNK2N98kNB
	B3PIlp2vB/+mPoyEkPeycpLtt+ViHpDRrXSlHf0xawo8OUeotw0gJN4DIsnAoJx5
	BZLeBjumjLvcoiC+d6+7nVRLnm8FjBJFClnJxVfx9GyrLf6vyM4iuaiFf9/V+sGM
	ViE9bT9tfHu695YwO37tkg749WYt4T1OC8HbQKJbNsKAkxTTdAdtmwrNyTTldPo1
	rio6whbthOKp4TJdafLWXYJRCif3ujJRNryzY6z7KvaSD7OJTWraALH+vkIDUDlZ
	AweXKfQaCu+4FoB9z7E8c9yJ1Qfnxf3cZwBwQYENMXphnCNQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa70j7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 12:37:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9158e75cbc0so499274785a.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781527079; x=1782131879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6fVp7jYcAZmrwzaUnaM3fqB1+h+mZJ/JXaPdRH08Dg=;
        b=LDYsDKcGWSdrGU19x2/Jx9ls1koOOIdjsGCyJcKCY/9ylKeoCisSeq27UmCjUx4NEN
         4ybDTWwl6DPVsnev3m6j1bQiXI3QVN5ewWFcDZv7LJ0TW5RfconD9usXDo6ghNc15/IS
         m2ycWHsang4TC2X2hjDohK5wkO4kM6/KtNwYkS8R+o2tJZnkuyiqPOZUKsCrhvEhBuoX
         XeZ2LP1S2YznyYaaxiqQ6kjgf69G2nhAqNwfSi0j5LltOifp1aapgMsRmdjaxsIUysQn
         fmb69Gg2SeM3UczO3jKsT/J1f1SXHqxtJS/bSIUIjPEFRPqq7SYbj+FzWRzN7v9ty0Rz
         b79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527079; x=1782131879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6fVp7jYcAZmrwzaUnaM3fqB1+h+mZJ/JXaPdRH08Dg=;
        b=R9aHEQTZj9uAknDd3tJD3RdgbkhNvY3IcZ20VbV3XcGgCnLfkkuQNgO0wYTWx9D4l1
         rs5SXldz8AzFs8vuYqFjdLCctuoUGMm4+JAkM0tersQmQNLqPpv3u5bgmnnEE2tl4ahH
         igxTUflQzwYX+u4D8AOK0MtbHkJAnBaoZZgsUkdHyG4tFB4BNhwOsY9r4OBMF8wXYa0C
         4NgRV6MJj7JnuKyTm0qy3OQ1d9RLu6PjD7OBN7n9cQ19ML1u4jc8I9dQQYxwT981T8La
         wfUcmQ9g2b06ev1KF68WP+2CUXkoBbcXKxDjeEdCW5H5Go32GCM3wpfLDEgHxRql/HkI
         j41g==
X-Forwarded-Encrypted: i=1; AFNElJ9spPBrjUsbwxuXcdc5ZtXylRvpAPc4F1cSffpIGZtK3SxeD+qRkFbqe3RF8ATRVsg9MtpmBq1kwoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCI5xZ5R7FEsEcbJr/scgw2N3SHWevC3bAhL3hn+J8YFQ/am1Z
	1H9y0/vd+HQ/IFQ7a707yzGXNs/clvp08Gv0j3w83ObFq8Q4fc+1UtbRNK1w0oCdhYocPpYRhZm
	ysF7bnWgEgDVaO0rSBNAJdslyObIl4SChODZRiMllM2nirRzVAoZoFKV/7yncUhA=
X-Gm-Gg: Acq92OH04/tA4ShHg1fqj2OSZzSNkuCoqHQILqZ0w/UnyLeOtGKoZcTwxBVcEAvuA6k
	LbklVkPpF1pFwMEoIdEpHv6S0Y3mGLGpXDO6MTKPiq7PkEolZdTknGBQ496U9ibkGK+q/pRogF1
	wMVhN2HFe+CkviQE4XYyYX/3uH5xQnt2v+W3f7XC/hICA/8vrFE3GX33UMJFkRnM3QhuI/9MXvo
	JO1ONSlaorjcPz/zEj6KAZ6FVmuLFimP8bFcAApmCSYpOi0ZivT59l0u8c6M31jdJ3NErHXjNxi
	Rqm/iG4q6JDjrpQjiPvi/bN4U3aDxi/4WJ8MLlgxexNJ2N4wgMm3Wrq7WeHF3QorubF35DbNSl1
	i9NHRa7Hr3jBIFNNgq0kgvlzwWyRUd0Moq0+o183PDXktBXsnBdACz9/wEMSprmxkLldYdPT1qC
	Wj5pk=
X-Received: by 2002:a05:620a:f0f:b0:915:aad5:e941 with SMTP id af79cd13be357-9161bc210e7mr2144987485a.17.1781527078724;
        Mon, 15 Jun 2026 05:37:58 -0700 (PDT)
X-Received: by 2002:a05:620a:f0f:b0:915:aad5:e941 with SMTP id af79cd13be357-9161bc210e7mr2144979285a.17.1781527078028;
        Mon, 15 Jun 2026 05:37:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b3d0bsm2798253e87.71.2026.06.15.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:37:57 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC/MEMSTICK updates for v7.2
Date: Mon, 15 Jun 2026 14:37:41 +0200
Message-ID: <20260615123755.10059-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _T5GGz5ZjJDeKWTS3TP8DV1Qfa_FrJOo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMyBTYWx0ZWRfXzG4HGpOXjefN
 lK/l1wA2LvL92bYjr/su7Xbj/Xz5VkiAj7fjdWAm65xSXtUf0UIr9zao80bwX7809ML24a0vEkh
 5koeVbTbrTN93+ktDusAL4CxqrNRdsU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMyBTYWx0ZWRfX8J+sTn+fw6ZY
 9zIBRIc3KttMc8r4o3TiBN6L9FJ6Urh7IDMIwOT6dlelE8hpWev2lLFUvCYYWY9Q3150QW40ilu
 8IRxit7vTzZ+VruPjcGrE8EVvQkQwT4916kJcqLEhhXe2/AFJBFuT2YcOvBlcQaR9wjFBQUG7RS
 +ppXv2qGk7j+nbliLlyGALMjsrEn2P1TMCD7WhAtjmDfBnBf56rPLSFDywUvb8FBzF7/CMAKGgL
 T8VkAIJIwFVPRb1sSlXJviocHqdPq5ieXhfLinFmvHq6wdclFExfcycqB/chyBA0DqlU3CL84M9
 HbZrqHtglrisRjR1W5ySNFbvN7elAvJBD+T8MxUSvU7s0HvJTJk8od7l2hltasTnPImqQxnBQ13
 RMeQ/H6IF9VlFSh2uwRX027la1lkzGNVdFDQsr1HsIHm3pgQl5Bd7F2tyUlGj6DygcXmYo/0yPg
 cYXtt75S+3AlWOwxsvw==
X-Proofpoint-GUID: _T5GGz5ZjJDeKWTS3TP8DV1Qfa_FrJOo
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a2ff227 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=iLZLDsJfo-nAcM_4oHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150133

Hi Linus,

Here's the pull-request with updates for MMC and MEMSTICK for v7.2.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f595e8e77a51eee35e331f69321766593a845ef2:

  mmc: sdhci: add signal voltage switch in sdhci_resume_host (2026-05-29 15:02:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2

for you to fetch changes up to 576e40d20e100ba62e21bfda94ad948820c90a23:

  mmc: Merge branch fixes into next (2026-05-29 16:42:41 +0200)

----------------------------------------------------------------
MMC core:
 - Validate host's max_segs to fail gracefully

MMC host:
 - davinci: Avoid potential NULL dereference in the IRQ handler
 - davinci: Call mmc_add_host() in the correct order during probe
 - dw_mmc-exynos: Increase DMA threshold for exynos7870
 - renesas_sdhi: Add support for RZ/G2E, RZ/G2N and R-Car M3Le variants
 - sdhci-msm: Add support for Hawi, Eliza and Shikra variants
 - sdhci-of-k1: Add support for SD UHS-I modes
 - sdhci-of-k1: Add support for tuning for eMMC HS200 and SD UHS-I

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mmc: sdhci-msm: Add Eliza compatible

Artem Shimko (2):
      mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
      mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths

Iker Pedrosa (4):
      dt-bindings: mmc: spacemit,sdhci: add pinctrl support for voltage switching
      mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
      mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
      mmc: sdhci-of-k1: add comprehensive SDR tuning support

Kaustabh Chakraborty (2):
      mmc: dw_mmc: implement option for configuring DMA threshold
      mmc: dw_mmc: exynos: increase DMA threshold value for exynos7870

Krzysztof Kozlowski (2):
      mmc: host: Move MODULE_DEVICE_TABLE next to the table itself
      memstick: Constify the driver id_table

Lad Prabhakar (2):
      mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
      mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

Manivannan Sadhasivam (1):
      dt-bindings: mmc: sdhci-msm: Rename the binding to include 'qcom' prefix

Marek Vasut (2):
      dt-bindings: mmc: renesas,sdhi: Document R-Car M3Le support
      mmc: renesas_sdhi: add R-Car M3Le compatibility string

Monish Chunara (1):
      dt-bindings: mmc: sdhci-msm: Document the Shikra compatible

Nitin Rawat (1):
      dt-bindings: mmc: sdhci-msm: qcom: Add Hawi compatible

Osama Abdelkader (1):
      mmc: davinci: fix mmc_add_host order in probe

Shawn Lin (3):
      mmc: core: Add validation for host-provided max_segs
      mmc: dw_mmc: Move misplaced comment
      mmc: dw_mmc: Add desc_num field for clarity

Stepan Ionichev (1):
      mmc: davinci: avoid NULL deref of host->data in IRQ handler

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Uwe Kleine-König (The Capable Hub) (1):
      mmc: via-sdmmc: Simplify initialisation of pci_device_id array

 .../mmc/{sdhci-msm.yaml => qcom,sdhci-msm.yaml}    |   5 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   1 +
 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  15 ++
 drivers/memstick/host/tifm_ms.c                    |   2 +-
 drivers/misc/tifm_core.c                           |   4 +-
 drivers/mmc/core/queue.c                           |   8 +-
 drivers/mmc/host/cavium-thunderx.c                 |   2 +-
 drivers/mmc/host/davinci_mmc.c                     |  16 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 +
 drivers/mmc/host/dw_mmc.c                          |  20 +-
 drivers/mmc/host/dw_mmc.h                          |   6 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   3 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  36 ++-
 drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
 drivers/mmc/host/tifm_sd.c                         |   4 +-
 drivers/mmc/host/via-sdmmc.c                       |   5 +-
 drivers/mmc/host/wmt-sdmmc.c                       |   2 +-
 include/linux/tifm.h                               |   2 +-
 18 files changed, 332 insertions(+), 57 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{sdhci-msm.yaml => qcom,sdhci-msm.yaml} (97%)
