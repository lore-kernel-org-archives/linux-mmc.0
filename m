Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487C3B388A
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514507; cv=none; b=DeA7pmBGkARGznnYZ+n76Gktuv/ni6qn9MPWwpwCoR+ZOktp/oUHvvpry4otH5DjcKiEX2e193WMomo4UKRz4uw49NqCdvF9Nn7sTHq5R4vj+1DQO/wWRnKec4Nm7/YiD16jrpvmQj8sajEQI5TLw6YpmdPTM+b6fJ6yBROS/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514507; c=relaxed/simple;
	bh=sSu1rmCbKklvuYL8pG9B62fBY+5STvRKxD0ZbLLROYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Blzj6zKii7t509Cu8F9dBKUz+Du9ELYWjS05FZR9zKFEkl7T8vuYHF4ujYPbl7cJlDP7fiCvUiwxx3qwaf6FQaXsynAIzGqTX9GcLdxQHDv6kXK14NvRLa+N2NZaW846Cbs4duzM2bwe4MeYUX2hqlGqt1AzAIWoe52biCK2ciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e04guieL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVUIeKwG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e04guieL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVUIeKwG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NG7iHP4134105
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KGCfN3Etp4rNqYD8yfNNQic/5RsW0siFclTSIyKyGb8=; b=e04guieLGXwXmUqH
	X9WHo+oZfM4/1n1iLsPw8MFqIVhoJSQom83V0WKOS4hEEGilZ+T4MnlnQ1xFo8FR
	2n2zt00MLW5GZG0p8+uLRa2PDmY870NCx5m/ZjQLSvDZiUzWxA2PupB8VPaAic8o
	C3p5WLX3olBLXMbJmeuO/PWcABv7eZvq2mgiJirDcxd1Gqx9aNJI1nzYbAsdyR7M
	Ecd2/HZGIPM4N8dTTrgvp2FFQSt5v6KC+InV41XXDZT5gDfeoGnhup/qGwea64s5
	lZfDqSmF3bP9NDFE33sai3jM7apk3bRddY5A1qSctSVHM+rA0gUN/JMPUmPg4sFp
	bN/M4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7456vfrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cd01a14e81so35648605ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787514502; x=1788119302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGCfN3Etp4rNqYD8yfNNQic/5RsW0siFclTSIyKyGb8=;
        b=bVUIeKwG/wNMHCNq4g18tr77As0fv/yJszRRUNBIyQFt4kJaCLriiBzJUaTOLVnHYq
         A+pz9RbFAekQVX6YV2AyTMwfqK62O6OK2yUauL46NyCFyc7pPgh1KEGAXxptQ2HcF2sr
         0O6vttVPM+zJEG+j4rWJPiQEywHDnk9nxuILN3+JNJ9L2cHMThQoMUYF3kxjiAxWnDtB
         zgLnJtI/UfOvNN/MAk7Y7Z9NsVLC8pN/hZidguckw+xGUJUziI9rp+R9TbGOk9WWvkih
         Wys93OKUvubfrUtTR5mlFq8FaQbBuuNWS8PKWMTqh2OEM+LIYJMEA9cB1LwSptXFjc1U
         kDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514502; x=1788119302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGCfN3Etp4rNqYD8yfNNQic/5RsW0siFclTSIyKyGb8=;
        b=NqU0xfo0ugxScXFFwJZio3ZqluERCTxmT8tZxPc8x0Yk+qRkAey9EPSmMXeiNvlGR0
         rKISyM5us+ooP0FjnLbYtMEmhj4ixRPBfcl0a3FRH9PyL34HZmpdBixShBuXYYUCvz4y
         /SXUXUbXDDE0uApcruMua2YJC2ofuZf2aTDdxDMMjZnGq0vhU13oJhmr23HC7Stc7g5k
         VjKWZzHQUSfTWutcLTCRgGeEJW0p79AIWY2f72/7CD/WaAQCEi3Xmn8gYU+3wQh3JjTf
         6rmw7jwN8G3otmOp+zRJatVFvvgGSPWzNR+dUpToUb4nDhH+uun+yn9aAeKBn1bXkT3M
         Etmg==
