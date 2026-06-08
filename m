Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39E27FB37
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955346; cv=none; b=hJpVC6CBRqTKJ1LWbw6LRTSTnHV9FWYvSbdGvsHwX6+kXlyG+5+ievWCCAeGzvlZKPkSr7VE7rKo+ZOntjSkVlkASLvSB4G8in1He+S9AxgyE2esgEjbo2tH8w8mbEoaaxKrdpwbZ9839xrknB18pRWFu1ywyoJ65RkMeMFNWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955346; c=relaxed/simple;
	bh=HPJrgV/WvcC5J528dV3QG/rkJGKe1vbeM4CVOkeyLQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6nnE7Qzt43zF0rgFW0c165EpleXPsxpDqfWS3N6YSdpVKt0sS0FHizOg83ZTLyl2pVWaNK0fr2tK5ndvfpHaTzru98lqxN9ElL+W9/4tjhoZwhVIRhk2k032P+UCTNlebhEumVMDrApHNAuoLbADehmBwU/I9zXI3LQ4yKQwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X8jCRgHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Br35f+n+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X8jCRgHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Br35f+n+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Iv50K4090730
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 21:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yZGKQDFpwwqtyl5XA4nQYM3xUM5ByH30DMsiQvsyHU=; b=X8jCRgHZIB8BQlHv
	tsgXVsM4F/b2XgA6J+HCyya8k9fMZY58SltTJcpVAu6St/lCCejq5dN8BlV4fAS2
	S/JRSUoRwfWjwbUQYfhnSL/XlP67jB0I6NN470qo4l/ph9x4A7p7CtWoqvLSooLK
	2xx7+JaO8gp0OvRcQMWKj+S2UTdkRUeyUmUaIMp4rT9IGDRjcfJPH4G+tRZilJPA
	wS1MsU8xxoiJG/UEUJfjs1mLn0mbJYfQgB5ih1FHj8nqx6swUz9DBEJtzmHk8mZq
	5YWPiTgm3T3lebChmoq3GgUm7USfY3JpPAgBqzyjcx1eg3qRuoO0/Y10/IZbAcik
	FeuEpQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envajauhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 21:49:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a298cd62so3114677a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780955344; x=1781560144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yZGKQDFpwwqtyl5XA4nQYM3xUM5ByH30DMsiQvsyHU=;
        b=Br35f+n+2wqMv6HwBFzFndeXCQHesVKuaXZZ6XuyO/8Wmu+CN8K6Izm0LMtO1bhvJZ
         v6dNuHbR2GSM1mABh21axmkZeH0OvVkXaN1jx0v5XkHljIhBKwnwtMQkWHFMVhPkTn4I
         Dsy9RFUZIh/yJCo8OWwgOJ+6lqw2eQpsVjE6Q4gu+LldA9ffl1rWp7JvBx71fERmf8XL
         GvHk7KXTS6bC0tR+pw+8UwYT790TXAmp6JLfERKaZQjwfTHfPJjgP190X/07aoL4lqCX
         5wIVv1nQR1UOJnp9LKpLhtp93W/wbAxbbrhQ8iBCtvOcQxy0DVOjrIapjn1+yRoCuoFU
         +uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955344; x=1781560144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5yZGKQDFpwwqtyl5XA4nQYM3xUM5ByH30DMsiQvsyHU=;
        b=gNWU0Fk+kMyClL+bjf84YsBz7FQaFJZHGti7LH2DQliuwo2oYlFqNDcfnGYZAe7GP+
         ybJnatN/Dn4rMUt63cCl1Xu6ZjzLG2woJEriv8u1H+OO8Ii2KOl/i/kP5limjbpk6eEX
         xOPXNI/6pu6wfeL9w8+BihhT4qdEcwuIPf4tabcCTd/zmTfyxSCAx/Ai+6SjxjyLTt8Q
         DblPl2f66lhbK9/Weu/KP4wm78sk+ergppxBJ3ZC+59XLzdRbKp3xdPUeySQtrYH6mJY
         FRUryS0HgpFonhcggy3MoizZkpj08LiHUVd5ZzPLrcj4DWZWIDCltZW8EMP0xwoBBRPw
         ACWg==
