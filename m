Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3C33CEB7
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004031; cv=none; b=LrXQmFouiwDMgNHLBLJZigAHwxGK753ftNKVPNAdiSWjzMvjbc3tBOE6D80uxgxC/KUf7sc+S0H3CgoP6m6rosZq2NwGalmqEZ0DyciIgqDr+2A21LrF5VTUrs8rbV7p9GNwFYDRVrBlnnn+RSX8PcIQItjYV0nR/oxW6Lcv754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004031; c=relaxed/simple;
	bh=Zi8P4IJsrN5PCQK4xo00ZPvmwVI9z+jIt40lmIFld5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pjuv8/nKSddGF8xGMwDPzhg+HSvimXCqxNJkb+6kyf84654NPDbD8dUk2G3Z3yywp2yIYM1xDG7hyvCtBSmJrYrGpGHopL14fKN1JYQTurzMaZTNW8PpXuhT6/6rNnfXPqDSS5/7KIdCsYkes+kE91US6Sy0bN8r2PFw2GbSy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmGHQiqe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmGHQiqe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8GP012122
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0MlJyi6xlGQ4JiQQxsUH2044SHYqkJNDG1W6ew662Q=; b=nmGHQiqeJh+8d2I4
	rUfuN7OdmN51/mU2AUJXaA5wRKSY8ZqtGwfYW7k4Mc8xvpnB8IB46mfbB857E8c9
	PXPd0w/tYitw/hGdNS/e6mFWHHGkHCGZmrOrlkMxpBFeElu0ffcD1Dc5ZrltydT9
	jyD3H3sNsH6e57lGnqHlm53VpRvMmD1xfX3xqf92EDYqOeLwbA11TTrB02FEJAFW
	I0oi9PX1SrQuvmiM5ZSy6DVE9ZkdL/aIoDYRvgLckbmbeZCgAioAmBgF9SXEA4ec
	b2ALCUjyhvCOU3wne6vvJaAqJp1/OHQPDqVlmE7FOPAM3989DE8uiumgcSlM0ul2
	o8tUFA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj4nvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:40:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7723d779674so1162409b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004029; x=1757608829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0MlJyi6xlGQ4JiQQxsUH2044SHYqkJNDG1W6ew662Q=;
        b=HfJiYC57LRR9PbumjNnWBpUxytJSXZQ+bDydzNbhuBX64QbmHnQZJNUFgfJh+mXt/a
         EUEwMvInGDmNkJl2W8gBnyXFv+0w9eFbCyTRrGeZoFGPt72y9roAtMSMeJKc4bUKpsh8
         sxzhcFhobnO+cDTqYmo+KksPbPonsLlO7yIZqgk8Ott20k+G2rsEkEIfzYP5wrbLNqiB
         oQVyUeBFWriFeCooqUo/melTicn5XhM9lDYsAvi183hssgrkzJWOhZikqpRCeDeYT2re
         WROhGYd2lLmqXNi6syhxEjJIdY4BpdcOXXvsl75vqOpkYRe9jGlCDE/cPfol/ktlC7oE
         KjYw==
X-Forwarded-Encrypted: i=1; AJvYcCUgKcmn6ly85UKSpqbx5D5ly9YTjzRg6qGIHiVr+raJ/GibNAbHrGWavSYYr9zWte5pkh6dpYASOpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVk1KvsnkcARdApcAdypap+6kK6Rfty1s+YRVzifDxh9F/HCtU
	1cZScOMDLUd/RdcudVAOsJIorT5qzVXRj7ZcV7K2LzZRnRWMkcm7bf62NI1QzjZ56WzauRUHwjE
	RL8H40CUKIDjMh7tgUNabNZqI+lTSEqAKCv4ojRr80ctvfgmmXDEyUry0dHzwJio=
X-Gm-Gg: ASbGncsH2tESReOnW4iEQUtIX+XcA5wuQ4BMy3RjsYcZjOMx6ZXVHxcqREhC25vpF4S
	6LveBLYV9ww0ANJU8Zd3SYe5UEcgUvvrAiMcvmO/VTpB51yTLK5oDwd84fN1C3qYO7dl6Tu+L+n
	FJnY13aBah+dtPUdad+Y11SC9HDZnu9MjI2D3ksm06HzRIC65n032jWGZL8ygNFGGbuPrVZkZBd
	dwibwJr+mMUWqY0iKyiEt9XMs4iwOfKNwZk8U1yAbDKgr75Ast11uKWtWbVJrLmGt9lW+q+JxjA
	SS9YpN56Etz1EipJS2RbUcjiLP7XGZij4vsGt0MwUzJwuOtROK95NzvkYXFdbYq0Oe/h
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-243f5bae8acmr20306950637.25.1757004028723;
        Thu, 04 Sep 2025 09:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0hqSjTV8JZGJkiN6dTs6Zedyh6YiLXgXgSj90NXrTKN9ydub2uoKmDCtf+fOgPDEeOaq5Vw==
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-243f5bae8acmr20306896637.25.1757004028089;
        Thu, 04 Sep 2025 09:40:28 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:27 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:09 +0530
Subject: [PATCH v3 13/14] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-13-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=ODJ8lQ3jakhcv7zggi3511Zu7KexUOIuDZjyNJiIUUk=;
 b=nRG6nxDgky9xmJhMRuGpBCnQWH6z2PchN2hWiGAyg9tyGCXJGzJzyqrhHLgHOcwFQdYBB1N/C
 zmuk+DtUnsfARS350Cl2HFKFYWs/15YaQKmRaELoQsOgXSow1uQke53
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX8Xr9VdPVBEbl
 ad2wUiDDtvtuGmbsuFOHC+ahJ7O9VtzElWyGYTVSFyiNTrN4v436ZjB4f4ubOr8hJb2YfOmbDIH
 LYLMpenasd/MqAxz/RUa+u7Tun2IevXgfgAZIMgvxkEXok6uZawONzRyXzKcKmNcdCi3cYQzj0V
 yhLufoQGsS0e8IrdZrHdT2io05Ajp8TA1LfZY7ecVjTuP8woyNav1F6QpzvXZW2xJtHj0I+L2xi
 mZDaxQwXtHcc4kgm8Pw0STWCVJOwCKZJIKIQyLc+bXLrWS6xqEiaGnYTqPeBM95iDE/lYbmLWzb
 oynAnnni5UBijTOuS3kvTx/kpycLdSHNvnpP3DuNwTx/0ndVBvmtTJq9zULPomFUlLQctUAtmOB
 l/xsOwfE
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b9c0fd cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Rye9TsTwPMDKiC_iSCMA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: RiuRKxUdEZcHAlvBUemJA9aVsJPR7DXs
X-Proofpoint-ORIG-GUID: RiuRKxUdEZcHAlvBUemJA9aVsJPR7DXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

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
index a34f902c1358..f3a4deee383d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6760,6 +6761,45 @@ compute-cb@5 {
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

