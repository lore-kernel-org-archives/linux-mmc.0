Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB453A1696
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461496; cv=none; b=mkpe58N+cDnVnjzYNdRqQlL1S072iOk/bKzXDp/flLzvL1wj3muRuWtD9VihqZROkh9QXjzNLo103OcaJcyiZHu+ZJtpGBon/zdujHBHX5xJAFZd9jmaWp7DTAgXmAddFhQk/0yC79XBqUhkv6p5MyngP/8nU8Mw9K1WLCMo0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461496; c=relaxed/simple;
	bh=adkMKR1iXVx+DwmZ3065YpyXhuugVWY0+cU+LJwva4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7TrrPy0CMvKjSLygUnl9W+hQ6Uc8K3Ljf5daYPwt4pRTSvQ0uwx1fuAA7y9xt/hXOUwRbkY13MSqgJjYBKCYH44JxafLuCVQ6nuQupG43F3/cYEv+8HjWfJhAaP0PSNKASLt9PT/rRMjnsJZG8W+p+CTBrlg2Zcc3qf2c8Xgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUqyFTET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UfxlyPIX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUqyFTET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UfxlyPIX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWja73718161
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rb0nIYYamBu
	gMkUBgoIqbypSuVTrhDhDqU1MT4y2vJo=; b=DUqyFTETmQyHD8vNPyIOTED5LPx
	itmqBxqa2/5ZK0NqmsapWvXj7Tjmt4E31nhOGfkoOq/z7MuYGLGFn/vMpiPawodT
	Wuid+/pkzTCUQYdg8W4K7OkIF3kD8t3da1WpW6a6D3ljhUI4pEwurd1tQrhw+c6k
	1Z2PKw1ZhZNPbkVXiwodrbSYQzOyz2cLxWajTt7pKajDKYLNHboafYr+bCbfdJp3
	8ETARFXFYbS8l3hxMEJtRkaqi78Iv6UJPn2Me1/aWrvKC2JZrpnW39vbP/rrIwHV
	HuxOH1lYRsM17CGQPmcoKraWPK7NfrGDa/zkUHOfTmgiIfKZRKhjIDTPvlw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwesxk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a3514f912so1446923b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786461493; x=1787066293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rb0nIYYamBugMkUBgoIqbypSuVTrhDhDqU1MT4y2vJo=;
        b=UfxlyPIXipfp+9iUQ0xWZywl7ijRe4EwZ9OsPcv3Y8Cu7Baew0hpaygcsFpVsV2sgv
         TfIObk7UsxDQmG+pFKzo2T2Z7hAf79rp97zIHG/gOBHRTnfcyVVqH2m0JukrrJ3QHH7k
         JT9mMV4p8kIXf3V+UQ94iDS/gyxnw5xNwEtxPsocMShHBsfV87msLemi84zWWgl0HJC0
         f48+pDWsROGvqrtqkc6nohSO2DfkMqpNV6vg4jGzB00wIyAVY2FacCxn3OPWB8c+EUat
         G1TJVKiNx8s7gGVbQrvujsSi3kyPXMt5ro6jweXpBsjP/6hJYbgEKl97Q+92QbyjpZFk
         CVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461493; x=1787066293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb0nIYYamBugMkUBgoIqbypSuVTrhDhDqU1MT4y2vJo=;
        b=W8mw4UlUB9aclXzXp4jETxP+s45zgBefQrlQ+AP1N8C7v32OaHHFXlnBQr0TZiXo4d
         lXJVabNCYqqnZ7BImQokyuAap3fdAI131SpZwm5mhhN2WTwNS/PWKQu+hKnDKqOsGUnf
         YCJeVN4t2WbR3fixVpXcTINJZYYzuPLGHeum5oTY4EZtzF4GEU6Y2jZvIperm0hbFaWb
         itiC8LpY2wThCMFLoMpKsyQt6u+fpY/I3CtX2qF26KcTNZPbMFQjPaSWTa5D4dO/pa9A
         aK4qRMWL5C6zf/yQlDk9YAdujV1xsQmTCFDtj+OaSEd1m8bIP33qkw6Bx6DjM5/p+X9O
         JHvw==
X-Forwarded-Encrypted: i=1; AHgh+RrstGfvIGmgSHDAYeZRRmxQzx00c+PiCcFmUtlQFeuTd69eDG53X/8lwv3fpU8fXnftfCZY4BxPEag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfB+2Yo19wG8P/t2DE5l0Mm8hoOjaKJGjm9yOatHs5KSDdEmv
	Ef42Eu7KulWomnzej/D0Xntc/Qk89x8Mks+THoTgHrZBGYdZpWY5t1sMIemLPgMjwukpSkQVqkw
	/uDsACuVkM5eqhORLj9HMWtyq6THqgFpNgJqRAFul5tnwJB1RfuBGagnLN5fZLJ8=
