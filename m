Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517F314A9B
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580282; cv=none; b=cWtzTnWlzH3meYq3xGg0BVEEy8ljKr47EBWHmYuyPV+N7b04sp1Z5+9fmSIQfQ6p8/yZPrI1XCwvFMKujx1DaQ6b2bwVOl5p/SCyJazS/nuR6tLxkgsS1+uo4EGoGqem9AMhlFlCk25kPVxR6jwich/tIeKwwpKMUTcLZxIqRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580282; c=relaxed/simple;
	bh=yM7PsCJOfo1O8B7Z+MHBYKtQYFgSA+XM28CKwgjSXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAH+5OCjoXtsdKeyY9KNqX2AtuM+Z0VhbYZA4e7KJLEQ/2QLyrsiB44G2K0b231j2obs6MpFuiP4rUvEN2hWMzIRI1karNTecmVLuzOeWwBMCfh/v8IGwQ+81Wk4wiSe7GmzrIibROqYxuRn9qmCusKZKtd67/Ud26/N+0XeHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fldrpCj+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYytVdn1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fldrpCj+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYytVdn1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO9sdmU561247
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB
	51X9ls6I=; b=fldrpCj+zA9Q7h/0byn4xtx/X+g2HVNthktaN8KT3CGaPx18Eeu
	ZhgJsqk+U2LEM5K848P1u9lcbDdFs/Khx/O6Svo+Whi74m1Mpo2HVFq1ZyRbaFm7
	FR+LI/bJ210Qj95lb2XVxhhV4IiAM/dhKI29cjmc5z9G0QcpqRsMDKqMEnnk9vdW
	USDUGebEx5Bm3wxnkkWgHGHUJTWuTq1VVLSx/i9AvMFY5ir8V7JBPvubHtnWW3Hr
	QcBZauX+sDL4uoJQt4t2tHim/XbTLT8JdR4dZ/GjRpYAwhDkmTQ3+B/IBpt2U0Xb
	kcDr/k7K10BXVAahHytAxbDKQ+4kgg96tnQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7u9cuhr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 12:44:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so128415671cf.2
        for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2025 04:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580279; x=1767185079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB51X9ls6I=;
        b=RYytVdn126kypVtTg1GkdJiohXNRe7DwkSKAEviZzpGs2F2q95lrOvmZOoppK0JUER
         g5GFUCNc9GfskpCjO6XOgwpNsO38IWrQau6hoRdhfCwGTWIGoFBlW7eyZuLQoLc3OZzG
         6Q2Ad58+d++Fc5GEkaNvyewMmqNYLyuSiz/t2UDzWaA48D8LmQgf+U/d+CVGiSj2NMCZ
         wiOsmEd6BHGqeSOoqpn5t0IYUqZMnBLceAtf/lBL5dEbiFisuqhITcenq3Gahd7RtZUT
         sB9A54Sgb/1xAy0ZoOh85eHJBo5ooCBD81JiL5TAsRADVPiFy+YiYSt++kCpQaYPZyQn
         jN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580279; x=1767185079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB51X9ls6I=;
        b=KYfgSjQ4HR6CKHvrTUw18bP4y/1IZL/2ez6HlpcpjIBqFXpJBtSoqimDBOAq6XMKth
         Hp5c0JfrKU0CuVHphO5RklxXlCpcPmwnKbDl1RKjN10KcZBL0MJ2tfn1+jH81WNZoIbJ
         eN+L7VewIX+jI5ef7FXrYAdviupGj2crpyeGI2gcNPaPpWgwxYi9oDks443kA5VCZIxS
         b83ExsxxOYKDpeIOOrCagKS8fQ+tPWSy3rGKO7s3X1X/lblHjWIlWhil15CpjxMcQSEo
         MbRHqricWwBRbkAfJ9q1GTPYOoJK5TZ0Rqaxl9hPpdqQVvwC65E+JrIFdUvyyo2TwkCN
         KKbw==
