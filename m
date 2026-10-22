Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662735;
	b=2aAuWft4zZyTcVKEO6e/fCaOhkJp6yvfApSwbyo7pXbsmp09xpWApBBtBKborcq2JsrD
	 ketecLZPiRje+f7ojVDoAsdQVXfaX4TSQywUDno69q8ACqTF5qihHz3gDvPGZHYnFsxrI
	 1qAJb+Lz4oR15X69QO4cwjOU/7nlC2X89dl2A6YT8xlDF0V73fqO6wdQ/5bctJrjnpUnO
	 YN/iA8xXVul2Jher9i0csVnRp6IAb5OPTQ0xcSo7qrmz6KsPlTqBnFhAWUvRtn8FksOFz
	 pEoBrVPTZbElcmXA4JEKjo6OBHtVwFPQGf9VNJsskKDAU1HJrfguWW72GyC75aEHOwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662735;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LYt9rd0NfUvWvMCN389zamkO3Dpz4pDQJgC5BLvRDzI=;
	b=fL6fLSqaRTxGmyKxI25zQtM9Yti2B63EVgjIEAP42HdJYFGK+hGWhBtlCoxtz5KGLS4+
	 D+KFktODq3HjBptqeY9gkunjcjiMGYFQregcRFJaqC53rfsoLhrbHWbEO/Xq58afjsRV1
	 I+zfQVs/RJwhF4Iz/jbiZesb1biKlFHiQYFlyoE78IOskQDq049FNkGfK1FdGj2Ch1Pud
	 lFf4+vhn3PkGR4+4ligNzE9rV5YX5qFzlgvJ8uyvF+6Y2ZEjqkP3DV1+IfzsoL2SKzZx8
	 GVhBx9NlmA3qOifJhK3Q2Cv8Mb7Sfy/+kpIhkxtV3/W1D006M7ciQMTh78A+PdhKcrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V7hWSRu9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S0nZXerw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E5606A31E
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F05E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V7hWSRu9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S0nZXerw
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M709Gc1996036
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYt9rd0NfUvWvMCN389zamkO3Dpz4pDQJgC5BLvRDzI=; b=V7hWSRu9CGmPGUBC
	bZyvP3ha08wYeCIRvaVAPf/Gf0eROu3Z+K5s+mYmzYCcNhtpkElunwVNidvyEcPi
	MIUcxkQO/g+NQo5gc8XQ56j0TSEDKn/cUx1F0V/yqj8Zx+T1/T/y8CArBSPKlEdv
	L6l/yTVBr54ftOBjtjfq/ekDUhtwAlQm8F9anGn8Nu9e9H6MPALxkFwHiRefp30c
	ZsUQQINiFPylOoeuUrltHHHsislSUuXdAFY3rOz7yfSzwLpAufNChre5xP1NUCkl
	PZ6rveCA/3Ab3nzgeVEZhKC5tOvJx3BS7LNetHjJhglvgMcAYj/0xt/OeMR0lS/s
	rCgZaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bsrnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:52:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3157666eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792662733; x=1793267533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYt9rd0NfUvWvMCN389zamkO3Dpz4pDQJgC5BLvRDzI=;
        b=S0nZXerwXws6OKBZcUgBzInHxXP4VFvZwXGQn90ulcWdVZuI6xhjVVUdP06YYAQEMJ
         fmlPZAJZjY88LUThaJxdXfTrdcl+rSczTm5LAUGQ9RggnRNQ0WJsCjITBGcDRGdGQH99
         ndNTQKbkDlqPWOEbocYjiMrPBsuBlgSa/6iNOhgt6d1aUTKxPi6/wvE+R9mvfZTvhzCq
         +ngDZkRMJEwV7ZKB7GWRp+XIjsYyPKgNy6pcu6ofEGOzptWhWnVfgKKdBDMWXG2UiyID
         8cFS1rVV8VOKB6rHj4Z/R+jKWC+x/IRv+DRbfy8lYhiEPT4KtoRssLt6tKvWHhGKbtTe
         uswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662733; x=1793267533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYt9rd0NfUvWvMCN389zamkO3Dpz4pDQJgC5BLvRDzI=;
        b=Sg39SuhU+8ahUf3MpWOi4KflCuGLYBK5gmUho2JLqZfIKIY0D8ahUEAhKBPPXpF5bO
         Bo8Y+n4vtzUTCtO5quE/i1msFIdo24AauIIgvEV7axGk4/ecbTP26pDpM/xpqHMzhxxO
         xCMb/pgKdTPtRkrO0nR/fsZEs7SpTWfuGsM3yVY5KWt+yMFeKiOaWwQAp7e41AbWN9VC
         dF6WUHPvplbPbPuMCLejsDXSFMJMh6b4AefCSqRXuWG8fTHknfKOdIipNe+fvvzJqTe5
         FFa1WKrPh6keinTYM8OKt5i5U+95nZXmEyj9kMGknYiuatS3cD9Q9SZ31QuzhnKJ7feM
         IJIA==
