Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902C344D9D
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789626; cv=none; b=WJ9A6bW7z9o86exqZRaXGktw3DfxOZ7i9FDoJBcUSTLispIvrZ3eQ0N7avFqpvrehmrXafzsJsW1gr82x4lnwuGgIgStd/rZi2c1VbOHMjA7C+DtlMHPsG3rIcRA5IW1kMVXiKWYlK+PdAgKj1NJ9lyG+3Ye7ORqKHgm9CwQgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789626; c=relaxed/simple;
	bh=fEDcueaVPZuZZ8KSYxOQD7qiH2fXZMltI7o+8/sRum0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ngg5jNCmcU6okU00WgEZeHezPZsiWt2FgGbgsIJ44KrakwZhaLirYHOARjd0S5nl1/+apqGrOjG8/x1d7J+bSceBF+j2UET3SLddEWGlwvuZrVIkwZ1KWL+xFJC2Gjxj8bjDpuDH3MFbjfprTSdzokolV2Omt1ApyzGBbAEUwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njnnxDwx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O0ghJtNM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="njnnxDwx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O0ghJtNM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aHWk2802213
	for <linux-mmc@vger.kernel.org>; Fri, 6 Mar 2026 09:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D7ShTnqinuK
	M6FTDfKn0IjuJRriONczDYAp0B6s77wo=; b=njnnxDwxKum12Hhp42P6zRnZh6m
	5qZAttBdp6qCHHoyPO/emHNmToTh/AMxSeS79SaJAHv0whqjDtT1yOKczak5ju95
	KGVrD9XzUhf5k5I0eL8NbNpM76cZgdlhagAbRwz+qqZXbT0fELrvNKmozji2lQjs
	m8O0nVWZXvtbUAioYCS8cnV4BZrek0TiBfpKHR46ExykD+T/Ju5onKK+zWgIPH9p
	dssOFkBTwtVaHFXHUnJ9W1IJ83Aa7rInJCp1oDiOW+buFV2draZAfZH1eqjbiYHN
	H2rQQs/3/Mq0G9H5BH9MbVsI/fQKUGt+TxmraxWPo2oE1QoHDKm5D5E2KMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqgp427vf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 09:33:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3597b55adebso4216155a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772789623; x=1773394423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7ShTnqinuKM6FTDfKn0IjuJRriONczDYAp0B6s77wo=;
        b=O0ghJtNMHyl0CVnUt1gtWBXfAYsBsaUuBqpaftLFmW4TrY8eW68jdjzOU5vDc8i+lJ
         Uhs2rlHISod6qB13mi8cpNODDR0E4GPknjdxoetw8NODlgf8w66igG/NAILyxbFlH3KT
         swX1hgDGFSloAPZbylMxzoA9p/2TJTcfawnujbWRH5jMwDkFHKTqsBO2BMYfE/3bOC2K
         HE3f5hBfGq5QysNEH9x+r3fVPNrMUS8/m7qlXGROkvTF5hYUk9hYgQCduVwi8S0KBhJH
         I85Ln8kuzXOFCItJPIWK852v/flTY1ykTQTP+n/m2PDOMWdvECmUjEyV+yw4wP789mgh
         iu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789623; x=1773394423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7ShTnqinuKM6FTDfKn0IjuJRriONczDYAp0B6s77wo=;
        b=arLTgMGA4wKcutd5rqYPUp843jBArmgVrGkJxpWoqmYhc/Y+w0wq1SMQgyZlZU4/nN
         eV6/rO7wyyHmgbgU+eCgG6W5QZAAY5gMsZ8zlphYa2jk3NwnFSy6o2gTfthUESGzEn0K
         1F9KcED14EFFVU9J/DHthFymsfGQCWgY6mFs+2Glxwf+BNe/Rtl3NM/jl4T/XE6pF/79
         obsK8B95m1ze1IfjJ6KxJ1QLqmTNppobBB9BK3cQ79x+yeK84BnKJKliEJv25PfVtyrE
         9nfCojMRdRuhR9kl8plB8PBFwM6MLCV54aXxAnLPxpp37aP6osG/mxFYAkFrxdR/RiOr
         zULQ==
X-Gm-Message-State: AOJu0YwxiOhWuDozOy8o79Hf1beN+ISvS3nv1gVMUO/clFGPiry3b5Pt
	LJuhnjYN5HsKZ6Ss1XnFDpQJ+sSIXdQVnHqEI5eGN+mp0ymxuYJGF+HMq1HjiGyeNk6HbG1wBRj
	wx+YQ7n9gLb6Uud+ji0KMwhJBRXJH2KSMyMAQmQ7IWIkvVX1XKzIRPHrJuiOfftgeaFhexeg=
X-Gm-Gg: ATEYQzztaxjw68nXYYn21kEucFtDSOvkAoAgrlF1QsJD/6UjHVZ8WFvdvdXsswacLJM
	Qy8s2nLNPBiB8zAfX3ern8GkmYY50tk/lc0Zpnha0HXXPU++jMfooXCSrLLIJfpjP7FCLqJPeld
	YKJdK4vYNtRCg6DS5hRV8R7GCsD5IrvtTcMU/0IksRZewPY+hjBquM1RH0e1UwnN6I9E4+RSmwo
	4SfvYcVnZBNTXEjw2EATc1UtPzq3ZknlnKm926txyBNbNyWIDnwMEF0cLqje7ibH02+/4o/9vgL
	LCbF2JXc6XwQSagu0s5qyNe4BGAFSNDZnAfJx14upTJD99FBboaeZGqCg/d0UHjhZwl3ZiaSLfb
	qvF3853iktqlgv/ZgcogGvsv0V+8xYxhexzlACuwbzMT3NVpFrkZz
