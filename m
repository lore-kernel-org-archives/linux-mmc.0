Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB7348896
	for <linux-mmc@vger.kernel.org>; Tue,  5 May 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977213; cv=none; b=fZeMjqOVQF0Tj7u6wGKJDmby3ImWL6EjVzKsUCp7aCb/mJcOslGoiBnG0bSFeOu7l+yFJqxGhlL2T4jwotv4sCaHmDeX0prQFmBph8u6OOuX6/tm1NIvRhikhEo9VYkz2pd0wcFh8Qc+dtA0yDPqsbzq8yPki3sx2d0bD3UrAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977213; c=relaxed/simple;
	bh=PjW+DnQKVSB0mT0jRom/dUieI9edI4FfKspoUTAq0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlomk+gqcU5wo+L6Woqma5HJHqx2M0OJho1ozR3CLdyKrL36YCgu7w+oEHkJSv4RImLwygnh3mbIrwKLW+r/v5/VVh2GYrHy1vnPOY82d4cLUF36XB6F1s0iEstXL6t6PB5an18mjFGzUxVBBHV15vp+UlUeM6ht0ZSIyNKoD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzC01LLs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D87jr8gy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzC01LLs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D87jr8gy"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456EEHv331266
	for <linux-mmc@vger.kernel.org>; Tue, 5 May 2026 10:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=x2DkZv2vjeyX7QS9/9m0NS3mR3P2THZBgDb
	bte5VJB4=; b=UzC01LLsWWT36YRTRDJ8T12atEF7HUb0dzYgAEnsUUZCRRtUjmN
	ntamOvzdEV/w8krgxVwiDbYLszbSW6Eg7zLv/WFMH5Z+aFF79SDThhbml3Sikapt
	fM0RxKLQ5vTfvNAP6b4y+SNqmXsm/GGWjTk8qNfYLZHzOmYinR/j8Kjl5AuYGtaO
	X1FQi8IoZFeKDHu/TsqfjMxGeaxgG5sBkKy7pSXFgOIKT0HADGQCI38I+At/DHRF
	vLvxu2LKDrgc7+JoXhl44PnyreHEclnpNVKWLxovWNw4Eqqgxrv+LzjNQqsWaPf3
	EGNmlYWig1PkTLIXlY5MoBAJfdbcTuyh6bA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1c1k4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 10:33:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d8e8c47a3so143781311cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777977210; x=1778582010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2DkZv2vjeyX7QS9/9m0NS3mR3P2THZBgDbbte5VJB4=;
        b=D87jr8gyxdt5Pa2CDgaPdwX75M4MiKjtsMDZiWAx6HGq/RdQOhSCNjb5WXh6dHYEIH
         cRqe+tJP8jqouoicTJIqo7Pwj3LyHw66hTXqXIVVt2KayJc/pnm0WBPRHgKTrQD7D1V8
         WuTuVmpesU9ett7pMI+7giqO6JytOGTNTq6YLkCwP97aZ0FqtTbneXlLCtfvQegtLdUr
         BwCaFJnJtsFUFoavx3qPNZsieKMp8SlLdgWyWMiVHmMSvCQ+rQaHQmKuQsNFxmycgJtd
         wc9wtTY9TGID1GxUVReZVRsH7dB6lbg+PFxLpUyZZAukFj0//8Ekkf2hEfFGPMX+9m4c
         7b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977210; x=1778582010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2DkZv2vjeyX7QS9/9m0NS3mR3P2THZBgDbbte5VJB4=;
        b=kNBVOaBJHSCuBCAWKhEYtU0iigZYyXzQovlmWWyM21CZUhy15U5EkVoKnLZ7RBeLf8
         uiGvHjtZ0Zzryw8NfnXON1sttNhXkDLbwsUuOEYQLjsw49zICy7jfY5juXn2oRHBZd+Y
         Us5hUxjjhs5c12xJn7zTHCAy2EGLMz3MJwLs9vYrA7WrLE6N1j3VLzkpfPUddTMIvcCp
         O6+HgjOcVu1gJ8DX6qTLG9qvUraP9QiyIKG1IhnRb+/51wTTAAwqwh41EfNwwNLcI/gB
         iSkMa31WOf2pss3fLtoGcwnAaESqaoSroKYmk3mLdCdc6mZvyJoXB39LN0Ob1rMz3gvH
         6kBA==
