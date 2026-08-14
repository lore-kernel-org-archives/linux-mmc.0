Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128C3C1D4B
	for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717235; cv=none; b=NVQAMpjgvl4FySy77MaB+YJVLorJnTlXzr+NLGOBAtnFINQsLuhS3ewZf7JSU1lQcEZbkNV80poST+thctNpHmqkOnAK926moIvqacH9RhnNBQA6mx1yLUBegGUYkjANQi4NwcehROt7u5K3V1tIVBQe+aZjvpSpJYQZAHVaiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717235; c=relaxed/simple;
	bh=6ubUtij028ciG8eA7qshIWoVkphMvLMblsfQMYOq0/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FboRDHk4brH+gr4+JDTNJNqxmRkMt7/Pt/cvx/XSxaUCmbKEO+SYSnf1nHWUYXEZa28QD3lwYY/p+3PbUvH2n4Cidv8TLAL5T1UBufHq0UsDFq1+4qbSooOUHWneNT4dI2mpGRD7aFuYNJxbGnXlA6/5zlZmSwu84ojri5e2p/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b3ko83Gw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gOwsESDv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b3ko83Gw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOwsESDv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EDxVJN1565052
	for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 14:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ZaYJyS88v1km9or5Aj9dFFZrwn/PVURb594
	fNdViUeE=; b=b3ko83GwTlqZcl70JWJGtbTOQfZ7pFVDNwVHaDcX41GkhIFRS34
	JMBQI5242AUT6nIZQlN+ZZ8fBHvayHgmTINTh1SyyEdMi2FSeyyW8Cua6CZJRXm1
	PIVzd+LM6x1SSXrTmhYSj4/VFD/hRL0qK7m5JuGeXTca5Wa2DM/xtAMmU56qmjZu
	4IiBXkOjskGQuz28QRaE1opqnSjEs/6Q2N6ogOwiSfPTAdev7xFwHkdbATORA1Pf
	aF1EOPX3wpTlL3kRxNdjMIY7wmyplBJhiRY1kURu+UmxpuNKBngNS6o8ostxQOYU
	CYWeKLNjbjLgmkp2FSaCk+X0bqsfypUebMA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f4jqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 14:20:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso16412641cf.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786717215; x=1787322015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaYJyS88v1km9or5Aj9dFFZrwn/PVURb594fNdViUeE=;
        b=gOwsESDvLDLp0BVz8pd7/cm1/2UQ8lXLEptch+fzYVVZ8oXS3KRudFlQGfvNVhC77n
         KA/YD1908lP5IiTB6UgCTVwzyImSEzzYpEfJhDVPbwSvUM5FuI4Ar9A7PE0u78eKFEwv
         /OivCzkSe1SAyCPFhe5C98OhlY0yD1Zw8H3d8X+KW4c2kCNNW0NmjtXIdqbzeKYD00tk
         fxdzyVEKVNZeAqeL5o0a2V7JJxUJUwHPS4esxxLDYzIUYkWjBoZyETp0AlMO9YomV6uY
         ZTznhtUqPTYgUplfUOgiA04zNuJbv26UUpCFB0uhPgoLBhzTUVha2v13yh+03ZNtgthW
         30kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717215; x=1787322015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaYJyS88v1km9or5Aj9dFFZrwn/PVURb594fNdViUeE=;
        b=LxLwTYobpL9Mjpb7Va9zmOni1csPV8uWk5OZKd85dj9xCFb9Bp0/mN7qZEnVMcNgT+
         PrAPROTh4ODOGN/Uu6CH8aaRQ8q9At66huKI6NYBQPUBNu4seY+GeK4NnFl7SjdsKVMa
         MF3psKe6XSRUYESQTxjNBJK+nH6r32E8oLHAwFVSKYDlKtTmAiA7ktGOf/vIUHASuAcj
         plI4WAZYuIkcvJYbBtXMRuY5pnMiKd67zddUpZyU6oBeaJIpZNJ4pHa1o784VqwEOMoR
         0XePl2NX0QzMcCE643VkbrOQltamZ7oepUovOSGkQUXqt0YwDo8t3kDs1Gx4/lMClg4/
         4E1g==
X-Forwarded-Encrypted: i=1; AHgh+RrkTaCzKcHXgmjBnArGd/hNWRGlioYqiDaVi8eSKY7FZK1uKug98Gnlc+fGEZxXw7rYYzQhFC4A0uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwntBhu5iHjEEcBbXNckuIvHeDMCi7Kv6PDv1QLB9BRZrzWmQje
	dn+VPgN4ImoAAn1M56foJdWctMm2htf3tHI73ZwztoBqHphDrq68VPIIhxGRxbWMrqyMWDmN5SC
	ccMR5LcbEaojLsBB45oWChDQYdgh8kQ7C7pH1MVDbK5D4CJSg8vq7qm96amykIuo=
