Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6E3EAC86
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991601; cv=none; b=MEW6UOfOVxr2au0HXxlOQPt4HL+mB3GU0ABNPzJkwnmzG6j8z3Sr3Scn15N/BZmYAgtZanVQabe26snYXP38ncq4qZNAhFCfW7sY+8lTLZYA56eyYksdDBh2z88zldyKD9OudE+fjkN1aDDJhyEV8SXu5PLgGYoZsw1aPaDljxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991601; c=relaxed/simple;
	bh=yYJ5VBN7wBwAYsQ0zlbRkE0xdiTrAcSbG/QNNToAmpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2ijMydaEQvyg/lZF4PAG7ILZ+kbm/actTRHetXWospmVCC0RToU8VxDUHDu2BCAJpT4bjGfS6T/X4I6a7JuAgt2Aro7rbbFa1ie8PB5xuoneBBx55yr0dYJtWdw75FoBl82kKw3VfRJ1K+O3nMJoawGdNibSGUhoS0F1FUtr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGK78Hh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1L3oOhH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGK78Hh2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1L3oOhH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wrKu945089
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 07:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=; b=oGK78Hh2GvSSk3nx
	gRnEthzbKV089nIAjT+pSAu6UIWXHONVitXv+kCiYNajab87B+rFJbZw9tkGCq5B
	j1v0xQtK8QFmGL4AiAHzvO3DrS1j7d0IIx35SbMpvtzTsRXJqzsPsFplwmJ/7Uik
	xha+82hUokTCipYZ1DCkQE+tum05qEMgwTeSbTBu7/e0n4Qky/Kv7swLuSX18C0g
	g6uS3XehElds/iQla4W4q4foq9qDeMYFes1lTTi5O9+qZi7jVPiUZhNLFx1xcdtm
	WR4lK1+q0aM/KbvRlQQeCaaUEpY4u+rq/tDaV0fQr19uQbHeaLK8b943DzeCPHc8
	vbkc3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx45g6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 07:53:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5175b7946d5so43444231cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991598; x=1781596398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=V1L3oOhH+pqUN12byo5Nmtn4RJwdRG+59ehbHvN/X2dVdIEWt0SYBuNCeC/25nmRPW
         8MKbaJrfgXeWi7saPTOq8hHRGHRQQDW2pjiMgH1zswy190UleM0Y14+/bUVS/UZ5OYAF
         QbT45Xwmbf88kbYKq3zUTPKtFlFj4x/tQiRSrM5tIqnsUEh2/N4qT09wphEIaY1safcD
         ++voo/p3XpsQPjxpFAfvofRZI7HKZq6JijICU0ICHRYHg7sVNPAoSjqMTSNwN/qHjbqo
         4FIlWfCTCK0xfWuh3mP1mJIdl3+rIRPYBGPqGRc8b5htK6cga6TaG/sGFMwXPVEBbPi0
         uYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991598; x=1781596398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=K2b1fOZXfhm73p7tzX71LKZY8t1rIJ4koXsEcb4JSDeDkfS5O7tYF5nZZcymvSe+Rp
         fvU8vFniEgIctOWKRk+wxQKE07CYKqh9Mqyv+KmxCrMev6HkXpSzG88Ixg9Xuzk0bXME
         KnEuWvn0ob8mllHQ3iQ4ptNxCAmXYx3CuYu49BWj13AJHVF5OkqBcDQtqna3X8SL/5iE
         dFYwvgLqTQONL5aTMoSX+TSd6q4G+neFUybiBn/y9tNbAGamQaXmO5t7O20fIY1yp20a
         cXFq/Ri5YpsEV0JAb9T2Eaoo85mYhSp56Q1RIM5BYeAL4O998wX0i3dPeSpVHwiUG4aj
         1jgA==
X-Gm-Message-State: AOJu0Yz+QU/PgvMmaEo877dpinaIfJKFbDjFs7pumcBFvejJ4m1CWrbX
	rqOX42M2SMEeh9NrC0k062mXwyWchOfxuZVWwh3YO3KhsbOPsQvmr3C2/nF6h3pjlhRJaKpLak+
	4i8rm0J+mQG2+n/cCzaRj4va/pNTFyQEnMIyvG/XekCtNsJ0oAolAHk+KorS8Olo=
X-Gm-Gg: Acq92OEzd1BwYh236gm2McrS1NlxQUd8OFKXIXO6zj3AKDdtYS7IZg0drOMerguOa7Y
	fw6KGsIBpnsDDU3Zz2mFTTJP8cznEzylRv6wERaM1nMxejtRISbQ5Qr7lavxGGzIe3i3fecHxg1
	uqgWM1FbJU5PFNjvxuwFPcN6dFDE8SxaEWm8ZKr8BkGz6L1Gv9FDx91jiY8/GC/iSETJb7YTv6e
	0+eOjYs5Jrk8CEJxk5pqd5mOTr5tacneLpDvYH/otuHwU3b0OSAtlVyZ8BCTzRsn16e9NoxqmS8
	M0isdUKNAb9x8O1CQldkC37CeXbE31SPzbhe0iWiqEpPLoklPgEW4RmCoclZsvrJ5Mr0un1szQk
	q7dtqu0qUb7EHsIuj0ueQgQh3J6FyhNLbiXd6anHITWdkJfgAn96TO0BQmSsN3PhecVaoOrY1ZW
	XLWDV+itRhCxbJ2cDQEWSnNmTYlEPuIaV3Sc4mw5ZTr80NUeVx0yidviHjREQNplExVNVzueK4Z
	1LzudGQh0nU
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186043331cf.24.1780991598489;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186042831cf.24.1780991598097;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:27 +0200
Subject: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a27c66f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: _MD2JL4BC2xmh1pCkl2vBhdCAD-SSYFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX3YLzbPF/33rp
 oeFdIdDx7XNxoOFfYPMQwehxbzzLRxjEU01wsqXjtO7zJGjNr/7AZRszf5RkgJ8Za5UlRwDhb71
 rr1quk2SzMXrG4Pgw+huVbm5ylr5YcmjpGwDDBTeDzNGkuzhEW0M+ldFMusGYT9xIIjKgDuaTsb
 IuQtnsHn73Nv4gUiZUTwP4dtb6FeXquRm37wZ2TfV7S30JUc5kJ4DTSJ2bZZN9JbWjijHYX47Tm
 oSGT2kSjLLDmPTdr/Otos5zkvVUm9QgsXMKCzN+1qKNsui3rjleaybqkQ0mg80oqTl7fBQ32GWi
 mVIVuhyUV+ZG34O/w3sV46heJdcIoS9m2mKc3bpbcDDMaa9wB0H88hVJJ5j9xsxzQEZ2l054Rva
 1s95xkHqyvRTm5UjpBur/vxYBZLFew==
X-Proofpoint-GUID: _MD2JL4BC2xmh1pCkl2vBhdCAD-SSYFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606090074

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b9919d48c41ac09f1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description: |
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