X-Received: by 2002:a17:90b:3810:b0:343:7714:4caa with SMTP id 98e67ed59e1d1-359be27b694mr1558712a91.3.1772789623296;
        Fri, 06 Mar 2026 01:33:43 -0800 (PST)
X-Received: by 2002:a17:90b:3810:b0:343:7714:4caa with SMTP id 98e67ed59e1d1-359be27b694mr1558682a91.3.1772789622746;
        Fri, 06 Mar 2026 01:33:42 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbcacf06sm647549a91.4.2026.03.06.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 01:33:42 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH v5 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Date: Fri,  6 Mar 2026 15:03:30 +0530
Message-Id: <20260306093332.4193993-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i5KFGtSwY1c8K3_fuZy9ErIgPSnOdeH1
X-Authority-Analysis: v=2.4 cv=LegxKzfi c=1 sm=1 tr=0 ts=69aa9f78 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fvWVRpvV8V6VEHT1R0IA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5MCBTYWx0ZWRfX7Mz76gLm+69f
 IUs967FBW1L2O0zLoCQ1PtkqbbcyhWiph2rXnEFqzSQgu1IDd6a6KdxoZ5oyw79yaniXQh2ZwU9
 0Mn1xogXg8kIbOlHDHZVHptQoZElPRZeNpUXK/iN4IeyaIkw8c4X7buABWsOig9lCTYSoJZQyHu
 W5PiMq8EsxDka9waEtaAszc7E5Hz3mPVNzHxQk+YC09QpjqsNzS2j0npibFn6PxuMazHGK1H09G
 FJi3qr1xqVSv/VCccsOyS/z0ixwGfz09sfeP7uiDrI6dDMidmQVE34jQKpY7kuOtNCkcQbJue+h
 I4aIJESZQ9lGZrze9noUELtKf82oAJW88cYehDmZiBnXOGle1i6i6lsH5b5WbfpzFdl5e2Fw1l0
 i8ueMrcwRcYUR/r9xn2Cgt4GaT0XCTII5qXJEJpmfUb8QswPz2wy3wVoztv0LRsbrqEKVrVYCkq
 kVxDyy0N3B4OVZKI75Q==
X-Proofpoint-GUID: i5KFGtSwY1c8K3_fuZy9ErIgPSnOdeH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060090

Starting with sc7280(kodiak), the ICE will have its own device-tree node.
So add the qcom,ice property to reference it.

To avoid double-modeling, when qcom,ice is present, disallow an embedded ICE
register region in the SDHCI node. Older SoCs without ICE remain valid as
no additional requirement is imposed.

Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

---

Some initial work is done by Abel here:
https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/
and by Abhinaba here:
https://lore.kernel.org/all/20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-1-2a34d8d03c72@oss.qualcomm.com/

This patch adds the purpose and usage for phandle in the description and encodes
it properly in the schema.
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 95 +++++++++++++------
 1 file changed, 67 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 938be8228d66..cc9f7724bdf0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -140,6 +140,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DLL_CONFIG reg.
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the Inline Crypto Engine (ICE) hardware block for this controller.
+
   iommus:
     minItems: 1
     maxItems: 8
@@ -193,35 +198,69 @@ allOf:
             enum:
               - qcom,sdhci-msm-v4
     then:
-      properties:
-        reg:
-          minItems: 2
-          items:
-            - description: Host controller register map
-            - description: SD Core register map
-            - description: CQE register map
-            - description: Inline Crypto Engine register map
-        reg-names:
-          minItems: 2
-          items:
-            - const: hc
-            - const: core
-            - const: cqhci
-            - const: ice
+      if:
+        required:
+          - qcom,ice
+      then:
+        properties:
+          reg:
+            minItems: 2
+            items:
+              - description: Host controller register map
+              - description: SD Core register map
+              - description: CQE register map
+          reg-names:
+            minItems: 2
+            items:
+              - const: hc
+              - const: core
+              - const: cqhci
+      else:
+        properties:
+          reg:
+            minItems: 2
+            items:
+              - description: Host controller register map
+              - description: SD Core register map
+              - description: CQE register map
+              - description: Inline Crypto Engine register map
+          reg-names:
+            minItems: 2
+            items:
+              - const: hc
+              - const: core
+              - const: cqhci
+              - const: ice
     else:
-      properties:
-        reg:
-          minItems: 1
-          items:
-            - description: Host controller register map
-            - description: CQE register map
-            - description: Inline Crypto Engine register map
-        reg-names:
-          minItems: 1
-          items:
-            - const: hc
-            - const: cqhci
-            - const: ice
+      if:
+        required:
+          - qcom,ice
+      then:
+        properties:
+          reg:
+            minItems: 1
+            items:
+              - description: Host controller register map
+              - description: CQE register map
+          reg-names:
+            minItems: 1
+            items:
+              - const: hc
+              - const: cqhci
+      else:
+        properties:
+          reg:
+            minItems: 1
+            items:
+              - description: Host controller register map
+              - description: CQE register map
+              - description: Inline Crypto Engine register map
+          reg-names:
+            minItems: 1
+            items:
+              - const: hc
+              - const: cqhci
+              - const: ice
 
 unevaluatedProperties: false
 
-- 
2.34.1

