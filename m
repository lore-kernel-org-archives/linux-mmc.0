Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980554963D4
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921649; cv=none; b=gqZd71tKGVBM7XoDgKGC6tm3w22BAXHIAqMmdky9z2Oz+YEQVmySs73gHz3adVEo6nB+WWz9aklS+bwi+2Wfo1il/kAWt/W9UIBgzCy+E3fPyaKmlvL5TatdHSgmTqK9crdyw7TDOY1qkAOtT6f6/+BLALWh4T4UAgP3Qb/z2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921649; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bX+N1vjgBVccrQLL6D0wL91Z2vnDH2W6qaHe6bsHepDmVDF3Ba3iKig9kHEGKLTfgczjVt1ICxaypNm5FGZl6uNUV2S882UqzZlCYny0As0jy8Nl5AKP/z1l/utvu5dykxdxqI6nAuq3d46xi5EzYG6bYhLHD+6b6Z6FJhblcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nI3M/mnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kL8aV5wZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nI3M/mnS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kL8aV5wZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoeUq1548161
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 16:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=nI3M/mnSsplZXCvM
	E/yYWLSoIqVEdpGFBU5EwH/Gviv1hba+cB9tv/LWQc6yso+5yoIZl1/xERs98BVh
	sUlqRQWuUucfPwKyfl23pfghMzXqv9lYjjWJiAJlyLjAek/1pPn7EwsvDnP2KnMn
	aMGOlhKXkir+AMRgLkTzqcIl4N7QIjfUmZRiHs4qNQJZBFxExtThHLQ0YwH8Xc/8
	HseoertmTvfR5JrtSYZysP7IrkkfEcR6FYBk9RoiEfuCccjqN9ugmqnuryXBXknT
	oHIwJnvbojDg7qcYZGPfmki5GpS8DwHb7PMycCUrRljDrLi7zNo0MsCqNOVSHcH2
	K+DsXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy3n3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 16:00:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e52306621so81796285a.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921644; x=1783526444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=kL8aV5wZQ75DbDd/KhPDeeDcNsFqRkCQKKF/7S8gT6sozYcodal/6N4+QrkwLBS/Cz
         Rl+9UBBguntxERTTfz1adO3iYQUsnafEzgevBqNEkJqhXciEjKleaaaBwu2fIq/qSRPn
         FLA2HukOvCBRJ7jhGZWEg5rH30NRHGI8MoDCtMeZ1Ru4J29I2P4DXqMZf9YrIUOi1ffP
         iy6q2Gg+Dhf1DwbLPuqoSUukEo4aS7jJRqvY2J66r3iyndIQfizE4+ZCMi77rqEib8UJ
         vUqf9YyiU9tCcyNlJZEUe6u95bCjuI2sPob8VH5NGIDkRJygT4XHStBkgiOYyiZeZ9co
         fLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921644; x=1783526444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=Sa5AiZc7EZA4kx73rPdGwyA57wlzpFyjm8FqrETeX+ZnnPGLjXbdgEFxQ5DelcD4hY
         ITOq6cmKBFy58Ly55Q3tjlGDH/zIM84Xnoe9DvKhT4IPnIfr4HtDj8U02dSEiVW0kGi8
         vZmRqOuxW2DQ0g8LgZaDDH19S+gHHx5Byhty8JBfcCt2spiZ+7+EqNVWYx1fLWjlyGXz
         Ylry8MXfm+c4SHAdM/ba3sZY018tk/tFe7hYQSJ7UbuVgkyBHGhG8ROei2FoL+p6KurS
         cNZmKIH2qII9eAM8ml4hqBgYhXvZNKdj2mSRH4k3DfsxFnre/x1aCACCNktNSXHmVpUx
         X4ug==
X-Gm-Message-State: AOJu0YyeYWDiM2xhhWhxJkDhxdVfBv64RyuxVDMLURTk3FDLtnTSssOf
	gjyZ/p2RgaHg3RBCcOzC50pXU78tKbtf1hfptr8ZZXrjnbwuuUDpUcXGOle8Tjr1XG9VYlpSiU0
	F9G3zhl810KaqIRp7PyoKNA1mDb8JujEUEufpHgP0H5t4Uq7jpXN42KtXR60lsxY=
X-Gm-Gg: AfdE7cmoHRNGht5l+326WQ5BoGmdMMuNSLEhAw6hPXKa9vnyndRYCgZ5EKdzPNsqEaI
	vHurRpxSiIC67byvoTmB+JhnzJ2hZiTX7MpoxFzequ/I8lt4jyJc1+fcpXsJ7F0j73SjaFIUjVN
	i0fhuojOEjnmJQvsbDIkyuiJYj5pHa8ZWDz4V17VdOwIHTj8TUFkuOkA+YW3sNK2kgWxvwgLDR2
	Ja7S9TTdiFvHAb01RVQAssImy0t0qRSbkqZI9n37EAjBV9mpMFGG82ZL26DJnMDcf5jwYzc32TB
	dXGtceMzcANju/1XvKZYFxiAGS/ZCqiGEJsGRgHxguoH7i6aHWQAMtE/Nvm4XTsqAjsqgTJ4RpI
	T0gNw95UN/rqMDC4moM/QUZyI6Elz8/XNFts5ChTdZBUyUdsO053ADqWsHU+GJigTrj/3quvxry
	t2+reQ+PwZAYcre/AbBhree/RsPJ15gQsW96zg07t29QDrw4pIYApVTNd7yayAeks=
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323528585a.28.1782921643157;
        Wed, 01 Jul 2026 09:00:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323511985a.28.1782921642439;
        Wed, 01 Jul 2026 09:00:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:28 +0200
Subject: [PATCH v7 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-4-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: WUaOe9FeVYHsgoA1xiUKSkiCesnBCIVm
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a4539ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX3CbKe2FCMoxD
 dv/tTeVOapRN9roTLJPXHOD/nrl1Gn4D+azmD5UwJm9bhY+xvLBrtt13EZaQzNBNkRseuFXZ4zl
 xPTMySNMLs1FIqwZVcqcfBJcOpN4yC1WZexfjVx1KOvx5Hju8hsALIRUQy/rottKEeS+WV/3qj+
 gR5ppSQ2I2JWc/nuoaGlyfIwQAL0gtIuZvDR1ORhaKXg7kUr8yrFTlNY7D39NC2QDVqrcibktuO
 PFUYYBJQbQyDHHLmrg3Kkb/0Z7WNm14uIRxJ6sMjqu8cC5XRNYNyoLJIjjrL5rKFnm40WKhorCT
 cU9bI4/wHQcybjiwVxo0fmKUnb0YM8uD6T+bSiV1m3E6j5L4WoI8BH//DatLATFlOk4bftsl3dt
 HB0chGrHdYO8kk6ngjH7eE2Kj7fbmsLPxShkCfwkTVrFnR6C+4vwhXKOKcV/648qRUsEcs43KVf
 Cf0TDOcm3M0HqUQyN+w==
X-Proofpoint-ORIG-GUID: WUaOe9FeVYHsgoA1xiUKSkiCesnBCIVm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX4YenLSa6Yk5t
 BNdwynoSTiBqTMhB2cKg2hwxyDkOlN6AphQX3zZwEqfsivlJ5rD9PUAEizgMbz6z9MaWT7dh02i
 RNPaIdsiHo5mD6G9XVJ7e99uBoISiv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

