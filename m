Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14153338F23
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580289; cv=none; b=Aqos6gGWdfL6cVPagy5liLkZgdWRMSCjxLx7Jf8NMKV0rPtrR9NnR1lQnu7MEAkgcShCNLdAEkBPXlIIHd7JK17oTrJ6sqMZIfDsqEOi+0ncdsAV4p7mkvPye/APWwfv8KN5pYNMrKOFRFEPagpHPxThjmTv3kkfhDXH2VNdRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580289; c=relaxed/simple;
	bh=FSxaYZxRQw8NtKxY6K+zMOwodj+OLUAUfn5MDuEJjsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ6JRPVcjXHUBFdTr34bcnC+f5a7MUIPxUD6iCKLmoGWmeqhB7F4YRsHYY01O09yp8RyxsvvvhJVWTUKWpSbgLYIZ7rlI0EWBBYpsZEGb4eCobNHUHXVWzlhssZB/WLNf3OnbNR2bFpR6qqtf0iDpGcl/TLkHOL/E2urPa9hoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYv/QbS9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUqN94k5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYv/QbS9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUqN94k5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO7s2dg1056227
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KNilgW2hQVL
	A4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=; b=OYv/QbS9aElI5G5BGNnWjL6XO02
	WgVgefJa+aL3ab57iZqGYNa3drsUElqFpIzmnFd8kVZHqgJQZbsP8tFFCPHP1X0e
	xPLgoLq7gr93/JC7zzSQmeEK8RL8Ojw4do9qDtvsRhjnRa4fgNsZRg1CnxEWsGDs
	g1yOJJhJBVNG1a4NKOsul4cxqODezrmnKnk7D5AVtor0aQ9S9fvJv//VPn/hvhNi
	p2dGmPx51k37IrtpaAr+w6b4p12ieo6pihlO1I58l27jrTkuScbpyGuTeM4mpPJ/
	FyMwcoelU2AA8SGCP1GShqSOL/KWgA9yT7vYMRfG1ILIAPWgx6h/VNVV+nA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b811v2err-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed74e6c468so83492541cf.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580286; x=1767185086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNilgW2hQVLA4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=;
        b=XUqN94k5TlKaY29Ktw8Qhtuav1wad0MGVQGU0yRoqt9Ta5t+eHemMafIeHNINE+3P4
         IOrzX88LlDjpzzb3W/uQ/UVjAe6Q2C+fgwfCB8x6ncRTW57uKMQnsUPnLiTFEpgpGwjb
         6cKnveix0qZf/v6H/v1SF9fkpw7u/0JOrxxfRI9Xflrz/PHopGeqif8fsWuLsaJelqoO
         3ZW6G5eXbPH8G90KG0rMYU4WJ5dQuSrgW5TiaOif3LEFeuPrUt9CaKL8NsGQ9ekyptRA
         0VGlI9gdjIt4P9CGQsGQDm/m1dD8CU2tioADjQ2nwbxYZhSLlnDoG7FOrNEF1i6h/XT4
         pEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580286; x=1767185086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNilgW2hQVLA4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=;
        b=ZPRGPf++6rCnC47huAY3p9f+ovYAsZtJh3e/uXdW+K0pGZC3DQYxJBgv5xypVQ93tA
         KSYVAT3Zmya9Zwt0n4IQNDqv4Ra5pcErHUUi0xrwsryAXZI7dd+C7qaLxf1GPzRq3Axy
         LIOJ26sryJVfAjQZ4FFNS+M5m7LCdx08dzFskBHA+4GpG2pH7gaMLZ8gaMBPcBHjYRLJ
         +vMHPPDlZnOBTKHTgIpDCskhaCDQ/2a8ejhD+fvRBJMtWeTpp1IdjJXov1kX5/Qs7F1p
         tfbyCTReObIDCalJ0SVtxAOFmWZQnv+Pdji3CG3iah7xLzZ22k672nNPuYa6jm6TkntP
         UoWA==
X-Forwarded-Encrypted: i=1; AJvYcCVBopdaS7zo8xMroRA4bnfQ0AxAEacuxkDjGzNE8l7ZR31Na3VpfS+PX7jUg+VCdNId8eILu4caMhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxtkBJeJ53ycxZGWRUDlPi8NPmY8zW+qjPQ2D28iHfRdkVZ9X
	qHaqDJFvuFcg4sDSTcLMbg7hiJ1pCGKKqycifEE/9lLA83dHDg7BUwsTVrYqVJT+AcZ3Si9rkbJ
	JiwSuQA88CGqZ7SwpOD9QW+PHnBgqyH79MtWVpTcmCc7R7U8OLRHjiicxY5+cQcM=
X-Gm-Gg: AY/fxX4KIihhYxVrksL+pRvngK/Mk7f35aGQGm+sGb5/n/gATDFPT/aTQt8KjyZmpOr
	pJf51YtRZdjoIt1S+pAjtNCclYqitLwcz79QTAA5rrr9FJHcCXLOtm5P4fz1rvIW+UF+t2AOQIF
	doP8P7bL1VH5e+PK09MtXYDMl6Gl0dty4JjI0C0046WmL0poaVqJU9CRugPOyKGg+iO/VRvH+Hf
	UkprW0Iv2x6LZrgr1buzyHfBa/q5E/H5uuHoF0X//2r0u/AnJimfIvlNHaddMfrOno5iJLyFLJk
	T0y9h5lvdGh8F+RmnAAD+OBJ/UyQecqtd6MBPX/KO3CTSwm+NGye6+oYa0r2ijwoUkJk8ztp9Hb
	PWE+RKqQ8VZRe36G8GqfBcMgSmNHqEYrwWLexw6JEAP6wydpi5wQ1GCm7eRfKQ4XgLsSXzw==
