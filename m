Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489528;
	b=JWc3dIhzHisAd96KLvCaxnW0fimYTILPGX/dmrFc/SlqPI0BxyiOxyCekkT0bvZHir+V
	 DPiRsgz0xphw5HBEz0wi7D7gGSa/t03e8oq0jyaeMLQLqX/hGGKSjUsRZj7vCHldMyKPu
	 mOdTlYaXrQjhWz96CcMHfbq4G08pw5O2ddwG1A02jepKZySaOme6w4Wek+6cf6HB6sgzr
	 EtxiOX0BrQmkGcSLoYnoi6YQUrCAG0v10eVfIHuVid7awNGPcem+PF69MU62LZ+95/5Qi
	 +JgkNqrh8UQTVHxaa395JZ/6mwquJtxr7Plny68yamB3126N3nBauHzhz35AJFNSExQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=;
	b=kLESmlm5B02ArEKd3JPiMZjHfBGWWAZ+79WiiJWwjtKINHFVMCraZyXd0G5MOD+bs4iH
	 2nWGdJGlxTvwqUtStYfZG98C04NKM7uCF+mh+Yhm2gA15ZNb4QNiVq4+6IpZGnNFj9bGJ
	 7043GMrtub2WYm4vjgbGCQ5QpHogYad2HlCwss6nQfxbtRuhg0Qpgs1aOCXSKKsWUVZvs
	 wG/Y5lrDa3pNqUv8FWbN1V7Yroiq2oy+PI/zH+R3+fWS+nBBOoHrt8suZG7NkFkYAkylF
	 Xs4qQ28jFCxq5JU5kSfMMv3wZnesxlZaiKWStOpS/OYDJ6io/qbzNmxwCTiNhkDwbKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iEV4faAH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAWxeJJr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A4606A88F
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E3A4606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iEV4faAH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAWxeJJr
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9NebZ2514376
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=; b=iEV4faAH6AEwx0yK
	M8mdfguFa67BDVndXkch3vGD1FgznzpBchyXDhGoZPawVNC1dGjOQvR25hpW3Xm5
	gYz8OciFHmJZC1PAWKdsA6NTFwNc3jT87CbXxksERiEUcwN9EUi67VRrQW/QtPqm
	dhg4Qk/mThJZB+x/uQAcwelSZm8sIFBG0vn+u1G+NZ81DGD7R3ZPcaIL9qNneVq0
	0bbqu0E3mPhjh3nSQTBEcFMGntolMHPmaok+g03Lc61oY0Qzq3Rdpp7nXapZHY3i
	nDRRC3D+HBu1Plz+rpNbp4LrtHjqj1aW0nuIjHP1fW2yWkPPSSksSIGFWU0mpl+0
	nzom3w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1uq5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f479b9819so6824732eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489527; x=1795094327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=;
        b=YAWxeJJrmwgtpLdrXgRxtWdhAHbyFVdp8oXahHIP0oYMmIVLxpn9Po7ZDdTgUQuVeH
         gxiuxJsZoXYKRazaTliQHaMjlYuJ/dzkgDCu+kg37puDm7BdMkaY7Lo41sczo9STlmtd
         UKHDnY+tafrAEIpyhnFjttObXI2+ryWuwfVVfYQgcz8JT1v//9qcnt62bW87LYtI15u1
         +KimLqtNrClzQ0JezqoCjTNPXS5Zog2RPhJP6ZRwmtlaIXyQLCSxUeU2D1oKOOq7N+ul
         xYsNu8ncNpY6kAuPQ2xnEQO8g9Rlc6iG/iUGEpJ4OzFp8RDc3OM8JwqrsUoL1XXXNKp7
         VOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489527; x=1795094327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=;
        b=c7/3KMhv0pmdOkJysjvrAeV4PPZqviBllujpEhT5nDq7FsD+GtsiK+V4I5c7G8QoQZ
         JpJapMvbamWxidT19KLafG16AOzA6+tihy2Y2PjOAvr6fryy7DYiahHWR4MvCQOoqZ6Q
         4Jm3/LmKaHxiL1rL+WASmg2Y/kS879Tcb2R1LNAB0xSvZm8Hzj7Y44oA9eF/iyfP0Gm+
         Dcfbw5dFqs23G85f026E+anSPnHKL03/S+toCfeozFlVqyUP5NRYz6aq2g2mypRVA/MC
         uqUH4nvdqJGdY78+3K9zpp51qCvHB9O1OXpLMnqG2Nmqy5jtn7mDcftEVZn/DvcTNf8u
         y6sA==