X-Forwarded-Encrypted: i=1; AJvYcCUnzRjJ0hEvN4x+NENmOF4BOlE9cP6pVuKbjq5z8bLGdH0EgxHRsBA5ibICmglyedHmFvDWICZAqXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnJWH23m5eAeuWv8MijSQqLZuc1op4cFQz0chkUxJH9vslo9G
	ix9GF+7yFkkr0/vknSOkKQPpEtSxE4aSD7gjn0PxMMa6WiMPJ7YzJjWF5td6c63JiShW80XUuC/
	AUVOZEyh2Prud2CzvaNmzmruPxy9QCCGILvnWB5p/dKCSguPznmDCILa/wfpW/Tg=
X-Gm-Gg: AY/fxX75GSsIVTyX8QTUBPUy4tXbQ07BxTK9xLp/UaSqUDGYpxmqlzThpOIlQrdqQAn
	0qv5s++dzvan6/fE7HUtpHxywh9+bDE+GaHPg/InBczJEZ7Y6gFzkzq5yHT4TgSHMh7m5aUzD3Z
	smXpYzFgggfWbx4Y1PAI7TZ5wb89WKTUDTxhtzXxpaygXpLQQzZruJkIVeXYJ8Qe5PNqsyBQ8h+
	Floh/g0y3AJpkEMsPFGtGXcE+iQ65xBk/59DIXYmZ2UhHOi4CXTDdOr3UTsWolIAzsgQfjPgPJG
	rP7pywTarFLxur1snNc1mQFhCINIgunRcrZ8aUYvTdXV57JRpIOFsmh01ss98UqUnO5yuSBfe0/
	5fHHDwA6os4FlfEMP24Y9fwCFjiVVHTGYegKpnR1f0AedgeVnSJjztVbhxEnByHs6ShwpoQ==
X-Received: by 2002:a05:622a:1c0b:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-4f4abd2b668mr288449001cf.37.1766580279326;
        Wed, 24 Dec 2025 04:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+NA1y+53V5FjdDZScyPo8qs3w+gs5u6C1SMipwvVq0kLIBUeyMoHc8CouFvb8Es/3VC8oWA==
