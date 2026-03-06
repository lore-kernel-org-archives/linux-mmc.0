Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61F3451CE
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789644; cv=none; b=ct5yGByaS5Olg8/UdI/UEMioVE7EFiglK1c26crroH2Hr6qwniXzQaLGGL0396Y11ztvHWniyxlOy2vBUaq0wK60OcDy4tH3kESujDirM13CI/s8yNgwl0lmgcQ5wxocSBjB9hGpKTJPXwweWkiX9dgHGdMj4EbENo6F8faPX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789644; c=relaxed/simple;
	bh=8ebMs7i13WqPF0zC4w+oVAIdgnjTx2rCxck2UIJoxuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnno64ETzOJPw+jmHUS/PrdoDzWxMn/CbVtmBirHFhaZjZlmfkoXifRlihKYru6QqF5H7GOPhUFZeonEYN7nVF1gMJQ5+QAu0xObdFcpcwMl2Z5CVJQO02c+rtn5PRw+0QN/Mtbmdnh2u8b0pCpRRRiSwlaI5K7nRw1BDzOAyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igSsrnbe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iEjbYHm8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igSsrnbe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iEjbYHm8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aKhD265468
	for <linux-mmc@vger.kernel.org>; Fri, 6 Mar 2026 09:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=prNokE296Cy
	f7UgIGcapomuvXdqfCedaVm3IT2o8IjI=; b=igSsrnbelWVGKxA7mWx75h62PaQ
	D4XXqFBBLqx9rt866v3WbV893LY/W5ORuebT4eGTIeyIQnblsw2kepbt3YvvOBU3
	RktRYosxcBD+yeU3k8MdgX6IPAwlDf6Wda3gGpSjAOkgT3y7K4YUdhGakcpbkQAL
	hfXZc2JrrR2NBBs+biv8IYLpPyWb7R0pH4mxIsfFFoZFMVV6qN/PVTDJYrooO1sy
	Q13JbWTYzayHwipDCW1DMzsymEZEjWZ4WDYWKTRBNJ4yxczOhQ6vdWra/W4pkOr0
	mLwkTasxs7+zupGOXnNyIUgyofCJ6Dgys7/jPngOhdREH6lvCNw/2cA5AhQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqdvku0qq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 09:34:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358f058973fso8774884a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 01:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772789627; x=1773394427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=iEjbYHm82QffZbhnl/dFFPQAkoI9niUSWEHzv4t4eWvCkO4W8LagE0LTith9qLxZ+o
         hjsByh7csxw0xUkQ3s205c3pdZN/W6hKxRfLMCoRqj3XKG55dnkng3RmqT36MeRXvRRM
         EqtanOdPUDhXoZbc18j4/4MVPsBTDgg4laudht+86Gj7Ih3F4qeGoAp9X/tRX51eWirt
         sowMD5R8lRNidZ/UptaMYEhRuoF0Pf5jzDVWrhl1Ep0mHCEaI4KQ4V8NedVetapQ/Y+l
         jmxaEn8oW5+8e++g3OPE4/uPADxW6BoSq9Y95YZ12zEkspVVzJrtyb52Qk8OB4VbkNuq
         aLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789627; x=1773394427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=AHs9KqfMaIKxB4f1EKC4mNAfDcWX4z7UesP3CqGa1fdQRKGLz3ggAVnxD3FYaQKrHS
         CLXg9B9c2VGBOzxBPERP9+adBYlq+HQPAdPfLyUzZfRTYf3+iQUMAABJXqTlpBweP0Ox
         6cNhy82CGiIyDguKCW+ZtI0GeCgaPD+MKNiC3DwxYW2nZhnSQQqtDfSmxhG4RvNFn/6p
         4rSGZKdekRQOj9CEfWrDjl7gJduuN8YoNUYRQf+/KCmn875g7IbhsdgxT+fjMHoMKYMk
         IyhE0hDETIIHsgEM+iWvvRp0+miIglBbBcwaaEV598NUJ7F/UvWlQmwEucJZCGmIKMOi
         MWJg==
