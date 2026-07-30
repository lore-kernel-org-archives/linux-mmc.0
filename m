Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA443D501
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420521; cv=none; b=acAag8Vp5Z2P9rvOh76Mio+6LcwBhk1EL1YDDCdR8Xy7MJYUa3sTw0tweAtv2ToSaSVDXNWzsMAYhsKEygKK8Hnm6DENFCar2RCV9R2cfuD+8tT0wRKa/TVhIcAjcRlcjb+AYEX5KOc8qGbnCoZOK4zNcSgL8M8hkuQK8kXNkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420521; c=relaxed/simple;
	bh=YLPr7TThknuHRweRQd5AnSaQHr9z47c/8vkT2o0DLCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q10jOUEPx+7rt+6u0LXUvX/LQIbt1UhCpvfUSYWWUfLoia/DjGzTgapauebCbxu1Gio757X54+IMveHcZbAB5f58P3fsfWpiGE/Bt5TULUxZc6Ptt738kf6ApCTdxjZ63CdBHNhvntzpr0d0JPv+dtHRhQJQie68GwV6ql90kQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IW+q6+OK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHlQnnS3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IW+q6+OK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHlQnnS3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDRuW427182
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ToOb8xl6bqk
	7/mITFay8ShYzRKcgoE8ExL8nP+bjnjQ=; b=IW+q6+OKYM+90L4DKHH9cbtUsEM
	sBKWqKg/NQqX6PIsR5K3nOMr+IeypAWezfHgXKkaa8xz4g1bNKZ0bBRYCKHRCsv7
	NPTF5Ilb38F0dQBnK4ITPoBcvC+MotlHiLqX389bi1jFBLX51JuR7fD6RWytSUVS
	Z8RkC0IEZm+8Yjn+uB1BMk4ydcNx/F+jWR9rXpvoeycl7k4vz1nth1ZWuaD2kHv3
	KpmyhRw2pvfsy0suqTO7bRzg+buCVhE65gASwTsO/OVbSvdP99r+GK0IE6YOza+Z
	sVH+LYX/up6JUT+FHggb/uL5bu6kq5zHpM8IgoJHtfemjn0b2kG9v8Rhmig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3tyh781-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e934385db1so24811026d6.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785420518; x=1786025318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToOb8xl6bqk7/mITFay8ShYzRKcgoE8ExL8nP+bjnjQ=;
        b=XHlQnnS3lKd7PupzRlJJfR6m2SFUr3DgeF+puCf5ST9e2nrTy9ubY2WXxxT+EV43Hd
         i+q0x7uSF1dO5tTP/bTgMxEpQ1SRmeZxEFLlfr6a3Si3etJnQLI7J4usAUkN6+OUisTp
         A4noT2Leop35ajDr2uW9smmzDeliSZZ+rMailaWejOvHGmsYjzmNBLPsJu9hCg1cR7hH
         2tjZhU+5I3Z8FvgBLafTE5a8RJXpb7zoBI+0wwSQOoZEfbtyr5eNPLslkpQdnsZHy5+e
         OknxgFvHeXmWGwCzJdvEiKcgAFNynnv9B3dg7lauheXDoQzt5jZwc43SJ0Orhgd2d4NM
         7TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420518; x=1786025318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ToOb8xl6bqk7/mITFay8ShYzRKcgoE8ExL8nP+bjnjQ=;
        b=UOpuavrQGV+DaIS6Vn6eAn7avhrg+d88asv1E4pFmUO3lxaV63XX0GbbVKXQTEj4Yn
         jlDmFZ5JDbN8Tss9ocnjv3lD+fgS47ZYgNgVBmEGNq9tCpCDtNG4m1id1MQ3AHM8oklO
         KHJlOZIjJDOr0Ti6QVX30EEgnWULGBacusaUU7ueLcNW66H/HhU8yeQJr2rM+CfNZAhw
         bLFLwB3Wdx4/BBcu9aYjlvPKYnHO/vJF/W5bzbumuN9ajo7LvIsYpHSOFJufnOerP5Mb
         VitcNY3jeeRjLaPu/EZplw1h4uAFvqC4TvgCdk2ibuxsJyquLXgU9PME2sjjap9zp9Q5
         F6bQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMtTpu0RRFjHckgLF+Yr/2Sx0vCf0Dgxa+5cNhN0kg/sLHPk2vOjRrMxl+CtfWaR+p5ZgzdQky3so=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCm+LhwcJy5ZXvNMxzfZdroom4PRI5sveurRCMW5bi8ww5FByJ
	nF0YgPQ70jxq5VO6Vdpxw4RkE46ESpiVZWK7+m8bovKVnA6jRfVhrZ0z73p9H/rXeyMZQylPqr3
	r3oTq7oO1bPdr5Fj2ZHc1SlHb4hgOkVr55VdUMEeufd6d3hmuYbiBNdHzQ3kyupM=
