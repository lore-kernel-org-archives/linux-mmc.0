Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE124501B
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983167; cv=none; b=fpJrwKUX/62dYPIogbrYa+2OVFdP+23o9tyD8R3L5d7C1311dky0bkepgeXVaur5JOgW342gBuY1EZwdUtTHgn4/cgzteBhjdh0RFUbod228/aFfQ6uVZDNVtQgLdEIHlWNgPxk5J6YTf7rojUzRj/iK7UM/FqZqHxujrrB35Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983167; c=relaxed/simple;
	bh=jJNP7fhiYa5NXhP2ZCyBQvZANGHpz/q82PDVglB5fWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDnQEtL8DvRwpgo6XNaum+octhq/HSDdbr16FQiwr6WFhBYRbd0ab0bIQ7kUHTEDg7FVanFJlALTZulL4WE3bUvZwD2vLWtNs3iKEZ0KSdvKRTvUL+Kx4x0GiUewApZCnnmbNIHjamai74PSkxrLoWXbw53Z2BOaZymnWBJq/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XV0V9zUy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P1SCBsom; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XV0V9zUy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P1SCBsom"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO7QAfM2241658
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cUF0GA4Fgp6
	HZRZuuhnb+qO3BSsRgQEVHtyoMxCiTZ4=; b=XV0V9zUyQ7oXAksIcxpQMnBrhJF
	g42+Mt8mVt5UB0quUDcgzMYe0RfVg6mqMCjLkHJOLNX1yyK0FKI/oljBpG5kBbB+
	oCG9dp+Q7QNN+r5+3HGr58Va+oGXiljnspDJ6h/HRFxSSvRc2pByV99nwbj7ylC5
	FJL4WN/6KW8bCjQzm+qpscXsNavnvHjRag5cnfldAB+UZq6obmWrsNpbwyJVxB7Z
	V37lx432H2ddLEQ/7jxMj6oNRCXHCU9+EdqxxMb65AnQGYFEKeO5XgrrrhmbVjWx
	0wuBTnXU+tjw96TJ7rAmKikbCqzJIABPxF1UM49wDjQiuGc5mN2YWLyzANw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak6cdvrhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2954d676f9dso29219985ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 03:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763983163; x=1764587963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUF0GA4Fgp6HZRZuuhnb+qO3BSsRgQEVHtyoMxCiTZ4=;
        b=P1SCBsomhFc4srr6qqW3fiubVuJO4xW+vjLeZUfrypKPiqeaOR/8H8XxdjhnQ+nsqM
         bbYSl/KgkCJg6epkpJaCnXKM5OnnfZJ562BPuisbsFTFx8mwTjTjn0zI1N2c7rNkbsPQ
         0GOk0Gg+W/qcOWsnh7M+jPKeefjSLSXGIg37GSDCG925hp6Ztg+tnI8EDkf2ZTzTUh1/
         RWfSDJOZUfjPpgleroB+RuiM4veTht5I+AtAgqgDLW8hpMk0yyPic13PEYQp05/NEtlW
         gTqKlQV9soyt7Ss9Ho+I69J9kquWZthA/lIBfchmsBF/pr3USrNXXBugxeSwaQ5V0XEC
         dZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983163; x=1764587963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUF0GA4Fgp6HZRZuuhnb+qO3BSsRgQEVHtyoMxCiTZ4=;
        b=c3kF5s1It5STVJtfuwFX7dxnbTYxoAFEkVHebBKzTvhj+8JDd41Wn60yCAFVl9ErVl
         zHQsNB/8eUPdJSLEi87xNnvR45xaZit0s7UyHx2msXa3SzEQEE6AyUSfL+dHZUjRraEy
         vmIged4ilNbNwqXQVfdvEQlbNSRrU3F66cJhnZnVHMX1LEGo+Uwn+KT0WcN4tWjdZ5cY
         AxjAI1PAO6Y355ZmJ3t+dTF1ATkNrm7lGPqM2zyfyoE8tp9c9ES5lRwz+5YGepd+TmvW
         +kPgJN4sHdyqqw3bBBCYKfK0IuHXNC5mkxWgocjiE2oMZ40kgXRorWWChCfwVNOkJHvw
         sjYg==
X-Gm-Message-State: AOJu0YwIgz5mmDivyqvGyrA1BvpA4Xh7i1JnDkI2NT7Esu5/qp2wFQxI
	y0DKNzZfdZSRgxkIfa9vh+/0+ZHN4FogwNx0xfKZsvdSkSsbVLdqk6c5RqxHuKZaaiZme207WLT
	a6njwnHK2Qy1gx6tMaE9W0tFg5/A9viKb+6akkLRjBFBnn5HrHYdNWLMlT34uIFVUUP2DOhE=