X-Gm-Gg: AR+sD1331jxOUY31HQcR+YhouA/w1Nx4RJW7dtuMboQK+VSfu+y2TcrlKITUYi1VQT4
	TgQslcBBkaiP22vKxkUEV0ScRwHvrDl5c9xpFLZNYwFglicGeFNWiGpzb6axYVTVCmwnQ6doD4a
	KC1cY4yjjD5ubGI7/dV7Xjr7T0U4SgLwNRI6mdlUZ+OW8K3sD+xRTM6O4oZWHe09qxk24cCS8cO
	CNLZxIevQjITZKqUW4+tElzG4SfocQKUn+V+WC+3AgjKX0Nh3huiDbi6NK5BSXeojJsmMqvx7Wm
	meFRpeVlyg7ppnB8/IPOLHRfN1pB4iyggqvjuZwvrUzqrEf0O1wrxoqjJ6cugxeV4oxCChEehwI
	NFYO9zR73WRAhbmE8+QabH0DWgs5uVBI=
X-Received: by 2002:a05:6a00:3a24:b0:847:5ec6:3afe with SMTP id d2e1a72fcca58-84fafa1c035mr928004b3a.31.1786461492935;
        Tue, 11 Aug 2026 08:18:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a24:b0:847:5ec6:3afe with SMTP id d2e1a72fcca58-84fafa1c035mr927950b3a.31.1786461492483;
        Tue, 11 Aug 2026 08:18:12 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa95261b0sm983727b3a.36.2026.08.11.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:18:12 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v7 1/2] mmc: Allow host driver to control the re-programming of crypto keys
Date: Tue, 11 Aug 2026 20:47:58 +0530
Message-Id: <20260811151759.1258525-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811151759.1258525-1-neeraj.soni@oss.qualcomm.com>
References: <20260811151759.1258525-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Io4nH5_LOxr6zrz_o51v_OCCnoErh93c
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b3d35 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gPkh30t4SdGlgi7DwewA:9
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Io4nH5_LOxr6zrz_o51v_OCCnoErh93c
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyOCBTYWx0ZWRfXzcBomisGV/KW
 X09H3SVg3Lj2jxC8+AGUpr78ME7M6uYAnzQkCEX7oBL8LGHdsnwYWfJPlZh1k7Wdg43km5Kr51i
 PsyFCoAo1Wb2cTtkL29Hlpy7wTnpnoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyOCBTYWx0ZWRfXwKApxPwaiNy5
 azdz3ocxLXuNLpvtG/ARJXQpts7IycKrrhkKDWEeMOf8dyAp5sYJVyyD3mlC6uXPL36F7V/SK5u
 +eDS2DFS99Lk0C5RQwO5L2vm0SPVtD7jYa4drdLeD6A0LBe46HTuNnY0htkq3n0T4YxHydn+wwu
 RnHGSJBcMZSljJVGDfGujYtd1RsqZAAa6TKw8T5Bec/pt/lhNSx3UIDLy3/S01SYRAeDmC3h+Gt
 ClxZLS807X3jHcoDuoWS0BQKD8do33UA7q7eI484IxTiP8vXzFUGCfxKOLwhCrUFyqQ+rdcXhde
 0vxCI358hSNna0RN9wvkIo1Ds4qBHFN6BHknBHQ/tue9o5M2ChzjOpS+MPLpP2YYJM/Swc3h2+J
 ozNdTz30F86lvR1s+xuY6R8aRlOx16U+nvC8MbrLjF2kpSqMmKy9Z3h6izNfAygHkgeRRmAgKp7
 SaT+73GZEdGL1COyBSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110128

The register context for the crypto profile belongs to the
sdhci/cqhci host and not the mmc card, hence re-programming should be
managed by the host driver itself.

Add the flag MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control
reprogramming keys to crypto engine for SoCs which do not require this
feature.

Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/core/crypto.c | 2 +-
 include/linux/mmc/host.h  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index ba84f02c2a10..3c3c45fdf39b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -463,6 +463,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_CRYPTO_NO_REPROG (1 << 29)	/* Host handles inline crypto key reprogramming */
 
 	bool			uhs2_sd_tran;	/* UHS-II flag for SD_TRAN state */
 	bool			uhs2_app_cmd;	/* UHS-II flag for APP command */
-- 
2.34.1