X-Gm-Message-State: AOJu0Yxp/001PJzLlmN6F6vluVEibt6+ot4IEiQZZlZBe5U7PG5gz06r
	rYFemOWEOmk3Vgr3g32oHZ+4TNiCUM2/EpiiMsY4iikyqR5hJzrx/E5UewBlhOxwINjDD8+8cTK
	O63Dik56L6Pqd6W8WyIkGZBXtSs1jGayfBoEoQWdbSkMxINsa01yZTRhlityLCNE=
X-Gm-Gg: ATEYQzzHalz5U5PjMX1sddKs9nOMSKGLHz3oQ0DMAjhh9wp1pxAyOizu5KPIiiIZplB
	5bwLNcriv+8FagFYU+lBt3EuPd0lrgVtvTzQxqw3f+KNaXtww+CuJEHIZ/67+gOirDC5RJ4/tMI
	qiU0gmI2QchjpZYgRl186xUeq3f3wCis5PLwujQPDgfEUtSSAAEQwNzTDNMMuyr6AjVjXnFvL+t
	UEQSSJ0Ip4FMwbxmAGyHAJvd8p7a1vz82Pg++x5VE0Ox+Bu/ZJqhuhR2ySs5cK1tsocggkUTWqH
	Am+TgnVo0gp8moiml2MvU74gbzvG/KG9FLNUawf1h1NzufFRoHK/Oq01sfRa0EVHa9oz73NXR30
	Q+6/9PmSGlBIL9SmPr0XUHadPYo6OTqM0JPeXA0rzu0yL8Vrmf9hh
X-Received: by 2002:a17:90b:2f8f:b0:359:8727:6448 with SMTP id 98e67ed59e1d1-359be32bbbbmr1443964a91.17.1772789627330;
        Fri, 06 Mar 2026 01:33:47 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:359:8727:6448 with SMTP id 98e67ed59e1d1-359be32bbbbmr1443947a91.17.1772789626858;
        Fri, 06 Mar 2026 01:33:46 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbcacf06sm647549a91.4.2026.03.06.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 01:33:46 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 2/3] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Fri,  6 Mar 2026 15:03:31 +0530
Message-Id: <20260306093332.4193993-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M7xA6iws c=1 sm=1 tr=0 ts=69aa9f88 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=w5lGHQi5D-TRKhmXJ3sA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5MCBTYWx0ZWRfXx9QXsdPdECAu
 NQz51zaiyav7n0xDOGIZRIXQRiK3IMmYslKQlnw5aWCc70+bmP/DXcxf5f93p+3IoWTnZG8xbaO
 qY4ni5mTg53fc+Tgb+ne/xkrp2SjnG/79NtNjLS0xEqfBuIoVP6gcE3gBXuU68TikDMYmBcBDXA
 vxFgeyCXob2n2QKvO8dC5Ot+9+LvnFmMaGEcpauyrLu1WHRurbg71xgp4kp2tcpmzmPzQS+x7L1
 NhRnHuqmC8IJvr8Vbd4eAxq2GF4GHl8jt31Naijias5V0TKC0jdeFGlmt1lQFpn5DIoTImoOpDA
 OFA/8vpB6w8tFGazv/jbODfne6EOENZnSuMV1DBOZJeqzmc6qHfuZhhuu+yMV/IKkZxGvcwqK8j
 Ka2BWrgSj/RHO7JtVnviY00f1C1QVJYnWSkbjILfhLTduUJh7Myz853UA2d1SYzB13UTYnvhja6
 97wKwZiqOwmPVGMl6rw==
X-Proofpoint-GUID: 71eH6karjweCEUo33EOhiJ8hntqPTKoW
X-Proofpoint-ORIG-GUID: 71eH6karjweCEUo33EOhiJ8hntqPTKoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060090

Add an ICE node to kodiak SoC description and enable it by adding a
phandle to the SDHC node.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800..de01a6669522 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1045,6 +1045,8 @@ sdhc_1: mmc@7c4000 {
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 
+			qcom,ice = <&sdhc_ice>;
+
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
@@ -1071,6 +1073,13 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@7c8000 {
+			compatible = "qcom,sc7280-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x007c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		gpi_dma0: dma-controller@900000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
-- 
2.34.1

