Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B530ACEA
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219002; cv=none; b=UXdcBudE8d2OiZ4UtPpxWO16KeoJ98sBPdDv/VNQQft7Bn1KK1nOGUQpudMl3p1py2QMlXtENE6PTXrV+gy7rACq/KwL4qjxSN9KOUG4h/YJn9ZPbaxiSyw6m5mIwTntM2/gDK5BmF2dlsswjr1HqLXwJxN3YM7qHngh6W8vLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219002; c=relaxed/simple;
	bh=hd0CoMo58CAUzr+VqJ+RAeH8nis97OD0oQjfGlLV2Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2GZZIIC8Z5W6hGHL3AdQ5arNEQtbdkOiJXQdPgGy5D8GdqfzJ9TblysJAn4BIB914KScHpVGrkb3QRiW6K5Fi44bvwrJ9VIQQ2D9TYavMzpVK7CizFzaE5zx1KMOLVd9F2P8cs+JpikIixhG19bU05B/K3fncYzSK43h+ridc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhq5tgn0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhq5tgn0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N75wBQ028844
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fR2JDFO0Mtu
	aMMk5vsO3PZEznusuCLxw5SSeKXZkFr0=; b=hhq5tgn0qZnnv4cXLZHGCmYzHg+
	+b+OgLayWgJSb7LgMITUGIWgHmV8MvxU3+pBC/FzFolZxvX34HQtK3mknRYPLAAY
	oYDQOfT7GjzZutZyv09Waap5meyrt67wc/qobDkoLT65fgmhfyJlDmo3tNp2HJ2Y
	QCDxCWiGcwo/UmG1ggmzhDMdRw1HUpxWVZlUR1d+KLzc3rS+u/SS/QUzMdy4K1/D
	eWdcT5dlc04lRyVly7dn1M97mLqP9bnhwdSMVO9M5aiINQ9dOKebT5fzZ6ySBLxu
	TTtV9QeiLgxMsQqfLpcyZL1S2u0ID2PNrtEVnSthWo1vSN5eooNI6q/aFcA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wdurb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:30:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290950e7b1bso1513805ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 04:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218999; x=1761823799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR2JDFO0MtuaMMk5vsO3PZEznusuCLxw5SSeKXZkFr0=;
        b=KDUOXx7oWpTFflNPQh6j73ib4efohcITZbo2296QhMYeEVsSptBGI5te2uF1n0u/nN
         lulh0KrOT8mxHeynoqP3TEqNI4qdUdJH0zM5VQu2uTAExq5l6Rssyk2rTEuY7Y2hDIf0
         y405czKoRAyaH3yzowmpzjhPVOnx5euMBdBospxUGPgX0IUUdYJ2dCn5cdCDLrODJfmb
         hxW4nqFeKDfEKKi5Jt8b0HRi4p1TVL0GtXtgQaGBU8xCp8jcKjnJEe/sXqJg1H0TOAHD
         yco7kwNOByc3SsRx9Kqyf5TWosZSimna4GHffMcXAnGuVy/2cfU/4CZ95xVgeCUTtn4b
         g/VQ==
X-Gm-Message-State: AOJu0YzWbecAf9UijnaeoT4KZAgS8hxJEn6bfT7oZpsnOuqrEOhOYRWY
	4lb9dfzjlcYTuE9ELe4dqKaoiBDIr0mXBSz8qnoeD8LYRYM13d5p9e98Ep/GWcGx2PfZgYX3DiW
	tkmr+JzyFbpp0DmDG0EX9W0umGe2OHVCZRNYNoLLRQAe/xyhgNKdZIDbrnB6M7/45gmgN/w==
X-Gm-Gg: ASbGncvTICX/7AGuBt5Y3BNhg5tL5t45gQRF5KH9atMiMyqA8g9/GSP7o85MH+Mb6OG
	smTXqYkIpSEtYPaLyJTilvdw/2LljSQf+s2wbAZ0GAZeugAsUKl6iB5x2l0ABczIxRBxO0riZhT
	cxMA2lU0yshVZCTY8fyJ0g5XeaV5o6WaVHgaWdV6IrKV2EaueLv8hZvJT/CZkOB2lf6FKDM708x
	K3gh6LqUsjL5WWxP2BOGOnDlza6pgLZ+HpLm0UAA/1Xe7oE2MfurIrUfwD3U1y0oL68jPMBozQz
	Ozfae6uxTp97BeOyUCMvuC2W5knOt+BQCEuHmgxqsNUdLW0e6NIh4iM0kc+AHSBIpYJHvo88deE
	JIgxLIC7sJ7BMVqiFvN40QKOOjbkoSw==
X-Received: by 2002:a17:903:1746:b0:25c:9c28:b425 with SMTP id d9443c01a7336-292d3fe2f79mr65295065ad.11.1761218999178;
        Thu, 23 Oct 2025 04:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuXQI9VRXhnQMSIZ4xgGvAhDSywgxIFMeOu/zYuaXfGqNrmw1i1qi4dhUipSl7+nHiLMY6pw==
X-Received: by 2002:a17:903:1746:b0:25c:9c28:b425 with SMTP id d9443c01a7336-292d3fe2f79mr65294885ad.11.1761218998716;
        Thu, 23 Oct 2025 04:29:58 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:57 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
Date: Thu, 23 Oct 2025 16:59:23 +0530
Message-Id: <20251023112924.1073811-4-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O5_tc0dQo5TDAkj77ghbdsYqVO2RTtJb
X-Proofpoint-GUID: O5_tc0dQo5TDAkj77ghbdsYqVO2RTtJb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX+T2nBShPbLl4
 h6WkpzELZNjJF1MJt+Z3marJiK0WQ0jF8CaTW8senMEKaWyAjBPbCANkWN+CqKsqvbCyTPTNKnq
 2MzVRIiF95KhRNCsWdg2ae2RoD2rIarqnBVJy8+0iGYPINGcHkv9m/9K+QHkXZvUMw3dY2wFfnf
 6qu5oLwTlTNeKFGokPb6wHlP8V4chOHelL1d5ZFk/xjpkBmrBFuh9+Je/OM37Wddv6wDfVA+K7p
 4F6aLnaye/k/5hjDYaDuL00Va2/K05D4YyX4VLA/azuQ0TyBFZ7Zwbnm4hlryW0Q1Cnfjztn86u
 sprcAFXzAgC607dT9QRB+K+n39tfltlSAhuwCLh5T0jzs5LfpL5TyTE0txE82Fu3Hd8SojkVMx3
 pDCLdwZGBmLJ+LgpaoSIzEaIIPC9pg==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68fa11b8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=QH13294MLfywbrI7NfsA:9 a=zgiPjhLxNE0A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

Enable SD Card host controller for sm8750 mtp board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..a8727d353b46 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1030,6 +1030,22 @@ &remoteproc_mpss {
 	status = "fail";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>;
+	pinctrl-1 = <&sdc2_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
-- 
2.34.1

