Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88E344DB6
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789621; cv=none; b=sUayiQPsMOpJPBy0v1ESnGql8Uxt7MAe+qzq+XFMlYKmYX3UxgaDzhFTU3YngEBb7e4bF5Fc0jJZIr4zGn8QgBUJ/Hcb7UCGTERM3ZJRBrkMHh+ILhV5pMPuSc4fiwFRBF93118vfGDvl1fVX8GuAhy6tBe/emRdwHx8DJZziQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789621; c=relaxed/simple;
	bh=tHi2a8QE8KKwNz5asvYMfGoRfMO8gx2jo+W2jzVkLWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UaxHdJgIy0XlCkoFYTwcj/gGEUUSi2mRlWwi3viJC/ifzneMbRGHvfBX7dNauBHXr7Su0mQdAPIJCP2L3gX/iBtwnfmeu8tXqULysbr8SAhJten7W2sLegWwhDSajTnlsDm8vuvWamETsomKpB+AX/Zpifb1kxiCPmtnjf5NEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYYyDliv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cInA46VN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYYyDliv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cInA46VN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62654Tii4193546
	for <linux-mmc@vger.kernel.org>; Fri, 6 Mar 2026 09:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HdK/+DyIPdjo8vnqeEhYuvYJ5G6b5jLU/xm
	ncGgF7IA=; b=QYYyDliviaKNV/BNNBMA3+IBDO5yTlsFOhkvWy7jYmmIa/YpgQT
	87zvz7LSU29bHfPZa8dIvzQ0UZkDro3EmY+2wM/lPyueqn0bcpJHIjLI+onr9lW1
	YODQyDk6CeIctl9YqaxalUzIkcDKLIGjyQ6Ly7IyywzHdk1Cfaw08p4D/s+UH435
	2o/GVx+hq25JSY7E3iJlwxY8h0Oe3uUKxq0bt9ZTR+ZUzbFhUTsezyElSYSZlgQe
	8ppJjBLxmKkYGVoyp5igZpRsWBMKe2kp2SH7bp8wChUKabRErOhyTrk9c3+mnZ35
	nks8S/Sj/nD0HmmQ2DvmVpuABZomm1aLWXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5rvbq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 09:33:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35641c14663so9464101a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 01:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772789618; x=1773394418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdK/+DyIPdjo8vnqeEhYuvYJ5G6b5jLU/xmncGgF7IA=;
        b=cInA46VNNcDaLzUTOK2dohckdeEtq5qEEsop+eOLHh2TAZk2ePYcYMogdJxRqTTh/t
         3tBElsd8E4Zwc9HjLFcNHWnC+A4YQwr3URzi0pREH7ivzJCAfCZTD2jdKoYmz4wJFQJT
         kqTpIYLAGB4YYRA4czxiZUM2sqg4JQRds6jaXavwTRF5wblLl0PqfmHuqPNQvAeS2Jgp
         v5X15g5QmQWwNrvgdk8N3rVB1OYFev/d6W7F9LVKTqUppuX+brePetnYSLeWuRR+BoDi
         VW+jJmCYffiWNN/N2ep6audKLKAP5qOhzn6bQG4Eclwg/Uthkp7K/aWV4e/qO5g9kRqz
         jUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789618; x=1773394418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdK/+DyIPdjo8vnqeEhYuvYJ5G6b5jLU/xmncGgF7IA=;
        b=fJztHiNnFGeuTuLrqRyQoEgsXCyk/P5YDrN6VXSpllVZOsArGp6LWzoKIefYFK9q6H
         IeEn6gOzfYYxYzxpdZB4oRIi2wGo2sYf5D+la34LP+6j4zAJ529FPz5rbWVb3sJluABX
         SDyffIiriZSl+0tL28WU8/UgmmGDd6N7/raS8vmeUeGJ/rWd1W1Q/WAfEI+eglVKYnYR
         VzhrPZjqLl8zd6LY7MvwLMEU+2adr+g+ZrOofZzbD6qqPaCUkxB7axEZUMxUoSp7lx2b
         Jc9J+/KxOxoEOxsuoti3pbPn1seOyH4/K1FkWZDU4Wj6JjbjqDLntP+4QlSQsov61Oox
         5DHw==
X-Gm-Message-State: AOJu0YyK8pNJLiqvp4w+YNWqLTCfWE6faFlOh6n0XM6XbV9j18v5wA/b
	OvTNMLMyVpnWFyIn70vSYpgK2gEsSqmqqRE4iJBg4Q1OIu14do0hj+i2UYdpje8BhweGrx7Jw9J
	ydPCQ/RLukFZRaHGIroSm2DRtAyujSFJluiY7JGbF1Ii3sEDWlql3Mg1Q7NlTqOtzXa6z3Ks=
