Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7133291C3F
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771305939; cv=none; b=KhY5Rixbs+HzS1thzQ+4khDDkIw3N3+ax2wXm6C+jV5uthLiiqxdDGtBAl5s4+2XLVL1DNIS3DBfNwhl5fvHNH3aE37yInfdkPLN/ELEyD5hBDhgjiEvnL/IpWZ/f34NRldKMxOmJs+BX8AcLgtDMoiTRhCWSH+GDEYpzuVMLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771305939; c=relaxed/simple;
	bh=UDGiA6u2Mh2ioc77iBLv2w+58RFL9PLVhVaFyxTpzu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1hlXojSeh+RTWIze0RRuJb8f6es1vR9a/ZYnRgJNgb233QX1RJQKWKNUinBoNucZwKvvmNt5+hX62I0SvX2hRmzMUi12KufwRuRyHFD9FunbsZ3/dLuiwXfzoHR+S+iCakpAZvvj85ncEl2XtBYoyH4OgY1jkMK5tvla2gpHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Idl9gKHT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e0mxOXjw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Idl9gKHT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0mxOXjw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GHbdSY2802096
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SW6o5m2x1c8
	kR5oWPSQwkrgwQFlNO/zECsmjC67PYuo=; b=Idl9gKHT+G95pNP2Yot+LIdGbLH
	kam3JYPNyEJC16sVK+CbNO8UQKtibkq7U3JDNTok+6120QnB2Z6IeEMveGgzyiwv
	GuncEre5lqsjPsDaK7vZhUOAnT0/KKWOZG0WfZg2bFZeZjZeBNh0UzqVeXT6o4Xh
	s1TpNWRE0RlXC3uCdxIcktwD/t9UA6UGXiPUPXUhQlejAEW8CriXnayTdXjwLGw1
	3uWbG4dY5s/KPqN/rr6udSaOdhOaJa8Pg5VmwjvegrYLTCORDr48S9ETgN16zHNX
	mk6qhYrtq1BYtiSO7Sjbhk+DJZeTqHRrcHphg4e63FmlEl3+AOMNFjTJXug==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxujc00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso3640042a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 21:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771305936; x=1771910736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW6o5m2x1c8kR5oWPSQwkrgwQFlNO/zECsmjC67PYuo=;
        b=e0mxOXjwZgE/F7jbrYSSChqDjl3s2YIGClArdspEvjvQH6hB6pmPThacCh7IQpphbu
         bq8l3+//QubnouI7LjegyZGIjKhAaDB6Din6vYASvK4x7Bszajj8eZoO0grAC+Eu4Z4N
         801Y7JIpnzkmca+nmGkmySpGawpl3jvfXlBk0ztvrscxLGqlSFzMLN7hq+hsVNTxPTz6
         GcDK9GYGg2+17xO6z9QFayDDBJStI9GgTWaVhPpi5hQfeAQp5W8tUHb8CUKNzyIXEnVV
         fibon8NP+HUxlE/shdW8EwxTmw3lmT0V7V36Wjmkud/k/i7PkSyK/OCnWb1e52wFRbQ1
         Bykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771305936; x=1771910736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SW6o5m2x1c8kR5oWPSQwkrgwQFlNO/zECsmjC67PYuo=;
        b=HFr4dq5MBpm5AA3LcLO2mnxKm5BYlQIexl05eANRMIEbohtWC8gydRxKWSOuq8hNZ7
         ZgSTDYIDt/nkb+nyd0mlEzwTLBbMvPDm1cy6+jl4Fygt9hN7Gc9xsDADjYxqbn85ooK9
         Y1cNGbQP2T3O/46dWTj16iO0Av+WzFtNBt588tNhK87pzmkE5fRahlFSPzwC95fPt8kr
         9djmHGTd/YbLTBRknFS6ty8TThKL16ix92WrBYYQYj1PJgrD/dMWWTrYPpcOMvvId8OW
         sMNGir9GTdr1z/IZTkIpgj5A3YPVljOJd/5RShqFPdaUNYVFXpu1HR51ebG0XmNjS0Tm
         lfcg==
