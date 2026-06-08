Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69833D6D2
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915849; cv=none; b=HiDHxY/ys7MGA4KUw1lKCrrmewp/y47u4IyEVGM88WoIqhg3Chsg5zD0AQqU+EwMA/1dlGqQezCHMerqHGIhm+edB+3xprgQptzbN1RweOhied00W16MAHW4k8P9zXyFTElvyGqU1Cd7Z3uO2rpRAddq62xB70HPtV/VY0ibZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915849; c=relaxed/simple;
	bh=Py9S39WSsqNn5txRhNRguCyI8QhKY+XwVW2450FRg1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTd5RGu2S3yPOKUiSVJWddnsDEGR9iWt9x2xCyaROQ6mkFONuQJ1ZaAbkboRsJ0qxn3d6oJbAeyVj+yvaAPNGxGLgG9jnvjM64AwvSlB4+tq/grMdJjpnuWrSFvffn4Vzer/cw2KVRVFcAeB4rXqFo5lL6ORwpYnFcDYIuqdgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIbofuVL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xg8fwuyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIbofuVL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xg8fwuyh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A2xwV2882026
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 10:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=; b=DIbofuVLZ0OazGPY
	eM5Fx7D4dpdBevCAkSGgCG4FSIbgCFSVwfZW4LCQAntAgjPxORVNho5v1DCgfslF
	W9kj/1D7UKheGa6LNYtUnNLQJOOex1NVWxTPw0zSfl2lx2eX6JCUa7+aDO+bKy+c
	0rqCQHpy+l1MKNyCZSbY1v3ObgIN6qzypHWDb4Z0yV4PFVe9jK44lABrGw5Fjmsw
	PrwdFTEvzBigxfKLrzRJ5wPt7S6hQ3nCmbvRqXaFkcchzzBXhc48ggXw7gBo+OG6
	LwmZ7+R826Z8AO3t306GnuKl+gyzgYPbqTIR6jn3mGtVnInRVeLXvRIVySfZjkUY
	HJaGEA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun406h9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 10:50:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5178fc89b2aso70204961cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915847; x=1781520647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=;
        b=Xg8fwuyh30Lia5IJYEO4AZ0yxlRGlMlAhHftmr7YKF80ePg9Y7Uk7nr2i+abwZd/7h
         VQisWow6IUfiqvB7IJF04yFdF/2+mSt+ScAQ3ZaZT/M99LERO//4Hpa1bkzJC6EE7r8d
         8mVn3G7yZ8qZGlWgpPmcgRaJ5DMIIXHaRCA75uOVRcbqUnBoyWrWMr5PUiOugR3hdnS5
         mNRzJkHcl0i2ZIVVK1JnN6hyIjugr2cajRP/0+hS9mQ2DDgzn44RcycXARh/I+6E9WTx
         hx8CIt8xEQxJa0w57pihb9VqPXWvLw9lB+jsuB5D7vQVsa7z3giu8tOaRns6E8XRjqF/
         GF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915847; x=1781520647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=;
        b=UksF0o+7svYo9cscqYE6Q9KyaXVmLzENuwrMHwwgFrZ+ZZHi1NtaTLaK8TJl3/Brok
         2KM2w2VJgbl1YlF0X3Pwf0uQ2jmYhbdiexe+0RRukEe0CSq1V3yodQWQPrQQxeWLci/g
         aSNUeElYmnhsbhLMqMaKyQt/QmQdOA99qcEFIrJtRYqzQT1+1pqx8TzJawfW2hVCMgT8
         5TNR1SufixZzSuI/60+/Zcr6tf4aQLGFJMFVS/RF1jofxSsEc89b6gs5dV5CfEZ/63Af
         zWbuBp00TjQomS8ReozF1SfGaO6XTc5Uk/9tgvpcfeIo4F0ZeDhA7h8yEtnZ3GSRk8mJ
         rl2A==
X-Gm-Message-State: AOJu0Yz88UaUMCM5KUatRqHxYXjNJQQfk9oPKCGlo1WsOsCwHmlyOX/Q
	24khUViPWo0ukPRhzh7EfSCl2BSaoS6cdQre0QZxmp5tuIO1lk1X3+t6YYKPmbk12C4pDWbkDJL
	30ngRuPJ66Tot0yry7wYd4m+Nj+Z+gN7UjbC5QM/KOAmkmLPA3jQ3oMtAaBuyrgDdBsBlRhu8oA
	==
X-Gm-Gg: Acq92OGr51x6VUlv9KLRZjUj54HA0xM3XQh2DarK19MrkxmdW0iV5VZNpmXHw6OraF1
	tq9UJPbgkJPfll941d7aZ2OXvYJeIfbE9ApvPmMRCq55rcqZPLN6+PB1JOVU78lavAWvX/vvS8S
	vjAofmhBFG/YsWLqSsGC+17v7JA5POKfIi7NsUVUzOtpsgTR1aYMvFhSarXC1KG6Khf4S3uPrmC
	sFTGJR/aTZ0FL80sDYELuNTO5QbIUM3bldNHti0Ei5crzB+QWeNLysjMflucBrdF6N+7uar/oCd
	wH26mgHTYAnwwgjufBWO+nsSoqcUQ6PjPlNB/Q+GZGItBjkfPYxuzqMs4Cvu9w6I2z07aeYuaIl
	n2R4Cpt63VdgUz4y8BccqWUQXyHurKWfJTrV9Gl9U94LRFzBiBDBxaBm2uVq5IbhhlZHvYid84K
	w1uT818Y1PArziET+Am+IE9titN+ZoXLAlFKqlJcEAQaxDnrCnbvX2QbfGc4uGPJFf3c3YWrH4c
	ryAW7AVnT1p
X-Received: by 2002:ac8:748a:0:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-51795b7322cmr169213981cf.3.1780915846623;
        Mon, 08 Jun 2026 03:50:46 -0700 (PDT)
X-Received: by 2002:ac8:748a:0:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-51795b7322cmr169213621cf.3.1780915846226;
        Mon, 08 Jun 2026 03:50:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:39 +0200
Subject: [PATCH v3 2/7] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfXz/coBHvq3DNp
 IIFz9LGgt07jU8K0WxnAbceWZpKEjRAiPfKTFAfhkh1FBpoo/5eOeqtmpnDqDG5NSUzKX2soSzO
 EQp+pQ22bo5iq/j8+0Ii+ShNF7yjZhY4ucxe/dozY9LPieRkk0Lam+B5xmf2QcqqLLCAvvu8W1v
 SmejJ0k/Lp301/eCDYr7q2dK6ycmWMznFnJ1HkNL95DBAAdaZ0EmvYuE+h3yO5jw94VNMoghOHa
 VseGhbf3zOwM1dyeA+mYkD1VoTEvWzpmPk0jG1Kf7PCg3KrikVnkZiUf985BxQVB+j+CKO1Dhy3
 BDo472jJr8wfRomCLY9yoyGJMZV24VnGcN8rLfdLAcqc5yQoQeudhwA8yH6zzWpuxb9uPFeDgYZ
 hJbpH2bY8dO4toOBci9cTRkaWsXebA6Z6JZKY84ubHNO++jvwyL74NxYoo7WVaUyU4PmKyKsupf
 AWT7JqkpjbaUKvEdq0Q==
X-Proofpoint-ORIG-GUID: Hlq-PN_cJ_EN-b552oOZbSscBjkZSrzC
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a269e87 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Hlq-PN_cJ_EN-b552oOZbSscBjkZSrzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b9919d48c41ac09f1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description: |
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

