Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309687;
	b=F4G5QhM+7R3bLdEDRnWlpLSwrapPurqlcRb5Sk7x3YlNbAydUxl5wQPo2WxTBzWnk883
	 WFOA4rW/Qe39unlwtm4bVeScusAgPyfkFwJ8YFr8zZFWvsu/wXWftXojRRobAR0OenN/9
	 WUnib9owR34Z9ylfOpip7sdQEVLS066m0HxDQB1xbm4qCwSdJj4GehLtcJ4BfurZuewj9
	 QJ/9lKAK2O5fXWBj0psHIneSHDd70qzEWof2IhRyHaFeUQVnQi62jTvJy8xBAvl6mHyLU
	 c0AB8hBURFLBo6t4bF9byHPNbCGT4OlqGq6ePqD3XN+xFQozPuJbnNPACEbwk+N7cXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309687;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=634s9ey5bVDAAJWvmWh4EmNBuNdV1VszbOyaPeok9lY=;
	b=XL+NmHg+RYBuKTQcaOmD9WbmAq4bdJBPNzhvsd9p6Kq2cCaG1SOfRSs6x0hvtEDIATYy
	 Qti4NVO/P+g/3wb3oTZVaNYywr6ndO7JGvKyIGjg0+BefuvJJFUhWrrtgFPMmOcHlNm8q
	 FoN8sceZjhkzO2JbUZ/o3fy8QMRhlQPdSMypM4VFRc+o/hu9nE5wW1mtQcvQOk5QmozTz
	 CkqtAuXwAyekDuFFYm+jx2nnFfp/HJvm8jE+0VVzKMD6OBLKL9Te4ImFCE2W2KxjV1EYI
	 j4EhnAqDxyCxuX+fyB0UKoj3+27fa2sssI2BUHO9If6OTe/vi86ZdEHApMclGCaJj/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fH47qvFI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8MPyVeW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98927606A326
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 11:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98927606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fH47qvFI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8MPyVeW
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9xZ23195930
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 11:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=634s9ey5bVDAAJWvmWh4EmNBuNdV1VszbOy
	aPeok9lY=; b=fH47qvFIu8/EMCCumwLKAUdnr6XTkxKY0Ng4W0Zj7U/7x8Tve5a
	Tg+kyNYddE/oYtwz4f6rXv6xnE/b9lF69Biqz37kujTpKyjYsoCUhPn1gHJrMzxl
	KoIHJEO0OKIc37MYoVIzrHX3EOPEKzovXzOqHBwxgMIzl5amh/Qb9wJMp8JcBi/w
	FHIv12S1IbkoW+3kTT+3+AKwyaXqeshdZ1wJ56z0vI0Sc5GOigsoGBI5koalXy1d
	UELGe8wb/NF5oxE8945BXNXAMcC22jwLGGOD1mkx8KlYWOrJSyCCYSQaVnri+/iS
	hBZ39V2fa23WParxsYItF4kqniDjXSHWRzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03crhd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 11:21:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1f2fafeaso298912185a.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794309685; x=1794914485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=634s9ey5bVDAAJWvmWh4EmNBuNdV1VszbOyaPeok9lY=;
        b=e8MPyVeWXqnLK2finPCUEb0A2dQQxADUFnlDtZNAAbMJBIKtZijDxrFF/eaHr6NQNw
         ZRUrmGytc77nHWPVRbOzqp2PfLzwwJNrkdNvHHFE7LMe3zhIomxc0zaeTdnYUshWk5cr
         7u53TqjKgbJeXESgyce+WGbU1EZF+1hkgIqb0SSdZ7Q44KMYr7ki8i7eYb+aWPStK05e
         xQxf4R2PtvIrq/i4flYq72hQg0Wx0H3N0wMkIwYT5kMXVRM+2cJ4EsozHunIXt18ruUC
         xbAT/qC4ujo2qDcTzo+CsjkfJCWpAttfiNSQcAisOCjWhTbYfiNuZoe2PfjJBUNhQxs1
         4cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309685; x=1794914485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=634s9ey5bVDAAJWvmWh4EmNBuNdV1VszbOyaPeok9lY=;
        b=Om8YKEW6QllBDsoIq4ArHUqKfLdHZJJ0fLUMyiIIfKXMp09TM8aErFxcL5d8LAroZH
         VEu2ydN5OQdpeUUc3fwPlnV9b/3om+phoJcnBveUL3qbZjpGQBf61tEH25W3YnVBu+KD
         zrPU8Z1i5Mgz3M9IV4BltygdnRd+nTmRgnktDE6rthGmzKvtPwxRjiCTI8vbH9bychk9
         StGvcb62J6tNtRuMnbQIWV3CXXe2z9Pzkwuiwi197WXLd8iIl0ItlgLXdEBwLVpifBDf
         dg/2Xagce38kq2XNN55JYTqe6U8P3CYSBKNQPYKvwsm5jCPsafovKswDw90rTOudras5
         rVuw==
