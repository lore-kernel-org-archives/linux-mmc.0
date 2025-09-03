Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105B3019D1
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900114; cv=none; b=Mpx0G/2mw0pgHyul3YOtbPo0nuFQ64ywNV8sHK8KyjFB+zGXZIfaeFVbA0cHZnKGfdQhfQgv2VL2mFM7JxGSHrH0SltPLZQaOML2HhRSOfXULE3xMBSPI3nBVdh5UF+DTu0gZiq4AJPkSTkllAI6+TDnF1K0nvafiqrmkhrO0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900114; c=relaxed/simple;
	bh=Q+4M1gxYM9HSpOhjer1cCvNOrpmuy2jkOdR2r3bDUIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buQm0kbIBWoxn3sHoTfWbnvFkrINsV4A5nIX7pBu221LMLeEufg93sFnR/BZZMKRJj07Y1LVGqmUcNT0kMvjFsHogOze/7026UmNUr9Ca1UZVb1OdHDXfczJ+iqUyf0hr5c2+tU/XH1nxP/uoB4s4RU035YtvqI0gb3Wi0mvi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5ZoMyae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5ZoMyae"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEnUY013898
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3yoLPIunPhlxXFE1YCNYajxXEoQDgef9KEiYtHFNANU=; b=V5ZoMyaeQ/IMBAZS
	NSftbvkO9lVLdFO5Bi0+h1D0e2XRtjZGPbUKa/MiyFhRBsml++Cdlefsu150yOpb
	LmU2ZdFqVbpnklrxTkFpG09MEkybAzoF6BRU3KU5sQ/hDtUIsBQyH7O//KJcgKaP
	F3ytORc+yQILisfLCCWrW18NZJJLRqgqlOfiLWzQiA6Zfc24MOGAXVC0LLDtffOu
	P52k8N8rB4hqhd/j51ohY9TLgWoCzmzJdlynX0mH9/SvQrFZH77bXIIESWFZ1MEj
	2VQKZcNTQMzXMZCy5rC7yAwje0LReENfZrBR0BS5gEUhRDd1mFlM5ctF77VUOqto
	o0WhEQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy7cvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4d48818a04so4074653a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900109; x=1757504909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yoLPIunPhlxXFE1YCNYajxXEoQDgef9KEiYtHFNANU=;
        b=sdJGRJ3nLRtRYNY9RIVQDmqUm2RmCJ7HyDhjDBoEl8zaHl97Em8n/2NlnBwlkM+NPo
         0RdmEcMLL+ccLDFZGbcqVU4UxvosEfqftBZGnCEfFhtw/w9nigX7lHzTCDNJN3SKJk+l
         Wpdehhn/+JBQsCLz2q0heDErld7BOxx/MIaOEDRr2SOUUOecHmb+rO8QsRHvP2W3y8KS
         Qk33HDbGveotHVo4vc+TBUeFXdVs2SmzefJJXWgNeO9ZXPMjYtq/sMtTpjG+Gl7bHWDY
         pfrZPtIOw+jglEz4aTkUWEIbB4obZ9kBC0Sa/BnXid0AZwDADjJ1gbJXFCEevn8s8WDJ
         9znQ==
X-Forwarded-Encrypted: i=1; AJvYcCVenal5/3YCNHZr8XDWEdBnXkJ6fRFT7THajHi/ws7B0GxEJ5FWrE622kD5NfCSlvRwXa5LXGZRceE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPwpSrTDCQSVLsVNQ3WU7Q4ioJyRjPA3y61JiJSI3gQGnPQTH
	4hc24uSDjSwNT7OyTPA2ZBDqDAGviaSesSd27tlH92rjfc+kkZgkKdjtPQ97hZkRHD7dgF++mEw
	Tsyudr1cqBqiLhNfm/m/R/DmogAIkPCq0KZrguaB5sdMyRuzzn8KsY18zp7R760DtIvIEFyA=
X-Gm-Gg: ASbGnctr1n7O+tYH52UzRSO0TzQDlU83xLEBUZ07k33nZei5PL4pU7RU7ghxV77umrJ
	tkhhDnGAUnWhIj35FKu/UolAsVQyGLsQmS/cv2t/0y317LCgT6DdvRPV8IWXeS4X5H9gpxnIUk4
	7oKCQ1ULSlfnFeM8eFO8vqTJSClCBg24KmdEw/6YNSNPdYjky2R6dxhk2lQXTF18ziGUU0nQ0+T
	IZvROnTLhuiOn/M1sPa9lRIrTaVXkS0wwWj7TCy6ShimHW62O32An0zdTSR35fmD3Uu1aOzSxer
	S7g8nXJNprXwVUlVOhuJnTOrFIj0WRGkBIG6f3YCcIip7n4u15kh8QGJrjI+ckLIFIT7
X-Received: by 2002:a05:6a20:a10a:b0:246:4bd:b1e0 with SMTP id adf61e73a8af0-24604bdb601mr4899149637.11.1756900109301;
        Wed, 03 Sep 2025 04:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAWInvuzPYzNObB97vfhFOKCVNEC/bk/7+AjIv2wJlRbSZhoDyW3yO6kIqh6YF/MAAVsUJHw==
X-Received: by 2002:a05:6a20:a10a:b0:246:4bd:b1e0 with SMTP id adf61e73a8af0-24604bdb601mr4899109637.11.1756900108811;
        Wed, 03 Sep 2025 04:48:28 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:28 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:13 +0530
Subject: [PATCH v2 12/13] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-12-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=U/3aiQXpOo/u0LdqKxwMBduUHkRjUaNYx/wLMpz8xkc=;
 b=oknvzwqjjZHQ+lM3hzDmbgunEZPkHv8q/ZeUVHhRQ06P+pw430u+f7T4pnXpjUGz2rrAewx4N
 DQTGHRuuSd5CnIsNIR2doOiv+j97FbkbvVtyredmF73OecIYOJgyPRa
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b82b0e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=vHYnVJDjh8PKMNTngWAA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: ZjnIYEgQeKeBQEWFJvKeD-KCJdgNkoH0
X-Proofpoint-ORIG-GUID: ZjnIYEgQeKeBQEWFJvKeD-KCJdgNkoH0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxty9F9OL3v4y
 SIPCDhEKoXSHpscMBcDNgO9kei3y6Cm65mXY1I6bRr0taJLD+dTK9wv1bYawn5DS1vAzWkGhgaT
 KBZb/NIaNS2KHpthcXIxIZ6P4WlgD/Pk6Kbrcpcf1YCPb5kPA88+JFY8m4M9GUu40F0C5k9hn1E
 Z2JOQj84lCc0dXMrEIvzsFf6+1G8YnfyqtXVr4dNCSJ5vVxvDibRkVMncXTHOVNVDRfg1Idbc9g
 ew3xJiSoP28U+zN/mKRI9bGAUPiriEf3YMeDTtPbUrw+Lzoe8fa5OvgA4+smP6JCT+KVYQZ0epI
 joCPxlnw0qTzx/v7yKYj8+NCbvMXwfawoYFslRTg0mQSbvc0dQmLg9btjqYNhnOvtWur0nuWVqT
 JxVbcyqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add GPR(Generic Pack router) node along with
APM(Audio Process Manager) and PRM(Proxy resource
Manager) audio services.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 9e4709dce32b..41003d8878f0 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6700,6 +6701,45 @@ compute-cb@5 {
 						dma-coherent;
 					};
 				};
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x3001 0x0>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 	};

-- 
2.51.0