X-Gm-Message-State: AFq9FYIIPzzond2XBObKMQ2bPrDQaizNwM0WToac+Objt8I9mCsyvnFN
	94TmhVFpn0fIej2Ohw+WVT/IcbpXmE8zBukHv9pa+bd4P517ywb3ISu7uCKighEf2r7G2Z91GBJ
	ZiHbGirsCIwcfcgXaFUEG9MzPOVPl8HkRPyNH+S/Mspc3B2X+CDBSYEmzzU5YnmY=
X-Gm-Gg: AYBFou1q8vX7oSIpdKfdN0SlcVRxtDE3QCy9FLqsuy+UYpITY01eXdnad3ET+R7+O4i
	t8jxXUpa4G9AxH04SdvalL4IPMgA6iUC6XvXyB9LYpvqd9AmwSpHqAFA9hALkU4qTJ6HnY+FcGj
	R2Rv7WKtkrmnvDSWLwZluE93KMQwjcQjzmVlIr/L8fmY19swJng+HUJ23M8A0YZh85S6s0GZfiY
	awU3N4yXx9QbX/arDYrHuKfIRL6aXVvFB3UGI3eWGX/FFvpclChQIx30hRNjHAGCc+eCdWRQlLX
	OC6mkQ/yjZWugK2CBFRgKUr64pM/tvADqf8MU8+QC0EmMPP/MvBVqeVLb/CSqlmaO8qu53GpXx2
	HJzZ2wH/hb+aynfo1cinCQzzndpHfKccU
X-Received: by 2002:a05:7301:1885:b0:366:703c:5ef8 with SMTP id 5a478bee46e88-3674ce2fd08mr6635025eec.7.1792662732830;
        Thu, 22 Oct 2026 02:52:12 -0700 (PDT)
X-Received: by 2002:a05:7301:1885:b0:366:703c:5ef8 with SMTP id 5a478bee46e88-3674ce2fd08mr6635001eec.7.1792662732279;
        Thu, 22 Oct 2026 02:52:12 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e153519sm15742170eec.3.2026.10.22.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:52:11 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:21:51 +0530
Subject: [PATCH 2/3] ufs: ufs-qcom: Enable ICE before enabling crypto
 support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-qcom_ice_pm_enable-v1-2-f7a84086c651@oss.qualcomm.com>
References: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
In-Reply-To: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: GFRYoWhAqUdypXFbEChqLgFZM6W35SU8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX+Qb3vXG/HqG1
 yGP0ROStxxvA2883Un0rInAiLNEnFDUNUx68ggedYWeaTwqTVwUbxHaKO41OFi40oDRIATkO3+X
 MPHlvIf33+U+GTf1odrGQ9p5h7AyHM4=
