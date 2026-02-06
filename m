Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6C39900A
	for <linux-mmc@vger.kernel.org>; Fri,  6 Feb 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376864; cv=none; b=fuYmgcxZbCY0LsEmfcCTL273Yo/PvzHwRrScOBhPwMSHS8m4cJdcJ9Qa+xh4ZPd3UkxGn/ef3nMwg3/ysctBdLIAoQ/6Ie6ctfYPkxbp8CzBe+zYNWwUOIF4AHZMBXaX9r6Kk4PoLkZhM2TbqQMqrrRTz/S2czV5BexZXvHTKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376864; c=relaxed/simple;
	bh=7fzCRKNeico0VkgpfXHDz6wAtWNgExE6Orne5o+vyFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJ4qawzJ5LYghgtZtd/7+XBlcejeLbdlgNf7+DMsNOIrNQ82baIvFttlEApmgbe07McTSvPCpkNnHAlLxXdBhe5LP1SN3z5c12E4uzRqFMDtEndZ3nG0JyffZQjPj4Zdg/Z0x1reR1ILvc7wOuNzFxbSshQD1If1uSJZzukhkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eChFmc3s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NfUyiDa3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eChFmc3s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NfUyiDa3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167Xrql2482237
	for <linux-mmc@vger.kernel.org>; Fri, 6 Feb 2026 11:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Qd51hyAwErx
	4oKxNGOcfF+v2MJgkyQ9ErDoevb4XkJI=; b=eChFmc3sIqK0qklziDh8XPT21yo
	8kl130gRHf+xarJUmpPBqizhe8YKBl0IRNufWZwUt0EUbYxKwwcGFIS8KdNJe1k1
	4KLKgMNyzkXwVxxCxO/eHg9PBg9fhQ9y3CI02V99alX8KgJ44tlCOBNUMzJGJGJn
	aMxjC6mNM6cpVLBskqQlosK6quTqJ8STDdomBy+TjhTsdZQ3XCtDElza7Q40T/V3
	q/OuLwLA6klIVYchfXGprKszrWMd0U5E/k4oePUbyzkG7Nif51Lus6nSE4R5PFNI
	Da5+aOQ7zds81+xrlpQE7wqtC8YOEufsGCXtWgAKX9DyJwaEVPUMXwTm7Kw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c170rea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 11:21:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso1146109a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 03:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770376863; x=1770981663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd51hyAwErx4oKxNGOcfF+v2MJgkyQ9ErDoevb4XkJI=;
        b=NfUyiDa3E03K8z4N9xtV1xkY+Uh2UQGGDQv4ovLqjFbs3OFreHtcGekGlQwrVrsJgv
         jz7FltGdQJcWw9jrq2zNj+eWxaLOBOF7uPxtK3w/Dt/qIjMjs9vB0u63hw5XT2ISe9Of
         dSnh02MjJ1vIrkwFTBfUDVMOIvZdju16H0aO8KBZQYhZoFE/pasR4p13Dfa70S6G1a7f
         u2bZjmmFICdhnoX+foV4ZpdGmVMjULhqai0f1tXz6p/g7iBhaC4isTTXDdhi7Bk/j44e
         s4axFsHwQpEw5/pTWD9YRVFE/BtD23/5Rx9LcRDSAzljvNPj1/2Gacy1BH1qX2BVLhhR
         ruDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770376863; x=1770981663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qd51hyAwErx4oKxNGOcfF+v2MJgkyQ9ErDoevb4XkJI=;
        b=Wb89If6qB3hDoXG/gcMo+/uKssoxTGDrn40RosaxA05LyztjuIknPTdI9bySw4zEw/
         bfJPPQsYr1jtwWQrdmjUGep279+dRFRhTb9kTuS7jxrHT5/9XPxcZM5zQaGXZXnHdjW4
         TjzkYVBpMtCr/ghaB76LMS9s9C4kRt1X7n6RvZl9uBtS8OzJu5aW+Ig1FTBmxynFAYmG
         QUxknc1vfcaYKcc/dbppsJ4M3yhA+Q6dheT+IK7jdU3fQWELla2vTc5J9Bo/cbtRFRau
         qxifsuLsnicvaGsAnrPDj7mTD1jqsbgg6UTjwWFpDGfqXEjGFv6LQEIVxbfIICfU5qxm
         R8VA==
