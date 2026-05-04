Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549622DCBFA
	for <linux-mmc@vger.kernel.org>; Mon,  4 May 2026 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878827; cv=none; b=CtUeJhu1HYP7WmafgEOnG+EuUrqLY0eskGhAGa1mWmVRoA8L1OlNaVuG8CgIdHMMAIvCf+x6cmLXjWuGr9al7UsGCHb26vhvnTse2KbrC4TFoZMd9sRZXi9l9VbRkHIH10GVFeJ6f2V5CSDafkJkksXMaHWr5VpGBJ6UlDRl11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878827; c=relaxed/simple;
	bh=mgDoBSAakO9qDXsL2/r9FFZEdsZsiOoecAZxo6z85zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XOQGlW3NSgZ51ZyUh3KPvxr6mLlT7AUpRjz41cCThETPzmcZrSR+POuYY4QYWXjeq8pMu9mYn40W2xUKAqyJ2M8epK4Z7aOyYI0iKeuAiLTuk52epC3d97i0Gsk4jOc7fIsGKsEO43Z5EsQ4DA/PoEvr/M6OCBO7on12F5/0k0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o4/Q91Lk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YSo4CbXu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o4/Q91Lk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YSo4CbXu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DNOr3470817
	for <linux-mmc@vger.kernel.org>; Mon, 4 May 2026 07:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uhCXwzdwT3yWeiBLgjZNG1h99Opv1nJwQpv
	6j8pehy8=; b=o4/Q91LkPvsSEOePrTanCCr/SFdDOcFQqQh4TnlR+keBerlQYV5
	BTDcx5njSqnpo/kKJBGBuksiZtDQMWreeHqtvHpbJuJuvJundJ2km+EEdd+9xUKo
	/TKwsg+fITw33YG2qcq1FxYCna9/4EWKLmPckbgzwYAdlvucAqUlCiacjD9mB24U
	+cpGLDXi815BXzmuCDPsH/1CcIYo4vhq4wfaxmJ4aOaW5bdgxS0LP7wwH+hZdXy+
	g1tVMw2ogRFZa+1nvgN1u0RENPf2r+X8VGzv2uJ0ufjjbcxSr9KYS9vH4OnqEgbx
	4Rb9gBdmK3eNu5qrgAvvsC70sraDfTLxH+A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9bvmng5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 04 May 2026 07:13:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b465bf993cso39639065ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2026 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777878824; x=1778483624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhCXwzdwT3yWeiBLgjZNG1h99Opv1nJwQpv6j8pehy8=;
        b=YSo4CbXu4qzhmQfjw0iDn6IQoe3D52LXujWE4KTpuKLkpP0s5xAmFqTbng4AL9TKnO
         LHpQUsHl2+NS2hddBA770M/hdk97EL9W9Jf0tfoVuaXzXMG60E0QIFL48nCHnd9rEOWx
         7U5sbUUvxt4f2jyDZUVT7NR2CFEL0Wah6ug45WfC8vbsI9E5q9l0BfcJgQZYB9ktr9q/
         KMyVbCirK7K789WeZq/usqDN9tFd+4NcS8TaOOqTfsd2O0UdzavqIYU1rZTEe18Mp5mL
         QOM+JuP4KhjDMOGF0HhHzCqmEmLQBIZ3zp6ifaZcCDeWwtJRe88/Kv89k0vyOjKPhO+6
         5wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777878824; x=1778483624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhCXwzdwT3yWeiBLgjZNG1h99Opv1nJwQpv6j8pehy8=;
        b=D4e92ny1V2I5qtOQEfh5JRXcrdXPMhS5HFpoHKNYDHShqsx6JxaPSBjinIKXL01OSO
         wDf9YU3moW6xSv+TWEMNLemTIP4eCWCTbXX9pQSEfvyB83avUF6oQmkRIdfseTEFdpAg
         wHCrtV4+/rNDkM9A9gD/Lpi9BRaNA9VKrGpHx9SwthV6msZLe5ngqwnKskO6c0RETUMc
         QWXRaJCZLGQ+zlHZkjoLVdbFuVnlMPOGr4AACBLHR87EtgyZt2P8jRcjmYmOm4COgTRD
         4Os5RgBzyBM3DfjffPfdQ6CvTH8IgRHjO8hCSQe3RdBf8EqruVzjKK0A7dURM0bCFY7G
         RiDA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZqzArEv3CKgbcRzqOAdBEm1TV/nu2knCf3p2qgaOCRnLqBmMgEfy2tVmBz/fw5ETjUrB0XeUrlEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVM93XJvmqsQ6tQx5cobTq7a+zqHXXmr6XzsTvQcSbacWdx8BB
	4eYYqxtX9djSRP6rbWEVd6sa1hDQxg+Qy86qPrrY3LLBn5jI0E2msJv31ztZCG7g0h23MjK7Gdw
	QVhSmE+CmuxGUnbIlKFRFmXrios/OefsYiSg74ra4S5XUMj0ScrIf4Iqi7HdcZh0=
