Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74D4B8DFC
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921660; cv=none; b=hyuvbWfTpMJWvLIilqDyUJpe5oBy9o17YGtTLUzmLM7ngJjtmhhG0onmuuuna9ySH6KCQQVyUbbRsjNpT8I1g5hvR0WF7OD1ioeMaDRjiTyQO7PQp6IgCNEpRdsAVvUB0KkYnX6+XMbije9L0dahN/fv4Z+/sSlQngTxgbSEyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921660; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttnls4HLxMJG0fOBcOYGbwDosHNZ11VylQ+Bvv7ZUfngjJK3haMS6F73E9DivifNaqY1gWRkGxe+DoKPNyf0V7/73EZR+pnraQIN2nT4LWO81Yza6eOFSiQqd4mTAnLPKEoKAi9ktAEQrSaSlnb2mh6fxA2Xl0G4RzOC96IPObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbIMQfWk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPXHx/yA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbIMQfWk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPXHx/yA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoAU91551484
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 16:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=NbIMQfWk/M75Jc/m
	JJcsFsiD2oORCimjwwYEEgLE4CCbKa8/jk6TtZTAo2x1Chq82xjvwdmFs4twAiDE
	VmDSeiTYXtYJ39ntpwwchbR4xciMLf94auLLm5dXenL6roE2PUu4b2pcjDlKN9xr
	Tmqt2K6wYY4XM7zkpb8EEBtYVMordmmk8cH//v311NIYAS4Ewqa30tp56XPJEkxp
	NnUVh1GPoJ9JUr24MaNvUObsxb/pYWhBmwiTgocSru7GcYIPCxOqTEcs6tMXN12J
	Yoiz/RgXGsjpYOtHtjdn03/y2bD6I/b9+OrJm8s54ZTFl7pmFxudXQyCt6fIC9on
	tk9Efg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw4wpe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 16:00:53 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-447cbcf3c15so434988fac.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921652; x=1783526452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=CPXHx/yA9SWZf/msCSHBnGg5vUirWSVlKMjclcdpQbz9wzcdoQZOJ3TRw+viG0Om1Q
         BYMARaWiEbNMkE/FqE27Iqny7dxlw5jiul5y9U83SnjXSFKQl5Zc3u33kb/K1k1+rkGb
         rL0yYGcZ9dBOpCcnMF3hf3fo5cT6TNKpHqnX9ByRFvJBZxbM9H6+iaMhOywGzV8axqLF
         BrvH+CTr1s2rXcnhJYRAR6Td0aoQe2zH/L+TTvkUKtZJQEoyTRDx8+EGHA2Su7O8uL30
         9GWeiHhqDGd43JNsdv+twEE87Ad0DuZFWSt+JlbK5b5lqGtYCGq6X07izwZFLY0BnNoT
         Z/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921652; x=1783526452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=kpf59O91W9BtnEU9RAw8st6XXq+J7hHif61vIfYsUvaRFT/LRZ663xg5OyWPU3aiIJ
         KrU5SlhroY5iq9Dnhjr+9/G+wWPTOBRA1WbvzDCZkiYGmiuboZDHMdwUQEtyGi1I6Epn
         4lNcUI6mYqBxvohJ7fiX9i8EoBx4vFWfKgFpJWzEDUcc9J9icbR4vimCi4/+tTFf7QW6
         tsj7O/L+fhCMgrljffBRn7ee2h7JC4pqvbkgCcifYknR7j4Ju5oqmG/unt1HNMlt6N4m
         vvHCjxCKhNpFjLogUZeW3k2AgZRCt0NqlQPpTINNnHxFJ91J5Q68G0PIEuTtz+alqrSW
         N31w==
X-Gm-Message-State: AOJu0YwJnlOUm57jQ+EdF03Q/axyYf7tNbLcQGM0NFByl4DBr5VtM6t3
	GDvqxs5mc39VA2VLjP5XR7SwPRHWPCU8hw7R51Q8jGTVdh6SeTXkBy9/jEcgVWOdOSfSwX3ugsi
	4fkYdSHMyfVIRm7ritDLa4kkU/h5i6+6n3zXAUHY+cJ5wUBsteip+u3r0pFasJ5mQRVSNAXQQZ5
	YH
X-Gm-Gg: AfdE7cldY2CdBRz6drEXlvv7UJYEkEj86pzS3+rfTgYIXcDEZSpGA8V5GVyTLnFCGTp
	9VaXXPlx6uLPUJS/T2NE3M3cEHMSBe8uG1WPltQHjrO2z0WxUlxhXnRf+PtDQn0ElpofV2FqBh4
	I7HNTbbVhYK9fGIP2oo5JfCfDiiXtEtO4Di9XMqP4kTfaKVl32mAKk1Xr9QbDBDXcXD/BwVvQKM
	umMfPRljMr5hb+z+OovSv9sSqxLXTCB+OGorfihiTN1yKXrDzyAOssTceJ0ZQ+AaIxb4w8tCgQs
	Hryr+ATN/J+ZAyS4P3fMqUYL3N/LVxbOhHY6vj3YfAP4KlGef3/ZF4oL/XCEsX4tv3ecm46EbqD
	Q4ROG2n2F7wfDe2nKZtT+kfDYiI0OvKZvYa0tzUU+Oujmkchm8swluEBU7hviLw3wCfREJr2fFc
	WzISzmLAuquMevOJHrT3/7jwh7bM8b6vHEjjko4VA66B1lF0UJq//bTc+lOIDysi8=
X-Received: by 2002:a05:6871:c928:b0:42f:d844:7d0b with SMTP id 586e51a60fabf-44cab55b3d4mr1222497fac.6.1782921652319;
        Wed, 01 Jul 2026 09:00:52 -0700 (PDT)
X-Received: by 2002:a05:620a:6f02:b0:915:afa5:725 with SMTP id af79cd13be357-92e78206c88mr299831085a.6.1782921639993;
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:27 +0200
Subject: [PATCH v7 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-3-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a4539b5 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: nEenI4wI5A9WsoBOJdRn0mvcTruXkcbP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXyNZwM5N0ckwv
 QbrZwmvHr2tdWuX5s+3EYNQsz7YuguOqvbMPOsB+gNw8RkV61m20D/Dnc6wmNKMbeTcS0L6Qnzq
 qiRrLIn+6qXYrf3E39BbubP1WdR1rg0=
X-Proofpoint-GUID: nEenI4wI5A9WsoBOJdRn0mvcTruXkcbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX2tCKMucRezGC
 BF8vXWA1fDzIIgu+X9Tl1O+lPvlyWanT9t5/js5Y3JbPn24+TnNKNI5wJ68E//0oM5E8AfBgvTP
 8InpL3/PRyYJ/WZzaYqTkTboKsWqrsnep0WoarYT/IobmIpcjEp6ZbGG870I/reH8Wa0jNMCvsZ
 GRGgm3/4g7FQHlEEIXDhcSVKKUsJEuboMOrNku7l58g/V9uNIPvkyJF3nshk8Z61PP6KyoKejye
 9ckTpKFJqPsHAP/xSq7rOO2OGwliJqbD/Lc17xw0IOLH5xC7YcSdAvHD8jvyd6w87C5+PG7lI1C
 CTOHw3K6IXpZzj3Mq/CsytveU3grsgbrtPokCIKNEW/UwFL7FZ0cuxt8nJLuECvCmKglY8Vbe88
 oYKGglDys1Rh+Zublix+x3UD5kAYFLJvjyEDXXObyCSHSvkxGuaKqghGOUe4rMzPao99S/K2IsI
 OoJDE0xT15Y0nhQYELQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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