X-Forwarded-Encrypted: i=1; AFNElJ+JqxdxCgj7OXwWtrjbSnYRG6BXKDi3Skai5fQnR4oun93dNZ5QX+SKcy7gc1di+vhLeSL45s6DaMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFqhXKQSAbUvw9pOLuCLOU0UvLz0KXmlQUP8tgpR8H2b3M3w3
	V3A/J49hVp7SABgu9pvdIl4y/3aMU0YKocHrH/PWcg3lSdYQB1o/dV07Hc2b7Wry59DMo1aVH8d
	Vjzb6VIzTdvAxAM0Ox5GvUxS188aBtLRWz7lYgpmnyeLJ1qtLR6vvi/lMMyyeFHLevBIbaZg=
X-Gm-Gg: AeBDieuCL9gW3cofdyv/Z1SZ4xKZnTyGuV9kBw/TjsC4a9SxEuQ+pfIxRmdSrn1faYj
	BWKUoy4mdMpRMxgT3z669noM3lvMduvKhrOMbVTWOrlb12Drl5jpYRYelOT2jOtEBsFR8Eqx+dh
	ayoFCWdikm9P98bBb8GM7bJbp3+UmfZTAHHNcoHPliJ4sKTaV/UT01sokkPTeUIOdErjsunhu5D
	nm/mC9npriLB0nW0Jiz45WXGJt+RPXGwCHMIApjqZ/KJewUq0s+hNiscZB2kMN4VfYakbB2sbAb
	MXwQtbfQF53g0l1C+4F/Iv8D3tfSmxq97ZioDkPCzc2G8RK135t2rbFzS1Ltxx8hpVrHjeQAnsP
	miMI4hR7n+SWsjWCNFqZFd8KYnPwVJuZLFMvX7CC1RGOrLPM=
X-Received: by 2002:a05:622a:4387:b0:50e:60d7:b272 with SMTP id d75a77b69052e-512d32e32d3mr120093481cf.41.1777977210060;
        Tue, 05 May 2026 03:33:30 -0700 (PDT)
X-Received: by 2002:a05:622a:4387:b0:50e:60d7:b272 with SMTP id d75a77b69052e-512d32e32d3mr120093211cf.41.1777977209617;
        Tue, 05 May 2026 03:33:29 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm608975275e9.1.2026.05.05.03.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:33:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Robert Richter <rric@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Alex Dubov <oakad@yahoo.com>, Alexey Charkov <alchark@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] mmc: host: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:33:24 +0200
