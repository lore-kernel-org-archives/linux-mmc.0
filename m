Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA8438468
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420534; cv=none; b=AwSg9ScZpXoXJtcvqw+N059qC7RaYC8f7UeQpbI0DtcaeL9TGf9nDXs8wEuXmS4r8+pcnj8k4FyDglgHWnktOC74ajSIq2WTTOg+GjyciXeN4ygguZ3vWbOFcTh7l5ycoeCe0+T7D5vUqvdPYia/Nlm2xE7fxnKVOqbHvXU1eAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420534; c=relaxed/simple;
	bh=gX7L121EHCJ2xpO6FumAoCTBKS83D7x8y5FA1Luaqig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTHCgZEwi5v5FZRiTGP/AYErHK9A+5ruEU/Qzm93/gc2/ViKSEIxIrfhQkIe2SoF5mZ7GcDkdYn4n5X3y+XY6XxwEjrXXrPq4izOHXtGZ3Jc9IBR7cfG1X1IUVGO/XUg4mnicSltDat/pAqQRyfTRDpDHRSjyo6P0McrNdruK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EW8Or5vB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M7iY83W5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EW8Or5vB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7iY83W5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDBNh715588
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZiKwp4iFQl4
	+TVSFMRodDlpTE6zm5cCQ0F24fi991wY=; b=EW8Or5vBOly80LSkYQbKWiEADPc
	VTMg7ufx733Kwz8VjDhVJSlThYWXfR2aznp0O8a0nPn4O0CpalZiY1g1vL6hmgnA
	Q5nIgv9e6orqJiJIh02zyJahSIr393dwwO7K1nhn0eSwTAEJ/DE3OZGZyU1OfFFT
	MKB49jt5qAYzVWU4zHuyAAP9xD7/ynWU8dJTfyfut522ikHVgQeMsG62ZcCu11mK
	jo0NR5dmGWB/kHW1145jAhzzLVv5kSsClRWgEvH9jrH+AnO3+R7QjUE6UEIGwV/T
	mm+8ZybfMnIkKYQ1oPsEYDcCAMvFzNfDK7BbfSbKlVeg5tKBCfB0qMfqACA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ucrcmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eac2620cb0so22855936d6.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785420530; x=1786025330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiKwp4iFQl4+TVSFMRodDlpTE6zm5cCQ0F24fi991wY=;
        b=M7iY83W5VoI7+IpHkBXlSaCvlDzyEJRBiXrqwEDH1xmYm9P0Gify+ydaIdjll1Y5Yt
         kRsXT+bp2J4NQ4BLd+wt2dAOCyodEn2EhRI1pWBhUPAK6RKUoODQfhngvRhsUBMunZQF
         I9myHa4bodCSpLxBcuNk1WSS/bO1znbej8Pp5whW+v4xARNuAqFkVUmhWTJcVw36bFtf
         lijtDQ7QsQVZGyewc0+n4O3+aCiVpheposdI8TbiUeMDg2lmJUJI6wGl0sg1mvD3I1Gr
         gy3eGfHEUwybhnYtqw6PmDb/Hw5wBUFrwrRar/sryQxG+f2hT4+AR5Dt8/J4cz6NmxMs
         OiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420530; x=1786025330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZiKwp4iFQl4+TVSFMRodDlpTE6zm5cCQ0F24fi991wY=;
        b=Mj6yt096hALAKymxEWBt+WndOQAuc9AiIp4ByTlGxOIPpn8LQKP76ZhpR2F4rDRAEJ
         CLCnbzsT2Jp7F5zBuSlrTDZTjZAbwclalEDcs7DxOUQBPUmbuuh5AvP19aUEmJ3S4df1
         KHcGye6MgqUu+bDFshVB9YvuFlm8j5d6bsBS2JtkEWPjfo5LEc3Bn2LYYlcv5uIXNi33
         iRIZcF1+iGnoaGvx9WjL5obg7vpB71vAegvgYxILf7prhHQC0Ben2PO2aGF76/AqieuD
         W7HuSS8ISlWIsQGNm+L2wj3aUhlOAxfj9eNpRY6NhQ5SSHT6ce6HUpnmaZKcA2fBOVRs
         8cjA==
X-Forwarded-Encrypted: i=1; AHgh+RqoEzYf+/m4y+9e9uExMpBFoLHDUzv9b8z3OspOsPInxFh+0Xkvh0oAORP1dxTgXSnzakgYYXMVk+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/AWZMRMSkwOfokyExRCvYv7Zwc9wPG0nczFKSLADmNWa+nHh
	cZx2DWpqJhkHJ3KmzkZ68yj4CM0wSmx0BVe7sgWOCP/kx8g1iYGEexYTeV8u3nzMUPQqpFITCd5
	9ZAaJ8DCwL9lnfyZFXKHJfBg8X1HTYG6VVvhlJlucgPWic7zzqIRRtiuIKRi6dE4=
