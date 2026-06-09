Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FC3EEAE7
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991604; cv=none; b=O+4xiAjYUtyGEyVMcAnt8QVyIr7wgiBs5PDwG7GbRM6LPWgXyKwDSn5fKxPWoZI4BjIIgm3CafksCJs3h5IEpQFLKxujLuh/YE5owNh8+6un7l3aYdv/IcZ+LR4GM9bTXZqc9thFYK/9ejn5HP6eCiXs4cjd1qAdqugJjYMcwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991604; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvhfwKFspGUIOQz1B7gFfxdFQsQmX2OCak+Dk9Etsb1xBgI8PBwDcmSkbfdpeV5JLVRKmSkZIXItJoVy4KCNZ3cFmDQyNgtOuF/T2WwczSa30cSwyAMLBHb7vT7KwqAQ6mfz/MzNrRUFaLne80ZoPzlM/oOUK3BClOS5DYDjaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFktGxKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d754NhLA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFktGxKu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d754NhLA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597fOYV1491027
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 07:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=mFktGxKub3OBWZqq
	WmvRXRbzTgMecOXVAW0uD4F7zuze8xHExVrgprxqAAD7nDnk/8EbCmQf42UKmaVv
	EY4ZBOIPvyl9sX5iMKvzypi8hRZZKJKBb7fv/MiUGCAi0cmCcarSKpmQIUEtxmh5
	QgowqOHnsq/aP6sjmDd4q8r5Q2PJBXf3axT24MnJAfg/UJzurNToZi+fo+L8qwaa
	iWg4gFPSZg+4uQ5Y2r3nngrJ8whTX9lqDc0KFnMn8p/0mUWMs/OL0HLKL+LtqVaB
	ZC+xgpButnyvMGf7bvxTB9NZZljIe7A3dgHWBaIxrPwBMljD6kczacpfglUutKMm
	PmVrag==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr81eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 07:53:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5175bb9d47fso104056641cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991602; x=1781596402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=d754NhLAH6Coen+vdM1OAy7+lPYQu109KuvI/pbA2nIo5eTP3iULRZ9DNBLNBmpTUZ
         i7bxTrn6x2lyDr8ATCUrkOXgHY8dSKjj8Ro+WO+Kif1P5C0lL6cra6qWV42T+rSb9zNN
         KCX8NKJJItYGHv0JNJ/UutmS+3PI9fg13uGZrkg5wlLoVe3vY97SI5uJBpQeD6L7DOUj
         fIW16S2qummtws3qdV4hjl3mLDpBWpZlsKXaLMN/rz24HrJLm1N2ui1Mmx34eUVcNyx2
         XvQkUFrwiLLakg9CykM4lk1R8XYJeiXNX90+YeiqnbOSG6wRhVxJmUo9b3UE6OBBWl2U
         r6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991602; x=1781596402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=YCNy5oed+9lr9WfewpRzwj85iIOwR+NJPbyWayyhTmSK1NynSvqarfpqV0ewevUCTP
         xqJvOIw8e666tRoAM4uydr/Lu0JUpX+LcNzZMLXWiqcwJEu+jVFgYJpnCsDEyd8lpGyc
         zAEQjFlv+PuGYjrdPpIO7kE7Wygc0W132Xd/t3NVDkEuwQtP0KImLre7Jnz9N0mnJsqc
         GwkGl9X48l7ZWeYxh7TG/C/Bl/6sflI32Ee4139AWJswtwEtuGdS4Oi6m94XhjGW3Pez
         aXtSPz+u4uJLU901+Nv1d2xnrwxjLBiaee5z9rEHnIbk8+t8sLnZqzMS1DQeIqvVLGXJ
         C1jg==
X-Gm-Message-State: AOJu0YwG47KcFx1QzutJfQBCopjDbPQ+UzJUyzIA/FdVM9k8lFnzfH+W
	TzfKNIHiK+dB3ds3VR3QFa/L5PEA4prOqeGVsvZcGZal+NQkSso/8t+chrEIJU6j158RMJuq24a
	DOrZ74WNushHnZEZgOS4pw3fSmyndL7wzxiraDbxGXMj7fJYN8MzTvzPXXodgxPA=
X-Gm-Gg: Acq92OGIFwX4Hl0fovybEbSmlbcM+KgIo0L3AymlbojxVNaEPaSmqI7xK75eRkximNC
	aE54JVP/c9AVmFNKRu8qxxKwsDlBk4qR3vJgTECaJgEn4IGepARHSE/lP2/ixiANqcwwGytL9Cw
	aiwkgSSw2IBofCxRnfD4gE4IklGZMAuQi5IGrgNJRd44zKRtUMlgprVSweyNOX0WiGouz7JS8p3
	1h8CivwGGkK7t0xYPM11Wmbknpuzxuf1q3gTphO0GWW4T+oxW8BYloWy0EYPO+M1u+Nfcrdsp3f
	AouPL6FSXnXvbAj4NKMCyVmRfLxya4Vl8DMylCBmLV98kXnwG3GM2fhTxevWpGS1ubdiIVZC/Nx
	z6KD3euU5GpUHr1X1cVnURhkutF5wsbQ1Pwwc2VAm7RyXX5vU/SiG6sdiVu1AjEmAvTfP2+sRLq
	R1VTQ0VpbifP7UnhkXlxlXWazleUGbBT8NL2qvx9ePt07Z0WDbYOmusIAmCODH5FzkpZuVlbjUS
	wAPpvjstgWl
X-Received: by 2002:ac8:5c83:0:b0:50e:6313:6e13 with SMTP id d75a77b69052e-51795a829femr267703891cf.5.1780991601773;
        Tue, 09 Jun 2026 00:53:21 -0700 (PDT)
X-Received: by 2002:ac8:5c83:0:b0:50e:6313:6e13 with SMTP id d75a77b69052e-51795a829femr267703571cf.5.1780991601346;
        Tue, 09 Jun 2026 00:53:21 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:28 +0200
Subject: [PATCH v4 3/8] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-3-45712e6b22c6@oss.qualcomm.com>
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
X-Proofpoint-GUID: 6Wb0MIblOAdzhjtMwl9Y8tiTeXDTqmKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX5ncS4Fpb6w39
 aiuBelVm7c3itvNYDMnTgobW65IeeueCSt1UyhiRdVJuWUjVYfcIiYLIvK61qchCpGfRxMPPKba
 jkVaHPVqpK0jmdUd6VOey3+2M3bFgZZIhvnNBbga+Qzf/f03SrI+GEScew7zA3gnY6B7bGl2Qjc
 leaHN708aW09oxzYddXyNRc+YMCFxjxul84tn/8IX7PXjlejbHVBL5+DWHUEotUsxL38QTs3naE
 kQnNBt6dBytxNqVrn2985pz04V0/PqPxMmYuyaXCDmmHx05W5OhV5PFAqIsqK1ibmQHNhG4C16a
 lz8qAwjFnRLKvx76OJbvyZRP/LV8L7QP+3Ni+Zbmp4v/XltWK+4eSTbWVIJkaMeiu9ZmNVi3rCa
 dO9WOPaIBrN02RvnN3OcrswZcqYZ7GTl6jeE7/Y4BqcNU2fZXO8Uoh8vazhtcRYp3E3Xrre448r
 heVNDzsCJF1DmXIogAQ==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a27c672 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6Wb0MIblOAdzhjtMwl9Y8tiTeXDTqmKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