Message-ID: <20260505103323.207010-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=PjW+DnQKVSB0mT0jRom/dUieI9edI4FfKspoUTAq0v4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cdz46Nekv3Ivsw0G+x6XR1JfbSXw62V+jb93
 pR1j5MH3/SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnHcwAKCRDBN2bmhouD
 12u+D/41b4gKZmew7PuY8CCotWa+e/dgECIHhATwN3HmcshZwBB50gv8+t+O0BWCDSd2TbGG/LL
 dlxAA2dvt1UBmyMJfYKMkkwz5Dl6qw5mRiQopBVx2kLPzHS+kw774ZiMJWR4FBEjEPXf/akIFfe
 NClWF0a1zmC8fXPnmpgkPLcUeTsi+OysDqZk8Bzq5D/sYZNfXrMzkMkWXDHBYINDmGsSdBoZdPk
 5cYV22KU6zfZmHrYZGiTE6EH4nwXqgbdvZxn8cA/lEfBn0XhQ54YKc8M445nK+ECBc25tp2Rsy9
 X0wcjZ/4KfowYSs1h9lYEPlHH1KQmtj0gF99N/eSKpMyFprJlYGBlgtgs8NLoNg79gbowwOw/t8
 9Cpf2QJxzkHI8GtsWI35WhnlupQri8b3dDsRN2Vtc7N4+jqgUxgPzUp8298yT8kr0IvDFQLkole
 0HofMe99yucWpMzw+RAtPWXgUNBPXiVbYpsa/orFYV/8ScmdglsPqVxOIfh8NkyztVSksplcg89
 jETZErRwdldhNyS6yX45ZeN2QKS3FDUHyEde1cOE4b/W/88JC/WNPWG1laXdpSkiCpnYhpgnId7
 4IB3WpDcx9dcH+ckNH3VM3ajzhuITonDYiyY12bTqEouX8FWbDHv1xvWwihmSvdXUmUje+7yhL/ XnUTcl2C7BI38aQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ufsWDGnb_JetzGqyfPs4R1a7RnvNtelI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5OCBTYWx0ZWRfX2XKts/q8rUE3
 JogDu+GH2whuOgn4X3eTPep7wSTtnELlrz2NySZ7h9+SxiWL/q2CN1zNn7KXH5grGi3fBBm5pCM
 KiR9ndOv//paTdnehJy0E09VoijKDykscg+nU8CJuzg/8MzMDelu71y9MgfbifixaSjZ+NaC8N8
 Y/4Q4uXWVVakCr9uV0h+jFWtk9MQ/BuKFgPkefNvc1+1QTFfc2mj2z8qbcjKtjoZNoMVf8dh7cw
 G2xjuM8tk7HiKyn2DTgw+RdhPX5bzPV+yryjdBgTprQqDWPQ9OV0k5E13xH0ffVKLIRY+0PBt2l
 HCPxonSOwkFHC7f7KvWg/g5y0aTBlojbxaz/AKR8b8WpnvXMpjvkmU2YYI0eZT8X0d9q0Cl0pB3
 61FedlauUiPCvcWIhy/46gBQXGYDr36mftTp47N1xl+jU/gj4fGdQBDgsExDpJAM5h5wPB5CWrG
 NLCVgr2q32z9xBQC9oA==
X-Proofpoint-GUID: ufsWDGnb_JetzGqyfPs4R1a7RnvNtelI
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f9c77b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=UPwjdVLwzqKTMXskr54A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050098

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/cavium-thunderx.c | 2 +-
 drivers/mmc/host/tifm_sd.c         | 2 +-
 drivers/mmc/host/wmt-sdmmc.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 1373deb3f531..84ff6d82ae3c 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -188,6 +188,7 @@ static const struct pci_device_id thunder_mmc_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa010) },
 	{ 0, }  /* end of table */
 };
+MODULE_DEVICE_TABLE(pci, thunder_mmc_id_table);
 
 static struct pci_driver thunder_mmc_driver = {
 	.name = KBUILD_MODNAME,
@@ -201,4 +202,3 @@ module_pci_driver(thunder_mmc_driver);
 MODULE_AUTHOR("Cavium Inc.");
 MODULE_DESCRIPTION("Cavium ThunderX eMMC Driver");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, thunder_mmc_id_table);
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index c1f7d5b37911..aebffd3ebf60 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -1044,6 +1044,7 @@ static int tifm_sd_resume(struct tifm_dev *sock)
 static struct tifm_device_id tifm_sd_id_tbl[] = {
 	{ TIFM_TYPE_SD }, { }
 };
+MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
 
 static struct tifm_driver tifm_sd_driver = {
 	.driver = {
@@ -1070,7 +1071,6 @@ static void __exit tifm_sd_exit(void)
 MODULE_AUTHOR("Alex Dubov");
 MODULE_DESCRIPTION("TI FlashMedia SD driver");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
 MODULE_VERSION(DRIVER_VERSION);
 
 module_init(tifm_sd_init);
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 1b1d691e19fc..489daee4f4fc 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -744,6 +744,7 @@ static const struct of_device_id wmt_mci_dt_ids[] = {
 	{ .compatible = "wm,wm8505-sdhc", .data = &wm8505_caps },
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, wmt_mci_dt_ids);
 
 static int wmt_mci_probe(struct platform_device *pdev)
 {
@@ -980,4 +981,3 @@ module_platform_driver(wmt_mci_driver);
 MODULE_DESCRIPTION("Wondermedia MMC/SD Driver");
 MODULE_AUTHOR("Tony Prisk");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(of, wmt_mci_dt_ids);
-- 
2.51.0

