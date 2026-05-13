Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D338D6A9
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671194; cv=none; b=X3bW+TdC8yTEZIgjDToUFXJKgIZEShOuLip6ExeTPuWZaa6GwXiznISczp05U4KQ+juxxND3NOIsOvn8nd1HZhU/Oe4JXejMB1u2jH5dRjWBhdk9J0eJWgFOGkX/96356pQFhFWpk7683QMJtGGo4I+AZDVr5JBXS7aChlwQjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671194; c=relaxed/simple;
	bh=riex9Jp9gsiobhfzqRzI6SaMLT0mbjKk2HzzJZhpT3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=abWHJPzhMlddpIr+7Icm37eUS8hirMY8ljPARoDYLNgl6QH3Ji0m6vRY4D8PXfLB9Q+fcsyThVTmMIh3HuHHvZRWG/xzdAtaRSmllvtbj5/r7uFFrtey/lK2JZndkf3G16292ziMPDhcWebXhWao1eoErJzkaM9lJpYQMFDAPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mVhikmHA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hrMFtvY+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mVhikmHA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hrMFtvY+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DACwkI2338782
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 11:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LU5NSsY7bFPgMWDZ5uYhZ1
	C3WMf6I+mQtjhQ+WJ/8sU=; b=mVhikmHA3/X6zgzgZ2U3G0oJjJqjnvGF/Wyj2t
	OUJtjqAS0jFwrskapHXhJx5sXXOxEF2L+1riZTM7dQN7NnXH1pckLHad466ERj9C
	QccYdKdqGKDcLdEYaZ1qmUqehcGBd8fl+7I7IwAkrIhhp9JHqbqXi1thVXafIoyo
	XECOsEEYebeYGr+Wz1LNT4y5YpH95J964kdyG4AQNrZxgaLZDDSVsW7hOCezExqG
	rqzyqK3ebi68vIkcv9Twz/zbVkbAUipTO3U7zyoTqo2PWZA0tULZEV8g3yMFNvRR
	TsmXtM1hhtSFUPB4PbYIrZ5QRO+SNThbq4pNgS8WlawPcT9A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vxb5g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 11:19:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d5d1c2289so60304511cf.2
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778671191; x=1779275991; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LU5NSsY7bFPgMWDZ5uYhZ1C3WMf6I+mQtjhQ+WJ/8sU=;
        b=hrMFtvY+DYbt6Nryr7nFOD4Hk5ypo2aVTrf37tMsNQUOzVfGd70hfS9kDZq3Y9ta+I
         afyzu4fNzpj2A5UhiYPP85zLlqWKfhUgDous0z192y22M8vojKGikYWilY3rogGttzr0
         5sn1+MVXYXYbeT3FMs0Wqr9eGCrEGIPZO/2AgzmzEWcESrnSOBWfgL4pmhvizWrtt9xZ
         lldj39bMmJKeSgfRDO7YVg8xNgGnuNUIzfXUVyihpaviE2a9ogXZJZa5Y3jhO8ABW6nG
         0qBhdh92Oc4x189b/na1d2COa1X3fC9zS9zBKs38RjpwIlRmWraBs91uDK2t0BUJdG0g
         3NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671191; x=1779275991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU5NSsY7bFPgMWDZ5uYhZ1C3WMf6I+mQtjhQ+WJ/8sU=;
        b=WoPwA4W1OKDV4rqJ/7FtNK1z+vrYMLUWHqs84vp2EU1z0TOZ+D7VpBFwlfXz8a2ryY
         E5jV7VD+a1Fbue/SvSHNoEHukkHce51acLgNAu162jWzmb0Z/+obDpnRy5mUZsELKeDQ
         QIY9DvtGutIDk5AbgXqoLpxoDjmzB2PKZhQWuEpOSlM7fuLMrCNDMQD5AJIjd2PdJD+T
         74Y4SApVAA8upHFq/GaeqU9dwM7hDa0RHcHF5g0ImB4ZeUaP6JY2LX6LbqeSsqmSUWEe
         5EHhFvJe/5Rcbr7xmOjxMJLUqGb6sbBVp++oijIhvD7lnsyph3znBf+LSR6D/jvti0bI
         CBug==
X-Gm-Message-State: AOJu0YxcGmV8OTgdipyty87Z9abZB5dcmjbyLtqalAIMLRPR2CKLcyOJ
	hKLQP/zhb9cvvuA+sofxM74oVzlFWtEGwYFOhkS0r6GrbPrz1KZkk1Lm5N9EF0hY2NmYYtvvsuY
	TRcI7fMio4f30LWR7sJW89rcn1OoEQUa4V1QprdVA8MvpBbcYIl94L5bUfOlsjmI=
X-Gm-Gg: Acq92OHSG+SoeeeL0JO83wgJAWNCC+qxE1inaJ72/wq546sCkVRPooQU60PBr3JAFF2
	5dO+o1TIlxVwQlKXlzuWABDn2RRfCVsuKTeaN0xeKV6axeGiDM3jM0aNl9M2GI+oMxCMma42LBM
	OsUaK7p9P6LvHIx1MQ87RapN/zQc2CUPDuMD3blirvBhcyRbtCrmElJFxAeBKY3FMuHZER9M5a/
	+Mkk0e5na3RTi7SMdtIKrItZcKcQ+sPv0MWIeAAhx/uoKfZk9a1FGsZoI+KIco6tJmkjQiQIGEB
	qO5WD5srEZbYSc9JgZNQHYtDOMnX83WIwci25fENoA0ClSC2DUGx8UzogPyWcxgxLW6ALkFoOhP
	IHSBr0nx3lGONQ3NG/vnP811WoxMaJQ==
