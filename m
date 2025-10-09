Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62507299A84
	for <linux-mmc@vger.kernel.org>; Thu,  9 Oct 2025 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990777; cv=none; b=eSdmEoFKsJ053zOBK+pJKjOkzpxV022mvPjh/ZmU08wfaDLUBAzfe9T0sucEr5jZTZWRq0z9p5IM7IY92KMNFZCZINZK6UZ8jP93MTkVRJoC+NxOIMr0Vxe5E8fsEDn6kBOyRFJLD7jWgV2dv4IaWzk4/ViYydRHuB1YkARMohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990777; c=relaxed/simple;
	bh=oj3ZGY6/IILJHtVhKA2pv4u2cYCEUcRJUrt5ILBWwaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pouMZoCi45qp+G4bybnsu9IFUeF58ll3JChT2WaUdawGWvCiEWZ60SvupRwKq1wL2PVaP9qWJNwxDZ00GtSrQskdVjk33iYHgF37pg7Vwn5Crzs/y4cotjKSnsT+oLPoO2ynjg6t0lIbpdQnTQnvV1IB5+TZQn9SRubCvzGHxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6vUhfmK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6vUhfmK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EUIm029325
	for <linux-mmc@vger.kernel.org>; Thu, 9 Oct 2025 06:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKq3yr9dCGurHHla7xpzo8tVBMxkbqg8w1/ZkAGSJww=; b=L6vUhfmK/kuMOSQ/
	12D51qQOvUVVgKtQvZL8CUrNFBD8aC57zU0NNY9V0jZLOh7RWd9tiY2BXUixtyxv
	Ftel022nfyjLoCfNrUZ4rAuJPq91t/GxCmxoNEeKQCRIm7mZ2Z9IR7Zp809TikfN
	kcuyMN9xTOuC3ZWxlCnjI7aXH4M1ZxMrdYrY0dXpTfjtraQKmGmK9pSXHzlBIlVw
	3Z/tEZ2rLRYHxTmykUIDhLKwzyD4uObx8yi2s+4Nfx0i1VUhH4GECTjwldOa65wt
	rYNBsnXD2iVQ7ENz+GBvsLZ2GCUj8WtlRghJT0hJBD0id/+BGYiRjek5K1F4lzvN
	enlm0Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kspxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 06:19:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b609c0f6522so1481548a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2025 23:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990775; x=1760595575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKq3yr9dCGurHHla7xpzo8tVBMxkbqg8w1/ZkAGSJww=;
        b=KuEPv6L4pzpsLfbqyYeC6y+4cdN/UDwlqa7ijgchWpUSEYQnWTPlkQOAhSioDrEQcM
         avpGxL2ZuzbroJqAmPIracx36LRfH6SqGyNmY9XKvXQgpNBxrX2RR1EffWLo0ZhRtszE
         zFeNSac9au0epbexsxQYcXhXCO8ASgGHQUEmvTSsdi/4O8U6ES9gJMP1DS22JPCTCzOP
         c+NUKUqOzy+/YjzV/PNDiDEOI/ymyVWyujDkAQAS5fsJgKOzdcVhnIh667MSl3HtQCKs
         sb32ECIrUj8Ef4IpTrGXouciOk+/DFrGVoIEoYjk9qg9PlfzMqEPQxj6daU9cyU8bYek
         CWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjKTD25JtkuYiAl2FHzBWYy5+nzEiK4Vh5YV1v4Ajh7JpPmuK0SdZHoUT0xcVfmaT+HmpualZMGqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpinPuogqT+oiUQjppJnbkVWSGnSP7LVVYEq0Hh6Fah7/JIyb6
	a6AEXiUNChEzT3rnrFy9OfKyvAPqdWjCqJRi5lf5i+uNzkk+4/nrmGw5JrqZCMBzweLhFhUYnQA
	aXD9GJwQOWmW+xn5P+ZXW46xvaSJAc0qhduoNydPhWBs4y8FI9mjtBXiqyDEzbDE=
X-Gm-Gg: ASbGnctBOe/TPS9l2o39tErKFew8cdYnzPIXi2UQ+7h9Po1BnbAWfeHckDzjryjwx/B
	Ioi19GIOCL4V5xbwwNYyvFtPSrsUlMswFZazDxX7Pjxi0niEcku056fdSJOufleUCMGeBrQhLPk
	IemKwZgiJm99BX7UhTT1fI8UGDdaqgR5EdUNgcjD947vECfIv92Mj0nPkG3YEobbNAlctzRPWZ6
	pZ5LBZe43T97V+tP369Vu8WK7mGMM5mQu7wWMzvOBJ4MNZEBAGnYp3vh+e8dEz1wj0+6M15yUlL
	BfvCTMiD+YLtQQvyaf1gEEC1N28QVDfBaRlNQ8gv7rVruX37FWzyQxX0HtZehBAd1m97t4bZUhd
	UpuPiTuY=
X-Received: by 2002:a05:6a20:1611:b0:2fc:d558:78a6 with SMTP id adf61e73a8af0-32da84ed6b9mr8614518637.60.1759990774875;
        Wed, 08 Oct 2025 23:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkgqFYMmy2IRS7a6u6Iwn0slDhgJRib+1JAT43YjU6dOCmUekP/T+l8jn1xHIvBWMdRcySFg==
X-Received: by 2002:a05:6a20:1611:b0:2fc:d558:78a6 with SMTP id adf61e73a8af0-32da84ed6b9mr8614477637.60.1759990774374;
        Wed, 08 Oct 2025 23:19:34 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:34 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 11:48:55 +0530
Subject: [PATCH 5/5] dts: qcom: qcs615-ride: Enable ice ufs and emmc
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-5-2a34d8d03c72@oss.qualcomm.com>
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5SBzHLi7JTcO
 mZoY6YVSCpen+aCCUdpTS5qiePBEJaQSKAfCM3Iqsm4wp5utjForIGZrGdtHVDjHT+TszypMsSM
 1NYI2YvkID1Rrz0JQSUEGLp2r4bDBZSODu5G7cBlO8rgAtLw7XAkX5qqlDRtgWJG5YpmL/vgzSV
 lTw5jM1Ub+f8O5EpXL1M0lroYqleolXmeYWrTVWkymsf77zO+Zpx5aVUop2bGZteAFdHudmcOku
 SPZdk2KMpzLE3imbsZGXAFYY8r8N2x8F4io1xPhYvPsmtpAIGSBa+49TKu3IPlKePL7SsAzasWc
 E7O4EJt0yyOorqTp0fxStx3KXmxumskXPWxMtK8lOAw7h6yvhajx5CAVKndprT5aMUnGxFTkFZG
 LXsX6Z7yh0MY3rKWGPkjoUnhf4k6gg==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e753f7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=FZPswq4iDIBThNNNJiIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: d3b-aYwhnRf2GFbRVGWk3UTz6f6xzT--
X-Proofpoint-ORIG-GUID: d3b-aYwhnRf2GFbRVGWk3UTz6f6xzT--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Enable ICE UFS and eMMC for QCS615-ride platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 705ea71b07a10aea82b5789e8ab9f757683f678a..6e80951c4159fd1fee2f737e0b271a9abaf82a49 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -288,6 +288,14 @@ vreg_l17a: ldo17 {
 	};
 };
 
+&ice {
+	status = "okay";
+};
+
+&ice_mmc {
+	status = "okay";
+};
+
 &pcie {
 	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;

-- 
2.34.1

