Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A7380FD3
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897329; cv=none; b=hFqlBf975sNAsPZ/dU4fxex8OcDKUhg63ElqLHWYsWl37EFuSiU3HYpS3vKhKcebXXD0s59H7LhSUU1sKu51h5H0Qmha5pm45SGhSl1ba+8X2BoPcsM7ZB+Mk87mAyFQL/8Y9M4IJF4kDU0DPwQmjzjBfgJSyeTZ+m6yXl7MjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897329; c=relaxed/simple;
	bh=O4cVCaQ46n8Ms5D3Bco+aQwbzl8/UIR3ClZEnBlY0Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ue0nO5viXdqwKveOeF0CrsNQ4hkk7tXkiRtXCw+Bc7UOJZweEmwZ7254yZ+vu74FoB6rR2SYbxBJjpCeOHCX7hsgpoDLyRVo3vNL2H+l6E4YfPY1PFg08e/0bwnc4jB4+8ceUAI2Jvj2e/gw5WDTYcccqC31cbjIXkReRaaw4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ue0TQ6Hu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/OP1Yey; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ue0TQ6Hu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/OP1Yey"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mTSu2152267
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzoIeP/9RJB+tfcp0der6+uQoAklbzCN/nK9ht7zzAc=; b=Ue0TQ6HuLggxG2UQ
	pzIx626T4ghJxbF5OHCfrB+wxqp+xGpCuT9tCuFDqvHoCo3D257w5I82asfaEr82
	Hkcky9s/R/LZOWzN52/ucFmcmEspzIXQ9ZOGge1ZF1vfOHQqiDOrmrg+LlmdtfzB
	TQJH8EFpa+pW2urJ9zQZ7AjbHv1ZeEYmP+nN4ho3FEbklzU+h0xron0k+OTmXr/n
	w97oNiSmsG3bAo7wm8GrgRlss+oKIbbuZkr2eiYWoJOgNTTSSJMHm3cuLOffHN+f
	zNVDviIhqaAhLWUzjDV/UPldn/tUc+GKh/Ar3I9D8yFRs5gFiOMYehrp6qL26UfT
	452Gyg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edu6rj6ah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc6899bfb1so126052095ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779897326; x=1780502126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzoIeP/9RJB+tfcp0der6+uQoAklbzCN/nK9ht7zzAc=;
        b=T/OP1YeySfEykNQWBjFqmJ63jzC+XJcA5sT9gDd1ywnTAQsHqtnNWiirruQnPgjziu
         0fqBZ+JjMf36C2dwTnWciRIGDTeZvhQfVGRWAgvUC7nyEWPlqxtcSv44ZECPMFd0wuib
         SfQncHyokU8O+F8Rq2NGFD58hvFgMofvQHBMq4u5/4Fz3ygtbCW0yJ2CIfyjf3RU+eI5
         8UsA0Jc7onJ5+trVf/2U1hDcY0ziQ1xvJ/6oZTE0sZwB98JbJIK3fKdvfbhFd8uBboqN
         SBS7P9DqRi3mZTUP0V9v69h+laia1U1AQLSQwTNfd2pNMhPExjsM1Lc7ijnizrJKr1fQ
         KJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897326; x=1780502126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MzoIeP/9RJB+tfcp0der6+uQoAklbzCN/nK9ht7zzAc=;
        b=pog850PjuHx4rNzandq7PxAJPQEaQ8NzV0CKtFumb4Cg+4MucdEC/rI7+GjgoSjto1
         M02DQOnAQixJkm1HS8mf1SZK3PZj/gjP1EaDAE/Peu9lMPkQaYaU8ySnPVLvuzW6nZv8
         fva21gVyPM7kJxTwU6VNmQaru/fvKN63W/H47pc4CstyaGd+kPksQbiFCnvA8jN05JP7
         +OnbULA4PdI4cqn5tMYa1MqpHBomAR3MvKVT8vkXndLjerKVpXC73mjCYSNHAo1gsoq/
         We+XHEKzqozRTVUyM2akxexL7VVXISIUpOM2IIBjccIWHejGo17uPsvsajTOISz1GFba
         N/Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8PXBctCVtGDfVA7wdroEJXiZPJQnB55QkNaxST8xIBz6GPwtdXg9mWoqy9jJ17WsozVQ+9PYvG2AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeoyLDZsmdLoxst410UsSr90oPCJDWIzms7qSZIELEkHLJBKp
	fYZ2/u17mxGsxEh4wZkcz0blCbk9gjU7HfELQuVH6VA5XjUZ9jeVW/gmYawDrFfi+VsDIXaHnvI
	4ezm7oTDENUE26YwKIs9TUGjY+SoIyFpB3Dqz08lBdSKobYVehwevQsfLDtHpMAM=
