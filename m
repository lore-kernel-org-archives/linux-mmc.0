Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956543DEFF1;
	Tue, 25 Aug 2026 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647033; cv=none; b=q45RzpmOJYozqdXNUW/XpqNUUcYMabA4+fLg7VVri4arFRoN5OBERzqY3HOJE7Vgp/wldMp2AL81/s/iTGxbKO+fazTxxX7nDaZ1eD6QbUaMoD72H915DSMVt/1gskG5rwyPTbJRVHJ/gEzxYtzZaXd3a/y6ONgfu8VhkWu1eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647033; c=relaxed/simple;
	bh=dY3R2BieCJBuRXOF3/b2wWYcmKq5YJwaox3pRyD2fso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kc7enec+KUmg7Grlq9GnXnrVDQ1v5qIL5jcKroL4/sJRzyNiwUhQdwbtJr4XnlgoMUReZudmpvmsvQWRfjxEaWw7teK2/qsmCJ51Q9zGC4/Z0iYs9/TDyGeKxUxeJ6dAXvkmopBYuiYast8VkrjFR7QS0pEp2aUu5qhutOEeR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMcxvGUs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMcxvGUs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P896oY878144;
	Tue, 25 Aug 2026 08:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9ndG8C5Pmlsupjsqg3tf9762LO2Ie9IWMHg
	gzETEz/Q=; b=gMcxvGUsfuTTaqXx/rMlwZoPr8OzB+UEjlLkJoQ3ioxEdMW0A/G
	k/MHpNS7AIQINRW/7EGg9fESgujRCrdPpilUTOf21bSw5DVjBZV2SK7KQfV2ZDOM
	HZsyBA3Qo9HPZc0xP1iaUaDJ/x9zLcxaH19XilEEgdi1AkQy9JEVZu9zkP8YyzU0
	+kg8GI9l1zO+JSWcJXdmiFa9pzJeSptFBjruChY8NjYxYJWw4HaBRRVNc0T2BH9t
	+OGoEOuJucPOdKLgqDAOUfPdC5wy79MqBZBnoNyNMm0PRtm/pbexD+J9o7dmHLEs
	VcVN3EnIQQIQFXgK+wXb+ZzuNtXe7FnWU4A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8rqukehe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 08:37:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P8b5F6032650;
	Tue, 25 Aug 2026 08:37:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4g74ujn5nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 08:37:05 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67P8b5C7032639;
	Tue, 25 Aug 2026 08:37:05 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.101.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 67P8b5Uo032638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 08:37:05 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2342877)
	id 8CF01648; Tue, 25 Aug 2026 14:07:04 +0530 (+0530)
From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
To: krzk+dt@kernel.org, robh@kernel.org, ulfh@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Subject: [PATCH V2] dt-bindings: mmc: sdhci-msm: Document the Maili compatible
Date: Tue, 25 Aug 2026 14:07:02 +0530
Message-Id: <20260825083702.3931016-1-nitin.rawat@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: H8BwpSmfGvpPWUat3K9ssP7bZOaB1_uQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MiBTYWx0ZWRfXwc1UHMshgRgZ
 BC7zBRKPsLAW6uyBPaIPVsGPeFsbA1SOWrvGRcMpTuN+23zAog6iDaYQdxJWPQDhCARYivU0wC+
 gKrxlpyVTFbhvDwRfl9olgRbTkguBS4=
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a8d5436 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=knvCIUFXnbKBaXdP70cA:9
X-Proofpoint-GUID: H8BwpSmfGvpPWUat3K9ssP7bZOaB1_uQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MiBTYWx0ZWRfX0v0SdHiWtLri
 pYTm3K5ZNxbWZTfZYlOx/APxtbr1/vqG9kUP0Oe5ttXwSaymnRGMmdRF50EI6gqb0+UighYi/oX
 54QhqQPWZoJyC8GmvGD2yVzfN7iUwNqmxDjkJUP9xvEuMNuJcFQaV4N3DG0agxF0rjXCvXEjNil
 watO7tzTJAvVZvGma3iuNRwQwJvd/8Ogf1oGtErKXBP2weDlsAcu7uEVzq346rm2tIOghSoQC8d
 1hER42D//2Cj7lzYkQDkDZxqIN7bkOZcxsJHenjj/GDksu6AIMjnhS/eGtZujjCUDsLdHcqRpUC
 xAZs8HKX/2W8mhkKRlOXrg+J7kJaQxnrsgIxZpNHsmPWqLPPJfddQB2ODTDC6l1djV7Y1xW8lt3
 w/HXLeYR/Nankjv0MLBm65Nvd0OznpKCjfGss22tzNWv3GsFUzTgQoc93Cemi9gkzeKCX0w8Y6z
 PKfQ0eT2BfnoEd6pipQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250072

Document the compatible for SDHCI on Qualcomm Maili SoC.

Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
--
Changes from V1:
1. Added Reviewed-by tag from Jingyi Wang
--
 Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
index b3fcc1673c10..69bd44e65ad7 100644
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