X-Forwarded-Encrypted: i=1; AL+hErHWIYjiFoxvvQOOK7m2PVzlIwoQJaocR2ai9OtKa57Szjz2GnD4n7OePOV9JkxJmlfRdgQF/hIwPVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hjxZvpalr8PCcDmcsFeErRN6By6D7haA15YeAO2B7113+rxTq
	9ljxIP72BxN66tLvaZmLbbncM6L77FE3jcGiyKdkAwVnmf/4pTMTrWnrD6SOMPZ03Fmic5Zos/+
	FxRl8jO4S8fvAVr42VqGyFHTxzXnlY5c2/aVh8HwH1zjRPVbLDu+B4w5OOXCkFDk=
X-Gm-Gg: AYBFou3mphU5a0KD2CWdHhVeSMUmbyjW83mzqZ3Ks6uEh59lYorekVlB0488efV1CKj
	xUwz8UTotZV1BGCzfT9nz+oeGET668KiWYOzfWD60v6cSZYcv7fFwOe3JSQAEGQA3bfW5WXUBNQ
	EL6rqE3a70QOIsweMUJdGUv62gFIIF4YcUDjs87BeLGd6N8v28Nb31FKTVTNmtfM22crig++JPI
	eX48/b3HR0DBFRqi/TeiPoZLXTfPntBVPmwTMEV2X79/ynqLSq+lv0t/SslUJu8GYa65h33LDl9
	SoDl/XfyhP6taOLAgO2vi3X+vv/6df1TzSlR+qm3X8+lbF6hS4Z2zYtJt4Bc4BEHhkZkc1YloPY
	HeQnbperEfaDq5CVGCC5yacgdtLiUCSXy0QP/zlaESDhkLOf/lxLpCDMJnhTLN0aCBRmbTrb1em
	kdDpWLNYI=
X-Received: by 2002:a05:7300:ce01:b0:36a:1452:8dad with SMTP id 5a478bee46e88-3768636e3c6mr6130131eec.20.1794489526673;
        Thu, 12 Nov 2026 05:18:46 -0800 (PST)
X-Received: by 2002:a05:7300:ce01:b0:36a:1452:8dad with SMTP id 5a478bee46e88-3768636e3c6mr6130104eec.20.1794489526047;
        Thu, 12 Nov 2026 05:18:46 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm43798356eec.22.2026.11.12.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:45 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 18:48:18 +0530
Subject: [PATCH v2 2/2] ufs: ufs-qcom: Enable ICE before enabling crypto
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
Message-Id: <20261112-qcom_ice_pm_enable-v2-2-177e454d6f22@oss.qualcomm.com>
References: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
In-Reply-To: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5bcb7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lF1qQ_KX37YNnQO-sMYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: p_wv5haD6tgc63ABdifjMvbKyvDPQa3M
X-Proofpoint-ORIG-GUID: p_wv5haD6tgc63ABdifjMvbKyvDPQa3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX4M5iMvyKdzCv
 BV1uGYdGFHmi8vV5uktShoqvthNI7tZMXPpd2KfH84GdU/jkGwxYmpOM1VQtUXpGWvDBALHq2+x
 A/grKCpWAXoEpU0nQDS8KNYd/nk/bTCO1aKLzNoRoeKAFpyirvDG8ITKDRmdamlulSsx8TZHV10
 A6WJMaFZR/K67CBNBbmv9+6dhDy1iL+eHMe4DEAMVIsX29oQnL5hKLPrlaWLp/5ogpt7LVR7L0U
 oBQ/qSNFZi5WQQ6ZQlscBZxdt6YvJOmyg3ezmriA3cQ8pqbdAHZDo/YbyhpGN7S5VUwOZ43VAN4
 V0+Ic0fzXo1aJzCFSSg5aKsmnFZya8uDa0eql95vzDBPGIyFSM3o9JpvxeDLKS4MQiRm50f1JKF
 2qVxEmDc7DTden7spYhkm1Wu/bKYumBFkc8uYHfIbsfv6FAYUA6hyB/Gu8Nbo9hVFSx4hlAiMJu
 YxGwhPKrx84QlapZXCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX0MB3qMp1EnWT
 rsqzQcO1Xf8Zg6sGnn6/REBgaVjxKQikw8oW4XzCCBkJ0jvVOp7DzTYrmnkfDiDsyyl0E3lq4nW
 OkwcqdfzzOfX0/g6zDwZ+McpTleq+bs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120052

ufs-qcom currently exposes UFS crypto profile and sets UFSHCD_CAP_CRYPTO
before enabling ICE. This leaves a window where blk-crypto can issue
keyslot programming calls before ufs-qcom has explicitly enabled ICE.

Similar to MMC, enable ICE during ufs crypto init path to ensure ICE is
ready before blk-crypto can issue key programming calls.

Also call qcom_ice_enable() from HCE PRE_CHANGE path once crypto support
has been enabled. UFS controller reset can reset ICE state, and the UFS
core can reprogram keys during HCE start before POST_CHANGE.
Re-enabling ICE in PRE_CHANGE makes ICE ready before reset-time key
reprogramming and for any later ICE operation.

Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 6afb8498b8c2..4ec400c5281b 100644
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

