Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56C1E1E12
	for <linux-mmc@vger.kernel.org>; Thu,  9 Oct 2025 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990756; cv=none; b=eB1xV9ErfxXxmgfzMT8/gudvja51QIXRMWMprW2C26xSiq2Gj/UVYXIKdwvA9ck5qdPUbG+Fv0gkDmEB+RnEvtahwjXCzYyl7RKplZHyWOoohY+vKlNTmfqBBuG3a4c87R/2LupXOUhvF5hL/ALvXrjMaWinznYpqjPEdbwY3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990756; c=relaxed/simple;
	bh=RElW/V0Z435eecAoQxgFffr/tjQtz6OYj7jJiPqLdnw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u/aOpQGyapyQtoGvxRprPwjN5UIMO4Y7hXrUa2u1L78aUDDJWKYfgSKbsUnTGf78naLgarXl2hAafhts48+uSZhjVOBjXqAcuSG5sU/MGmLGUIy1C7D3p6V3uqYdorM90iOKq3FuOR5nkvs3uve6Os3zqLIqinKl6CsR/0h3PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjJFE0/r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjJFE0/r"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996ESDt029171
	for <linux-mmc@vger.kernel.org>; Thu, 9 Oct 2025 06:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=27kHMdvwH0X0328kYvOzhu
	ArDwRqIDLbTEsO0hy9HCs=; b=YjJFE0/rII1owim/UA+hyfDgNMuDeEEDElg3Iy
	B+juKA67PUZwgbom6twBx2RXIt1JjYmLShtoasVUiZMnv5be0KwZ5NWvGScDroHO
	lD9xXANlGq1mSs7xJoUflN/8+fXF/aQAoXn+QDygvzO4nrkmNvei+VWz/S+O2xJR
	qZYD+5LBVLsnQWCNffzEpxK6lJ8XikT9KOznD4P9/7Wg9WCRN+xRcW9FOw5B4xcx
	xU0opuJyAZuTC/k1d93/faxE4qYXdGUZCbSFsSdY21JTd4c+M6NcUDpZXzMIWT+C
	RReJnx8vGiqeAMwagGmXhYmTLKN6SLRzg6twbWnxd4SxO0zw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kspwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 06:19:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so770332a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2025 23:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990753; x=1760595553;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27kHMdvwH0X0328kYvOzhuArDwRqIDLbTEsO0hy9HCs=;
        b=jtDoFb2UI4DCebHYNreGONsZfEkIfBVl51J8kUghE299SljOvVSKfS+59I/tST6Jan
         qjz6Ae7hqet850Yi0HIqG8+CtpgmHV/Lff4JbtNaet9d8psPuCYZO1zuJvLxPvK3PFTR
         RBGaWZ2xyGUw+pRPxYKr10xmAG8TFX7YgRKnQpnfzT/Wo3m6U6TU/O+Cp8o0f8cD+1mX
         sIgBJd3yJLF0v7bvRv+V49AhDga/T7sWPKJKY/02JeUvCym/oyzVCw8tCPagVSWqvnGE
         b3e1KnL3R22oQ1kiiYF6f2G6jJNLRl4nXrdKzHVghIHkQNZnJ77YwhSYOo1Qu96L+Rll
         9auQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjz7jN0Dv8H7/ybo/CiX7YvFexOB5pm4dcBfXIKwV80pIsEN7eR5blE4augUxJfFftaqAjvb+dQ6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FJj7oqhrYpuha/WOvl/hThxSPjYELgZBnEWRCzZED6zOudZw
	BrMNj950dTfu+d381+lfE+5zTzSwZy+k2hcc+0MQnxLTi/fcrU+Y8jC7ILFMAR9t9tMdSObvGZl
	yxRzILZ8ff4Snna9EKS9X80X6y05fTGJBUTe6xMWiCtqL4yYZPfyhrq30E5KMJP0=
X-Gm-Gg: ASbGncuqjhemFTQ6AAFqvR28qStdL9YGz240NiQszoZ4ldVZhlESzxo+uOUVaDcytJb
	Zkm6lsrpUBPJoDXsJ0AGoa2kLW+wQK7hYUBS4qwOFFNnQTkQhU9pJNNN6xzBy60Z6Obyrg5B4x6
	2ewpUWcW/U3r0TsKeR59ExE3j3nrC0/uUDXg38W3suxGT6P8WxW4kZgo7RqFgwoBMtOCNtEqUc5
	p3m9MDkbTzlIiM+CKt/0sbNp5dvC9h5ir2OLBUj23e+/0fw2dhlw3zTu3y1DVrAgDUX0cnTZWqc
	K0zjis3YW0oaPaVTV+2Cas4fbl9cuJ45P8hLD4zOmijURM4RTs5yOlYx3feUox3u/YmvN5nXbvR
	/8w8Fifs=