X-Authority-Analysis: v=2.4 cv=F4fC5ahN c=1 sm=1 tr=0 ts=6ad9dccd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=poJO1rpmugtNz4m0g9UA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: GFRYoWhAqUdypXFbEChqLgFZM6W35SU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfXyij0Hx89gd0V
 SFPJb2v8GPooxFNyI7NRH/j9P2gnu+XFZ1YemTr7y+KCu07N4gvJYg8iXXTXjtEaBW3IxrBhtVr
 XYs42SQ/m6tBcTwV4bBXXPrQAUPesECPfUYkE9xYL5Gl9DP9xrmFYejq6se9EB2xfdY1+LJ5ezd
 wHJIGMoGEVs7JlJ0pz0ed15TohczvWFA32m7ZrOL7MkhpiCq5w2IiAZobANOUhC2zbUIIGSAMbH
 mRaR3Y2gixEx87fzZMaC1BMhWGYFBJb/eH959Yxq32S+qN0/PIsIrs4fyAqs89MzaykwRAVPSIu
 7sCLhg71pU5yfoG2h4fAxbGpXMa9pvGrgKwo+/S2yQwhrEyf/I93Tt0+YlH2I/+G2Dw7I8rG1Bn
 IrQxNcW5SaHva8UjVmOI8c6+YltLX6hTcSh8eK4NaqwAeewVZ8nyjOqF8FX+ofgsdKvAnPLOR2N
 aG1ugM3o8YSwAcfZj9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220039

ufs-qcom currently exposes UFS crypto profile and sets UFSHCD_CAP_CRYPTO
before enabling ICE. This leaves a window where blk-crypto can issue
keyslot programming calls before ufs-qcom has explicitly enabled ICE.

Similar to MMC, UFS also works today as ICE clocks remain enabled after
the probe, but it should not rely on that implicit clock state. Once ICE
supports runtime PM, ICE clocks can be suspended after probe, and
accessing ICE registers before qcom_ice_enable() call can fail due to
unclocked register access in qcom_ice_program_key().

Enable ICE during ufs crypto init path to ensure ICE is ready before
blk-crypto can issue key programming calls.

Also call qcom_ice_enable() from HCE PRE_CHANGE path once crypto support
has been enabled. UFS controller reset can reset ICE state, and the UFS
core can reprogram keys during HCE start before POST_CHANGE.
Re-enabling ICE in PRE_CHANGE makes ICE ready before reset-time key
reprogramming and for any later ICE operation.

Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index fee9b54ba5e1..7e5aa4573e0c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -158,13 +158,15 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
 	ufshcd_writel(hba, config, REG_UFS_MEM_ICE_NUM_CORE);
 }
 
-static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
+static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops; /* forward decl */
+
+static inline int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
 	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
-		qcom_ice_enable(host->ice);
-}
+		return qcom_ice_enable(host->ice);
 
-static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops; /* forward decl */
+	return 0;
+}
 
 static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 {
@@ -188,6 +190,12 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 
 	host->ice = ice;
 
+	err = qcom_ice_enable(host->ice);
+	if (err) {
+		dev_err(dev, "Failed to enable ICE: %d\n", err);
+		return err;
+	}
+
 	/* Initialize the blk_crypto_profile */
 
 	caps.reg_val = cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
@@ -318,11 +326,12 @@ static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
 
 #else
 
-static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
+static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 {
+	return 0;
 }
 
-static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
+static inline int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
 	return 0;
 }
@@ -636,12 +645,15 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 		 * is initialized.
 		 */
 		err = ufs_qcom_enable_lane_clks(host);
+		if (err)
+			return err;
+
+		err = ufs_qcom_ice_enable(host);
 		break;
 	case POST_CHANGE:
 		/* check if UFS PHY moved from DISABLED to HIBERN8 */
 		err = ufs_qcom_check_hibern8(hba);
 		ufs_qcom_enable_hw_clk_gating(hba);
-		ufs_qcom_ice_enable(host);
 		ufs_qcom_config_ice_allocator(host);
 		break;
 	default:
@@ -660,10 +672,9 @@ static int ufs_qcom_fw_managed_hce_enable_notify(struct ufs_hba *hba,
 	switch (status) {
 	case PRE_CHANGE:
 		ufs_qcom_select_unipro_mode(host);
-		break;
+		return ufs_qcom_ice_enable(host);
 	case POST_CHANGE:
 		ufs_qcom_enable_hw_clk_gating(hba);
-		ufs_qcom_ice_enable(host);
 		break;
 	default:
 		dev_err(hba->dev, "Invalid status %d\n", status);

-- 
2.34.1

