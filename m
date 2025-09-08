Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A02FD1D8
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319679; cv=none; b=ZPk0JO/wTz3jytUGWHeRdLnwNLQ253z1bGVQg+8j5oVVwJj4Kj/1fKlEVG4JFHi/XnvePG4oh6PP0C5t4iVh3B7MAOAxF3WpVdPryC/cW4KaBGSoDjK60PM41Th+5oeUM+ofqgNR/504Z0m9CAagANdKpz3Zpq85vHnHhYnTfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319679; c=relaxed/simple;
	bh=/4ZTJGnGR5GHDhrjOUf5bHrQ1cpXckbW9O7yW53a0iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O66moZw/G9fOOnQOeRfq6Ch3kDTaqT/454B038EQJC3EtlFqL/VZl5WCX7GeTR0r3t2wIfSQOjav2ATtir2qDGwrTh+bphqRBkbOV5eCNxKRaIJ3gYBRPe155cbiJa2aMIdWeztUqAFOpzVHlfsjmH8GB2U2C3iAVRzGr4anWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MEVFM4hg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MEVFM4hg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Kt1cG003963
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URCNjVbENokOE9jP4TmSk8RRgC/EOlHRv5J0OYYwhW8=; b=MEVFM4hgnWkMuj8o
	NFj1h2i9kxcnrnAhClcXs6uh0qBLs2Q1KaxfuQ2HDTPfD/zzH8kJuCaTzEwSNXuc
	jkfgatBGAa+Ff2Df5zYk+uENLxC43MSB9GzHp3umEmK7YLz/QpLDdb272Tll/fM7
	qUwyeMBrz/UCQH8EjjkPS1ONLOlYZHVX0iquLlBg/SgVLOzFevWqSAuujNgFiU2A
	rSXdQ0S/2FWaMy53msq8sxCy/Ty/ipy2rXtAfNwMLYFby1XCRBYSBHTG+PgWdBsK
	HgpsNd2pSfoh86NFp3DNDBm9VH+ww8dD9Rl49pC8GCh45fveW5/IWhFDyaJrolNQ
	FJzKhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfuq70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:21:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso89567975ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319676; x=1757924476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URCNjVbENokOE9jP4TmSk8RRgC/EOlHRv5J0OYYwhW8=;
        b=HBFplLgJG9gogZRHC6vrx5vkBuRma3xtO+IxIgKkIJF1UBBYK5Q5ojJB3o7JAvpMyM
         0U2L14GY9n/n0PsSGd0wZjqE2PaVziNoyLFAh2LwEOzrMRUCKNTfAfQZ6HZaQDp1Ni6H
         vQtgW/mBMlLZ9C5MEadrCFM+PA/4/kguHlqZA+XakyCs0r7+5V9YM2OCo7/7jNcvuq9e
         jzp1xUUttSFPOX1JuDYKzv/qW1hDPXpviQTR5U8YerwRmIyX+di+B7+M9icTNFXhbQ6+
         kdYMn8Z8TSXjq+QdKJHo4JiYdYSa4p9t0CaUPIGZRd1+FgM+0kqSHThFTrbFRX+XD1h7
         dAcg==
X-Forwarded-Encrypted: i=1; AJvYcCWSii1d7up0R8CKHupEVjZQShyAQ4oVQbRABC7cKZ7JGWrd+Lhl6GkzEFBfPgAyQZTUQV/xuW29KvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0qATHTMIHhNzInd6SwLt8UypvH6DQ7rDumK048QZR11hzqdX
	ic1S4rsVqRie/JQGnrbds1RuJjSi6xXTRSq/VaK4AemJ6POb73hbIcsCN426pH8YXhUPD/Udn7n
	wH9YlFFYH5GQ5PHXFeiSqiCvNg221ExQJ0u5eE4cvsleWr3+C/9ZaJ18PPNU8mbk=
X-Gm-Gg: ASbGncv4oNf+38jXHtWZ6TPId24G5YoK75lQKGXHnMubkwylr+5qUKm3T/NCoQFKzek
	bWhSubWed9CKY3MrEUPeqrMehBNH6gdFNpi+Mwx+ELOCwptUV4Q4x3JsuRqvjj0ywuyonPdxIxz
	8PMJ5uH3tyCq61zwk6s9kWyu+IvD1VVyvuBq02eFMNevLWgrPbnXt85DaBB3bWO5sB2ebAIo+7P
	6t6HnbKNhdqtYuTAEOWHDpFUX+cUTSKQoCB9ZnN7cDgUnriKnFHG8DRuGbaY7LzWIVnXKQfOx/T
	LPcJOeTRDbnNoZzjOvE0AN+5VFpGON8KermpLORPshzjO4L99wSrjScfLi/cUyYsJXFx
X-Received: by 2002:a17:903:19ce:b0:249:147:95bb with SMTP id d9443c01a7336-2516dfcd7ddmr84033685ad.13.1757319676047;
        Mon, 08 Sep 2025 01:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUVS2mXFhGtkWxSMzeASlmhLdAgvZo3EJP3gdXk7dKlzPA07k/IJbwS1KpZbz7wAZsYMfudg==
X-Received: by 2002:a17:903:19ce:b0:249:147:95bb with SMTP id d9443c01a7336-2516dfcd7ddmr84033485ad.13.1757319675569;
        Mon, 08 Sep 2025 01:21:15 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:21:15 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:03 +0530
Subject: [PATCH v4 13/14] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-13-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=sJt764nmIn3SiRpMOA7PhBLCauC1Z3J0FkQW3/5alxk=;
 b=2Cs0qSl19IFI5Aem/1KCsrfdDTsyphhbc2bhvoK5i1FcCTq5fwvREsgpZNuGVgOGZALk0gprY
 nvkZwTM7RU2BDgjU+yZJ13HL4Q8KE9tyVZc2YdF17at6TFixvHiLIs2
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: do5w_lRlWFvGNW_RbeKl7KwWeAbBraXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX3t2eTAAi8KEN
 WQja6zKCDwIJb1n3JwdPRl/w4E0StBXNdhosB+qzxh2zFZDlIOeoqWmdVnXXGTB1qNNtgUtr6DX
 jSC26hH75pOVXXz4Lzt5AytEUEbn/NoAuC9xZgld5ELGkXxRbErVhv+i6JjXBPFCc0/GTFaNlNc
 o/qhrKzBaIiPagGfFRSLp7yjRgijT+1o5VFsDGheorzmsrABMUM1mDr1rqhtz/CrLXBGec2wcLc
 D/KUsyCT+itgPi67RZlRjHLFeFi+J0ZQYvXI0jNo8gX+NstaJdXd3LRStL/jq0f6U8gw6sMu4ax
 wB3Xlza23UjVaWiidEQwToLBRitrmwEHcObwNW+MFHoUTI3jNfZP1VXQz0qnsSxqgeryGpM1eHk
 R+sAGnc2
X-Proofpoint-GUID: do5w_lRlWFvGNW_RbeKl7KwWeAbBraXg
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68be91fd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=vHYnVJDjh8PKMNTngWAA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

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
index 05d5da382bca..068acfa9a705 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6759,6 +6760,45 @@ compute-cb@5 {
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

