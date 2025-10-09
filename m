Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299A29993A
	for <linux-mmc@vger.kernel.org>; Thu,  9 Oct 2025 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990760; cv=none; b=iCS47KxXhKn3Wx3bHh2UrwW0l8EKE2yqhk3zICf3yihH4rBCF4RiA3cv6Cwq3tMAr7roDv2+bDlFT6tkBX0tf165IlvBG/Jt6dYyTnaxd3X+5Ha6+S2MTYvGjNTlRXZtLluwLKy3QqjgUku+eQz791Kk3WARD7pMYcTuGzw7qqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990760; c=relaxed/simple;
	bh=mhm3iyRHbrd6C1T0gzq8dZ3Be4D6uDhl+Lr3IO84qiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOuC/9aBPp6AoWfyq16v4C3TNbAF6dtTSsx+XqgptojQyhOjGCo925acaTomJ9H5GU+gYs7OaXgUgaYNYSJ/6ez3/f1/aj9PHZHNxrv6oLtcH38CiUnNRXhOiIkbOd7Bjf8bc6dH7R37ENHvik+qdtLsk2OQLYrJR0kPIbMLhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ga/+tSM9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ga/+tSM9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EGJX012246
	for <linux-mmc@vger.kernel.org>; Thu, 9 Oct 2025 06:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATUO9sxjCo5PUTMu4Z+g3kwu8CIesdgQ1LufySgyaP0=; b=Ga/+tSM9v0/LYuuH
	USW0Yiye6GxscVBv/DS8sLMt5yjAdBTAwmsordoas+3voS77lpWVXnEmUGDcyV9e
	ckJUuZj4j+T9TdFiPFW6kIibNrV3SvE6nb2fFA1B4tlTWxPNMQO9jmUEvagiWY1E
	L8f9gX5yhpOHw8j1JO66PE9T072HtyK0yMtkSDjxDvmhcSCIIgntkxCCoB8O8TmN
	M75RpwzO5K46RNhqI0KVBz0AT9ciw9SDThKdvo04uw4XZEZJE41S4FjSJ7vaqRf8
	PMM+HQC/onikNKcGUD94RZTgCvu4JN3GYZ45iDqTI8IcLKNFcXavzEuLyubah/zS
	lyIIZQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4khpx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 06:19:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3304def7909so1294051a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2025 23:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990758; x=1760595558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATUO9sxjCo5PUTMu4Z+g3kwu8CIesdgQ1LufySgyaP0=;
        b=fUv2G3GSryDBDoxLHF0nMn2qm8lq2ajiOg2ldFtKajPvHYuz3EsYoQusmwvmND2AvH
         arZGuMB+2bA8LnCpcAQvaDCu7TYZP+9W2lKv2RYGDgLcGD9pNOveOcn3dfa9E/kg4Lrb
         SwnW3ASyMqY//g5ZAnqkqDZTQVfEQ3LiF5KxPVv5+Y3CVj2CkyyLJhMf8ZXaM40RBLuD
         4YyDclBg2VkRTfOe5H5wXj8uwNDMisThDUbcf1LKhGWPHq1tgRVETdOk3u7iAvvXyiv0
         6XRZB0AHXZJ6gVq0XZcm1KO+Ft31n2QgGQ4KD2Rf30o201vAKdHMCLqGhor286vflgBB
         e3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXptYs1xJzh0siGBHUJzTLgTF0d7BYLG6RYKLA7MsMyKz3Tz7A1JSiWAJUHXEOLHSeUBUbUARVVrjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9SdAZFDU01jrJAmbmOZQgt7boVnHfxg6GrdFR2lLUEEEmwIt
	0q2WsHemCLZDdyTqn7i6vjKORBZFnXw0WzrKTzP2LabBpCp74UX6DyQHydUtfWL13nv0sxJ4nX0
	46omfU+s+W3vFY22tGgvODMUBFXg85T2b4W+6iz2rqYl4NNPpmF/ZXLe3IKw9pZs=
X-Gm-Gg: ASbGncv2XWZ994Yb5OA/lA/oe3J4xdDBQIzuShbBNgknSuie3Vb77tkON6l/xjQL3r0
	XWBoDgoeSolIGBhLgM9B4EV8YEdYG3APZ7STQTL9+8/tAAI6Hxde1Y+oP9l9Lj+j51ATnROrEkO
	LVb/mmkmr+YQ82Hj3F8ROfoozap99f07+WmBIb/9xs0k/r5tfdFQrFM17vlJG2xJayyf9QoTWVU
	sHfnvls7MBZspXEiCbrdZVTIAODuxIM0AMi/Lk6fR+rwYAzkPR1JibSX0473zD6QJrUq8xI89zr
	+AqOdf/wnz8TVehtRYRI7eCaXayW63/g8v+43nUH4CTKNA6XIq1A/fuarMEZVPW1pa4Fb6QAGDs
	zkME07Fs=
X-Received: by 2002:a17:90b:33c9:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33b513ebbc0mr8788425a91.35.1759990757583;
        Wed, 08 Oct 2025 23:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFAqILhWyE/XzKX2WhRN71ULW8L8fSTk+2psqr5ZcNytsqF57WijfbGOqYcU3wUDR0qZ960g==
X-Received: by 2002:a17:90b:33c9:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33b513ebbc0mr8788392a91.35.1759990757080;
        Wed, 08 Oct 2025 23:19:17 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:16 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 11:48:51 +0530
Subject: [PATCH 1/5] dt-bindings: mmc: add qcom,ice phandle to mmc
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-1-2a34d8d03c72@oss.qualcomm.com>
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e753e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=bQkk_NDItiJHBMw_kacA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: qRWaj8y-5avcIv1PD48BRtpIpue9sr_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzUctis4Gbhan
 tNut0wWY/RSYGYwEH4lO3tJW74prKiiTZ4lbbCVfMbNZiA24gMouzrokoDOzQ94D7xIWAK6SjYT
 Gtqb3QDVmDxYzZevrct6stT2DcNsX3iBwoH6bPTnm1EiM5qBf1k0rZF2P4Rdzcg3fm3cYirlknX
 6BEeUcddFqhCF+zFryWEgosJD2rwj03EAvGx1AIWHtydzWq1/53UbU5vHlAQVjpIG3sr8IwP/Mh
 xtm9W74fGbYWaRzet5KQNa+L5dVgQXbYcsMf/qaFYHTt4TxqcSGMZiC3yJfErnGDApnpqdLL0jv
 xLuJTLaXrTh4Nlvgryyqk3GiPALcPVysmeUk/SgNdYKJOs/gEcEalSpiyIA9nmS14jaPRThKrqJ
 qzcuo/GEo2BD37/8l5TOcrceXSVj1A==
X-Proofpoint-ORIG-GUID: qRWaj8y-5avcIv1PD48BRtpIpue9sr_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Add the 'qcom,ice' phandle to the MMC device tree binding to support
reference to an Inline Crypto Engine (ICE) device node.

ICE hardware is now represented as a separate device node, and its
clock and frequency configuration are managed independently by
the ICE driver.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff211e1bb262ad8d8c7fe1c77f1e7170..9d6be27b43cdfb349a1dc96a6687b5863af844d7 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -138,6 +138,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DLL_CONFIG reg.
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   iommus:
     minItems: 1
     maxItems: 8

-- 
2.34.1