X-Gm-Gg: AR+sD117OHhXf5+bge5uThl6dnS+PBeL837V73uBIBub5XlhCwjArLpjQLvZNsV1Srp
	hBQ0rntwlVMfRYmXWyxstYKxXtUJzLH0PIizadTuH/oejWCf9UHcJekMW7AxKC8ydd+FP/AXHX+
	7FFXq1OlXMKYOrAAQMoHT3qHXTljDCcYXbsEtSey4T0jElGKimuVTfI3f4uAjy5RWUKxB57fngT
	bk18DSFRPCr5MZEYszHSWkzDqqBH69dI++TG3ynTOYGx6KUNmY2Pr0XswpMgbR3r9vy7G4RQCN1
	dt1Nfh6qX34RSPFQAmyCU7h/DN/upQMJmZNFaraQfvfbF5tFGs39vZ4ipMJyR3CIBV1M7BUwmHa
	UsUOnfGHHHJWZGuhlhAWpUtTHhHFnTbM=
X-Received: by 2002:a05:6214:2621:b0:8cc:ee2e:8d9c with SMTP id 6a1803df08f44-9083b8b83damr2440846d6.5.1785420518446;
        Thu, 30 Jul 2026 07:08:38 -0700 (PDT)
X-Received: by 2002:a05:6214:2621:b0:8cc:ee2e:8d9c with SMTP id 6a1803df08f44-9083b8b83damr2438286d6.5.1785420515619;
        Thu, 30 Jul 2026 07:08:35 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908325186b7sm18465826d6.43.2026.07.30.07.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:08:35 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 1/4] mmc: Allow host driver to control the re-programming of Crypto keys
Date: Thu, 30 Jul 2026 19:38:19 +0530
Message-Id: <20260730140822.1976635-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tzG_ITbqpyc4GsjFYC9ZxcrJMPoWz2bA
X-Authority-Analysis: v=2.4 cv=JZOMa0KV c=1 sm=1 tr=0 ts=6a6b5ae7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=qCc5xqAkgSuM58seIEQA:9 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX2RLp9KU/3fbK
 JE9bmFTye+psGLrhZgvI+I4Hp+/JTm3RjRIkpVXpvUpSWJavn071mMhGl2fj4nCTbW9tb3ccDr7
 rtwSrs6BLtve7WEF0AKQI8k1ZbRFUC8KfSaxDHCRLXO4BFci8fWh14psWqMdU63ZVoaYmYFNe3s
 4MA+VHqer9qaB4Olaj6HJCuvZRbG0iSsQXcLWAPZhgVHkroASsfobjI2jtHPvLd3ikLi3vOyFHb
 5RpJAWU/vDV/iopj5Ai/J1ZaVnqePqQohmFvO2E3O21IsHWh01aW8JS7udRvWjuP/5NuzjD6in3
 6/vyc/L2RVvw6fyOr8A5k8q90Xm7DwcrITu/0RRxIefPH5l4VBjYY+YJEJn5v5+xcmKrQGQoFkg
 zYwRXGGVbvPSLqEfv3hTJJYrUKIhZckM6Zu0oOjcmaWWKE0TnLA5X/xcceAw7pY5fKvQmXfFH1w
 sq64Sgbqity+Q0jk4Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfXzlzx0jjxun4J
 if0uN+euYaWmknSdvhRihqQhlSo9Zh1qG0AFZ/JX2lHPDROK+U9iJByXCAQASyiZ2RJ5UKSQHcP
 xYLDL1wh7e1CnGYHdN/SMe3AYbirkwk=
X-Proofpoint-ORIG-GUID: tzG_ITbqpyc4GsjFYC9ZxcrJMPoWz2bA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300107

The register context for the crypto profile belongs to the
sdhci/cqhci host and not the mmc card, hence re-programming should be
managed by the host driver itself.

Add the flag MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control
reprogramming keys to crypto engine for SoCs which dont require this
feature.

Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/core/crypto.c | 2 +-
 include/linux/mmc/host.h  | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index fec4fbf16a5b..a5a90bfc634e 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -15,7 +15,7 @@
 void mmc_crypto_set_initial_state(struct mmc_host *host)
 {
 	/* Reset might clear all keys, so reprogram all the keys. */
-	if (host->caps2 & MMC_CAP2_CRYPTO)
+	if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
 		blk_crypto_reprogram_all_keys(&host->crypto_profile);
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..83d92fb64417 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -457,12 +457,9 @@ struct mmc_host {
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
-#ifdef CONFIG_MMC_CRYPTO
 #define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
-#else
-#define MMC_CAP2_CRYPTO		0
-#endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_CRYPTO_NO_REPROG (1 << 29)	/* Host handles inline crypto key reprogramming */
 
 	bool			uhs2_sd_tran;	/* UHS-II flag for SD_TRAN state */
 	bool			uhs2_app_cmd;	/* UHS-II flag for APP command */
-- 
2.34.1