X-Forwarded-Encrypted: i=1; AHgh+Rpdy1Dxn1IFzKBz1UKRv+h5vYNY73CGXaNagRAhF5pIjE7hS2ICrFmr3Nf2B6Vb2T0e3VBhClGSqm8=@vger.kernel.org
X-Gm-Message-State: AFuF++nbZrvJB5fLDiBWpJ6ZA4LAZCZ1hhxSKtDhYS6oBUave8Q0eenX
	M8NytndrRBB+rWjzvn5850yM+i+JkesyPOCEMt3eErgjOFYDE1FRh+57ETavG5+P6x7QqjIVtxL
	93M7BiXg1zjMI+3yW8vszBH9BvqU8kdu2DBJzVxsxDVdGqKAwuj/p8mdkzEGw3D0=
X-Gm-Gg: AR+sD11I1wUwguBzBkFAjGvLsuYN8HLb3wDt0muFgTjR8CW0BKaU/NrWGvuAUHFiKF2
	EL8Efy4GKM5KDtiOgZVxSTsdTZ7iDnlWF7BzT5ZWwzqnEUANsvnO2v0i1Is8M2MO7HuLanUrQm4
	rOSodDr9KeOB+/6p0xnC1iKtFr0/kgmKJteORtV55hgdZad9l1XY8PfeHNFYlErrAZlBFljlMR3
	OGwo0IYbEqoG3PcdVTr/qo2Np6wSYX4nhqXxn0623VY0vauKJ56t+yr0fufEvn5k9KuiqYBBexk
	kQfZRsEdleGOIghlyFTROVfxSQtAMKDDsJqyG9o6fAZioppD/SsohFDshemU/3Uh87a4cUxjBKI
	k7LMyNWYpE834Lj70dCL8d8GDm2Nb3GZoNmwrDw==
X-Received: by 2002:a17:903:fa6:b0:2d6:5beb:8692 with SMTP id d9443c01a7336-2d670bb5042mr259791985ad.6.1787514502442;
        Sun, 23 Aug 2026 12:48:22 -0700 (PDT)
X-Received: by 2002:a17:903:fa6:b0:2d6:5beb:8692 with SMTP id d9443c01a7336-2d670bb5042mr259791475ad.6.1787514502043;
        Sun, 23 Aug 2026 12:48:22 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f925190fsm32321623eec.31.2026.08.23.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:48:21 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 01:17:43 +0530
Subject: [PATCH v12 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-enable-ice-clock-scaling-v12-6-09271f583dc6@oss.qualcomm.com>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfXwDRddR6m24eH
 I2JsBNZ29rXsUHxQIPqCX9E5hLxvqpamkmbpfiOoDaIpBtEDF6BNiw0HxGyPCNHuQkuIHlU+Dn1
 CB1D6oFY0JUOg/LEZHCBTqNDw3541J8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfXyIAsSQnldfS7
 fX6vGx5CRsrrqliHDfky295nKiId67XXsiV40e8wyvkg1AlWNm1XZhsi8RUWOu5G3MhWbAkqjuT
 7Ng1PwV7yJKcN4MuC7aUjegHmFFn7f1O2jZDCyGpng8poE0KZhZp1KyfpeLnrz95SP2vnZrNjj5
 m/SOVCc/maMlysClimPPN7h16jZPK76kOcUyrgGWROvV9Rjzfhhr1Fs6c5q7teV3/Fl9eYufjK9
 F1W1FswjZLbn5iKxS5Iczyu8ONMoTqfan2huT7paJlcw+B2UQHxBIulgNWSpeTD6dR6hxgPIsD9
 wtHCB+ooDVKSCpR8FN4rI/3s7FisjwkMWblWO8IMoc61zVy2M1YYUWWhn45nSYzNXKPgTcC9+1l
 GuchJlTKgpBkyQfwvN6v7L12hVMrNuAs++YCSyJGiTABxKvLwPzXX11gh5NG/Bgt1YpKe6VSt2U
 BeLdTC8xygRYUB/Ss/A==
X-Authority-Analysis: v=2.4 cv=RtL16imK c=1 sm=1 tr=0 ts=6a8b4e87 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ASeq7m8wwX9lxpDCPrQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: vW_Njwm0Kss_WVSMrbjfYtU3YVK8JJGw
X-Proofpoint-GUID: vW_Njwm0Kss_WVSMrbjfYtU3YVK8JJGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230181

Qualcomm Inline Crypto Engine (ICE) platform driver now supports
an optional OPP-table.

Add OPP-table for ICE UFS device nodes for LeMans platform.

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index a10322c5bc35754042640d56ecb556a5ed5cf281..40d13ba5f785bc712b511870b94cfa9c6518c19f 100644
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