X-Gm-Gg: AeBDieu/XbSaVHOq8VCE2P+xM+N3PZMOSbAvC3A6aMoIJdQJXWe3puurYGzXR9y/VW+
	oIZgrHDhSOh18fAhk8uVTp37S+lv7c5MYoHEoOcQh5nit1QpPq6qiRqYj9wvc7Gx/1Mee5n7vQ3
	4aRk+H+52xgQ9OwrBLfKLxnR7OG7R49zUQD/JZkq4hPeZwDMPxVnRVnMsnaYqT1pgpucemj9auL
	SUvPfk6y0blQFJnuupdExcjlCxbiICuuz0L7ViDPKm2WU99NHDC9VRtg5QXD/gbP9Rso2B1IEL0
	mnMIuzv2jCSMfo5K4bqTPt1f70fOLx+NoQ5VCxfhWIuVVkSeZB25aNeTWY8t4J6fPt5Bd3WE7PY
	lw/C4IEhml9VxNXo6J0+dSHXiyzDGFNSGnHSXIqchPLA3Ff7vS4H+BA5iF99lgaMLAxE=
X-Received: by 2002:a17:903:17ce:b0:2ba:60a:3108 with SMTP id d9443c01a7336-2ba060a3334mr57979035ad.34.1777878824216;
        Mon, 04 May 2026 00:13:44 -0700 (PDT)
X-Received: by 2002:a17:903:17ce:b0:2ba:60a:3108 with SMTP id d9443c01a7336-2ba060a3334mr57978955ad.34.1777878823761;
        Mon, 04 May 2026 00:13:43 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6ac32sm96876715ad.83.2026.05.04.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 00:13:43 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>
Subject: [PATCH V1] dt-bindings: mmc: sdhci-msm: Document the Shikra compatible
Date: Mon,  4 May 2026 12:43:34 +0530
Message-Id: <20260504071334.1061325-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zmtOQmT5djonBHBQQhV5hTrcsBSJPOKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA3NSBTYWx0ZWRfX3+fGM6q/1q+r
 4dD/fBEKQRghGfAL9+LFAXtAlq0Rzfbx3NmonxKjwNjTpgSYQMYIg6dUxwMnwEteGeqo6jwbZ3M
 a5oHUmjPfzeB9d5PiozmWvv6FznRj85dmTQlPUkjicndDPONHbx4mKDhDojDiRo9ppCBvYV2hRL
 Ld2FBw511YSx5k8dTE+0k5Wnr0lGqH/BO0J68YpIqUSkztbsraepS8kvb/aMFiuDccn2QgxMHau
 5RxM4lJThH/xMvlEYFcIhxSMqWHsBJnTPCVMjfVL5H2WelEFZigW4Q61W6p2GGK+ylpe4aSsSpW
 w23Ay0S8D2z/nX+yKeJuheccDtR7uAEPFI7BHxOqPq/CllHfwgR0ZJn0aRoC9uhi5r7YHsBTg1o
 yNK3jRY0mb8yNWknJ7tmICTNi81KLWYzJJHQMIw5O7ILNfP8/e2qJfkuCtITuwtjVGT34uC72am
 t8sz7WFB20Zb3x0/Q1w==
X-Authority-Analysis: v=2.4 cv=dqLrzVg4 c=1 sm=1 tr=0 ts=69f84729 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=qygL5ZPXpCHcVOvnN3UA:9 a=zgiPjhLxNE0A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: zmtOQmT5djonBHBQQhV5hTrcsBSJPOKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040075

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Shikra, which uses 'shikra' as the fallback SoC.

The SDHCI controller on Shikra is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 695a95e8f35d..60dc6b0caa21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -62,6 +62,7 @@ properties:
               - qcom,sdx55-sdhci
               - qcom,sdx65-sdhci
               - qcom,sdx75-sdhci
+              - qcom,shikra-sdhci
               - qcom,sm6115-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
-- 
2.34.1