X-Gm-Message-State: AOJu0YwxwNJSHjcMDdkLiC0kDdSWDA5H2TzZUCkBzdf86UjUHsqhh/DL
	V7EgO8aazXEHgiJAZgj7acBEUsj/vdDlO1/Jskw+algexwQ3oAECS6cAuAojr779ytCMLVFO8LK
	cgI49WNfRAftOL7j+DPdsV+YkEB5x8O3lNg3rILgihHJECWaPq2gqtN07Iny5RRk=
X-Gm-Gg: AZuq6aIQ/MP4lB++2XSCfp5EP10CJQUAfAQiPslgJVnvBP0N9WsOcq091Lk50o+BqBC
	RwSBzY6w/qUbVkkRKesNh5goDcvwuRKxghYv662Q2RpKJGQM1qsVi+MOUU/HEt3ReQAbMCuV9Pj
	6sYuzl/stPIHvZ1IwznbaOfHycr4RdODg9LljKRmokEi1EUo7MLen+ZkxrmnoijYzp3+GfHt3NU
	iyI2wRF9jm10ColFg7Jo0hcqPbJ7AECZcPw24GYbeKinkLDM/AiMNOxxGgNoqGbWPBUkrx3A4w8
	ELZ0wYm4MYhG5vEzzFkRDNRYRdg9XvrTs4k+dWDdqF6iKWfymO1xlv7ESpLNMzY04Y6aUDhfAmd
	UxFenq8ItTWUSUtRqVVc5p51jiMW3XxgQ01SpPRXA
X-Received: by 2002:a17:903:1ac8:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2a951984b31mr25177275ad.52.1770376862820;
        Fri, 06 Feb 2026 03:21:02 -0800 (PST)
X-Received: by 2002:a17:903:1ac8:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2a951984b31mr25177065ad.52.1770376862367;
        Fri, 06 Feb 2026 03:21:02 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50211sm21675905ad.5.2026.02.06.03.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:21:02 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Date: Fri,  6 Feb 2026 16:50:52 +0530
Message-Id: <20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
References: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a8PLX3Zi7HZooWMWig0X5ZEer7audj2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3OSBTYWx0ZWRfX6hnxhyalVFkt
 BFYTdaTZZjm1gXuH7CqXX5pTO+cAWxaLCy/GCCF1ZmBBXTAlN/rHAwty09ci4y3SYIWAklP+Lre
 FCAL2986uWBi5A8fl9y0uDdmDIrhBw1bcQE18RizD/X7EKQy9L6aWOstARYcBSFiB7sSxDHK5KR
 XHo4YCbZCkLa4WvKQS5sFD8erBnR670TMyhbYZXI4yPiYqQQ67oVGLvQ6iVCtUpyTJZTCvG0mzh
 XNDUYome3p17RXEV0aCnp/f0Mx2PDwWtTgp9ZXMaD0SuF5/B2bQgoFsMhZ+SEaQRGZRwVemwI34
 LNq2v6oTNdtks5IziW1mR0TPGX+N9QrWs+/hMq87FUnd8QTXMP0X/yDduutbtVnUbSsCfIurvCq
 F/Mo4A8Y48i4+F45aFqmyajbNwDmiZ5FaIAKdpmx0VXWKGQlg27hL4kHyhQpRhy7jGpIYRmyExm
 nTRuLqarQTaySlpCs4g==
X-Proofpoint-ORIG-GUID: a8PLX3Zi7HZooWMWig0X5ZEer7audj2k
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=6985ce9f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yDwxroIEoajhRIdHyBUA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060079

Starting with sc7280(kodiak), the ICE will have its own device-tree node.
So add the qcom,ice property to reference it.

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
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 938be8228d66..f35b675c9f16 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -140,6 +140,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DLL_CONFIG reg.
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the Inline Crypto Engine node. ICE having its own platform driver will use this phandle to
+      manage its resources independently. Either add this phandle or ICE address space for ICE to work.
+
   iommus:
     minItems: 1
     maxItems: 8
@@ -223,6 +229,26 @@ allOf:
             - const: cqhci
             - const: ice
 
+  - if:
+      required:
+        - qcom,ice
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 3
+        reg-names:
+          minItems: 1
+          maxItems: 3
+    else:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 4
+        reg-names:
+          minItems: 1
+          maxItems: 4
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

