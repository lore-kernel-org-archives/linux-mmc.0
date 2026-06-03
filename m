Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD337409112
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474680; cv=none; b=DPmStVbq0Qc7zmVl5fYmmBUNxRNIVTlnXzoUJlHlBcrVEDgGoIIBJheQoUZYqB3Qjf0xJuXnRFOnwt3CVRUG0IukvMYY7aSBTGRd/OVEfxbRojGseNJ4019ayM9BMYN5gKbpVdtu9GO2zcOQJkOOKOV8g41qYjsPEBeUuspDoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474680; c=relaxed/simple;
	bh=siVCkOJCIpo4K19fdGfqUHZiRGMftG7SxvsrX3Hi/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ir6aYGgeNb7bZwN16K/dbeOfZKb6ZUE3M/G1j6IGsCPIHU28IjMrbyGHw/0NyzTy5Px4bt6KiSPd5IfbqRUQ1N0vyvVxNNpLG33PlUNIMHKudMD6y11mJDujEiVsjzB2vyThQOImKqUzCAt2BoX6L3/ZEkNJTWA9d2gti5DQmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hnbeRook; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i+us23nu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hnbeRook";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i+us23nu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RJoC3049356
	for <linux-mmc@vger.kernel.org>; Wed, 3 Jun 2026 08:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8Li13x49xQm2j2XhpbNUMJgPjtrLqsISpL5
	FuyGlDj4=; b=hnbeRook7dmLfj1yDRnzoeHN9dQISFxcjdZQhYPupjdpaw7mMcL
	sst5JEvMlD6TjxV1lHfc3r3reSU6bLz5WZuR+23xuoF+HKyf8CPWSD9PjXa/2eCB
	dclYyr2/2eRMfvpNJpRwc8oqMtJ6/HqwOZ4UgqDnUVFifNpv57K3FDTwMUbsKOy8
	v02GUN6xkXLCPrDP0Vmw6iS5O0W5NvCC9iKq/uuvhp6/jJsvoth6644txPk9eAz4
	zvhlN1DC+2HIg3aFjo4/n45QUkWpXoD76METCkIaSKHm/3SdVd2WOXAE4rKyvWxk
	bi9JYPCjxN5GrkrcFRZxY5l/9ZpQGuIkkTg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabg1dht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 08:17:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c33d75153dso1786822137.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780474676; x=1781079476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Li13x49xQm2j2XhpbNUMJgPjtrLqsISpL5FuyGlDj4=;
        b=i+us23numeQkf53Iv2ygNbisqbwaI8JlAIFPx4gbf0++kwpVEHm9oq3e9oJUrKwqLA
         m5JqBcQtoY5MxE3T9DgibpvRfeafIPaQb8kSakv1/Je3P0YCpYoRiASachektwGvTq0y
         PLMPziNZ0hMSp5wQ2Jf2K94Y5L4AzlO6lPq74X5MkUJz1M35gvvIBrkmPIVzX4+kuxY5
         K32PKKZpyQyYAKeCcrIukshHQ8YQRH3nZ24JT6TSGZxfHfaENj5YjDmcZuKoLSOyf5A8
         f2iYLG1awjM69i1kYDxaJXkMCS0D4Mze3MT/Q661rjd2W4zrjFRPV0pZLWrur7XS+FEY
         6F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474676; x=1781079476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Li13x49xQm2j2XhpbNUMJgPjtrLqsISpL5FuyGlDj4=;
        b=VQlrcysy9q+QsW6EmuT96vu2XQrGMZ72CP23wXEaDUUuuYEWyn3lyttTZdP4uqHbcO
         5trb0Qgc4DNyWnDWC33XGnWoBrW3dt98ooFnF7Tn4HxA9dZ5u5SXgby1K8Jtd2Udp2C5
         723oE5d+EviMwV146qRXYZfm2C+SqxmscafzpbLQOE0wRTvCwnQuoRrEQRpPPXrr3GyQ
         w3uGORVuruyTnPrREuvZHXiqslGUYjuba6swP93FwVY0O/3X+c0Tbv/KOG/kfB35O3JI
         xhgm5ghM+kecmshRYl0Kh7A3dZ366j0Xt3VZ4IN6gksWCLOmIf3f1ad5m0C4pt1wC3Wq
         GoHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AXtFimWF4puvu91kxCVqt2EsG3VD5ViYIPT6T1f+BZEXlJQ0YDPJGYTH8UWPkiGH2/S1yf6sE8q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WGf03nDdGAA+a+Hp6A8cKCfm+97gWKI4uDXzF7A+/99fvXjS
	ZiB6FFD6sR16xfoZsfdG0LCXJ64hVmJBGG+kUBF9yOVFeniSYhNEHHT0Df4McFe8V16X0R+5W9j
	kt4wPVAKBOl3uT2MBZEYuRAeLspOy9DGjIxXAGTtSoqocw5CM1KYHCqprcC9TaCY=