X-Forwarded-Encrypted: i=1; AFNElJ+Q9od1IXhuqeFOWmvAx7Dd5EfbOiPVr46r2TAzTOvRqNSUuzcNEwphrF7NNIuGVYklYd3Qzw34lAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6pbWA0hJo+XJHEoXymfsR79ViFD+NYPSOIPQYKgSdaxjfLa2
	npvs6ifzrWpNnbnWUxcpEGAfSBxbt5FcFoQO/4RbjZ5SJHn+i0VnNAo3Vivz5bDidNgvrE6LySp
	tsZNS5EP6P6tuN5PEnzwvzXU4klzso3cywu/BTn0Kqwkor3ZT/IrwlluKD/lozmA=
X-Gm-Gg: Acq92OGq0r0AKXiYkOFH0XFqgGwxXNXP66Bt6/YqnYrliPS3dgd7KcFUaEHUkBcrltG
	8VXWd8qtzHeZ7a1sT339zkX5K4uxOQoGe9C/vY43sHL9GvFLuqeyl9QOwhMNqxJEe7p67veN9yh
	hxKhNh88htp+WfVltUjnE5Npd8BxgSFh+7o29F8fBWSrLiRXfS8FdrmLA18JIgYPq7P3xz5Hr4l
	1yvyu7TgWK3KYwq1LHifnL8ejTXsYZU/WGRBBJFS0YSpwsrleRJ4ueQ93JwfOgYZYtmUXeXaWuB
	LkQ0wcbJds3xt2eXN3rwf/YVJqxL1AKqwSDeZDxelITQcTd4wNfX25Wjb3aS9pC9htaONDeGmMG
	0Hbg24o1hR9Tcc1gyBjI4NAw12KBAjt5NnDzqci0N1HAwsCFbdtXo+auGOYBIsJxqs1R1Pw==
X-Received: by 2002:a05:6a00:10c5:b0:842:3aee:12c2 with SMTP id d2e1a72fcca58-842b0e661e5mr16882663b3a.18.1780955343665;
        Mon, 08 Jun 2026 14:49:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c5:b0:842:3aee:12c2 with SMTP id d2e1a72fcca58-842b0e661e5mr16882639b3a.18.1780955343219;
        Mon, 08 Jun 2026 14:49:03 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm19607485b3a.40.2026.06.08.14.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:49:02 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 03:17:28 +0530
Subject: [PATCH v11 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enable-ice-clock-scaling-v11-6-1cebc8b3275b@oss.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Sl8Srz0JFvaeqgKkFG2vcU4VjCE8EvFE
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a2738d0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ASeq7m8wwX9lxpDCPrQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Sl8Srz0JFvaeqgKkFG2vcU4VjCE8EvFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE5OSBTYWx0ZWRfX5jHrJ1/EFvsT
 a5rWmBch3iFuJB5TkyUpSnsclAGXFLbKzIczC+oFmBOoAVPpxeVjZUUKEEBWTR8AMZWaLP3kqaa
 RvuMS+VvkbHwLYTh5QFyJVJ9+DsDvWg7r3YnjyF7AlDrQ1Y7A+SA1Y9RClZXJviuVW5BECHaI6Q
 f8VUrSugoiMjbCIXDlHiDt9hopx+A0NE5zfxUjxmg3apK5pg8XQjr85UeKwGOW7Wg3vpv1aCcxx
 iOFg8ZltVQDVS3blsu+KB8q9LifAtdTd7GGNNLydz+p9O3FYbNOHIlWdNkVOs+6LBcR/dOVnreD
 QK5g/t6NWj5dXxZbFIGXifgOlZ/DaAdT/n1A27Lmsu4Lvy6hWVqRh491v3HIc7GCYwOff3jDXHH
 2rtcFWpzOmUW8petW9XmyK6eNOefutx2R0FpCmR+j05Hc55cV8gjx3QJPHA+vLSeSw600WXKQGF
 Q6xzdzS8swK2NZ/MfZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080199

Qualcomm Inline Crypto Engine (ICE) platform driver now supports
an optional OPP-table.

Add OPP-table for ICE UFS device nodes for LeMans platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 353a6e6fd3acb22ef228bee340212b8b2c300957..f100d706edde465730873702f0b0a00b44050c23 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3109,6 +3109,32 @@ ice: crypto@1d88000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			operating-points-v2 = <&ice_opp_table>;
+
+			ice_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-75000000 {
+					opp-hz = /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-150000000 {
+					opp-hz = /bits/ 64 <150000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+
+				opp-600000000 {
+					opp-hz = /bits/ 64 <600000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		cryptobam: dma-controller@1dc4000 {

-- 
2.34.1