X-Gm-Gg: AR+sD137lrNxP8iVbyF7oUlH/n73j3ZFy6yacyX2K1aan9J8SAlG6MNSTBXXUUYnp9z
	mZMXWaS26URS7AzRbLM6P+EzAjDcdxhHyIO4CdOYmVnNij2WCf3vBdrp3jTydVrhFa5gEFO0oTa
	94wrMiRnMvBXt3TZrp8Rj9lzVLHERasmScKoRkRheaqc6iVaLajCpUpgOPO6o2abSn2Nwfc9kyS
	mbJlGCRv9+tpDy6y2L01WCOosDECE8Q6plSkVxQE8+LCqQiCeMSicbGE5nHncyItTpwxAILJyav
	EsupMEP7lX1EkObZoMNYWFucH3kWKm86VVrPmBS7nCiP8HDcaSizpPJeGYocZxEjit2KyBM9RNH
	CAvofHSyDHjGg5HzqvLu3lOAyFlXuYHkL/yYPovV7Ss/QB4gaJw89tEeNkQ==
X-Received: by 2002:ac8:7d50:0:b0:52d:7bd0:d12b with SMTP id d75a77b69052e-52d854faa39mr58882431cf.43.1786717214466;
        Fri, 14 Aug 2026 07:20:14 -0700 (PDT)
X-Received: by 2002:ac8:7d50:0:b0:52d:7bd0:d12b with SMTP id d75a77b69052e-52d854faa39mr58881581cf.43.1786717213930;
        Fri, 14 Aug 2026 07:20:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378da3esm108536866b.37.2026.08.14.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:20:12 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC fixes for v7.2-rc8
Date: Fri, 14 Aug 2026 16:20:10 +0200
Message-ID: <20260814142010.127902-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7f241f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=PXh4eQp6rZknt7XP5e4A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 1No_ejoWuBsA4IE4P40uSwQEOb7uS3GQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwOSBTYWx0ZWRfX3BKMpTOMNovX
 rnR8IhUN1oy8aw1yHUAcnmgGnV9GZ8EgNKqu8xeaJjGSjIqJw95DvFJ5vqr8d/pBmY2Fi6roGv5
 QAp1xyHvvaREOB+A08JCEjEHEdC7+umAJLTSTX9v1SoX4c9USLPje0/+f9Uh5UenlPfZwNZSygs
 NCAO9AqunGtxNzSkRvNASp7WbHUgkH15JCt2PAsOOtnz4YGqnUqumycOREmmWR4nHmP9OX1iNPM
 Miy9egPbHc1TOWJw/tZDZnXfNgWWT8vV3bX2vGyGvBjwvbIaT2IqAyHRYaQ8xPAvkYQ0Utewmh/
 42ZWlBFQ+/MjKPUX5ib31Qdk/sM4bPfCRPL0MnJJdFlGajojk1JJeF8ngFb1/i/7gq+tz4ye6t0
 Eob4WGuNlxLThiUg9wZ/usbzfrP9O+yT89DjWRDl8kEhziZrqaArSUb8Yl5HcIN/QQZCMBPiyAa
 /23M1FV+N9v/p5284Zg==
X-Proofpoint-ORIG-GUID: 1No_ejoWuBsA4IE4P40uSwQEOb7uS3GQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwOSBTYWx0ZWRfXyftp+4vAUlmu
 yCDUOaA8/tjf1iFK0USKZXnovkPDg6B/+SXOuxap6SA5Vy3l4zm0MHlqVOW1ktRuBIbZsAk0GI/
 +KAMmI6pFspNxFOf8pI2xog+LqPEOD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140109

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v7.2-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e27c946b589c53520409a0956b33d52ef7a0898f:

  mmc: sdhci-esdhc-imx: fix resume error handling (2026-07-15 11:00:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2-rc2-2

for you to fetch changes up to 00179ed9fbe07799676e2cb63c4e7f0e7cd80a5c:

  mmc: loongson2: Fix sg iteration in data reorder functions (2026-08-04 15:39:11 +0200)

----------------------------------------------------------------
MMC host:
 - atmel-mci: Fix use-after-free in atmci_remove due to race condition
 - loongson2: Fix sg iteration in data reorder functions
 - omap_hsmmc: Fix busy_timeout overflow in ns conversion on 32-bit
 - sdhci: Make tuning_err a signed int
 - sdhci: Unmap the bounce buffer before device release

----------------------------------------------------------------
Binbin Zhou (1):
      mmc: loongson2: Fix sg iteration in data reorder functions

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Myeonghun Pak (1):
      mmc: sdhci: unmap the bounce buffer before device release

Pei Xiao (1):
      mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition

Zhan Xusheng (1):
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

 drivers/mmc/host/atmel-mci.c     |  2 ++
 drivers/mmc/host/loongson2-mmc.c |  8 ++++----
 drivers/mmc/host/omap_hsmmc.c    |  2 +-
 drivers/mmc/host/sdhci.c         | 16 ++++++++++++++++
 drivers/mmc/host/sdhci.h         |  2 +-
 5 files changed, 24 insertions(+), 6 deletions(-)
