Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203573F8ECA
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723337; cv=none; b=gvPUsiGw2LMy2SQPIy1ay0w9kwBofEZCv1uzngiuXgW6EBaiLi8lZpB2AFHdhFnZWOwNro47EbT8mmL5rBepaY+EW2eYkYW8mGfBYvLKQSuo7MQjXfxjPs8jtuR04Y4fhY3OT1gWKucvPeIpPAOiVl7x8tp02Zu77mfWQE/Az0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723337; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EiiEmqVbAm+Cpk1I3vzcHEE0X9cbOc8qG76Z0/eZVTBQmz7V6C45CkpzNjNE2MNsAihvk2L1gX2qzhhGIyy06lSkM/jvuaIJq4tUKiVpRroXblLJavT42fsuTaZDQATgNnM9VWxY9vxQGmFpKzwpd38EMbWmcqjxFBj2hCAICSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e13Tz6kI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QbgZUo2i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e13Tz6kI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QbgZUo2i"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rGIL2101477
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=e13Tz6kIkamhMoyB
	AqyCH6LK7ijdeJzi8mw9q6lz57F/Ow9TLcusNIY3p57SGWT2u+O3U6K7e4UB7J2G
	ogjrH0OPfQFELQeerI3VUViYoM8y8m4USavzVNaAoYuLsxluNpSG/txMgDsf/w3j
	soMFqHdivw0sh4npujkwEjn4ywL0M2WOINtCmvuMk+3RN8roI3Q/p1jcob0NXBi1
	jlzY74NPlvYVX651DVAZ8MHYeUjX/IBFWNzBBSssuaeQe3d/kTe/iIJH7tLotVma
	oEtxlmnY5BRC2FXJSh76izJsOkfO17fGp4LnUdj3HMwytP4srQVIf55hWj4iikQi
	CkCOnA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cng32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:34 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-73883529f3eso894495137.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723333; x=1783328133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=QbgZUo2iHoKCTWS3QVajj3KNlBjmakUYbuiUb6Xk6Cs/K0Ql2+HvKY50C+6S7nbI45
         2ASG3EUtvNGFl04QDD3jUxzIpIytcpYE0Cpp5qyNrV3KOgrHUFZV59AKhqadDX8ku9p/
         hFQNH6mJzqm3r9ANjLvJYUgUznMgp2F6DP3BadMVJHPOYe19kJ9YZ7audU95PM6+dAU1
         kZxN+E6D1AJmPjJzd0+BZNQM23RZgujBzkxqGE5VmqhI5gvRFK/tLW6C3N47MRd/mbip
         c36P3sG4YO0vpnWImfmtaKgmoMacWZ5EYw9jhDo4goFGy28UeoOzO2zMUJJYJ6UHCKR9
         uPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723333; x=1783328133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=Rsv0On26D8NbMtatJFL753bvYoAVwiih9KPJRanTcX3g6zidkeoF4a1il79YLi/wVj
         ljiAwDT5hwDqtPzxErmxfveKi4yMqapjj/cM4vb51ER5eZAkHEAD+skYnC0VwwZz97ue
         S+7dXS2UjkDmhzbgltYUvXQoTAp4IGcRZwSzQtz86VEgSOKbnGMMHltKOZfgiHMARZbR
         2ONwfzd7LIZcIyXtWoXXisxOjkcBesZtpzsXAubqon8yGiWrMjNLagHWVwiB2pUY9GIb
         n7uCUCru/mN6yu8Ad9yvHPaoLlSbpFNcHTHMX2rXrYMvVq0Rxkp8BTuj5tXe2LKGmqBk
         Chig==
X-Gm-Message-State: AOJu0Yyctn2Qgr2lOefTkvI+FgCecWLbbwYbnoBMSIPCr7yC61ToQqoD
	lNbOnRU6xq4FIhNPSkd18dczaaaF77h8skxv6wJeYdt5kkcBgim6ifpHhbsy0mFYHWRwYKq6c4Z
	8Y4j4aj5NtyP16fo8GLnrtGAULgbc+dsY3WuwlwJbxoYTnGJm7pIjnJOvXYZ2LOo=
X-Gm-Gg: AfdE7cms5Fw4Jo09XBVFGNQgWJeJTGNi2jvA1ZEA/IeeoOD10Vk+YpvEFFBZx9lpWMm
	uzsGAQC8LlqyGHvNgTyl6fH3MqwZtia6da6dghwkgrPpTLPnTWdUC8XTQmB8V9YjNoLifJ6Q3vK
	MoV//C1DiXfAofcp2a94JQOOE6+hs4usRmdkR8EUzZesfT3Vcf1Q94yxKSMxH7kcmpl2FGZpjAi
	uxA/y9t1ySg8rTZPwkW2I1/wMhRMwkhjzVMWGuVyS5DcLK9BowMvQeiHm3fBSNHSMKub28SXthd
	1tuKnXHrHNcrOmCaCZ+p4EWX+hM44gz3xxvi9OCPeNzC+UBlHlJawmsJiImFNTi1d0nU1FQIxhF
	yp95f5gHzBWX07SLqDNzOwqgvVzEgS4jUbEgSbdSqLYGOMlaH05rsuU77m38dJM/6TcumAGJPAp
	7ytpU8lpHe9vAttXBjjIQsXNu/iwyH9zFTAnLEXlFF9jJTSI7IC7Am441nB2XNyFRGEoVirk1tI
	AnaAyZqGuS9W4utCMWM
X-Received: by 2002:a05:6102:80a5:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-73435d8a3b2mr7432136137.17.1782723333424;
        Mon, 29 Jun 2026 01:55:33 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-73435d8a3b2mr7432116137.17.1782723333025;
        Mon, 29 Jun 2026 01:55:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:22 +0200
Subject: [PATCH v6 3/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-3-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a423306 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX9q5PpJ/J7qJt
 jQ9rpseRf/Q96ke8AYglptdwLtlln/ss9WejWoGACArgI1ZCgS6wpgEcxCOoA2OI4MjZSYDI8Gb
 JrZ5hlImWHnKIodSIF15OypO28YsX50=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXxxxyk7Ex6dK3
 tpxOZgASXRk1FI8PcHOGJxpl7yBxxPFKOBiPiPf/p8bFh4/+itmZhhMhPmKRkuWFspMIVPHF0n1
 /+ll5a59qx2b85ER/tMAE0+BgGZ0D911UP0ZIEv5SQ9Z21KQPLs6iQ88gSUaTryeKI7Hhh+W6fG
 QRGtNVx+d8K88IaRBWtbdLOyIGYNxc0q+GGX+HcIv2ex06DlcTT2N+qpTu63NTPLe5TVr5AvT7J
 oBU8iDnGeyDAxq9dJM3XCtyMGH9RGXYjL9mpM/k9DHt9FhuLDwekT8j7kjmJ8lBRwmdZnh1ww78
 C0lnCKyPk7cQVKoFlwpJMlx0U6p9ILL9mxsDGXzJeJIWvoGf8PyZch+IQOBSqHcGPiXPwhSyQLC
 Axnns8AxQeMpkin1cCNAtpKccLMKCXkRa6noKDwDm0uYvpMj7gOmldSxfiKpt2HMTVQr0NIQ5ku
 wbNExSFgqFDhPlxFY4g==
X-Proofpoint-GUID: dBGxfOhJep7y1_qcMJAhjFgBh9Mf3BQ8
X-Proofpoint-ORIG-GUID: dBGxfOhJep7y1_qcMJAhjFgBh9Mf3BQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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