X-Received: by 2002:a05:6a20:6a1a:b0:323:cbb9:aa1b with SMTP id adf61e73a8af0-32da845fef7mr8847872637.51.1759990753252;
        Wed, 08 Oct 2025 23:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwiXOhov/LxmRkYry+Q9grSkuraWC5lKuqWh3Ov3GOZp6ZzGWGHWrshn76JtzwZKRRdX/NA==
X-Received: by 2002:a05:6a20:6a1a:b0:323:cbb9:aa1b with SMTP id adf61e73a8af0-32da845fef7mr8847838637.51.1759990752738;
        Wed, 08 Oct 2025 23:19:12 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:12 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH 0/5] Add separate ICE UFS and eMMC device nodes for QCS615
 platform
Date: Thu, 09 Oct 2025 11:48:50 +0530
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpT52gC/x2OwQrCMBBEf6Xk7ELS0ir+injY7m40YJKabUUo/
 XcXj28G3szuVFoSdddud00+SVMtBuHUOXpieQgkNna978fg/QTIDCoLNlytI4EtKmBhkJwJ2BS
 WlcqiEGuDN+kURlheuBpmuAwy03CemZmcjSxNYvr+D9zux/EDOpnIN5AAAAA=
X-Change-ID: 20251006-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-83ebc37bdddc
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0INIZEHwXxjy
 d7ZsciAP8hRkwHt3Sk2rW5lhkncHqv2cPO128ALGPoBdE0nbB1d4/Clm8k1H9lVMffIa7W+ORt9
 31wY5JQverOEdJkl6mzwaj1+q6LL0urdnrw59DhRdrXIilz6LsV6ynY2bO6UGtRaf7x74mALQGY
 Vpin+FF8oqKoswhNol6wzH/4Rt/MSOt+8w9/+ASqeND93bC78ZQUCg1Iaqv7uXvL7topDfGYhkn
 dV+u8UrKGjkU7PGXjg/pCMkywmhodOxv0rI7+i7OAvvyzosKTdqalV927nUv8xkBo39layPqNkY
 iIWPCUPLaBT4VuuSYujd7FxOYOPFTNXFggSUv2Voa3z75Evee63leBmEHhOpD21ticufti4CcRC
 Evqi7g3/LOag7ocvKrrI5C6MstnKEg==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e753e2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=TE4wMAv-58-w6rAmtzAA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: UqQ2e5c542d5EQbdlp7AuMx5N0TzjfCN
X-Proofpoint-ORIG-GUID: UqQ2e5c542d5EQbdlp7AuMx5N0TzjfCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

This patch series introduces support for representing the Inline Crypto Engine (ICE)
as separate device nodes for both UFS and eMMC on the QCS615 platform.
Previously, ICE functionality was implicitly tied to the UFS/eMMC controllers.
With this update, ICE is modeled as an independent hardware block, allowing its
clock and frequency configuration to be managed directly by the ICE driver.
This separation improves modularity, aligns with hardware architecture.

The change allows the MMC/UFS controller to link to the ICE node for
crypto operations without embedding ICE-specific properties directly
in the MMC nodes.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
Abhinaba Rakshit (5):
      dt-bindings: mmc: add qcom,ice phandle to mmc
      dt-bindings: crypto: ice: add freq-table-hz property to ICE schema
      dt-bindings: crypto: ice: document the qcs615 inline crypto engine
      arm64: dts: qcom: qcs615: add ufs and emmc inline crypto engine nodes
      dts: qcom: qcs615-ride: Enable ice ufs and emmc

 .../bindings/crypto/qcom,inline-crypto-engine.yaml |  7 +++
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |  4 ++
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           |  8 ++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi               | 51 +++++++++++++---------
 4 files changed, 49 insertions(+), 21 deletions(-)
---
base-commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
change-id: 20251006-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-83ebc37bdddc

Best regards,
-- 
Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