X-Forwarded-Encrypted: i=1; AL+hErFVAoCzhTOKWeKkc2u6sCmtCmyBY9vLQFOg+z6krSgOG9ocAahxDNXOJhy/UveRFrJZA8U3aW6GI2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+y83NDhOghI1vVYvwYjNKusvjNiuh3TaNGJBvDn9A+WPznchES
	8CGlssF83oq3q6pjGCdQi6dBMiwnbitA1x5ReUdVEGp9CAITk/Gn/BqYfRsaYOsaLR8+T8D4i9t
	oc9XajHcAXopzdDEHMoq76CEqDhUeD24VPzWTcnWsTpvegZvK0C8vEcvsfFQeIyAjg2d+oZo=
X-Gm-Gg: AYBFou3Xt4KHOloKuM+qfplLoeJrNK6jFgGsP8KioMpNDILNInjx0AvFL++xEDHx6/N
	KzorzhdF4yPUTR9zk2603m3EURp5CiMO6Vt54Sqg2US8iz+M82D4DW35b95dSR6+mRFcG0n39+b
	rpBMiKNtfZqmWVUrV4/tsqV2x3kSuUQ4Y11swJRubfqd5fpAuOBl9l/obka1DB7sVJSH4TsmXMv
	CcM+fHeWGzhH+xxRP9fhwGBDPeR3HjoyfRYqVd4hTzWtiYGEfPmiahoZGA787sjh2UvnlJBRrZC
	U2YnJgaBHDkxhpzwq0GkOC7GKlSdtwRi0JZizfGzc1zjoMvrnlYhCyjI6lTiVdJN1gDxsoz9Btp
	YqtOTeaJKtmQCVwDCChN6Rx/UMeJu+Th3w5g/1O4QgXAzV2Iv7pndG0ve3HEx3WtmXkJDF9aV/N
	YdHMUIgbt1QhvDmni8SXsDQ4RTonBM/6g=
X-Received: by 2002:a05:620a:6f0a:b0:93c:7f48:8f46 with SMTP id af79cd13be357-9479f1d0c8bmr342015685a.4.1794309684600;
        Tue, 10 Nov 2026 03:21:24 -0800 (PST)
X-Received: by 2002:a05:620a:6f0a:b0:93c:7f48:8f46 with SMTP id af79cd13be357-9479f1d0c8bmr342013385a.4.1794309684196;
        Tue, 10 Nov 2026 03:21:24 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a61f5b6sm96498366b.54.2026.11.10.03.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:21:23 -0800 (PST)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v7.4-rc3
