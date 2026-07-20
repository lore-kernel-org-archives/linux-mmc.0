Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FD41166D;
	Mon, 20 Jul 2026 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584615; cv=none; b=os+e0Aw8PY5Z2BUgXBZu6YS9eTdZdlKUIFnnLQ4NH9YPCmB6jYcq5leEilZMqyMp7acg5WE1uc0zz1zYLFgeHFCqk4ipE06uHE8uVJp+Ur1G+w5IpAcfFuIR2x54SxZqYjEUyXiL4SpYlILEYjQMjQktNH/nBGDWRmdhEiVxb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584615; c=relaxed/simple;
	bh=rFHtA+OQX00vdgu1FIH3BJ5MiynZaunIggegQByo+Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IqS7Y/ijg2g0IxYbcfZeNNjKbba3G0k9VhUQp9TYYwEskv0E1bET8Eb+zaKYsK6cVjme/Rm2Nv6wE/DymLMLrmctxcEUsEjgnwLpLvyoN9Z8PLIUaLy3ElO2Zr+yV+XW9MMSqK+5OoSIUw4YFJOUEq1fwUqM7Pb4lQzVTLnPXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJUMAFGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJUMAFGj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJU0HE3368819;
	Mon, 20 Jul 2026 21:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eirM1jKmLbzUAYJH/SPS2pcWi+7XOaJzK6y
	CZnFBkRQ=; b=mJUMAFGjheMRPlHDbjhdl0XvvmeuMTmrTaC/6pC+9Mw+AwhfpcG
	YV4jjLvwYNw5NYqLmuVxbVgKzhMkaKYixF7PU9BJPnfkNmGWz3gF4fKwn2nQ49Fq
	VIHtFYPW53v6xjBdzjUnVxdO4sm1dW2XX1TTi0HsXdIXa7MSMMcWZZ8y6NfYfmYv
	sMqlFfMEEnO6OrfoOLaDAPmU1sOXScbw4ocDjpQ3wPL2ss/wiurNJQNrbdUDtQsc
	fuhs+bpSeWdIW9pPzFf4jcmAfPbav8YVo6zjHx1pAIvDfIBN/Akl2XZX4pl+7dXG
	ceJ688GO4D1KBOK2/1cZhafoM7ySMgXQH4w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs036n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 21:56:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KLumPT021949;
	Mon, 20 Jul 2026 21:56:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fgj53k9nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 21:56:48 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66KLumJa021944;
	Mon, 20 Jul 2026 21:56:48 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.101.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66KLum5i021943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 21:56:48 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2342877)
	id 68B21644; Tue, 21 Jul 2026 03:26:47 +0530 (+0530)
From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
To: krzk+dt@kernel.org, robh@kernel.org, ulfh@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Subject: [PATCH V1] dt-bindings: mmc: sdhci-msm: Document the Maili compatible
Date: Tue, 21 Jul 2026 03:26:45 +0530
Message-Id: <20260720215645.1464901-1-nitin.rawat@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIzNyBTYWx0ZWRfX6deLzWirMWI0
 As3mRPE58jEcnXsr5T0KSlhKtxVgPQr/NXb3GHkHernfcJJLJVfWs3xNPgPq3tD1Aktzm/q0TzX
 uy44ccp8ja4Ub2TqThmD0Abo5qmJ+z0=
X-Proofpoint-ORIG-GUID: -gGwUT45iVQivOwVLLs5p6kTXO5dk96J
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e99a3 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=KwdnOhj-2HFfZa4zV1EA:9
X-Proofpoint-GUID: -gGwUT45iVQivOwVLLs5p6kTXO5dk96J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIzNyBTYWx0ZWRfX8VA8u7j1vHe+
 5dK8M8oykN8zEaOuVZ6YHRxYOu0rUazZL2NgU3SrZH1386VyteT0DpehJ5hHpgE8XQYmlqL1N3W
 R1ttUj0eGJwo9afYsVnCvQznNOS0F6eWPBdgsFf2oCCApn0wIIAUOmXOYQ32pm8Cdm+CMYrBXGw
 FwHVi5Xr9XZs1zOY6qQscUagciJfLMMv4aWl8bVALrsIrAlluRqNlI8yUX8OniULNPVzNOI32rI
 QcyPi8x7cRZzNSBWoPnx8I9A37lzeZNDn57vvCVmfio1obLxlawEoyBPqPuXZdJ9JfT2bCnssdF
 HvU1RKh6/5zY0KmH/dDZU3NuhB5WNffYXo2LXJNTALiVyAtRrzXwNuXCgWXXPb6++hZVM0c7cyK
 pu3Ll8mwjKH1g5+Q6QM/fW2BK0aCNcbkhidPMzLv56VbXUrIMoHwbox8ASNNuziiPXrs+6SVv3d
 812JZouj2YNwyXBVqvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200237

Document the compatible for SDHCI on Qualcomm Maili SoC.

Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
index bd558a11b792..8dfcd1351551 100644
--- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
@@ -47,6 +47,7 @@ properties:
               - qcom,ipq9574-sdhci
               - qcom,ipq9650-sdhci
               - qcom,kaanapali-sdhci
+              - qcom,maili-sdhci
               - qcom,milos-sdhci
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
--
2.34.1

