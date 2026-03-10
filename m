Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A01381AF8
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142569; cv=none; b=ApfAPOjip/szUIyoiDZhcIjIc9TM5qwvwt5YNILKJrMNmHF5X2q0UcDt0jK+DpbiTJMGnBHB1ktnKvqJLMl/VVwRe7deqOVuHR0e0FzAgFkXp2GnPNz51BYN3Cd7eRdeBuzg9b+57w40yeDu14SX0IxMDQw4KM0yEmWe3PaQBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142569; c=relaxed/simple;
	bh=YB5H6nKDzuRtgFwJ1i5Q/Qk4kcvZWSIfp6EvmZloeXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KORGIcPWqUi0Qwm5elcCH8BDf95xdJ6kt2EsoEQKiEi6IFuJTLQ/l4tWhC4f9eM2FCen3KKIimP3qH0ejls0h30+dROZ6LAvjFufSY8TkQHvHbhidpBXmF/mF91tfgsVYTwxGXJLFonUgzZFCFx1l+5d+TIAWSfzUtyChDsV0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOhypUTL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BvhEl2BW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOhypUTL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BvhEl2BW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ABMGPD2021370
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=U+3L4zEcyWq
	eULxxEKN5YBsUaEbvTHXmb/NCvqIMPoM=; b=kOhypUTLtFfecWERK5IcZ0nUGu+
	BjoxbrTdq8L1EvAYXwacGvf+Nzsp3tSHaElIrzQ4jCJ4pfDBo5T/DA8tu9Zbr7ZC
	F4jgdDYwWr5mjnu70PqGwrn/c3Zoh6IuHOMpsj3ALXXbaWN8jreLooKLdrFPpIGV
	4yN8A56zE2ZXWZcETcHsNwI3JlyitRvYZqCpXSBAx5vmt6SFVXX3N2BWu2VdbLXp
	hAYQc33oy/hHQ7mN0u4BRgXgL5gAjaBkIfSAL97bMRoobisbu3KbjXq1oKDE3wIv
	bB7mI3+tuZvgtC2LNUGj+XhzArl542HGgFrnuq9nL1zisT/voLTuYNj/Wwg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cte3w94mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829ba0e63e8so1082183b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773142567; x=1773747367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+3L4zEcyWqeULxxEKN5YBsUaEbvTHXmb/NCvqIMPoM=;
        b=BvhEl2BWtjNryLB7V2ANtJviJ7BWyCOTKCnXG5yTvKUMJKMiVN2FdcEMKIojnZ4a2k
         iH9/s/H1aOon36s42m92umFEWwNIPW4MANV28al++5Csf8BcDCGnZn/nM7R245T7vKKl
         Zwe1qlqU2BljJIZTT7HBQO9lkzed5r+Iya3+/wXeryK0rQl19w/5D3Fvr89B/R5JFL8e
         TCtW5DfIU8XmlrNuo8vA0WoD8X4M/HesyKHqZY/FjT2arI7i63alJSzcws1j/FrA4T/9
         Op/eD/WgCCcCn3is+q9iKAVHKfJ44q7yktBBM7NnT8E2iF0y7vuJxC5eVGRJ+1Fq77DR
         M7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142567; x=1773747367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+3L4zEcyWqeULxxEKN5YBsUaEbvTHXmb/NCvqIMPoM=;
        b=Pq8UTLrZ40td6qYPAE16pnkPm7Glnb3cZpLdkwKKoIEXzph0wWJu5UDy5q4ZkN2eq9
         15sxWmqoIS+t8xQvWKwvoiBHM1o3Up7nKnKqGAkQ+0JQXIH873TbgsBV6cTxwGX92Laz
         Fr7rgi2WjK5lCrK9izUThwE67HVoSR8yq3DGwR3Cf97JPV7V4+ZWhLeA2atG0uYZrLHw
         QE5VAj5aF/jFmGqq/vOVu9BotusxGunmonlnvqRQAlEYRXT29y40NLFIjz1Dr7kSYLU+
         s1jf2JD2y7/Bbk4yINKN1EMtuOpGD5+0SheJnrv96CyRvLG5Nib+PhrNHIKwShOPTCpY
         w3GQ==
