Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE908371EAB
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232508; cv=none; b=Quhbp77qxKyF9l1v6Jw1tn8Wd/jSpamwU1WlWEng4+dhfr/Ct0mJGcTJQ0qjslJ3Tm9YAVFBRg6sQqxHDhAHIOy3dumPER+WcreHCJg5m7XPAruEXmpJc7r7cvE+7sWPp0Z3P/fRHNXTk60UNztIQeH/7b9O7bPS7dsWyQHeHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232508; c=relaxed/simple;
	bh=bIBcAYpVmFWgxOVMtIDqpSvu09YY+NiCzJTZkWhGL/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBMvO+6I+IX6d3sWoKerefJ05VncjaZ0Ec+B+fKpu/k7U/WGEAjVKpqAyxGn84YzdMEu73usUbQnDiWQbSgiNkyFSbnWN4mT07+4E+pI3V5/fQK1fuEw59hKW6ZfAnWftdN5tIATTJWobeWwvSeiQi4FKpFDSvnrdsnx+tZquIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDtwhsfl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDtwhsfl"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBPGA3007563
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZqG1x0C2Vi/fvgd89OKAZucnUy94PXEwuDfboAV8Cbo=; b=bDtwhsflUNbP/o1x
	AcazB4a+GFs2pD7dD1h643kybLc7UWML5+gP/pqDzrZJkHT/NT39fg7Txeo4Gmrd
	5Y6NCTSYnmiN2/j08mr3GzApkHBH1X2C5RYcSEPka/QWfI+4wOzaBX+irOdKpI7T
	L8hSmKTBmlHaZeVS+fl+iU6mfh+eDj0NORRBziAkCj34ta5fK7AyiHNmuTqHSBpz
	PLuT8u+9aNDOOKZwL9dC/Uq6NYE4h8Yaf0rUoIJ98GM9q6w2lXn8ofOVXRJMpJum
	UGu9QRGpdCAAeIs6I9p+jLlVp9sB8rWFVyTbuAIDxVwsAeJbmBNYCRst4ggNLLNV
	xZCYQw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x8a1d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e8ae86ab3so5700011b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 11:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232504; x=1756837304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqG1x0C2Vi/fvgd89OKAZucnUy94PXEwuDfboAV8Cbo=;
        b=u78phk5zBtbw8OXi2VWYyv6tC/wWmuadt7W6KJU7fRRRC40HEcwBwf40IuSoPOWc5L
         ElMs+lyLOK6Yt1v1AK+FJdh+TkxQJruy3bJAHix4MyIBTY7K782TAxrsf6FQnbYqb/Mk
         ntbg6v6LWGm1dln51eMUnC3NQ0AOxofprWk+nFeYE0XAWEo7sh3sEltAfYPwHwXIdZGQ
         SOJaFaV37IQ20KLFFRoCfbN0l3D3F9nWin/ORpnG0C5e/zsXk36gZPGm9FRHp/nq0wG+
         tMYVKVMPEF5Gcysedxfw1qFhwB695DDebR9q7fFtZqfGEZ1sCGz9NFj1/PLOxMMIX1/+
         Gjqg==
X-Forwarded-Encrypted: i=1; AJvYcCWcqh6Own3ogonL1B5udz7oGi42XY3wph0Krh2b+wUvP0+SwY3u70sVAejafMoEPYtcpqddLrb98SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWnqW4F/FkDDHZ3HD8y58FmbEtNi8tMS4V2+NjjjzYK3drrWK
	EBcRkO5f3pEIk93jcru+tvBfYmmWwohrnnWeGG0XmuHsLmVzzXxl9/zQHtStXTDfIV8x0nOZonH
	E9IdV771XxQMlarkGbBt8ud3n9ZqKvU6I0s6MaXaHgm3ooWcts5OHTpViB6XY2V8=
X-Gm-Gg: ASbGnct+PDV8nM/gvL74dpDkfiakHvUWmpjEAHeWxu5p4Eds0rFtZenTJHMTLvDwkRe
	HOYU7WAmMYPMcLcKPfue9SMnyTp++nBuFfpo9By/V4uosmHQXiEYUc4KFRT6bUYIWpX1iq1aYpv
	ywqNeZl1I9X4zRo1x8PIJhkLpsCPeyKOj5yscX+U0gHfuW2ud47X74fy7jcUAZFpJSXWWfkKTXC
	ebRhcxmZTXuSghTRS687r69gRvli4/uIvoDHVuiSXHkJVeofaw/y7AYCM2GlXBLO6yywjZOIRKE
	kBktleMHVSgleOT8XB/3M4iKIY2d/P6DLrN58zgJWy8H4z86sGLhi36Beh/pmDR2arVP
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id adf61e73a8af0-24340dca336mr25779273637.48.1756232504009;
        Tue, 26 Aug 2025 11:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi/T/3A+ZcqC2AyUm9So880Y60J/r0weCuRK5mB8bTebqwx94ASLUPJmyFLFQGaQpDcSY+eg==
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id adf61e73a8af0-24340dca336mr25779228637.48.1756232503505;
        Tue, 26 Aug 2025 11:21:43 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:43 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:03 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-4-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=40OWUv9iedJbCp6fZ7M8XF7kvnUUAqEsRqjGx3RvYOU=;
 b=y6s8OZMnYzKwwtVKaCt6Eoe6yyzw+1yqHwQFGnEHHe+s9/+8MtfFNQGbYa/ABeAkLkDe5ZYZp
 WUnLen66DySA+GDKrVSluY8ZYNI9Fzmrgkbx8xGWSauNgfqCD6xGISL
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: AMVyvvK8-oR6tTEMZnCr0Y2bN9KWSLFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX9+DqA4U+pnry
 raVPR3Cb0621nr8f/clk08ytZejwh0y9Y7Tbs+zQokpF2ZPZtdx4ZRNS5sovVslOwZMrQ084EnA
 a4btCgO3DACOgujupY5VOqnQwENj7BuBYe9QHKhw0PtBhOrNd/oI/NIyUdD8XiRgRDd/rMoJN2E
 GpY7QicnX0orDNiFiult4CbQnYczAQuh4xpLky73k88HkAUNqPra+fk5sGSQcdQp1obeDN5Y5Un
 4A7xWhbg4B4UqXfZzXbGunMbkfl2x0tm4fJsNhe2Cak5PHKD9kQXavXSKHi32guy9zSMeMGiwV1
 gs7/nccCw1qO+wONdooCHkEoDWOM7iuvqHlm7dT4Ded5xymvknXVoNmOTjzEN9Fa112jHYOBBZ3
 R9PPjnlw
X-Proofpoint-GUID: AMVyvvK8-oR6tTEMZnCr0Y2bN9KWSLFG
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68adfb38 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vHYnVJDjh8PKMNTngWAA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

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
index a5a3cdba47f3..28f0976ab526 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6679,6 +6680,45 @@ compute-cb@5 {
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