X-Gm-Gg: ASbGncs4UebStcYBc1d90It300E6MoPEL+BolKP1DfFRALj6ViDe95c+YhbMyrmMrwK
	Wmi457Cem1MKrxdLUmgzaZgPVCRSwBvB71hAAHl8BweyO/bzRbDslZuaFLacx6hVVfBmfMR3RKG
	cY0qDRXK46maSivbEjDBYaDtVWwgPJKOpEC3zt3gIFBs/yq/aYM2n7aAUHQXIbISaAZN71ZPXMj
	aunLsQpOZ5EyHOjE17q37zZBG5FscKYz87SYQZR8DCTU0L+EDH98/K+10gphkEZAMWuBLF7O2Ho
	QudEN6Ukum5SBdBvvQm4bpTqTOZPhzCtFuGzyp9WC12Tmavf3lAgUTKGrE2b5Q62+GF9LwYHxgW
	BauSGMR22z4ml2h8RohE3GmcZ+v+z0S18YwxL2XRW
X-Received: by 2002:a17:903:1aec:b0:297:e252:9e50 with SMTP id d9443c01a7336-29b6bf5daffmr131941245ad.42.1763983163450;
        Mon, 24 Nov 2025 03:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZfyj4YguZoyGyeuCaIVX5lSOuQhqJPS0C8k4q3kuES2AMA+MD0guN4v97F5K/TusgIeeSHw==
X-Received: by 2002:a17:903:1aec:b0:297:e252:9e50 with SMTP id d9443c01a7336-29b6bf5daffmr131940865ad.42.1763983162964;
        Mon, 24 Nov 2025 03:19:22 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b15b851sm130313165ad.43.2025.11.24.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:19:22 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Date: Mon, 24 Nov 2025 16:49:13 +0530
Message-Id: <20251124111914.3187803-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
References: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bsdBxUai c=1 sm=1 tr=0 ts=69243f3c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4iBehzXTjlExH0EJMJsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: YIhOskLYGAIG2gL1KYJvi44YXbtEgpjj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwMCBTYWx0ZWRfX8gNVid8JLNQe
 of6uTGPcyjIUjyVZCUWI8LLmUI3eEJVCWLnBrHp/GneLQnNLksMER5lY47EDndNcOHXx7ahMZgi
 BZggoTME2A7gG/d2wax60BM8G0Psh8l9558F04m0uKTl5ZRRLyHjkdsxGHdebBjBJXlmLshYFhD
 Dxetsg6cSc/ne3LKScd5rYAaoP3F4pJl1gbcaVN7qh04ubwg3USIb62xUqO/wxnOTd+WkcOHvUO
 cHgObHPExyfP1fCPs4Bo3OaOIACJUzZuKMdsJPGW5iGQoXRKq62T8eQytLq1euDjiO/VQsXOReP
 UXKXFCopk6q1Pnlk4wCZ/AC0219Iafa1CRop+OxQNmQXlUTpJRFkh2PwtDIu0xANBzr1N4V3acD
 kOG4HoSSUIiP2yoqRUvffCsVsGkoXw==
X-Proofpoint-GUID: YIhOskLYGAIG2gL1KYJvi44YXbtEgpjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240100

Starting with sc7280(kodiak), the ICE will have its own device-tree node.
So add the qcom,ice property to reference it.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 938be8228d66..154f8ce37da6 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -140,6 +140,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DLL_CONFIG reg.
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   iommus:
     minItems: 1
     maxItems: 8
@@ -223,6 +227,40 @@ allOf:
             - const: cqhci
             - const: ice
 
+  - if:
+      required:
+        - qcom,ice
+    then:
+      properties:
+        reg:
+          minItems: 2
+          items:
+            - description: Host controller register map
+            - description: SD Core register map
+            - description: CQE register map
+        reg-names:
+          minItems: 2
+          items:
+            - const: hc
+            - const: core
+            - const: cqhci
+    else:
+      properties:
+        reg:
+          minItems: 2
+          items:
+            - description: Host controller register map
+            - description: SD Core register map
+            - description: CQE register map
+            - description: Inline Crypto Engine register map
+        reg-names:
+          minItems: 2
+          items:
+            - const: hc
+            - const: core
+            - const: cqhci
+            - const: ice
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

