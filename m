Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E33D25C8
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447032; cv=none; b=L+EbM02gTSfm6gXeyvb8jHga+1OKsy4h3vzRQkJTSlIp1vfmJsHY7mKg0v0IhpL8rWGzKLYpEDXOkfqT5/ch4EioxRmmqQVzJeB5DGTj6LMnI5A5ntDIs7XokLjzAPiTNeD7nHAOygAwQYtYkQAuK26woLNM6ADEPQL/90fqUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447032; c=relaxed/simple;
	bh=Ss/xKitgd8olKTPkGOM+CzwTEm3C4JYbsOFB6qDCO+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMg3P8H2xyPYAfjzxw/HsiSy33Uwg0pYYQxVIWfQ+erRW6+DRVYWIH9X0r7olP53g1rIPexmBUg/ltWzaTRxDSOuHrriV6iTWNbPcehyW6PjgbhCM4AiPTt2XdKMhTzHAQF1RI4xUNkrEgsEGARzv0SiYLDZn9yjJ9W7Dv/D3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJgG/Wnv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qjn1x1E+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJgG/Wnv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qjn1x1E+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9H64k2765201
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 10:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rsFY2z5jc/JKZpx8doK+ltMU++8z2DwQdy8
	wREIH8mw=; b=GJgG/Wnv1s+qWiG3oXGUOaa1pE3nYhPIOEgIVW8P0VtrQJELxY3
	fg4Sf+X/R3lup7MyympNKaOW9NVrH1G7djbI3MkX/H1POWEcFtQhGfHb0FPzvF8z
	I1f9Wgwr9aHSWphsm/315RdKxCsQrKir+cNusEq6Dk0kJDFF5MJyjatY0npqbqca
	vdFBDRihDJGgjC6ewLhXp8UsrvNu2JCIo3Kh490B138PPXE7KX+yvtHboUx9G9Oh
	MVbVOaDJ/DiOsV2wq/Ofz2/BOCO/x+O6oW6YI1nhdZe8YDQ+qiJHZxUKODGBWvdI
	I9w/Sk2OpNn0TB0WEndhQD+8LfCoOUE527g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7vm7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 10:50:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so73591715ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779447029; x=1780051829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsFY2z5jc/JKZpx8doK+ltMU++8z2DwQdy8wREIH8mw=;
        b=Qjn1x1E+wxCq9gG5lWlLIzUISsG704Vwwle9A0LJPq1Cw/+rDcx3gBR5+u6hqjR0hE
         3e9ft5FnxSJb1yRdpBWkPJfynDL/AnanIxDNyrblU6SFMiIkTDrTz5dM7Hl/PIUuxnaW
         +i2/TWBQszpwslr8Lj+pV+TpZ1nmsj5PYEdJLObHCFj6cwJrPOjxRJi6rMMXv9s8dHHb
         /5KX1bFsMwzfwp6/xqQm/B3lcnED9YJ43I7hONSUl7Z/XZGpc/5Cxi0VYt/HUXFV+TwC
         4AN3D4JkWc/1xVYS7RvDLyhb5G3sRYqwkVZzIkxXD2wk8o3/9excc4V2qS1yJgMpli/h
         /BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447029; x=1780051829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsFY2z5jc/JKZpx8doK+ltMU++8z2DwQdy8wREIH8mw=;
        b=nOJAQLicEGL9yzNnp0ZTG2PwNHA9QJfp4VeiwLLW1U+PKBuDYUPpSJDrtNXEjy+YEF
         scT45cVExvhZskhZwnyve/F/doo6v1+BHt93qioNfqxqaReURCV1JehmH3EY+2l4MYJI
         eHPtyPos7imUIz99iFB4SdzS2+yzcs71rPQWr7X9HyHRBsk/Gw1aR0pfoBi0+BNV7NLt
         PLtWO88lzot1STnx5J+piKpq0iIdHJiEssi3bUhbp+hhxCafL+6KYwp+enR80KwuQeCC
         XdzoN3mRvKkJebWtzEI5CiRnB8FO1JRQKM8FATYD/Atyk7N6e+7EUihEKYKQfhe4AC5e
         NyVw==
X-Forwarded-Encrypted: i=1; AFNElJ8T8VchW2t7jYHKDZlV2zEof1ChAlfIojh6RPgBWULHJ205DZtXaZx+3bfnl38WN6Rxe9zWDQ/WFWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUE4SV8PM5DCk1mB23gIHVjjqVQ/l7e5n/QLCxqLA1Pk5zMLx
	Q6mAuIBv2DHs37Gxk94LRlSzyZCnTT1BXqLKtO+OZa5QxpwOMiL72Im7UpkgZD10KGd8G6mFDGo
	Jz0cEKjBCiGCmHGesDAndGXSXmqOJ2TTpiZ7+inSh7umC0J3OxSxPLHoUMMTGF50=
