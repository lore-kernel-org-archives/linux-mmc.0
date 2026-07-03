Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEB3E5EC0
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086345; cv=none; b=tz+eUOUww22rfId3uVSmqlXYuTjjkv1EFP+LWA9yXbWzev2B9163svIL+nl5nVVqQ3AGh5cFcBgo44WxKVLiceYEay84915Go7H1lZyqRLNl3JSBIEPv7LkeABiQZGFaC0Pxtz9yXcvwBoML13ClvBcUHak7MkoPaZ30u3k3qT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086345; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AW8slIAaViCl32Uj6PtbsvVATX6GKkSyNoyhHCNqziP0IV1bvQZ6K6zCHM/cOI5zTaMc5FzgH3Q+75QEYx0fmE3OgMH4d/QU3cNrXV44uOACFBl7WWPnsX5pfC0/JCs4qPE2UyP23KwAZgXX3E16VSqAwHIdCxwh2NlJzWXgtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjEwQ7KX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DAUem3ZW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjEwQ7KX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DAUem3ZW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663A399f3773578
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 13:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=BjEwQ7KXV91y6w5K
	VaQIfEuSxIf16eWd1haiwUtC/PYzRYiVxl1j5dXjqMoCiigcwbu0X+8vL/TExdy4
	ZgaYvX3s/VjRfFmnLJ2HAxVpoT2At/uvdsGENm8WOfnOSljYzXiflbVP57mea2FX
	KnQYVBSaRc+RTVmHc1S5LvgQFioMJfP0+CNEuyaeFSePaW2SyzXcOQyNvMVcGtyj
	FwwWkbyB25zHbrgMA13dzHUKe6tPQz9z0YNucycudgyRDEQ2qG4QyzaE1Utrt5uS
	gNyLrQaSn/7xmzjyveth3rLNCkQC+OEimnMLDr3jt7aY1uQdm/4UCnx8933DfJ1O
	dXR6hw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b038u1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 13:45:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e632390d2so104355985a.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086341; x=1783691141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=DAUem3ZWumHqhcbIU+3OZ7KebpPlezMWJlLSdDyU1luGwbnGTES5rbHC6b1tgl6WeC
         uefWlAExSsE6ohoBgrsNmUJdd6JtyNkxj2GGKjlqJdlhM8ZjsWl3eqOp2q6L9uAEFm3S
         f1j1UeaHWbuleXFPxJZxVhIE5Br29Kd58guAd0AbKddf3rLJQM65OFhEOwQlmC7iVpUz
         plNjjG0mb8JIPIbXVFWp/ql1GW53GfpgjkSTKbBavhqbQ01N+q2F2/R3oMGM0JUf4HxM
         l9t1iBSxHkC+5Di1eOnDSW7xGCZA/xsiWGYBI0ZAXm0FhLTerokyUo7Kbj7xUlKReRol
         J9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086341; x=1783691141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=moiuEGKeGOmky73BWkJtG7SICHwOAAvs/x4hZcan0HSN2iRIGYWrkabC6nVk2cQy8o
         wwbsp1Bka9jccZQ+S7v8heCesCuPNL0HHA3wzalM7rzrI0PnIUZgrB/dFMIV5FVUYxi/
         rcOqKENZQnQXAWOKLsS4JpaJWb8NEk4m7ZEq4JBt7z2fJf/Ljbd07MGMngVkeTp1DX0L
         rEyBHeUdYg47PZKB5Gds4BnwbOlwacKp+QG9jmDQxEHksukTpzM5UGPSQzo/HSLnyA7m
         r2Q9WcAL3MHGoat8x5KZI9B7y7lNpZdlZN5i7eGEx0oqYWxQdyOGZ6q+mwrWijEv9NVW
         Bikw==
X-Gm-Message-State: AOJu0YySHien90i3oAaKgJedLS7yAGnBWhud0116EY+mj9WD1tu4Tg38
	RwVjQFdUw6xAf8fxbKJ2Vw2y2gr7TyJiFxV1i7F1s2DhGHzs+N1HF1qB7U5n2rEGIUZD9gVVCCK
	U225Zmb7lHJEfvbmMtmIJbLQnSsIfpD2OfK7V0zuTGUabh3kNIsgwXrEJCZNlams=
X-Gm-Gg: AfdE7cm9QYIWENDEkOEvc8dB3bjkcbQQmqCaNkvXROrjI05ERca7JkaAnUsu92IA3UW
	pBmoK594CxYdm67D9Z7C+xbMgXMV9jjfAuDcaHhHAx1khFU5A/njuxmm57cPfGBLwe/WLRIMo+Z
	0kg5gs0grjbrUWd/jP0+Rp4levOpX6H8zluO9N5LAvCT6ynrndnZPN/b4gH5HHwXsepkap7Tjoa
	4w7uwyIUCCAJNL3HDTZBu/DC5fY5uFpU2bR3c1fAcptP+MA8JiWiD6aefBjYLSC6q9RikIuP6WS
	vGYV4SWj0nrpCOqgHtQTyoKIoE/LzYvHa/1AiBlu4q95nXJPjnnEyZwOmZGk2hRY0aSm3KZR7Mk
	MXl1HtVSBtx3VF00k7H/mwxJYJylxpn8G16WfYIYNHZXEKgm2D43PXp3urP/GXKjVFvBcZwJ8zO
	jzpP+PhO344sI4F1TgwVpCSxQj5Exx/8ZbdRuSrGrVdW0/E6AQIAUflwq0D1ZXhlo=
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223915085a.56.1783086332528;
        Fri, 03 Jul 2026 06:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223818485a.56.1783086327285;
        Fri, 03 Jul 2026 06:45:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:16 +0200
Subject: [PATCH v8 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-3-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXza/yOGPIyOuH
 8mUYYdx1nCFp7ao5psoyWasDpkwiud2uiymVg3EaZ+6x1RgJDv3O8Dhr163Nz6Fh3Zon3xqHXnf
 aWHaeA2ECoA3f8GPGhHufy+cU95RG+I=
X-Proofpoint-GUID: TT6cBshVXeVs1_5wgfDRYn5yJaHsZ_IH
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47bd06 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX6PVDsS547zyp
 dovI068VXWCrHx3T1FttcxFGmPzlTEy9ftLI0810Q92+WPzciHwpJH1MKVaOVqrPGhy44vNgvsH
 Ky+9tb/UzcVbbRoXVgQj6yB8/+z4ok/XrcfRxf0AuNKlPmpi7/LAsumX7SNGl0sxzYiEIxMmv7q
 HbyfgRuhc6bMLEeDPavL1CtOy0iRqpDsORfcQiiNejvrw13u/HQBMNU3S3Jz+yXho80FnsqxcWL
 1AcNpiUNPCZ6qCPTXuzoOCl9lj5oZSl9tXsf6BnYWygvRvWBp5cJT3OPc2DFamHMcVNNxbgaov9
 zWRslMn83qql2Gsset/fy8aGUJAY1uxHDtm8QQn04T8YDTDPDEuM8I+4BCP1BsEpOObSk0ImJEC
 9Ldf44aQfJyY1/L9nUiElGYe6XDdEZzl1ebaErDFn+z5CEqv8ALzhuc1M4JPqmaWaccNN98k+15
 gP+Kcqr97LVW4pkwlLA==
X-Proofpoint-ORIG-GUID: TT6cBshVXeVs1_5wgfDRYn5yJaHsZ_IH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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

