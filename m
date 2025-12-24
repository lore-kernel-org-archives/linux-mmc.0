Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84F338F39
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580290; cv=none; b=uY/bkBlf1xJM2UhyOc2K1AnqlF1ZlHMSsYDMK8IDXGuLIUtSiYiYgAgFOJYibX/mFX59D4HF5BrROdnpa+Spsg5WKS0vOwG0SjG5p1V2xGoHT/ktyc98drzSkTZvOCNmmfuziNWAuOYRGIq+VL76eTBQbszBiYV3aiscxf/JgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580290; c=relaxed/simple;
	bh=k3fIiJQnt3//kLj8p1O4BhrfyE8J8CFmxoc44wKmiXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrRzIRYDpMfyQ3Rp31z7GNx23DHV/CNdirQUJejhnwhxluFwAkiaVFeJKTuOOkDSIwgsy1N3aI7oI0qx48mhSkH/ZhR2h0GBUn2mpCAFnlcuWWyleGAD7W5kVLchVfnBsF/Comh8G2rs6kRZlwwWeuHBUj+3jit1pzQZm/+/Nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmVfTXwS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kw81z34e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YmVfTXwS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kw81z34e"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO3wKQ33796513
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pIBKnWae4ca
	tNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=; b=YmVfTXwSg+dzYWqzDS2Fpsnl+k+
	SoCPXSRlgSckh5iv5ayAMfxhfXcHJOkKcOHnKH8GO+G+PiIEOqh5yxvfzsvHvagh
	DsfzldtCWsLRZYfFfMiyj4BBioW9ZIbpAmldVI2UZI+qRHzxOuer4u5TqfyiuuHl
	bACTzaQOJHgjRDbHTNTpnL9981mFYhB5FqCtQQeIjKlpeVDTHcG2+McanmvDXwBi
	LPforIBOwwkdCel6R8oWLCRoBnJkER8aYz3DGpb93+EsTNsEcEqGtmlpfBAjdAbj
	WRgUUrxD5HDQbiZhGy+FNKF/BgDimrPDuNV872iYi/jr1GpII2a2ac7jPpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b88r696pw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edb6a94873so114772401cf.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580286; x=1767185086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIBKnWae4catNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=;
        b=Kw81z34eBz2dTzFoX39Jq42MGOO5kgle/XSD7brcPA+eg6kzs+tT7L3qyzs4x3eATz
         W6eGn2jWyFL7rxT3EG4V3yXa8yV37wV8psikN08cNkWFUzbWtqycGtvOUbqq+/uLMdjb
         6h6Gv5lSm/c8Vi+j3H7npDFAoNUvDuz9Pmzk+iICjbjRUxtbz5974UftrV/dAYOnJ94e
         thp1EQJV+zWHVVEEuco46VaXiCSNn7aOQoN4+Z4rGd52ol7LCZpQDAPaH9aK5z3JeUXR
         Zn3MnjzKUImvI1I3rxybsaJGDqZQwuR3UHdqDK7x4gU7ZDDvohr1tTxAqBuJLGK78yg+
         oOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580286; x=1767185086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIBKnWae4catNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=;
        b=KKf+M17k2blCMSU2bMIO29uEw6c+SM3+3SIzSQVIu8CcJT31Y5HqnkHxUHU/LlnR29
         iVUiwB4W3SNlZTU3ZgeqZKFpMlXIVZdKjMeDsBjho82PfF9soTy01Ijl36vO2zcJYNYp
         L6/97/TejeLB+UKq0RweCb1kFIDGignC4YYSr7KwiW2MNM0lB7zR/VPvnys6KXr9+NjZ
         WSKL0ENioXvHj3krKDi15pSdK9u8tJ1CHsrYjXYLrPg4OWJDDXbvt8NdkJ/AF/DxdcaR
         z2Gn66TbUeyYg9VS9NLiWrwW8m817TJtH4JBHVXSjJJOz1koHaZu+nGg5v1dz0D73FQ7
         tfRw==
X-Forwarded-Encrypted: i=1; AJvYcCWKyha7PvIn7Wicv6aXZQYj3HXR9TRYbhxnUXCckSwL4iPkcfMuZ5SQaLBW/Z5YaxWT/lnWHqS4vI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRABQ1YkSy05CxdtCj0PFN8rsV4SFYK1U9v3833BnhFbgwszTv
	Ld4Gx6duUm8z/Bm9wZkEiiIToisHGMgeXQOkfafjjyTRjsg9mmZLk0auq+vOnfen4kNjDfPzNV2
	MSZ4eKcHiKNlsR764TzYb/qLE2iZXMlUzeUcs2rkfxB1vWHUT2pyugU2CBanukxc=
X-Gm-Gg: AY/fxX49wqNxNnFwS/lJeDd7Gr+qRp/1WjjLH4viLCZ5C/eB2la6sfNBa66U+pAKB53
	ecY3RDzh45jS4bODpsKBzrAoxQY88fX3ixInOq0wSAOAYjEAN6L/eKsp8dL5Gq4GKlx8Nl0R4gM
	cROcn6qZ/WwkKQuHCs+3m6RzBt+P4u4eGb67unfH+7K6c6LgAWW3OuhNExu/Nt4SYZhJEBGYNXP
	LwT/BroB8qUVKjPQCMomeqng+4EQuwUf9uSxe6xKVkcrx9PSI/fejwc+0W99GRVeFP4Eritq8x2
	6duaU7ExVlVuL41zUGhuQR5u9TM/uV3JL8JGee9jvuuxpWTYYGQrt8UsqnbjJ0wuQvtQUCchOmo
	WXSZbH1YxU91Ev3JSSC3tW7mXZkSSp6LiYmiiOmFqKILsgJHseKfpxG8NPCkoseNZEdTtyQ==