Date: Tue, 10 Nov 2026 12:21:21 +0100
Message-ID: <20261110112121.44583-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: sSTyB0w8ukwma_JSNqkxQIpTo0EhMdb_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NSBTYWx0ZWRfXxg6yPfMMhk/5
 JbfMwbx4c9ChN4TRkrk2LK8MnPnNmGX2ny0JpwgySJ2KS6vog5btgDggCP0p5mtUJgjERn1GqS4
 SLwn4CHU9C7W3xw/6YWF3GKHDQ0I3FI=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af2fe35 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=m3AxwWjehh6Nn5NoYwgA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: sSTyB0w8ukwma_JSNqkxQIpTo0EhMdb_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NSBTYWx0ZWRfX1T85PoaTNy8w
 fu0oH0e+xsy6jctco/hpuuEeKBaUmalE5+p4l8ExcplIGl4IvwyRE2bgFluNVpAGlRQGJbSG6Uv
 RVTQYP0WLa/kSNMWD6h9Huu8PahvaHLf86fWAdkyS2EKUnz9OcU+KNyJ5ZXqkJRgZ1+K1tV2Tq7
 H2fq2Hqel5gjKWDutKy7oU632VByg23JAtacfE0WeMFHoVjBOYL9nyg5B1Np3J9qzn/KaNsbNng
 1Jja3mcqbenRZWb885Y/8PY/BV5Sk+oWLtNh2qxXYnGyNMhuO0P8NN6fk1k57L92myeKeV+YLmN
 B5aW2chsT7khasukiUasHbR5HCyofD4KXmzt9Ydf6G5okFGKNg1kT0ovuSbDJkkIO4GESL4iAJ4
 KFRh6fk3SWFaYu1hh+8fsmjEI5LpjaSGn/BJeYT5HOx6CoUlqP6iXjiQ6zgGt5AAB93IRJkiGik
 zhqDZfBjKLjDe4SQ9yQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100045

Hi Linus,

Here's a pull-request with a couple of MMC/MEMSTICK fixes intended for v7.4-rc3.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.4-rc1

for you to fetch changes up to 6b8b1e8827837bf4cf1f87219038fddae9e81b0b:

  mmc: jz4740: Remove the host before resetting the controller (2026-11-05 18:56:25 +0100)

----------------------------------------------------------------
MMC host:
 - jz4740: Remove the host before resetting the controller
 - meson-gx: Fix support for busy detection
 - mmci: Fix DMA channel leak when mmc_add_host() fails
 - omap: Synchronize clock timer before disabling fclk
 - sdhci-brcmstb: Don't log an error for missing BOOT registers
 - sdhci-esdhc-imx: Map unsupported driver type to Type B
 - sunxi: Fix clock and runtime PM leaks on probe failure

MEMSTICK:
 - Don't clear dev->driver in memstick_device_remove()

----------------------------------------------------------------
Anfernee Cao (2):
      mmc: mmci: fix DMA channel leak when mmc_add_host() fails
      mmc: sunxi: fix clock and runtime PM leaks on probe failure

Ian Ray (1):
      mmc: sdhci-esdhc-imx: map unsupported driver type to Type B

Igor Velkov (4):
      mmc: meson-gx: name the limit of the CMD_CFG timeout field
      mmc: meson-gx: honour the busy timeout for R1b commands
      mmc: meson-gx: report busy from DAT0 alone
      mmc: meson-gx: report the longest busy wait the controller can do

Joshua Mulloy (1):
      memstick: core: don't clear dev->driver in memstick_device_remove()

Karl Mehltretter (1):
      mmc: sdhci-brcmstb: don't log an error for missing BOOT registers

Olivier Louvignes (1):
      mmc: jz4740: Remove the host before resetting the controller

Runyu Xiao (1):
      mmc: omap: synchronize clock timer before disabling fclk

 drivers/memstick/core/memstick.c   |  1 -
 drivers/mmc/host/jz4740_mmc.c      |  5 +++--
 drivers/mmc/host/meson-gx-mmc.c    | 26 ++++++++++++++++++++++----
 drivers/mmc/host/mmci.c            |  4 +++-
 drivers/mmc/host/omap.c            |  4 ++--
 drivers/mmc/host/sdhci-brcmstb.c   | 11 ++++++++---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c       | 24 ++++++++++++++++++------
 8 files changed, 73 insertions(+), 19 deletions(-)
