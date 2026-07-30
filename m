Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E54477EA
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427254; cv=none; b=ftNkcbCxMiIDHyAqGUUvYCnhC7IrKtzO1wvX4yPLASWdN7fnNUU9/o2xIqSLfcIeHDNCRs0WL/MmxJT/YL3J5jFUJvjL6MS/zFRPEFTvyOBw9dEMOZBLgjFCzIYCTNdK0sZII8PdxJ1C6PM6ntxRJ3WWFVlb3HggqMjyymKx02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427254; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLylWOx++VkS07YYWixsTaToglyWcZU1dC4O6yULOHG52kfJu5+3MgyhjetUt327ynvhZUUG9HDcmoHqW6uPn7Jq0UT9hnpO6FBDgnjmO8bC+grnafmntakjG9f4ZA0oomy8WifHN6VvxW6Amp8k9f1eeO95PU0oLJtwXpJEcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mdc2lZTP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f995O6V6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mdc2lZTP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f995O6V6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQrCA2401631
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=Mdc2lZTPtt0S03NT
	RZN2LLYKd+6xXhFCtur9/pn9KUxEL/qAs2gSangnk3Eojs3/CX2/U8oIu1o6fKhC
	XroQfXn6jyxAvPOItfTXBxB6a8IEK4aVhaevupkro8jYPxWKsqEiumETD82FoNCv
	zojIrPoVqqom+od2/ljgKcP6kfMDX5SNaauAqJvwDWm2OmxejTT88jaqRV8dhhuA
	+pBxJQKtP7NAOOE4f5RoZyu1f2FUpYzK3pNhCbkmi4s+mx5iJ+i1z3qg4IrYqyDX
	v4V16C0fVnXQTebHonIJ1OlzTzv7K4oWtrb1v6u6WZahOxMwVdixSMnVEx8rgQet
	SXIImQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8168mxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8db414c7so34147281cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427250; x=1786032050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=f995O6V6+l0ZkTnatqochmwWKk2TqvvIo25KbncSpPzX6vAL/qZLk39A3xv2u8la/i
         Zt4REh5JjVxWhTeNByDVVqZ76ylrsJVeXnjeCS4j4PIchyKUCmJ+IZqvQiaVki9tA5vs
         HulSow84e7BYuovTKejSUnOYW0HCDhYGrJaU11gKEX25pLeJWIVweKHTJSg5gYY7WCno
         EyAJsMM2Osl7b8ThXJn93hOjn+p0mCtzphUju/vHYE7MtINnLm9P4bAhMP0UeL2pk85b
         MbkLiE/HGRX2C5cJg6HrtjH8txlroZh/wFvMIMilqiHs/ZFy74Il+6YvwFW7nmSvNAS0
         SuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427250; x=1786032050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=iPeTNqvivSMKaH8lg96lpU60Brvo3nbn+bz98RZQUzVkOZXmOS01eDFwASrwN7sSIi
         8XEuRfASsrPloVf6AL68iOETEkuSupMZ9POfjf9GW7p4AVUJa+odyvrtrQaU01xMokIs
         cCPHvntpfrLWY/c18ct9cO2reS9ky3IFZjZpwDaf3fVZSVxMchemgzkb5dSXM7+iBe9X
         iPEL8Qa+hAIe4r5z86F/c2XerI4R9Em6JJoma17MDjwL9B+Ps4RP4BQoit0TP83VLQQq
         gUK8MHZgyUYYW9wsjDrVKLFAP270XTAXviehdsrfZSipZ2XiuaJGb2dg/Pnc1vmX4xG7
         tFSA==
X-Gm-Message-State: AOJu0Yw4+cESTnmkBuEI2Yi01qXCqYvpTNEBSGTO/DAgnJvSCCUCC4rT
	r3T4mqnJD3ibcnITY4az2cVYTnL289nq3aBenrCiYkIPk6CAZeEtJaJv/hav8kE2rg1fmszQ5eo
	pxFqvX9WDoFse8P5nQcHsH2eX+gUvUmtzA5/6EnrMZEHe2OA3+pGMCsUYPRJ9GPU=
X-Gm-Gg: AR+sD11hkfDFlbtkHBeauQKIvOAeSYv+JJ8jA59U0VEBybHgFx2tg4qMAiLw4v3DHNF
	Cbzhrik/x/4uSee0oYIGOd2AQRsBdnaOZBJjQpLOfWYs6cLKHe9CxeL4vux9/dhIcOwX2SDEyRr
	qROwH4kz41Lo0VBr8OWM4I2AxL3XuFcaiAoMk0qhLsKvR+2OD9SogHpTfGW1gMQWo11XNSdekw4
	YfjvV5HTPiUxpliGyuYRoNk9Q2uCqVT+KWID2Kpp6ckGp3f82jmmHT7zOLNWaFUrpvfroFh0cXX
	Jo+j2txPAPXPpEFU0M/TgXQVU0R3UiY3A/1s2cIN7AbDFUVku1tRKQ8mO+rdS4RBmkmaTVM5OeJ
	P1t0fgerx3O6UHbDRtCnlnvFioPLF/T3/eC/3bFmOveiDGabMUQg7DpPxwMrWL3KN7Rr92rSGSP
	5hbfXgSZhtf49vk7A6NI+0/8N1TegU0J4V4uNWolXydUkWUBIf/KGf
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37918881cf.27.1785427249670;
        Thu, 30 Jul 2026 09:00:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37914671cf.27.1785427247300;
        Thu, 30 Jul 2026 09:00:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:33 +0200
Subject: [PATCH v9 03/10] dt-bindings: bluetooth: qcom: Add NVMEM BD
 address cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-3-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX30mCjhBUNesx
 C4erBa287TUxrIHz+CMBPwiz3qp7Bfl3NP+4u5qtXyQiSbvUYudO9fLD7wA5/HhdYAQor0D3ouY
 e53ukV4Trc4DWYJ1aW/RTz9sX/DP6FGmfMbSPKkVvFIQSNEeImSrFjQeyt41G4vjPEC24S/qwIq
 U9nVkmd8wvCCqjTzGRI+6bj0rwtfc+s6N5/2R4Dakltr4BGxVDT8d2ZhAd9IRS/GUhl8bAHRGO/
 YmdaW/WwYP+pX63KjlKm/EJg2vDl07mahJV4xQL7fW55yip2oFQkmuQASnAgp1oR47vub+UvQSB
 1lcYylJrqhKX1lKL2AItVXY7d1Uqs00NJjXPRXdwdSDHKE176UN+FJxWE2zNoxSRyF2N6VSN4hW
 KCCNWyY9gOjHgDmHVGNY8b+J7aEV+MX2Crmu1/5CfVoUpw6EfTF+Pssgr14Iz0CRIjC2fscuEUL
 gGU+cUS36RXze99pAmA==
X-Authority-Analysis: v=2.4 cv=LIlWhpW9 c=1 sm=1 tr=0 ts=6a6b7534 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: OIJuqOSjgLi5noKY7C2wWRmUvncOB1BL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX0Q2Sn4B9OtiS
 s72aaA1gy38qliinDYFr9jp1laCNVTO/YLk08ipcohX36mNrUSJCT0aJgN+u1Hfz2KBXeJLg/zH
 le3Mab13iC9heyD5NUMi1RQ+ZR8UItw=
X-Proofpoint-GUID: OIJuqOSjgLi5noKY7C2wWRmUvncOB1BL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

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