X-Received: by 2002:ac8:7f03:0:b0:509:3cd:b22f with SMTP id d75a77b69052e-5162f4a36d3mr36165681cf.23.1778671190946;
        Wed, 13 May 2026 04:19:50 -0700 (PDT)
X-Received: by 2002:ac8:7f03:0:b0:509:3cd:b22f with SMTP id d75a77b69052e-5162f4a36d3mr36165021cf.23.1778671190420;
        Wed, 13 May 2026 04:19:50 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5fd39asm63390735e9.2.2026.05.13.04.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:19:49 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 13 May 2026 14:19:37 +0300
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Add Eliza compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-eliza-bindings-sdhci-v1-1-b2cae44163c1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEheBGoC/yXMQQ6CMBBG4auQWTsJLSmoVzEuSjvAb0w1HTUEw
 t2tsvwW762kkiFK52qlLB8oHqnAHCoKk0+jMGIx2dq2tTMNyx2L5x4pIo3KGqcAjq4x1py8C8e
 OSvrMMmD+by/X3frubxJevxdt2xeiQw0aeAAAAA==
X-Change-ID: 20260513-eliza-bindings-sdhci-d531219a5c87
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=riex9Jp9gsiobhfzqRzI6SaMLT0mbjKk2HzzJZhpT3U=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqBF5T8R4qQyh4zB8syiJ6/XNs0+LS+ldULCNW+
 DPHZ07bbhqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCagReUwAKCRAbX0TJAJUV
 VolTD/wN9QCJ39OboibVnWe5lBeGUAq1CkEIBtWX97hbZxw3dV/NnT8zH/V2ET1UyV0RinGnx7y
 xuvQO1R6G2b237dGYrv9vYRB/i3sivHtYU0hQNSTZjfck+Zd5bTyDvhsfi7NdkMSBj8LHnpBOr9
 wJYwyjp+obNSzjv4735w4hWTen31iQZTBMXTrBl/1tO26wHUEVUKGkMn0q6yCmbZlyIgzpAtQDA
 uH0AjSJu7W+Phvh3BG1YQQ2tVES9mqOl/u2x6jM5KzgU2BtwzBeo+1CJUaI3yjD5FZR8Ir3g3sw
 A9SdJzK1Ljhn6luWGGLA7O/Hr1eld98BQEVtr92awPaa0i7pZ/nmDdzw78vUB7zpWRDcFHEFCe0
 0TErm3kWu8yjtt2ATynFEIs7brkbJ1kB7BfkG6Isbe9aRBFmuryHvCZjfrdVZDiU4ugbkq31nLJ
 sbkyL+1GyG9r+o07yyIlmKPXrxh9X6ZJkU0VMV6ebFav4eJnIxVmkQYMEaiWjTxzQUPPLMCRxua
 Ip5XB1mSE9YpcGTRofbWxw/dmxyfc9oLLAQ9E+S331npmiSTJn2lGa7cJTSnL+tSTroO19l3ZLa
 SgxLEZTfHZk6xzzS23HQe+z+qYH4oxZyUYK3TIezCVHF6iSNGatKjUY2pUMWgDQ3T9coaq3dpHB
 9cB0w4DTkI3pAZw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: BILgq9IU0H4WBn5MziC6FKOx4SD9UcTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDExOCBTYWx0ZWRfX1H7YdYJ4PPLD
 RVqBVfMn/d4Yp8ZXY/Sf1DODToSddYRZjWxudcsZumhZZgMLxBU+uj9UmUjucISRTqaZE7jIHzY
 vGR4Cep8B+vcsDny+g2Hzi222xNhZaWFVc/hpJN4YTAB2/XSdlEOM30bQAi2G7BBd3OXr/2UhLC
 qPurh6upq1gaQEPnT6TJafwE59CYo62i+L8wOVA4XOJ1MZAFmKxZJrDljT2t7S2NrJjDjUd4z3O
 fAuHYbrLDi/fcUKRBokoksHZE6YWFFf8OGqw9zL9jl1BJWx/NNFmI9lA+NHbQtPJAQ6L8UKWZCc
 LiUNj+iAbxLZX/QvHo6ECGJo4OZH3HWB7Y+9mXbEf1IfoDiyzYOD64VTp93O20KrzFQTMIygcT/
 VHv931LimVtsiuGPo2EL1aFpxP10KQrlPye6Tca0EocXW3dLsJDzKMqsHlgLCQc+32CIAZADg/B
 AKw8neCW/GdRaWsFS/A==
X-Proofpoint-GUID: BILgq9IU0H4WBn5MziC6FKOx4SD9UcTK
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a045e57 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=NtgjAHhJo3Q0P2g9Zl9R/g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=67XbsYgd54THOLoG6RkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130118

Document the compatible string for the SDHCI controller on the
Eliza platform.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 695a95e8f35d..adaed5272016 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -37,6 +37,7 @@ properties:
           - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
       - items:
           - enum:
+              - qcom,eliza-sdhci
               - qcom,ipq5018-sdhci
               - qcom,ipq5210-sdhci
               - qcom,ipq5332-sdhci

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260513-eliza-bindings-sdhci-d531219a5c87

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