X-Gm-Message-State: AOJu0YxbMBonP07L1uY0xleCx1kH63TnqSxhRMuZ2wDE45DPEk33wHfn
	6wtuzi902+fQEheFhVQl1xL845/JDD101SFVe0vK3oac7rXknCY704QPzFfwu4TwuGc+WkyfvJE
	m9usCYmAUZm1XKbl0LG67DFc1vix+8aqL6ICqOfxirW758vcHJJzRqUkVsgUD7QI=
X-Gm-Gg: AZuq6aIGI9kEuJVGRUlNW6V6CSq0rxH3grFV7i191xL+Ni6X4ngnithVZwjAn79vk79
	AU92yJQSmMjp/3MEbus65d6mNiF/INKQi0mljYcoVo7zrb3KVGPayzKv9G9kx3bdO9GfJ+PmHWJ
	sw/F2zjxmXGZAUBVqZlmi5e0ANqCwMb7S3EioFIqEDs3a8mjxiXYaNkLrouRv2wTNb1eKpFbvmy
	zqDxSBlRkU6oyEICe5J4mOnFrLhGXICCyLZ2cXpVcpz6O56hpbwXJd4WJ0XmdDayhKV6nkuJeYS
	4Yk1ac+cO654LSktKXmPB3Z4xYA9qKg4F6FdAwVwdoBzZmjULEMuljCcAqfH1pAzYkkS0cgyP9a
	CaHVSJ94M25WbJPmkEKea4DyVMDAjYtR16vICMI0FjpjUQ3dfDxOd
X-Received: by 2002:a17:90b:4f88:b0:354:bfb7:db1a with SMTP id 98e67ed59e1d1-358450c9aebmr7523960a91.31.1771305936461;
        Mon, 16 Feb 2026 21:25:36 -0800 (PST)
X-Received: by 2002:a17:90b:4f88:b0:354:bfb7:db1a with SMTP id 98e67ed59e1d1-358450c9aebmr7523950a91.31.1771305935995;
        Mon, 16 Feb 2026 21:25:35 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a87f47f1sm6537685a91.8.2026.02.16.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:25:35 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Date: Tue, 17 Feb 2026 10:55:24 +0530
Message-Id: <20260217052526.2335759-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gS3cfenUmXklv-_-G1mMHygEso_jqKqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0MiBTYWx0ZWRfXyjjbRD1SMJbE
 GONTKY5AD7i1wUiiJkwWXjWn8QmTWNZSkBBcdi6+3BhtRKqnZtBIi0wbZZzt7peNqFn9T4qFdRS
 YswqrwRZTvkVgCPq+NQrmvKqjspbrLufQr6Reaw01GHV2VEY/jC6x0nGkDa+lBPuNCbxfqEri8Y
 WMGSz2NjIe5hpmvkxY576pOFMYolXd/eMgs/hBl6awl8ZSCBAx9/f5JJ9UJrJawS9eUB4Sl3VlP
 cOa95svvTXdrnyFbHkUDMdpA+NrWpdhZci/wvsehkNnYrOsKWQkpGmPXQdCRne642GUgmE7Qk0i
 i9bMgKiOzTzWQEAsgn4Kev6mvwS+pWTJ6Y5waKESvJ1s6IrYnSt9I0hkOVkvVXTNe2Bk1arJurk
 whktVrlOcT9tln+A18h6YlVA8oWTPm8VxGQMQmYodYKmSAdYioKOnyqoNBguvH03m7KfuvsX7rD
 3Ez4RP3Gre41OF+vkvw==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=6993fbd1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=MkwR1HCittXvMrZHU44A:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gS3cfenUmXklv-_-G1mMHygEso_jqKqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170042

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
 .../devicetree/bindings/mmc/sdhci-msm.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 938be8228d66..9b902e0c8d09 100644
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
@@ -223,6 +228,16 @@ allOf:
             - const: cqhci
             - const: ice
 
+  - if:
+      required:
+        - qcom,ice
+    then:
+      properties:
+        reg-names:
+          not:
+            contains:
+              const: ice
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