X-Received: by 2002:a05:622a:1c0b:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-4f4abd2b668mr288448641cf.37.1766580278931;
        Wed, 24 Dec 2025 04:44:38 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:38 -0800 (PST)
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
Subject: [PATCH 1/4] mmc: atmel-mci: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:44:32 +0100
Message-ID: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=yM7PsCJOfo1O8B7Z+MHBYKtQYFgSA+XM28CKwgjSXg0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AvGomzzRiYXzxCRUVc56q7ljsbdKRtMaPH+
 BmIj4M47laJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgLwAKCRDBN2bmhouD
 1wBbD/91aQO1mFxSqslLTeFr4Dl5APuLTTk/ILf/WeP5bXwicwB+MKjkIBB/JMvW4h/70qH6Z0x
 l09ct2wktyCrkWbBXtou6V1Y7rQsfK5mBLfeoxl2z/dp0pdlPJ+qsTGLXvYBdllFC+pDR+g2a0z
 CfRUHflxj7UxVculnSnhluQuS2OrR3hG3fGC4hSE0ZHz3Cz91jZDiaif43yekqT14EMViCjISYR
 H6kMCEtvfb0MIxvAWqKiV5Q1h8khWIqVX12yPrf4VBGyBBXHt7B3QZfYeHKZCJsaDfOsJkUV6AM
 AVVwK/wByZHE6ifGhM6wfijBfJ14+RW5pP0GKmymxenVLVK5UfT5BzLb4k3GG33U50rZduZkfnw
 eb4Bs1IFB38KkbXmaqGOKFwpSesJzlAy+im5tpxruX59GaZgLflrwRxkG/bi3jqwRV0yBpjGzuF
 e+/PdMNsicVjYO+w6R3MtfXc57BiM4CTKFuJNIf370wI4+L+0KQiLwvsmMV2BaSLDHHNL0JKSsj
 vjYF2o3X8hNSkyG45ET2MNOjWnEdUMSgjSbImKE/Z7lsX1lkdTiF0tjBDqlqNie+zMUsjPkQVH9
 qVzme2ry1K2D/fe6OqB4TZTznqd3WBI5cl4kmaZ5rzs+cDgLAacpGV20A9n3wfVZMEiM9MBVLDA KYGhqVe3L36+D5Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Re31nT_m206A6tCbHL34ZM3C0aygPUEm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfX02HPr5ZoTvWD
 tG+1p6PbxpBo4LIJy0CYWjO3dlisGVwLMKpRSHa+CWfdNmuw2y558kCCJVrNieBW7/gmQYbKPU/
 2xG5VGJDE8lBuPHIq0SMQvw/pG0auaOuVUUGZvITDuCUhJ2Ot0KHfujxXk7DUWNq9LgT6nOu5/F
 4G/OMYEwM7Tu4nF9HbPh8H77HmPU5xwmjktzR3c3eIyoX/IFO+3OBROA3w7wEu9ldJkYhVAR9N9
 9C3ZoDwKaP1FzLAYPOAIjNsGYOyf2PJe3VR81X/yasfjcfCQKstH25M5efc1oeEbOdNZTDxNiZX
 3pMMBpoUj9tuoFOQSnQ4ZVQDfc+xC6K4UyP4k+mkFBEwb9wFUS8u3/QmV5NMf5L0MA7sSDSZN+S
 +E1/3hiDieY+VGdK6DRvPdjrXtEEqxerhxFSI1kQ0YR5nWZF8MJi5K1aynEKA8I2M+NbWD7Nj5A
 RS6+glSa/OyRnfqfYAw==
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=694be037 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8ZTf1ciMPyF_Hyv9z0sA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Re31nT_m206A6tCbHL34ZM3C0aygPUEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/atmel-mci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fdf6926ea468..3b4928f5b9b2 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -629,14 +629,13 @@ static int atmci_of_init(struct atmel_mci *host)
 {
 	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *cnp;
 	u32 slot_id;
 	int err;
 
 	if (!np)
 		return dev_err_probe(dev, -EINVAL, "device node not found\n");
 
-	for_each_child_of_node(np, cnp) {
+	for_each_child_of_node_scoped(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &slot_id)) {
 			dev_warn(dev, "reg property is missing for %pOF\n", cnp);
 			continue;
@@ -645,7 +644,6 @@ static int atmci_of_init(struct atmel_mci *host)
 		if (slot_id >= ATMCI_MAX_NR_SLOTS) {
 			dev_warn(dev, "can't have more than %d slots\n",
 			         ATMCI_MAX_NR_SLOTS);
-			of_node_put(cnp);
 			break;
 		}
 
@@ -658,10 +656,8 @@ static int atmci_of_init(struct atmel_mci *host)
 					      "cd", GPIOD_IN, "cd-gpios");
 		err = PTR_ERR_OR_ZERO(host->pdata[slot_id].detect_pin);
 		if (err) {
-			if (err != -ENOENT) {
-				of_node_put(cnp);
+			if (err != -ENOENT)
 				return err;
-			}
 			host->pdata[slot_id].detect_pin = NULL;
 		}
 
@@ -673,10 +669,8 @@ static int atmci_of_init(struct atmel_mci *host)
 					      "wp", GPIOD_IN, "wp-gpios");
 		err = PTR_ERR_OR_ZERO(host->pdata[slot_id].wp_pin);
 		if (err) {
-			if (err != -ENOENT) {
-				of_node_put(cnp);
+			if (err != -ENOENT)
 				return err;
-			}
 			host->pdata[slot_id].wp_pin = NULL;
 		}
 	}
-- 
2.51.0

