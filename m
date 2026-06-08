Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2D339863
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 04:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892228; cv=none; b=apeMhv7UV6uBdE6lcwvKqHOdhDEbPsTthTMOAZXXg30t7ykayL5W70AMQZlcDqpivE0bkN+CNO1TUNiPxJ9Kaf4e3akebo3NJ1tCaPYP80AwJqcL3EBE/RU93TOHchb0HhyvMGIaDJLgvtWtkfepuv3pLxAUQW3LNQCsceR4F6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892228; c=relaxed/simple;
	bh=MCcqXNt2n0euHaDJc19sj/EY2WjrYERxojbBmZwrnz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apNEmMeEpcqJcKqFyP17o6w5is8SoUaQ48lhgPTzPHS7rSGkggy++FRYuXQuFG5e9y50SlfsjlHiygyFpyK3ZuesDdueNF01vB7vq6EBf4u/e50DMud9Jy7Y0xynIauDvID2A0gXgFZAu/IiwaPL2nJ5H9fwxakNPFUDx+0WflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HuQV3Msk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HFJZA6MT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HuQV3Msk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HFJZA6MT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580GHFV2027023
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 04:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ItE2f5PKRt8
	N96ODMu49l60SVUvyhZLe22byazxGBMQ=; b=HuQV3Msk7oWEXoJWZSFq2Zn+vgF
	4lrQk6Cr08ZyI2ADtt3eS2SuhRM53fFebdWlR5xp7OEeVsbQm2hrQ1q9LlyZZCVT
	RYrHfDiVw6lSo13TuMHVubh8BEVAOwLwhOgLbhyvAYixcI46Dy2k+UxrwvQJjon1
	gYv4vmEedMPVKc8Qxr5xdAoSzM3Vz5vz3HJHR/L1bKWbk8+D9fVgTvPMXExbe41h
	WQiaQK4VbiRzjwSnt3CrT5exD1mfpM4etOC0WBDOk5OVoK8zH+QUtuEzl7Fd+vMk
	0IzPUChiP0qCHgvPRobgUpj5zhw1DMOZBxYUm1PlVbvolEsm0tEUgME6Q2w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4x268-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 04:17:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so4457880a91.3
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jun 2026 21:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780892225; x=1781497025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItE2f5PKRt8N96ODMu49l60SVUvyhZLe22byazxGBMQ=;
        b=HFJZA6MT12akI2XX4Mal0CjqMeKw/St3jsE2PM6fS4pVQr6tCiFQM3PW0sqJNJTIM2
         HXOM6izlpG8/CFwvHW8giPzD7PBaXNkpKDFsq6ESEG1sOnE/K3Et2uxJINmMJTKpqcnr
         pI7BrGPfcvnfDndhTxzDwJvWkLL5LH4ddvHqCpPwmIEqWMSUtI/5JSNxxt+8Le/5tYGN
         LUY1OkMlJzvDU9edJ5fjv+vY3X8VUaQTEbOJcrx6JsaLm/jXBQpLwIf3DaddD/1K6d7i
         caV6S7ivR/nRXN3bYVMZK6rueG3rHLS0BkvWIuY27D/vn9GziIZo/uAwS1OW5ss0SCKm
         hUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780892225; x=1781497025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItE2f5PKRt8N96ODMu49l60SVUvyhZLe22byazxGBMQ=;
        b=SWb5rTQYGCLXLKtcAfI/JKfr+XFGIWqgF+axhWKZmI3xcIorTHZPhbcNaKhGTCj4EJ
         N4ENGHepyx5cHMB64UcB4i2PMIGGc+JE5JM+ZU4ETfkevBeo8DG6zJk6had5saPVGMqY
         kpmiSa+RMEcfCKeS7Kg74Fj2wcOZ4JnmAwH0UN4gNCnlh36Mi9x/BlAPnRrK5Fr/RgQG
         0Z+c2WAUkDm0aVktIGVTsmN7cBRkR9RzaCqimG29iCPMojWUXJOSSfkQYdQZejLowefd
         QwaHhJr0R0erSlp2SfqrVk/YdzhUj79aWF4AcRVhxwcmUf1M2j9CKJotiwrUXLMRewvP
         t1rw==