X-Received: by 2002:ac8:5a4c:0:b0:4f1:ab28:d9f6 with SMTP id d75a77b69052e-4f4abd03195mr248360221cf.26.1766580286433;
        Wed, 24 Dec 2025 04:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTZXliHT1pgcb3I+/DNRDGU4Mh4keA+YHzBcuOF/mpCrQZKYCA78vOX3Oe8oOjwDHK4oJOAA==
X-Received: by 2002:ac8:5a4c:0:b0:4f1:ab28:d9f6 with SMTP id d75a77b69052e-4f4abd03195mr248359981cf.26.1766580286049;
        Wed, 24 Dec 2025 04:44:46 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:45 -0800 (PST)
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
Subject: [PATCH 4/4] mmc: sdhci: aspeed: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:44:35 +0100
Message-ID: <20251224124431.208434-8-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=k3fIiJQnt3//kLj8p1O4BhrfyE8J8CFmxoc44wKmiXk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AxsqyFxFGGpeZZHIhCyKOnvdjTJf+CTZuIW
 G78x7Z+JzWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgMQAKCRDBN2bmhouD
 17GWD/9Ixj1ULpYkMSdzu/q3hf0Kyx/91sewvClr8ICZPurrL/DEHrytAOup7j0UsUf2tqG+OyT
 q6YcG4NKAewr+dd4p6QyFCs6nsZ4iElL7Poc82/r2gIRHtRdWcCDaRZWlFvKMiR4pbqXC95Z0Zz
 s9fK2CprxcJVIOTMdjDqP0zIsBY7bn23YlXQmVkcnwj6tyDPDVeppRSNuLAC380N2f7msIhKcJQ
 hJkCfAP/LP92Cb8Yui3UoJ0pk0mYh2q1irGN9ANWu1j7Yv1py9TbXofb32r0aNUPL4eCkt6i9AX
 zFwqoAPZYFBnvUNpXZYwSzVTgpo+JA5kT7t1vKdt6z102UMhDrrYhFl/n/s7UnUZZnk+DiC45Xc
 GZeD1kOX3T1q3SuYwV8kE+G8vr+p1QLOS5wuBWwEidmkJfHGc/KRDVwreOXDAgeSMK93UbZqiDx
 +TXPEPeJ4QH2Y67axdeOdhhhsHD8xZ7XWxKOcjNoXkyIe26f4zdZ0F0NUBD47rgPILROWsCmicy
 waGD9LyfGuE8rVmiOhslBqiSQ3/fyNbBSlOfegAl1K/1fQHLCdl5E+ckDPH5j+NnzSiJGl/Ebvf
 jiLZwczT4DSEMogX90P/8nlA/WHEX+S/g9SdtVK2prE1TUsOpmany/Fame9afDjdsGeXptNT+8J g0yiZTEko+NQNlA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Dk0aoVrWiiYCeUOiqq4HWsb3Yhbc3K5x
X-Proofpoint-ORIG-GUID: Dk0aoVrWiiYCeUOiqq4HWsb3Yhbc3K5x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfXzjNxd8+2ZaHr
 bQ7ogc+KnZQwSD+wwtKHHUqZfv6DJxF6Y8yi5DJtMRKT45jlbUx+LxAV7FLwwWV7P0PLGJkN4Sc
 G98eCNyMMkA3f0gLwZqBsJAO5FKYZGhX62lbmj9syi4ocUvIT97gMmkuSra7Sz2wwTg8INj5+HE
 LCVAmoJqHAirtrOt+aiood8MM468s2aY8AW3ZvCnyxfRNkZGMwuWdBzl/AG0MZzpzzbBrOga3UG
 kQJJr5IuNavvtX3MuedzTB8ouWs+OXSW+ahXzD+zIpk43I2FhnJC1LEYBxJd67/bKvaz11xIasa
 sTGpkmi8g4R/4esejf2sRHbbAhXxwj5ihUm1a+a1Xfi+eX8SLM5G3voNW7UnL7ry3XosapCNTCZ
 L5W4PlJNnt/eKk1hIaposBoWdFsCVnqYeMgcU8xbne7pgoruhMnHFwitIDhXp/da9teglCuXCfa
 nBdeNay25+pI17XMtFQ==
X-Authority-Analysis: v=2.4 cv=Qahrf8bv c=1 sm=1 tr=0 ts=694be03f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=v5e_MpXYYeFlSKZv_FQA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index ca97b01996b1..4296def69436 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -519,7 +519,7 @@ static struct platform_driver aspeed_sdhci_driver = {
 static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
-	struct device_node *parent, *child;
+	struct device_node *parent;
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -548,12 +548,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, sdc);
 
 	parent = pdev->dev.of_node;
-	for_each_available_child_of_node(parent, child) {
+	for_each_available_child_of_node_scoped(parent, child) {
 		struct platform_device *cpdev;
 
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
 		if (!cpdev) {
-			of_node_put(child);
 			ret = -ENODEV;
 			goto err_clk;
 		}
-- 
2.51.0

