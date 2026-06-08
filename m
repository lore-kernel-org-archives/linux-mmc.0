Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BA34040D
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915852; cv=none; b=foHgaX5Rz7slQHvKBouASdAdb4mZQ6tKYtAkAJ14zWN70KpDNHqIQqf6Zt2k5gSPLNWbJDYS1p9ppdAYb0mP7u04TjOJo76BnVjLIXk1uRKXxZNt3iCcV7zfRazUr3mGI72jz+LW7imu/T5I3UNjFJEPebGt7X89Aln9MWFurnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915852; c=relaxed/simple;
	bh=RjAXLDtyeqYajrszhA7+nXfORAO+2o+t2+Lsa/IoOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmvnkyEqeXQC65VjrVUc2Xi9xulcZvbdyC1dS2fr4SKK3e9zXTrUeAcHJ0flPjIWZ6s/ZyaOLI8cRG8Rk3x9Igrz9+2KMRpVrQxuWJhsxURzOY60oAcGqq8ezva+UdlLYzopY4sxK3Z03iZVxI9DSSyVfsOjcPLNumFBLzqavXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJ+fkT9R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MPfVJOjJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJ+fkT9R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPfVJOjJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65890p7P3163819
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 10:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=; b=aJ+fkT9RztRhmNf0
	Hs5tso3nBk7AfTBl5tX3u0dCwDsl9/+VUa5mSGG9+pqG3on1RpVlRxxHdc8wJFb3
	zY+XWpCb3vdIvPtr7thAx0jSUCumKMwLb+NuB2JkSon19TshTB5qEr60Z+VQQOl2
	0Ftfi7HVQyOgZMxV/XpVVoNhemQSEOBdCAFpNHFm9yBqoLJLHhK9CZPsCWUWx0Z2
	EkIaWR36t/KgMuA+GOQILSaEaeGK9mxr1nbCC05CbkC0gXgp8gzhB6eomjuEVy7h
	7GlHDYTYulnr540njGieZEuBxy6pxRkvl1rQ4DX4aQRU/dAuigSm+YvefB+ODJgX
	lTiN0A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0gfd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 10:50:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ccd5491db4so30304706d6.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915849; x=1781520649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=MPfVJOjJGFLlBO78o8TFHqNS+NOAOXZq0SaULctyHQfIT9TvLOuCfw+Zrk0sLHpRrI
         eXkCxoONPQhHpAEVmD7PZB1EZmauY+8K3iqD6IyNRqwHpeq8WAMZa4w9BUieosMwKgkl
         qF9p1MFchlxtbnfdVcxiiPCBx2NT88D9F1rBs/tu3nStirmRtD8HG2XvbQuDxjJ0BMXx
         CHgJ8MvsZrhk8ZAE6iR+YK7VrD/aeOASlVr8ZPb5J8KMpknRDE/2rCd8rLlBb1oMkO36
         JAhQ92KzYMEcac1+VF5X7IaeRq6DdUfxzex6EXZyeO1Fikc2SfSJiSBox2HtDS7wfjnV
         jZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915849; x=1781520649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=Pambe7dlJb0IEudp7ijjrV6gCztc0YLRRGIIGw8Pv4IKoAllvlrZgNFmvLoba631MB
         iXc8omALubg0oJSlMl7O8AUxVPUi6mMnp+RzI1Hnv1y4t7QSQM/391M0pWjaslAP8+s7
         3QCvwmv0SorP7YyrUbu3dKYkkp8SRnpto+8p71H8PwLgdgz1j8Ms9dcJAIu4Qaqu41KE
         Ge04DhG90FWefauVg01wr21cSZQ+6SPSEN6zv2+b9SLG09iC5OxmqXDZzzXcBBpHdynO
         NVysFkwWgWVFnYtL2nArtWkBKvOre0XIjUOaRBpk2k3MBFoJpKVoHAfW9GNDsCFvxxk2
         AVEA==
X-Gm-Message-State: AOJu0YxBz9+3R7P9KrFnuBQmFCEI28k+hDJXAPWjMnNjGfHfzmm4d6Fz
	YTPWxGL1KtCjbgCKjyqBUDPGUN1sBWZTix6Jjf1R6HpCQXnLJQoZttTKsOmfVQ+qVYGAzKOnsd3
	P4UL8/bhvh5ybzzKnyxYCx+H9pJwePN7VqWaT7AG63FzAHEyWPEhlIjre1P4ETDJfxn8q2b++Qw
	==
X-Gm-Gg: Acq92OFBT0pG4zQ7Yftsks0JxFPj6sOvP54t531zjzF2KSbGB2KlEp3IQCNmbXHUbCx
	aMI95S0LYCBtRInkeaqw9hkA4G1JlwRl+pJYoaUS0Sx5UrYT1vp/Toe5yID4bRrxEdCxJzpVF6V
	FKbN5yg4LdFizXKOmYWNcYVs6q/7akpJEo8TfBAIOLRnBt8UpyBfYb3V8KdEX9st5X22BjNF26A
	nPRhLMW5IXXx6X97nTVnLV+RK3nGLheSlPtGOq05NJIlfhXp8pu9quzhrjKO458KwUOWklbzrtG
	OYKNgMZqpDJhinlKW5s/npnxI0x8Pe7UcVjEsfGj7iFbwxAzW7/HpbhXdDwBeNlMC7qJt90g+iC
	hA//5/kWY36Q2phHuwKsoKmHABwydme728lTDktB5WU26Pwcwrw2Fz7EyRKLEmUvQXeStgCr0x5
	rTuwftYvIh6j4K/ndVzscPqzisFpjbvhUgE8hWyuRb8QN0KGI1NRyzOJLKbw1ExC8trkvxSaUQb
	HY3QnGGNTeA
X-Received: by 2002:a05:622a:1a9b:b0:517:9157:ecf0 with SMTP id d75a77b69052e-51795be13abmr201563451cf.29.1780915849271;
        Mon, 08 Jun 2026 03:50:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9b:b0:517:9157:ecf0 with SMTP id d75a77b69052e-51795be13abmr201563041cf.29.1780915848772;
        Mon, 08 Jun 2026 03:50:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:47 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:40 +0200
Subject: [PATCH v3 3/7] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX1cuLaooc1FqE
 /ocXFi8Y4n6MRO7/Qrsa8nQY4UT7FCGbtw1H1AHmos83623LrABPQswJvoCF+6I7L/iRrjZ8S0Z
 gIAonPWydJMaBo+wtnzTiAYEKAPEai8PfAutnLH4LBR3fvh7GM5Urm//+v+ll8PBOSSFhPN9GVO
 PtRo51noz1I+FhXc3ykVlysFAWK3xiEwBntqJgr8gU4lXZVF0XVtQ+hDDaYvw62/rGH/pL/mztC
 Sj0mLrhC3b6R93/Lf3pL2pTfsLlL7bm48DA0/5/OH63UKj1OpUxIlvM6xNH91JlI+Ut1Oci0RYJ
 uMLAyu1gATX9B6obfqC6RqfS2jk1871+Ozf5kED2qPifqEhUAMmOHIcyX2Btlj9zn49wrWpLk1F
 +r5E2+j7tCk/1bS9ptY3Vaj7ty36XKmULWx+Qv0heZOXpsehb66hlek7C2uhX9q5vqHCQ/tqA6m
 Lru2yjJBJwdr7lzUCRw==
X-Proofpoint-ORIG-GUID: PH7kWgZhFma0oJNeMlq1Gg7GSennHlHH
X-Proofpoint-GUID: PH7kWgZhFma0oJNeMlq1Gg7GSennHlHH
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a269e89 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080101

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