X-Gm-Message-State: AOJu0Yy4QJvnbE96m0Q5ScAGMR3WMWCoMPpLy1SDPVQIl1Sn5SSkFVHJ
	EpM+HHShAJGEzc5oQljbKOXMuaC4mcv43tfW2dgF+pXuaSgh3Nr1Lpa4vBwSBnccGp+czXdZq57
	9bRHcT1MVKZ0uUs+cBxnkoA/mmaJgkNaspvxf/hUfZbzP6rOsrS8rQHCdcfi41Dc=
X-Gm-Gg: Acq92OEzywwuPqatRvVihEuWBYvxPqo9YxDw+oWmhi3NQzLrelYg/K+/gTSnaUPTCYg
	+ExjX6xQLiHxsp1wOMuskwChP2oQuAG5F1B5OJm0J/ax039M3zXi7Y/GBspBpEaMPPC2IgkRmLG
	OfkR84H0E3HljxweRgAUkHs6Shnyyye6nsNKbaekId2br6I0qhSHf3KgFfeb2bvNMxMf2WQCTak
	fDsRhAy+Wsr/fJarzJhIgUcHmfipWGeej8AyloBwQDht5BqOltAp5aKYMEghvsc4pYYx1hmtXgU
	hh4WemhT8IbwyJkRK5JecBXWctGU8VnkfG9hSE5guTgRREXLvlPPeA2DDfsIE5OPxBqRApn0wT3
	b4jAbyUJoX4gZO4HCi54J+vf/nPr3MNQ4FiXjZtGuCw0hxxpl21+fzYm/IqHchsE=
X-Received: by 2002:a17:902:fc46:b0:2bf:2188:a90f with SMTP id d9443c01a7336-2c1e85c5ae8mr150540155ad.32.1780892225338;
        Sun, 07 Jun 2026 21:17:05 -0700 (PDT)
X-Received: by 2002:a17:902:fc46:b0:2bf:2188:a90f with SMTP id d9443c01a7336-2c1e85c5ae8mr150539765ad.32.1780892224909;
        Sun, 07 Jun 2026 21:17:04 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fcdfsm209392525ad.78.2026.06.07.21.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 21:17:04 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v7 2/3] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Mon,  8 Jun 2026 09:46:49 +0530
Message-Id: <20260608041650.541502-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ky3wOJBORf3tlbl2VP8OD7HXDNBASMqG
X-Proofpoint-GUID: Ky3wOJBORf3tlbl2VP8OD7HXDNBASMqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzNCBTYWx0ZWRfX34btRqHLyvvD
 6dFRgGg5UuvE1g+OkrXX/MtOdpaz6B+JP7GCWTdf1JTR/joQqYUxl25dxQ3RNh0bWYnxULrsmlk
 FeczoHWISDecQCv7dxUN028GkWmf5s/8ftPu+ogR91a4J5MQ8ldBHPH5KZVb57zkSvsR+8S4T5P
 +rb56xUHcjI8ri4Bc3Kj7dFyiVw70xPR5Rc55r5MBEUyNPHOsFOjI8TJRas1uHrtq18pMehQLPL
 tRN7W00Yh7jyaAGyJor7USkIvn3n/XX4cxle+mKCS9PfomInHFCMtYYnVcRXhh34YrM/smnX0UM
 WiaCdw2/r9YjA2GcjiZj6qrfzg1Zg7pQucnvC8R5l3+YygVE96GCGMRUZypBjX3z8lXSOsULDki
 yDuH5Vti14+LlMzDy8Hxl/0cxJ7nhAZzLGsrl+Llw3UALMuf1Mc2VgqMiupaNHe6nuyXm7+SU5s
 rnDw7qSvEANYA6mYPTw==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a264242 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CUYPcHLqniwTzHo6yF8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080034

Add an ICE node to kodiak SoC description and enable it by adding a
phandle to the SDHC node.

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260310113557.348502-3-neeraj.soni@oss.qualcomm.com
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615..caf4ec9cf9fc 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1050,6 +1050,8 @@ sdhc_1: mmc@7c4000 {
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 
+			qcom,ice = <&sdhc_ice>;
+
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
@@ -1076,6 +1078,13 @@ opp-384000000 {
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