X-Gm-Message-State: AOJu0YwpnUt+2orQl0UqMLJ2R1m9LbAOTiMr7MYzE74f8WI3foXucWx8
	9HZb4pfhncUNaWEi+5O6hNH/a3srIpBDuicO6bSUVymE3S7y/eDzBmHjYgOnpeQ0D1FvFX8h+Ih
	Kf8LoqiaM0//L8wyQ+IGaQMHzID9GrMhumbbgDjDYn/oef/vPGkWITth49FKlSPM=
X-Gm-Gg: ATEYQzzvfO6+Pehlv1hTPSApZDwmcqr8Ic/L+rnIAbXpG4S0NrQzroLO42y03YcFE+s
	e5uCbkQCsqC8oq+WYqrez5szX+HuVASJgAB1DTJ+q5eSBWNmMJQEKslyLjB0iVBjWD/xaytVt/U
	ec5YIYDW90r27ytg70ZUEhlYQ+gPplDH9mrsIn3m6PaUIaQS5iOEL0rstE/sWaUbUo6WgHVdm1m
	QSnjPrbN/IQSIXnrHLikMgwA6RmIgOpE3zTBrTEqwL+bFLyaG7WICFBTaYuGe3q+jd6ky2lS8mM
	LEEb0b9SfOjJkTfYGKuoyn64MkxEk3ri/AD9dh0uJ71K4+ECkfQVJESMg/0W8Qq7V5hG71CE+GL
	ePFS427ygWxR5ozvaNJ7Pd4AeoUVIw/Ge28L9uK6Bq2c5NGnuglkv
X-Received: by 2002:a05:6a00:ae0b:b0:7f1:7b2a:ab5b with SMTP id d2e1a72fcca58-829a2e764d6mr9679703b3a.27.1773142566721;
        Tue, 10 Mar 2026 04:36:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:ae0b:b0:7f1:7b2a:ab5b with SMTP id d2e1a72fcca58-829a2e764d6mr9679684b3a.27.1773142566247;
        Tue, 10 Mar 2026 04:36:06 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4637bb1sm12364659b3a.10.2026.03.10.04.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:36:05 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH v6 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Date: Tue, 10 Mar 2026 17:05:55 +0530
Message-Id: <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMCBTYWx0ZWRfX6iFsFZtKZ0JZ
 LbEH+4/ESrJ1QuX2+UPcFcvnuq+enh/cP46w1VqhtBcnv9pJAbKGFzj2UGQSpQUbVLwsSS3Z1qk
 SXCtTses6IDQXuOR/S5A2hqmOru080S3ipo5TJfl0eshbGZX71sgQvlaNhOQ/Z6JkJ6hy+/MV/T
 8ldXizKwKGddSKBABK3Nkv1EWvNbW0fMrlaDYCuOB25VPGl9xXDSyHckqqEDvCPZDWpRbPPm11H
 ymxvk0DriRDvk/Wvmq89tKEQzALyC+0hGpn9rMGt9nPjyV/EQnbwxabEpJdLZyLWZphBJwURLRw
 ft+0eEBNUuIIrW327o4oQ6Ou/iLVK5niGoz8FXyp/iPqzsMJy9tIYU28uh0DrcGLdxftFjO9tGP
 8RrxwZLKionc4YJLOpGKMzR6uEc0X3XycNvPNAx3LcM056iNts6NgyuCFxNbUxf05ZpQVkZbL5S
 hknzMY1jp1pFqojxizg==
X-Authority-Analysis: v=2.4 cv=GtFPO01C c=1 sm=1 tr=0 ts=69b00227 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fvWVRpvV8V6VEHT1R0IA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: K8JznRPwGGGv9kksGDuKa_tOMgFah3FY
X-Proofpoint-GUID: K8JznRPwGGGv9kksGDuKa_tOMgFah3FY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100100

Starting with sc7280(kodiak), the ICE will have its own device-tree node.
So add the qcom,ice property to reference it.

To avoid double-modeling, when qcom,ice is present, disallow an embedded
ICE register region in the SDHCI node. Older SoCs without ICE remain
valid as no additional requirement is imposed.

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

