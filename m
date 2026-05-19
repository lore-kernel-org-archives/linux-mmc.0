Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB54949E9
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189734; cv=none; b=o1/U4NfcrmiL7tx/a/UHXayU/Ozp4sAmw5Z09+s1ERzFH8yawt/5xL8Q+NzDCIrnBfF34JUhHqrc35HJKw0PwwwQVlGGFpz5o8s+I9791OCIznQcclQRkPFjnD4CO0hXqEqUQ7UT+RVflfEosr4W5SQb9oldMBx70Wc/MGyxbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189734; c=relaxed/simple;
	bh=ROfWYzqfLTfeWEuSE0CQdQnZtXIf2oyWevn96M+Mxqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPRXWzdsPpz6dhu0yL9Ywoe5ZKVDX7SSfVmSwktuSxtns0bbmsSfbk4vB4eyMp836t05K6mX5l8CKPelmjAA17kXaelRgMdtJ7//XWbsjmxVbSLzuo453m1aiJu9mY23cXQF6NkymhxMgk93ZyoV2o2wiCGrD8qllL7jr7US09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnTob3+M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NAiVWFS9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnTob3+M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NAiVWFS9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9kq2K1256987
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IfCZBMhzSxU+6bFyzhG5aUVHXkjtGzqCHGeI9Odt9/w=; b=WnTob3+M2nl9fu13
	YqmnFopwWZ4Uta0SKpMeP4yYCkLcSl+3NGgkbQI8ZQIGhaepN2/BLVsDOK0gkv/W
	MadvYwIj7OcxqJ+WFmWCQUYGwez95sHcaMdSqlvB74Rxt8bGp3uG1eIeBWXdMNEN
	vasCf0vMLg+s6fJD1TMQgLixZbSNNCLN1uOALYkVXyDvh4t9ETjTmgt72+6QUVRw
	2ocXhyH9k3gXRjX9d8ig446PBNvusNm0QbFJ1A/hUx9jX0XGitrCOjScvHvqwOki
	1fwBiBvEwT4ou0n6YkN2aSrXolcgxOuiP1IqB5Wb5FfsYUrGyqzwDLFwm5z2OAxH
	byuFkw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nhj8b95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:22:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so2649382a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779189731; x=1779794531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfCZBMhzSxU+6bFyzhG5aUVHXkjtGzqCHGeI9Odt9/w=;
        b=NAiVWFS9Gf/ClcganLy2iOBYB/oC1UBCb1BqlZLWT9MNmEJZbJs3FTIq/3JNItJXVT
         muX5di7jSZIYX9LMDg/tYws7UTKW3eY/W1IFvtA+9zS+MmawBUvv80udl0rDD2Wj4lWJ
         nWP0QCp1t6OaQejten+O6ch0E4Dapkw91IUlc49vUWl9+Bx0Os2AQ0l2dlXr6FoblvVL
         2tz7rohPbDEOsGjHWEZ6npOXANrQrFELXJRFz2ZfNsokC+QxSmoU9nObvLyC3Y5jPmnK
         1cJS3+uBHzj4sfqEIhamL1dHMi4ihhapqVbgDd1XLBQB9oyiLK6B4EbAic78ri8xFrkw
         5WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779189731; x=1779794531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IfCZBMhzSxU+6bFyzhG5aUVHXkjtGzqCHGeI9Odt9/w=;
        b=LMc3f2sHQI3c41tBGISq55qYkFXZts4GcYBh2oO2gw79Cor01Y3yZSV3Ppv7NyHmbB
         oZFV2UiI+I8haj6b71cYsSFU6wuBuL/6TNDtnBpZ3wgFVorkXoXkryKzhROYNzVx2oVq
         mggNrwIspu4LnnWgqBhJEF5n1IUrKLypH2n1jdRzjhQksIVv92UsTX3jChVBJrq/ucuz
         CWDJnw2MdyQ7ywgmP5mIwZangKUnu6w2JUOqwRH/HnWcxFleDD3No+ZEbQbdiFw07g8g
         gCqH5KFfNKD+Fw6qW59JkXBBqeRqOpvImcj+AsV6Vj1BqzlBu3+9X+ZUrLLsLpqCh8Fc
         OtAg==
X-Forwarded-Encrypted: i=1; AFNElJ+SS03KEIjev+c0W0xpCzXuOLslE+UL7wJmBrzhdqKWvxqY3QmZ5ntu+gH7Cu5woq+f4EcTurfmy7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVH8mqKxNDZ5VU2PYclWDsEUCuP4u+DBcFaXYSGUaja8j9pxOp
	8nnxIhbyFW+zsCFp1BfP+vzkzmMd6ebay9270tetM08Tlj4WPv9TWUdy8jWPqCYHGU9u9RI3+Fj
	Apqtv67KLIoV7ECQC4vYETW9gbyfHsCvOnncQTy3l5QJ5OoBSMKJcaGFGzomKznkPFC6A8NQ=
