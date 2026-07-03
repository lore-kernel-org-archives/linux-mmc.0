Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0FE3DA7CC
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086328; cv=none; b=bQP718Kyw8TFIfY1y1Nww8VN2Amgs5db+xPlojpQoBSdZzZldIKwS18p7XnApwcvLSRq4hAiEoElPKRLAsKoKnxPYRZgn77XQIZasU+dfXELIhHKv9gDM6R2aPuHVkrvG8ZrrcfGBG++3D9BXOYkjYJ+Ei1fNkDhvlkFqI7Nf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086328; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Khfr8oTS3c2klDKgvHbTAyNArbpE6ijoPjLvGW6knka8Tj7rjbkt9GCQl0Fb0OkQAWv7o9EVgJ/aov/GXQr/wxNSNBZ7RpntKv7YeE8vEV18rfOHQUif78R79QwCMrtW37B0D8utDPIshhQNNkEIpmpo7RAs4X+VEEiKonVfMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HamYwJft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iIE09BZk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HamYwJft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iIE09BZk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663A2t083772699
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 13:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HamYwJftlF2U+0WQ
	8ZeaDZbNjDDayS3W7TsIqcAxTETXucyC0z4G1o4d/+ETQoYa39mqeUblscuz+VgR
	jV636xWSmpXDuBzmtz9fqW9RN4/gtV260m05QH7R9RGwWPQfHI+oTq9QGyxm0cgY
	LC082MkM1T+aqMGRjJcPF9fUgQRAqFopLYt3/ItSHHp0N6R+Jvp7d7H0mhds/5pZ
	dVLN/Kte205KojmTDX/q7hKwfEO9JR+7k8rJWbq7km3eB9DUIF6jMHouqfWuCBOv
	GPHfGAXTrZBlTlZLeWp5RHSaWg8JpTkgjaPniRYdTUQyd/FkcvETtxlI+R8DbV9w
	vigc9Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b038twb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 13:45:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91931144870so49065085a.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086324; x=1783691124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=iIE09BZk+iJKB3zE/G/Sn88RndPO5kbqb8jjrWdXA6pBqNt7Gr9mAu5rN/83PeFj/M
         4wan/dj8vzC8pkpeV8M8NC/g1a9ixdiOSorTUat08w9Kb9npHVjqamHmpZaLUHX643nj
         E/9tf9taWm1Klg7C04Dnfo3xv0MB4+t/lz4VLoK25W1Rnzf/sVr5yMsT3sFP2XlVdqfk
         3hJpMeU9dNV0bF76BPlTqqW+G17HHln4E4ZvkqqW8AkdOjECZ57sFae+UJzHfzIwOfOd
         ZQRpYL08c387iGY01zlnGZO793S7k7+cxIzHj7WU72LAjJUo4OBEndRYNxMvcfxC9AjA
         QhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086324; x=1783691124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=IG+0uob1CdNGumFIyLVYDKVypHMoxFblAsCU/CFTKGwqy583Hd9+xkGTC8Kn5wD89N
         3gD4Kpt5XnIx1wDGiaU1crQgxPSUk72X8pHJ7WI+ElneRpxi+9CMa1YTclsqbWtSiTuv
         XvX3R01M3gUDBRNDa51eSnhxClHASfWNP1luzzlJbjv7WXAmz2sEvscXepD8k83IW6HB
         eSCBLg97Z/uvdDO9GG/ND4/CYMl60+VQUmlMJFZU9G1HQ+WzhW4hZcP3fZfGXzcBHUnI
         gr1MYd1c3wM2wUIyUFkoTogX2WTFtmE+I6y2e45D1Wo5VNXRp2JE3V1N0+6ENtz56xOf
         TXug==
X-Gm-Message-State: AOJu0YyH32f3yjjHRT3R7st7cgRVg5wNlqIi6V1ou4R2H7i9G9WaGmf1
	KSob77DMX5yI1pFVbcAj1aicP6BgPOY7eugU5YGjcEMW1TxLB1VFJ5oshxWDqd33MgiOubfzYAj
	OXuM3IOG08zkWfkps4MzfXzjUpUlT4XDGET0zBlTZc4vr7WLaY9rBBKjfTKHVuIo=
X-Gm-Gg: AfdE7cl/IKc38acQDmIuIQHD/zRIlcC8H+Zjo0mws7+mVdBzY71LLZq9o96dpxw4fNt
	ASSPA6uUJio48WCTuzgvllKuZJzUtiWR/xntiD7OSKb6cr54MsXHuInvEZLDaxuq1WHgL6tqiVr
	orhtjMh00v9daWIkJB2E3/9eUjQsz8NXsQVQdw8N4JGXbNQyPuZmkpAINRZk+WQB9g39fc3CyNN
	hMl2nm55FuP89tZg1Zf2w7cu6espldBvW930wWGd66O2LrFa/8Mwj7FQT8C/+2O31PEQ/V3tdwg
	OGf+n+yxd/7pvA5mdQ+CbZTpf8AA9bIpk6t3x+Mc/ByHRnHs0L+4+eRHq1ioOogvBit3QjF6rFl
	xXDLFiZnAAnoOaEmxg74E3uKHxo3+QMC9zcqe0tiSfpGglzQwPac6AK9SZqkZUdtPbSMbvrfx+7
	bpzlr9I0rKzvktzZUVO1MT+Rj9vG1ofRo3UgBF2VM2NuBgLsPNhx85xqBEXM0B5qQ=
X-Received: by 2002:a05:620a:2b45:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92e840591damr804132885a.4.1783086323963;
        Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2b45:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92e840591damr804120985a.4.1783086323235;
        Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:15 +0200
Subject: [PATCH v8 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-2-98ae32bfc49a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX0v2F8wxFvOeu
 W/kJmLg0BsbhbVnVMxf8NX4jwcI7t6Arxxtln6zv8WFUkBCZ3i7SI7zvVILiBEuHPN/fa/YLs/y
 iao+O0Y3fCscVk1bGzhlkMRJosRT6tw=
X-Proofpoint-GUID: XtXbN5ntRTDvL28shxtK1Ks2mCTldoWP
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47bcf4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX3flQ3aplTsKl
 jigWkJDWt5CKN57eqklq38ipqKW41m3PGa3mr2XAi2xBHrSAc9c1b3wBcTfhfyRe2cmz577rbYK
 YQo0qN/2wHaygEpYsJQ+MUWxoshyOIie7N9fvpPjNNjh05sKu5xFI8AK7w7tmfvpcEFL12weYRz
 yVSps3udqPJbLAIZtV+llmEwFJiloDIfKUPUolcJiZLfTat9X5sBfFdBRGs7veESBqClrFywSF6
 BEpohssLE4xsVsPeXgFdjUnlDtsTrsqfB6vExWCTWIgI+k75HwZM1d4GplGpyterwhmrQTUBlzM
 fW2azQMFhEbc6qAk2O67Shti/6U3++yVMA7POGsilqXY55Vtnyf+CHx+CfKcSMQ1NisuAyZJXXD
 tRVAW8WrlnsJz29SLbmNUGmY6SEEpKt4voQuXZmJvPu2Yoj3nVaqvIaGULa46Iiaav0Xi+qHDND
 vkxkxTAI4SlJl1htQaQ==
X-Proofpoint-ORIG-GUID: XtXbN5ntRTDvL28shxtK1Ks2mCTldoWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
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