X-Gm-Gg: Acq92OEd7P9VcwDfVxnLgDZa8Sd3wrhl55S4pSPBipxHTCaWFD+QWylKHqNr5vP4XC2
	u1tB+WnzW2TRixo4BJH+qJMhIBPz2pxVdOOPBz9UIcUweKk2XJqzYf4iHZejgUDQgTA7CyEibdP
	jSwh161Hd1FFYrdxXXytAf8ADTiFeXi2G/9nM884TQMzz0qSRtSybYHLsQEbqLuASXyy0Nq7BYZ
	nck5rMTTNxuNbBbMz4Gn3UISkAhNHBu2zGBcc+04chOEMmb+nwCr+01WDRNN6aVSGWRX7+4tl4A
	AxYZguRFpdhCyty9d1HEeTI4VdfjDk+hDU+kABMC8/JZAtqAZOB0B8QQwElVBtUv8P63NKrWMj3
	FhU3rqmkd2BCciMwy4OyE8FtS6+bZPvezJ0+CvJaWpBenQAur14N84hdnCn/lbtwAKunxfDEIQp
	W0ADxEsvUsdA==
X-Received: by 2002:a05:6102:f0d:b0:604:ec90:ba14 with SMTP id ada2fe7eead31-6ec2dcccc08mr747564137.11.1780474675778;
        Wed, 03 Jun 2026 01:17:55 -0700 (PDT)
X-Received: by 2002:a05:6102:f0d:b0:604:ec90:ba14 with SMTP id ada2fe7eead31-6ec2dcccc08mr747554137.11.1780474675322;
        Wed, 03 Jun 2026 01:17:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (c-5eea438b-74736162.cust.telenor.se. [94.234.67.139])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9995b5sm496222e87.76.2026.06.03.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:17:54 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@qualcomm.com>
Subject: [GIT PULL] MMC fixes for v7.1-rc7
Date: Wed,  3 Jun 2026 10:17:50 +0200
Message-ID: <20260603081750.9423-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CstdE_GoO25-KDDgPXSLJExPYrZxOBl0
X-Authority-Analysis: v=2.4 cv=Ev3iaycA c=1 sm=1 tr=0 ts=6a1fe334 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=P5VT1K3liJgWG2gEIVqBXA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=J8LJRMg6qUcy8gEuYH8A:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: CstdE_GoO25-KDDgPXSLJExPYrZxOBl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA3OCBTYWx0ZWRfXy5ACGIBsF+c2
 WPoqgWWjLNH4qs42VxAX1x248uKIn152XTbBuJ3koz2RyVANemBaMkvdLJkdKhAfhab9whzlsvI
 7j6PQ6X1VyVx43CAZ7tTEsrExqWfmjtoQNsjuGUdJ2scIu6jgmXDqZhP/WhNCa21LEvmePHGPxO
 iOMxL7C4te0BBpkpZpmpj0sjcIq9+Nb4EEk7Vlga/gk+zZx+6oCWdPRLn6w9mkGr0EW5exfF2qU
 BeqaKTPiK4MHQxJOxn2Pptx06RBL7T5tgdkut+DKRuvTe2uagBTB9PLFSCUy351ZDO2ZpxKcUV2
 CwAde5cuimcqkODCYtOfBmQrD25tN/x4xDtX5uP80178OD0xu66/E4I7P7q351+CtQpYZwTTahG
 DHT7cB4vC3EZVzlv3StdNBSVXl4C+zEYY00otXUqhWMo5vkKyxPlVlIG94dihnKlBR9JKuGpuf8
 NPUkzSUKdPzQCvlCFYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030078

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v7.1-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.1-rc3

for you to fetch changes up to f595e8e77a51eee35e331f69321766593a845ef2:

  mmc: sdhci: add signal voltage switch in sdhci_resume_host (2026-05-29 15:02:47 +0200)

----------------------------------------------------------------
MMC core:
 - Fix host controller programming for eMMC fixed driver type

MMC host:
 - dw_mmc-rockchip: Add missing private data for very old controllers
 - litex_mmc: Fix clock management
 - renesas_sdhi: Add OF entry for RZ/G2H SoC
 - sdhci: Manage signal voltage switch during system resume for some hosts
 - sdhci-of-dwcmshc: Fix reset, clk and SDIO support for Eswin EIC7700

----------------------------------------------------------------
Heiko Stuebner (1):
      mmc: dw_mmc-rockchip: Add missing private data for very old controllers

Huan He (1):
      mmc: sdhci-of-dwcmshc: Fix reset, clk, and SDIO support for Eswin EIC7700

Inochi Amaoto (2):
      mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
      mmc: litex_mmc: Set mandatory idle clocks before CMD0

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Kamal Dasu (1):
      mmc: core: Fix host controller programming for fixed driver type

Lad Prabhakar (1):
      mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC

 drivers/mmc/core/mmc.c                        |  4 ++-
 drivers/mmc/host/dw_mmc-rockchip.c            | 17 +++++++++++
 drivers/mmc/host/litex_mmc.c                  | 20 ++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 44 +++++++++++++--------------
 drivers/mmc/host/sdhci.c                      |  1 +
 6 files changed, 61 insertions(+), 26 deletions(-)