X-Gm-Gg: AR+sD11KAjrSHfcElmWL5oTSWTlAxxdjtw4SdngeaEb/xsD9FcjS3stzd2JXOl4xwgq
	oJfklMRcNVlumgs1/y3QrZqWrMO9luw5XLKQyO6TWxRZ7TCjKFManTNHHdvJO6YYk9D39O7WJSc
	jZsPxiCBJJw9T4tQ3DE8KpAYb/w1HHtalGnz5gQjUFD7+oDidfeI1C0pdxvgHZWEqHYjjAZ1daU
	HxWJxkKfvxpUZ+ztI5LdfGhSxn9KCtUXK/nf21/nstDxcYzRru522yL8ySmWcL7+PwX1m1vx2BG
	9F7kVFLePW1kFVt9LEQRLH1Ywu1SVuwxBNmbkuV0U2qXrDrNHpHDg+1+Fq1BmOv4fD7mhEzlFyR
	e4ll7NwBgpG2ln0+adsd3J4S5q4EtxQQ=
X-Received: by 2002:a05:6214:5786:b0:8f3:e97:59b8 with SMTP id 6a1803df08f44-908346f63a6mr27425286d6.29.1785420529753;
        Thu, 30 Jul 2026 07:08:49 -0700 (PDT)
X-Received: by 2002:a05:6214:5786:b0:8f3:e97:59b8 with SMTP id 6a1803df08f44-908346f63a6mr27423376d6.29.1785420528110;
        Thu, 30 Jul 2026 07:08:48 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908325186b7sm18465826d6.43.2026.07.30.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:08:47 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 3/4] mmc: sdhci-msm: Use pm ops instead of macro to restore crypto keys
Date: Thu, 30 Jul 2026 19:38:21 +0530
Message-Id: <20260730140822.1976635-4-neeraj.soni@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX6vz2RL7FhBU2
 x28VejrRuHk1HptkFLygmNfKNDWT6gCqWdAWqJ+D+rl4KaYfGpaBSPinlOkWME4DKUctq5CdVXV
 IeJJ1hVsK3d7uOyrinXVsMUrB38fMj4=
X-Proofpoint-GUID: BY3j1WfyznXBSJ_-m9SRV1XnZ7UyIdE2
X-Proofpoint-ORIG-GUID: BY3j1WfyznXBSJ_-m9SRV1XnZ7UyIdE2
X-Authority-Analysis: v=2.4 cv=W6QIkxWk c=1 sm=1 tr=0 ts=6a6b5af2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=KcI988Z2Yvo0hyr3f6MA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX/UDzxROl5wb5
 PiUEbK36KOhE8B8xhcbsY+GaP1+/wkK2vrZl1IQUYZid4jRfmmcOIJaAjLyB6349II0xnDqmXBx
 KM0PR3qEaoE6aFjdYlTU/Uo+qWnVlvqw/wag7W8qMJ7E5b7sqMPdIPm0S8SkL1guO1UilGii5dF
 0ADofzNgGKFqLRuaI6FepgniWpfo3CzISjRaZ9EMk52uODEytelDohDhxhQalqummx4ohxqtGe+
 N9RnkxN5ZzlCYmi/1QSY8gM7dr+fRvA4Tvg1FSAxEHJR1XTJ7Fk2rluHmun3LVADKKZwtMGhJlL
 x5Z7/EE7PR/bBHfXtEW6Wbk9BmRA87Ndj/M5uMAzOhd4Udk17LtPzBDGVreAb1EPkDk3smA7rth
 lxARDa8Ziv9eQqBljBKj11i/0Xc3bcH2FA1mIbGczKHPRm34wUOyZZV4H5kswJtDTaXnJVr5c00
 pjq6FfC9BJKs2a3tuHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300107

From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>

Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
needs to be restored when hibernation exits. ICE keys are re-programmed
during sdhci_msm_ice_init() but it may not cover cases where the
hibernation image is already restored.

Unwrap the pm ops and use directly in driver to add the call to restore
Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
same state as before hibernation.

Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 7d71dc6f388d..a4998e74a2bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2986,9 +2986,26 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int sdhci_msm_restore(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+#ifdef CONFIG_MMC_CRYPTO
+	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
+		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
+#endif
+
+	return pm_runtime_force_resume(dev);
+}
+
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume, NULL)
+	.suspend	= pm_runtime_force_suspend,
+	.resume		= pm_runtime_force_resume,
+	.freeze		= pm_runtime_force_suspend,
+	.restore	= sdhci_msm_restore,
+	.thaw		= pm_runtime_force_resume,
+	.poweroff	= pm_runtime_force_suspend,
 };
 
 static struct platform_driver sdhci_msm_driver = {
-- 
2.34.1