X-Gm-Gg: Acq92OFPc6cbhYURRUqVfkTmtzZlL8SPk3a52T7bWVbixH748BEDpi4Hkre/MW9nOdc
	tBx9FuLeOAr76YmehqzNO9nHUNfLYtRyQGMPN8te692DsE+7Swz4lAtFCQhwUtMOwx0WsvlnSUs
	Iu46+TnAeU8oaly1KHIA7e7mzdu+DLlbEcAWmY5iz2Ce0rqWqwqzH4yy54KEE+cs2wA4Uw6wks3
	OM+sOz3mfaT9deCHPmH9zShhZqUGi2/DfpbViqy+Cj3ckraeclcTYEl2VYfKPmVLLQPkNM4NXuY
	VhVr88eO38JkLOJ/kFB1AoU65PDmtmgcB6/EOBamujykMYi7ZdFB82rhjnBO8ValESsJeAOnv+4
	eubj2T+JVwPfvSSaf5bfFVOyynQ8aR82siITbt4ew1oYJWqT+
X-Received: by 2002:a17:903:41d2:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2beb07b77f6mr33920715ad.25.1779447029272;
        Fri, 22 May 2026 03:50:29 -0700 (PDT)
X-Received: by 2002:a17:903:41d2:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2beb07b77f6mr33920325ad.25.1779447028828;
        Fri, 22 May 2026 03:50:28 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5914287sm19150935ad.79.2026.05.22.03.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:50:28 -0700 (PDT)
From: monish.chunara@oss.qualcomm.com
X-Google-Original-From: mchunara@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, nitin.rawat@oss.qualcomm.com,
        pradeep.pragallapati@oss.qualcomm.com, komal.bajaj@oss.qualcomm.com,
        monish.chunara@oss.qualcomm.com, jsodhapa@qti.qualcomm.com
Subject: [PATCH] arm64: dts: qcom: qcs615-ride: fix sdhc_2 vqmmc-supply for UHS-I mode
Date: Fri, 22 May 2026 16:20:20 +0530
Message-Id: <20260522105020.3588377-1-mchunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a1034f6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=5JD22pyS9HkwBMopzcwA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xfccoj86gJW48vb1YoFh8QTa1QfPn0lI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwNyBTYWx0ZWRfX0QqagAwypVVO
 wgRQGAKpFawRci4WZ9hv4bH3m/6be0y/jioQG7WdD6THbE6Y15lxsHcSc8DTMJRafuZPegddJX3
 JJYLFm+ArLLw3LHKG9n/MfqDtbFiTwMQcdC/D7wGwsvE6n6CnXlkzqSkRQRFcKfEatze2u8i8ed
 /3yCooZNRXwlLdfOLxER9OxEdUPSCe80PUOrhoPXudgzDuBYi1qCamRk4vJvexeDX7/EMeiPuhW
 QzjY52AJ3RaOvKSrAljDkZ+fe2aRlnpQGA6v3CSRz0Ok2MPxI1MfVM99x3K8DkyCSFpXbRw4GK0
 /W3aIMogsun/K54YoNNMCuH0ezvexZPQeklwX4KpkR7FRUaW4a9niyb/kASEt+vuEi+Ex1DgOZ4
 z6v7E/S45/vtgxWgPm5UWzYuMAfs9O5ZC/o+NRc4P914q6MmqHlKqKYKghG37p/fXinpwcyrnWQ
 WluO3L+b+Q9EEKcJPmw==
X-Proofpoint-ORIG-GUID: xfccoj86gJW48vb1YoFh8QTa1QfPn0lI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220107

From: Monish Chunara <monish.chunara@oss.qualcomm.com>

SD card is detected as SDHS instead of UHS-I because sdhc_2 was
configured with vreg_s4a as vqmmc-supply, which cannot switch
between 1.8V and 3.3V.

Switch vqmmc-supply to vreg_l2a and update its voltage range to
1800000-2960000 uV to enable proper UHS-I signaling.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 51b13b492472..047b4efb04b9 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -232,8 +232,8 @@ vreg_l1a: ldo1 {
 
 		vreg_l2a: ldo2 {
 			regulator-name = "vreg_l2a";
-			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <3100000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
 			regulator-allow-set-load;
 			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
@@ -599,7 +599,7 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vreg_l10a>;
-	vqmmc-supply = <&vreg_s4a>;
+	vqmmc-supply = <&vreg_l2a>;
 
 	status = "okay";
 };
-- 
2.34.1