X-Gm-Gg: Acq92OFKIi9obji0ZN3QlcEO0IBZMz0OCoJwLloUUverivRK9y0ReR5X+DQaHMmUQrm
	PLl1jRgCtSgWuTTrOpQbwzt9JVqoot6opOn0cdbkgCJRYeCQanEE087DJtzsZ0bLNrdj2UfNtJI
	OPqKYOd493wrf9/9Ui9yoDk54yI7Co/lz5xxVFsnHUJGRZIAj239j0u05eDvt2ukrvnTLVnxHjG
	N36GPq9mXxRrhMMcmhS/KAsrbRkD926gBH75lRsoO9Jlzx5oniPg12+bcdaSqEi3zusENBe//Cp
	8zc88Jh4ISsbxXYT7oiy+5tnAsPoGpmwgxiklEd5Ql8jO76UU1zpaeW7gXguhTEANEmRYIry+Y5
	rlFvZkvDX4hcjvVP73B6o1N9Y46qHY7E5G6cx
X-Received: by 2002:a17:902:da88:b0:2b7:ca38:975f with SMTP id d9443c01a7336-2beb05b57c8mr265814445ad.23.1779897325604;
        Wed, 27 May 2026 08:55:25 -0700 (PDT)
X-Received: by 2002:a17:902:da88:b0:2b7:ca38:975f with SMTP id d9443c01a7336-2beb05b57c8mr265813955ad.23.1779897325040;
        Wed, 27 May 2026 08:55:25 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beff36894dsm1264135ad.37.2026.05.27.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:55:24 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 27 May 2026 21:23:51 +0530
Subject: [PATCH v4 1/5] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-shikra-dt-v4-1-b5ca1fa0b392@oss.qualcomm.com>
References: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
In-Reply-To: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779897312; l=1745;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=O4cVCaQ46n8Ms5D3Bco+aQwbzl8/UIR3ClZEnBlY0Qg=;
 b=rDdsXqx2OGS4HgppqsyFw7mstu3UAVMe6PAhzN13fr4mCPzL5eaBydZ50PISMnIlKsANw/AQa
 kp+rRqblaBUAXV5KM+PCA8BfUHkOpqLgyaWVQb0E8b2SLc0gD57pb6g
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=MoJiLWae c=1 sm=1 tr=0 ts=6a1713ee cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nhUW8Zqzme2qF2hNOrkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OSBTYWx0ZWRfX+yx0ZYRcCU0Y
 9/gSVMj64LzUEUqxmP3KUj7D5dHg/foOizEpzcCDYdKav8ZU8NAcC7Ymxurhloz4pk017gaEqJA
 kez0u+hH+aKPyyESf8f9yKTfoxVCYGhsSGlsTgWo7XkQiddORlHc/BFjFXEtznhxbND4T2ctRjf
 UPqYUVlMymyCqvAwTqfOOhvWdfxYLOoNMd9dqtgFiaQ1xg5+vahY02XNQMZSD1AunRpAutffqZg
 G9fRPfuovO38ZGP09sBTn7FKhHq+Qna8vk9JGcoLENp/m16ZGEeYkItIdEKJkxvWSA/BOYe1xg8
 u2S7/0HRek0IchZFTOtRNGtU1XCMdC55MDWiPpAAcJWmoYd5QPTRgErJLISLmezUqSKoJZACFeo
 kuFB/mOnYzqbzck1dv5ocYX55epn3hxvTfZYaIyahaKqQCOj4FWOA88KhEQpGVLA01oakBFvoT5
 baf/MDgKDE+H7c3XDnw==
X-Proofpoint-GUID: za5T91Mwaq2e5D-2PrOHCraP11PURjLV
X-Proofpoint-ORIG-GUID: za5T91Mwaq2e5D-2PrOHCraP11PURjLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270159

Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
form factor. The SoM integrates the Shikra SoC, PMICs, and essential
passives, and is designed to be mounted on carrier boards.

Three eSoM variant are introduced:
  - CQM: retail variant with integrated modem (PM4125 and PM8005 PMIC)
  - CQS: retail variant without modem (PM4125 and PM8005 PMIC)
  - IQS: industrial-grade variant without modem (PM8150 PMIC)

Each SoM variant pairs with a common EVK carrier board provides debug
UART, USB, and other peripheral interfaces.

Add compatible strings for the CQ2390M, CQ2390S, IQ2390S SoM variant and
its corresponding EVK boards.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 50cc18a6ec5e..cf7d241f8107 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -989,6 +989,24 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - qcom,shikra-cqm-evk
+          - const: qcom,shikra-cqm-som
+          - const: qcom,shikra
+
+      - items:
+          - enum:
+              - qcom,shikra-cqs-evk
+          - const: qcom,shikra-cqs-som
+          - const: qcom,shikra
+
+      - items:
+          - enum:
+              - qcom,shikra-iqs-evk
+          - const: qcom,shikra-iqs-som
+          - const: qcom,shikra
+
       - items:
           - enum:
               - oneplus,billie2

-- 
2.34.1