X-Gm-Gg: ATEYQzxf/I3nFLIl+jG/yMC89x7LgJLwbHcTLxOJD1vOyNlSqLSAK8ZFWBDwPEndQWL
	Agem7ki3k4eqqigOXk0cbuKbHhiR0BoT0hUQQGKoXAAzeELzYchfqIlm3GZ5rTNMBQapcYZfXM/
	nkt1nBtoWLRgNZZcA1aZOkM9aFiSDFtywnFpuUYuoqg57rtu0AnhsAmbibtFjlTnTWl51tO9Dsg
	SfpPBl3kUQ9GGXRR0hsT35VuPZ5Iv9W/QXNNOPcj8LmzIdPs3aMToHkY3s2KIJtQAxG3HU9Zwg2
	xq9WsJqd+KIHYAKbd6qZvVHDEPO1HDfAXyi87ZOncO+/UhcsAKaWJNv3OzjYTIy0pnuxLBtZRGr
	Ss6HMfHZGJMU+fqK/PE8tKtdgAUMgSyzQ2C36WcVYa8TcMsLQSgds
X-Received: by 2002:a17:90b:17d1:b0:359:8d23:af5f with SMTP id 98e67ed59e1d1-359be384d2fmr1336185a91.35.1772789618433;
        Fri, 06 Mar 2026 01:33:38 -0800 (PST)
X-Received: by 2002:a17:90b:17d1:b0:359:8d23:af5f with SMTP id 98e67ed59e1d1-359be384d2fmr1336172a91.35.1772789617960;
        Fri, 06 Mar 2026 01:33:37 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbcacf06sm647549a91.4.2026.03.06.01.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 01:33:37 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 0/3] Enable Inline crypto engine for kodiak and monaco
Date: Fri,  6 Mar 2026 15:03:29 +0530
Message-Id: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IGERSl-esCdd_tKuLEVi_EkEHK9GhtJx
X-Proofpoint-GUID: IGERSl-esCdd_tKuLEVi_EkEHK9GhtJx
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69aa9f73 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=OaewepulewRRD3_FMPAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5MCBTYWx0ZWRfXzCrLObWz3PtU
 Y+wpSaJdFWb0ITyl2WEv7dfMYB/Cwm34IsaCceuf6vZwALppRFg+Kis+qc87dDHqPoYhUDnLMQi
 pTalWvYkGcccZGnVWQaSa7Ymzm0TO1w3W5+4nmZoswnq18N7MqUZ5f2ToJzQP24U7lkWO6/1UJU
 146iIdJr/IZhNS1caAWnU3LjlNhO8Qbnc/8qCJhfnVHQY1HHsoU/GWpFUAWq9q+0NRfq0EVwNSz
 JvFvcZHm+TpU2XCqmcjBcdmbGsUAIZPu/1Vp7K7N5FH62cMapu1DAEloYOfNFUgAPz9HMBEUC9/
 Rsfr/pS6yxbnFyqmcgTEdvqvYZrPT75uRjsbREwWCFEF5Or/+uf/hxJlli8deqPxNA84AxLlrIr
 1MzmBlEEmVG7Sj6d20xU2J2HUbShmCMFJny1TSmBTD7MbiLwF04KU+vdpRKrsSX8pJbpLTTtANd
 oeIcSQcvFK0n4AYXx8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060090

Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
node to enable it for kodiak and monaco.

How this patch was tested:
- export ARCH=arm64
- export CROSS_COMPILE=aarch64-linux-gnu-
- make menuconfig
- make defconifg
- make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs

---
Changes in v5:
- Updated the constraint for SDHCI 'v4' vs rest to reflect the 'qcom,ice'
  constraint.

Changes in v4:
- Added a new patch (3/3) for device tree changes for Monaco SoC.
- Updated commit subject of cover letter to reflect "monaco".
- Removed the text description of constraints from "description:" for "qcom,ice" and
  wrapped the code.
- Corrected the schema code to reflect the constraint of "qcom,ice" usage properly.

Changes in v3:
- Described the purpose for phandle in "description:" for "qcom,ice".
- Re-added the "if: required:" description for "qcom,ice" with proper
  encoding.
- Corrected the uppercase for base address and reg address space for ICE DT node.

Changes in v2:
- Removed the "if: required:" description for "qcom,ice" dt-binding
  as the ICE node is optional.
- Corrected the ICE dt node entry according to the dt-binding description.
- Added test details.

Changes in v1:
- Updated the dt-binding for ICE node.
- Added the dt node for ICE for kodiak.

Neeraj Soni (3):
  dt-bindings: mmc: sdhci-msm: Add ICE phandle
  arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
  arm64: dts: qcom: monaco: enable the inline crypto engine for SDHC

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 95 +++++++++++++------
 arch/arm64/boot/dts/qcom/kodiak.dtsi          |  9 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  9 ++
 3 files changed, 85 insertions(+), 28 deletions(-)

--
2.34.1