X-Gm-Gg: Acq92OFOIVZSBeFQYWiiIwnrbtZZploiPDUBJO22v2TFLEIBhGaAHnXcEvgPfbcsALE
	hvvODUwIOtKstJW7Ny3UdoQrkqCGWQaDvFax3ph1+bm8qYPIPm8tGctRBijaZxm4imPtxShDDsg
	9GhzJ1+0rSWCXQNQt5ZJC797xcNCW6nNo86X8RzE1V3QHdv87NsJi8Tw77X84KGtyxac9gWQy5R
	PkmLtITgLWgwn8VNVMzQoUq0Vna1HKUI7FlfSrsBjUSIItKkW+mr8zlVDAmz22XdQ7aeMb8ZCUy
	xG88HlPfPtjXEVLIcL4oNnfbDterHmOGgamldX6gW65SzE5v4plnZgYBjDlZJR68aok3FZvEcrs
	78vLWftHFalIm3tM91hzM2g0W1b98eu3nDmZhAC0QooECvgU=
X-Received: by 2002:a17:90b:5110:b0:366:1c9e:99b7 with SMTP id 98e67ed59e1d1-36951dd286cmr19479024a91.25.1779189730756;
        Tue, 19 May 2026 04:22:10 -0700 (PDT)
X-Received: by 2002:a17:90b:5110:b0:366:1c9e:99b7 with SMTP id 98e67ed59e1d1-36951dd286cmr19478978a91.25.1779189730169;
        Tue, 19 May 2026 04:22:10 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe78b9sm192743605ad.43.2026.05.19.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:22:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:51:23 +0530
Subject: [PATCH v2 3/5] arm64: dts: qcom: Add Shikra CQ7790M SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-shikra-dt-v2-3-c01b90fb4395@oss.qualcomm.com>
References: <20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com>
In-Reply-To: <20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779189702; l=3493;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ROfWYzqfLTfeWEuSE0CQdQnZtXIf2oyWevn96M+Mxqo=;
 b=pP3MfIHGhn/2oScZhcEZ5nSDWVAT+MjrRFL+l++qEoyV2NLrC91s2HU+2wfbjUJBflxtID4b6
 GO7T2+s7/HFCQdZ5ob9rgpy/+9aEd3YuQE0d14egoVbvmn8RILw7tki
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: ZFKl4l8SyI7xDGamrtM32MmtFDkxdOlr
X-Proofpoint-ORIG-GUID: ZFKl4l8SyI7xDGamrtM32MmtFDkxdOlr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExMiBTYWx0ZWRfX1rU34o+ZVPH/
 MHFN4E8AWNlCN6+eGg3NPbWfQqdT8ZsYbbsa06oOGFIcMBG21kP7SZFC8s4yfl+y/VQbf55IhWq
 qDYHuUCRdoOMeACno96hGq/Oo/cWsb0rbUq6heegmE/jvNPptH8j6M24oNSNpVcMvFfAijp0qef
 djpnyJylcR/ox5sI5LrmJ5q+nm3T3Eyt+Fcqyq05l7g1QXINle0gromJ3qQjyDBZtU08376laUf
 pxMmNc8kRW857LRYQEzCzcqb7cURGIpcxft8hxt0GOiVGye+9dKtadpS0ncv5mqpky80pLj03qM
 s4CKzLJd0g544CHypn6yBnPs/maMrEDMlVl76U6lp65Vk4G2yGwlADma1JKEHtISXdgHjJKQoAl
 SIDb6o2jeob2XOfrJl1ftNxpnruzZ6MW5AA89aUpOQhGeGpDysJViRXCoEZHb1FXSEMYGe3vrWQ
 5GKzWHD/to+EokqtIoA==
X-Authority-Analysis: v=2.4 cv=ToTWQjXh c=1 sm=1 tr=0 ts=6a0c47e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=yuh6J1mAL7zzRkeivMgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190112

Add device tree include for the CQ7790M variant of the Shikra
System-on-Module, a compact compute module integrating the Shikra SoC
and PMIC for IoT applications, designed to mount on carrier boards.

  - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 PMIC)

The DTSI includes the common shikra.dtsi and adds PM4125 PMIC regulator
definitions specific to this variant.

Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 112 +++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
new file mode 100644
index 000000000000..401e71720519
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "shikra.dtsi"
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm2250-regulators";
+
+		pm4125_s2: s2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm4125_l3: l3 {
+			regulator-min-microvolt = <624000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pm4125_l4: l4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l5: l5 {
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l6: l6 {
+			regulator-min-microvolt = <788000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm4125_l7: l7 {
+			regulator-min-microvolt = <664000>;
+			regulator-max-microvolt = <664000>;
+		};
+
+		pm4125_l8: l8 {
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm4125_l9: l9 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm4125_l10: l10 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l12: l12 {
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <975000>;
+		};
+
+		pm4125_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l17: l17 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm4125_l18: l18 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l19: l19 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l20: l20 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		pm4125_l21: l21 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		pm4125_l22: l22 {
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+		};
+	};
+};

-- 
2.34.1

