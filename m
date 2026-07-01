Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A44A138E
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921653; cv=none; b=H0Urp2PljmcDEt5jLIo2NZO3hkGwx44mY4NVRRAhHg/IhwD1utuKNrNm9nriL/kJFEBFqbMRbLcWHa6+DweLF5qP15+xxqkcEl65AEHYKddD4bWZX6kTH12JAenC5YiwRioImQybA6kb7m6d4FjJ8GcJElwCMtX0zaZsocOy2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921653; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PofT16J5Qlfr8H3d9/6jlrJvxmBwRzUlfoOO27l27HJiHzslGbK+l1f+R308HaQn2iON5C5xMAxXu1IQSpcKtc6C5GzscXAqhqDI0sqoVCnPXPYRsmwDa5uPHtLiJERwTicJcyOjdlulcQAmmgmIbgq8kNAwam/jbD4yi4BfW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRY1uaTe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4jr9sqB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRY1uaTe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4jr9sqB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoOrX1553303
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 16:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HRY1uaTeGIIRXKEL
	6wsaDKZf2cVplnvu8A7vouedWY/oJZ9OBdObNQEd5NXv59+E12gXEZG2Pue3jodZ
	Bf9nuB74OOOyxq3OY8Jnt8//r1cOb5bzbB87nvHHzfO+zPeP+gIGxBWsXvnSGkOB
	2sC5Leun+VnKFM05qXn0uwb/uc/49eaUxgwfH6B6lFtaXTBwCCWPZQsULNVLy1It
	7+iLF/bWx4bxIcjYIzCL94f3uW4Vsgk9mMqVs2JtjJHf9HuhdLux2WDTPsfCyZ6u
	1cNFycmRWxPCwad87+4Sxcdt48EMG54PciKP0BCWCVCgOYX4Zt3uVLYeRRwTEMPg
	qjISzQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd1fka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 16:00:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92b4b575561so116400385a.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921639; x=1783526439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=G4jr9sqBOCNTTwTPNL/ZWRVlo9MJvsG18rxBhDk29o4qOLQ1N2fX3OvgJPc2nsqaiR
         OGJT/WcP5C4UyxJ9cCbTGnAdkSC3/4pQUTZrAhVELUHaov5j5lHWOJEEZoF8T6H6YnmA
         0a/in2sbFiHySuRJYE2GIRpd8zYys9n+Lu12R7r+bLeprahp40jZbKqsjyXX990Wfi4v
         ABdDVScFwQ8RgQ4oREuxV3Oc+oONIYuljt+sN2yr0ffUDOZBwwrfYwDxc8qwmmMykypV
         yIxdg5FBmbK+s4oLXf/Z3n5mq1WwFSpkgAk9o33K6PAUKnS2qNQVFifImepl1ifQmbz4
         ZA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921639; x=1783526439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=akwda9wGh08qhbEGz4vLpOZw2U3PC7U5JejrghJCtCLXQLg/K22nbAcsvKUjL1on7A
         73eBzQeKsrcupoDNhVtqqvh0XfoBVMZCLJ5QLj2baM27Ob2bv3Rr2Sdu1ELbm5ywP7KP
         381rPozaBc3VfcQnH3a9F7SJngAdrbbvDuI0LuQi0HRc5bJrom9jfq5JfhFniJsAUTYJ
         /H3jd/9OfSa8jOdxucLPWPhVavzpIbEq3j3tyMOJsVfshQ6LNexx7ibPxd4kF3Z4xmwf
         4BvfZgAXfe1wVAzuHlUJlATGZphwwbJcvWiTpYndgTNVKc7WQX8wg3xELPzqY5FVcDSS
         Fb3g==
X-Gm-Message-State: AOJu0YxropoZgEZcIHH2aSa5Ttpg+SNQcvXNYDk95CIrGbW1gojTWNIM
	kI7mJzcjuu9d5BeBJe0OQ/tE0hDTaFz7jlwQnu4gNVEG2C+WWMgn0qgA+N/gDaUp5RdWfMtBJ05
	ACfSRV12Tz/DoGc0FYeNaMLk5wSbkaQFyQVWOe46i04I6wFYkE1b6IFVpo/z1sZA=
X-Gm-Gg: AfdE7cnVHfOMrMyVMWzCX7Ut8dL3JZykrAGt6tTD/JdHtM4MGOiqzf9ZielKlDE7U7/
	YIL2tZZyivFqnYvw+kRARKUo3pTuDIW6RNIMXqZpmW4VmBthWKsjhwxIwvsxPrmnOt1n9H5VOVG
	sRBQIApbGKu1iYqP3/rn68KWCm6TU89tDPVV5bcpOXdu+ymjT8ZuNM8riWVa5038ABkk6hy0Y3g
	JsnKAL6WZO0Q+guXQpotbb6p8tRF5w/7DMGA1r91IRtcBUXoVH7kLK564Q+jdjqXWRHsh7pJyFc
	iikW/2/GbGnuw/cYh4X1WMVZN4liuWbjN5F6P0XzcTvrzEPyGSAuY5IW9roaYaXtvfFWgqLX2wB
	Yn8QF4QVm+NOzWDm0hTp6jixSEfPYYAbDcQHgUOWL5dCmZ+NEG8dnc9hWfaJBycjjMzqSkXqJHw
	hq+Vj02fd9PK3IUfv4vR+ZIk0FkZGJ2z8yX/Ix9slJo7RfO3OOg1UCJmlNuapwQkk=
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914771485a.20.1782921638155;
        Wed, 01 Jul 2026 09:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914758385a.20.1782921637397;
        Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:26 +0200
Subject: [PATCH v7 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-2-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a4539a7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: pnAOFp1Eq7C8QsJeVn4iP7VSU6gFm0jC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX6G/Q/7v+Rgmi
 JLMDxvIYxgjpjGvJn2+m8tqjMBujpA7gAIkv6LHeTO/BJfojlgNnJg/8OSxlHn6/3Q9kyQqOxzN
 gA8rMbKVG088N7eNF+WegBY1e6Uw5oc=
X-Proofpoint-GUID: pnAOFp1Eq7C8QsJeVn4iP7VSU6gFm0jC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX3ZLL8+VlgbHL
 1qAI6zjUxFAq4iWXDAPE23XAmEq8XULJsSlW27PBx21G3kTvtVJquKiWhrdTFXERUo3JpEUj1ZC
 A+MHU9wIlAEdiFyfMZKqz2KsrCllNu/nQ8gAHpwDBOl9xUUtoJNIiDTGJ/86gXYCOU0PIWYLqp/
 do2VgFs73obFSd6uzfNVOj3N4ZckuW75XCAY1CCke1aEKnigK804K6PIki3cgiLEWqfkwAF2EEe
 4SRe0yzS27Xhk+SR0XIGavd8QiQunJwr0Eehs7a0fDcsMuuv6LCIZchzh2jZHmfUom9scOfj1Gv
 1IDkWLwDM5OuUzcmROiU9wRS67A50UwQaFtcdq8DmNCqz6CVzbYgQgwQbygN5P+vtnBJ7KM6mYf
 9WcmPjMSQtnH1Q/Y51hvkmmWByKYN8x6KU4itcK3JMxedRZHRb/juu/Ijb5wBVGPp7lZmhFbxEd
 O8XAY25LhB3N+5ylDmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
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