X-Received: by 2002:a05:622a:2488:b0:4f1:ccfa:377c with SMTP id d75a77b69052e-4f4abd61335mr226689411cf.45.1766580286311;
        Wed, 24 Dec 2025 04:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjvpN7s+TXKm4SLsrLkne4UHksiC+p6orY9KBQYhq92eh57vEMHcnwzJgX6up3Vu2ofSSjDQ==
X-Received: by 2002:a05:622a:2488:b0:4f1:ccfa:377c with SMTP id d75a77b69052e-4f4abd61335mr226687071cf.45.1766580282043;
        Wed, 24 Dec 2025 04:44:42 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Robert Richter <rric@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/4] mmc: cavium-octeon: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:44:33 +0100
Message-ID: <20251224124431.208434-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=FSxaYZxRQw8NtKxY6K+zMOwodj+OLUAUfn5MDuEJjsw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AwQ5nt6vw2D5baL22d3lRE3rCSSx3sNXoft
 Vv4+URvpJyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgMAAKCRDBN2bmhouD
 17PtD/9fPRxk2QKcs6uPuvMXpzzcrsQbQfN62ZHe0qNSRHZVjUZYRSclOZTFYSAbcTufyVWU6XQ
 +BeXZ/vHxvBypyatbdEQ/LlDjI3iPFTROp1xfZXNwjSVhfKs2YgngMDhBjdYLnj+PO1gfBKveQ/
 WwFiSASnRWqMBH/MQ5yzsuoZS5/HBB0S5yeY3HNKZAASCVsXKPmGsyQlDKc+aobVqSXIIit1Cnq
 phLUeHtgWO8BxwNRAPJCvAIeevCY2cUwoeaZC0sgO6BvTtHF3XAAVthEob/V7TANCFkQpFkIa9k
 ugZ7raeZuoEN251R028d1ihz5HO6XpvwTDDqgi7urpjhDixnoPAVWDrKpOcENAJg2jl4xIKfxFj
 6iepzuyHXalf/4fbXWTmTmQUjW1G0ohdRcb+AMvl60nnz7If3RHoNIxEM43ZJLlAK5BT/NMpEcw
 +AT7kZGOsqZ0y85GzBe5wzqqcrrsDxtBdCHnqh4v84nD0/D+pm/T4HKjfymo+Ld5Vs5Rb3kKEAB
 GUuyNEvbawqC/3EtNgnNYrHAEEqJ9BQyeDrJcIkrco854b3FknW5scT3l1XW2hQa8nLSTjrl/Zy
 Y5reUj7YPS6HmfNfkhtjmZQ6CAXdK58bZ0BcUGWK+XIFbmovY+QRNWftxWEVKJMWqhELo95L0rv +AeqG72kM21k/yQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfXzSJAj40TxkgA
 bwLfLubeYJB2f/pRhotjwsZXWczzE4E5DpTfmoQcKyYsRXwkuagyMExn3YuO/qXGP+A9d1aLH6F
 3OXF5Rf3ZLNFtA55qMULkeFqJubFEG4TL6JeJEsZyGUr1hgLESBp8Jc7sStraNPaqwd3hOyVAXD
 qTmG79paANcHXj2AdJdnWgTVybdfEpYeWl+VnGIPv13hitoDLcGArdNhJU4jmzNpiXupBOUeouo
 4JvJDpiyB40prlH8hqI7+fBmrAMFrL9ZyAfmh0DC7nO3WbN8tVi0Y86znuxp1SFRiIu7w7ayeeN
 YHHAXrPlLJfF8TeHQq+C7XmFDIajREsfkSylheIWkLiueC3vREI6bRZO46AgRz6sLyNWM0NIJdn
 RX25xPRJ3/YwwfDetK9sX10oKPyhOvezip/AViWAVZcN6BOa0xlu5bHUaJdX1QgLkOnU+3qhuc1
 WliE/nmkJuamwftn06Q==
X-Proofpoint-ORIG-GUID: nTIKCuA8i28NELNVQ7PmlZ4cSIvixUS6
X-Authority-Analysis: v=2.4 cv=WegBqkhX c=1 sm=1 tr=0 ts=694be03f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kVq6N5mEIK0mURhpU1kA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: nTIKCuA8i28NELNVQ7PmlZ4cSIvixUS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/cavium-octeon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 0592f356b1e5..8a0daddd9200 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -148,7 +148,7 @@ static void octeon_mmc_dmar_fixup_done(struct cvm_mmc_host *host)
 
 static int octeon_mmc_probe(struct platform_device *pdev)
 {
-	struct device_node *cn, *node = pdev->dev.of_node;
+	struct device_node *node = pdev->dev.of_node;
 	struct cvm_mmc_host *host;
 	void __iomem *base;
 	int mmc_irq[9];
@@ -268,7 +268,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	i = 0;
-	for_each_child_of_node(node, cn) {
+	for_each_child_of_node_scoped(node, cn) {
 		host->slot_pdev[i] =
 			of_platform_device_create(cn, NULL, &pdev->dev);
 		if (!host->slot_pdev[i]) {
@@ -279,7 +279,6 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "Error populating slots\n");
 			octeon_mmc_set_shared_power(host, 0);
-			of_node_put(cn);
 			goto error;
 		}
 		i++;
-- 
2.51.0

