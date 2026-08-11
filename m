Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB73AF65C
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461505; cv=none; b=tZVwKAnENVNrfy8B6oQBPN0SDTMC3vXwF7Q+e8DcuYFIoPYmXXm5Fr2cPfIfIAeJb0G8Y5b8CAC/A8USIegZW3ibboX7K+TFLXMbNRfd//TcxolWaRIi61iiGb03rivlRMKEoAPcyfCCs0I0AkwFkMCe8lYqvmjCz+RROfToGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461505; c=relaxed/simple;
	bh=NbgGl5cLf0ReGNO3COnwcEwBWeIot0njUhLwUl0O7Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7fRTpOV2o6Z0ho8VGaX4XbC6x0FFAFxx3bi8gvdGlOdbBujb8lsASGqX2qTN9xOJUkOlC1ypZ1y4AF4jrB8WjM4aKjHL418I90EaQnwwIadooy+v6Ytcupu196EnJzCs/Vz4jfa2sRz9Jr7zrXLfqbgZ0lyfO8qACkc9U38WKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrgZNspy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JjguI76M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrgZNspy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JjguI76M"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX0kT767094
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vpBZTVyDsH5
	y2y67euiXcDCt+is3/E/IpXezT6gqsyk=; b=KrgZNspyNqmWDi1qBQlx+RNFWqT
	FYkY9pzNNRXBAxoYgPsestSgDu4SyNue3KrOS+KsTlQOT8ClvnPZqRvD0LeR20ky
	sP8UOsUIpnAndU6mSpjJCqyr3K6CsC48jmVZiLoVsvMhQNGmUYSWa5EGIrqO3/CN
	3mhkM3jMZm1EUuDyl4EwRp7HczhwWl0he6zzC4/pkL49ZlOBFTVLtEeNHiiInuWs
	WEf7dWPc6ymHxAX9FeTeyYBL6Ojsz3j+cgds4DIUteRLuYxiCra9JHQejIsZBVYg
	AnFpy5wnhPfesXCWO5OrIK9UgM2J6XY9YgEbjbGI/S4PgwQ7AgNimG8cvfw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01q116c8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84857446424so5334504b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786461499; x=1787066299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpBZTVyDsH5y2y67euiXcDCt+is3/E/IpXezT6gqsyk=;
        b=JjguI76MxZnbcxfUkaZQGsifj35a7Xsd8mQpFttcrlDwkv8Kf50UgY2bl4TKLzh4oU
         c0DLxWcsyRR9vfZupGAifOs+1GEAkP/tgy2s8t6dIkek0Ub3ptLXSQ/NLeeD1CQs2tK3
         urJB757z+2oEFH3uhcHuoWCcSdBxKDc4GK5XL/zi5cmksVWBiUk1ZT2dmWN7i4rG4hIG
         C10QedDYvwPKJZ98e1Xa9fm2TqSFK6wh9rf8fK9i4xJHkAevF5Y4DWrhdS5NK/CMpySw
         18ahE0w8waqgCuaShKSFpO3vsChDcZMk8+u+96IqdcMsp3kI+ZU4ZHDD8vFay0F4v2jC
         Uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461499; x=1787066299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpBZTVyDsH5y2y67euiXcDCt+is3/E/IpXezT6gqsyk=;
        b=REoygedcoTeEuDtX/aGZ5I2xrfoLLDgJ/zZI87WyYydaK8+pL7KY8U9oh190DGHv7q
         0HmDnRcfO5Nlj8FKNLxB8a5xjT07rzhEZwL/1Kyq+S8mi3NEKv7griq0e25ctRbFnwwu
         6tUkerk6zi7Bh8Qwu3N0SZ34RamYGGhqQSKydVKhbgzw//hH8Pg4W6I1aN8ZWPZ5bDJv
         4J1+p478p7QHwVU6iSCPq6W6dn51fsHDng0xp+dv8AqaM+EVD7+gc+AtP8hvXftgBroI
         PZNdzjJFD2SalsFxK9FP60ruYAi4fv8e2voIM9Cj7UtXJC8QZaINbpCUpKagBFkCvUzQ
         ZAMg==
X-Forwarded-Encrypted: i=1; AHgh+RozdCurpn3t3/YfuV5c939DotTnnZP5m8/KPkLK5ZPrW7s9yE2LV4JuZnKPaK3IhSXWdgIDuu9nwAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLu7C1a3NrVp/qJ3I3jL9QKFFzfDBXv2GGkiuONGkA9TG/gu8e
	oV/Lk4MTMMUmkXOvXHaBxKaZ6H+UYGruSJQLXZ76umPszpYLu3WFfisSATY1mx+YUR/zPvoGC76
	UT5ZlMTLSploRpeJ2gsGi6Ga5kWQuPoCB7V5ROaKINRrEV2tFeEaXRRO61hrS/S8=
X-Gm-Gg: AR+sD12Jk+YpsEVc03NmtkOVt4Hy295WcIYi6xNcsxg6qOagB3+5FA/ONM7NGFzGr5i
	ZeUEcbmDGIiPGGqFnxyJ+drdxkg3ateYdwYThO0zNJ/BCUQkgI6kpNdNPd0ugtgyRwgAkHqQRn4
	on4myl/MYS3rPeL0F2hoUHfJf1UQXoB8LBRkghAtubSd2Bn33XV4XP34U2l5CA9/jv4GFjVH9S7
	0Cx0ACmDBAmZVEqpC4UedYAFBwLsITLscQejDd8rppUTX9QLJaEI72Yg50wjfWUv8jfhd+fw533
	CQiOYmHSp9/6HhFzGS7G5iAJcjlBxuF7eUUZ6+Fxrni1gCA6AeqBRy6bE8IBhTzftsIzNBJjgCZ
	DrXy+0AInsoK2CnSdl/p7roZJZ1XgfrY=
X-Received: by 2002:a05:6a00:3305:b0:84e:2f2e:8c4b with SMTP id d2e1a72fcca58-84fa88435c5mr4657644b3a.32.1786461499445;
        Tue, 11 Aug 2026 08:18:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:3305:b0:84e:2f2e:8c4b with SMTP id d2e1a72fcca58-84fa88435c5mr4657544b3a.32.1786461498900;
        Tue, 11 Aug 2026 08:18:18 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa95261b0sm983727b3a.36.2026.08.11.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:18:17 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v7 2/2] mmc: sdhci-msm: Use pm ops instead of macro to restore crypto keys
Date: Tue, 11 Aug 2026 20:47:59 +0530
Message-Id: <20260811151759.1258525-3-neeraj.soni@oss.qualcomm.com>
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
X-Proofpoint-GUID: qGuL-h9yRfzWx4JVJMrLAzi9K8yPAN3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyOCBTYWx0ZWRfX3RBeAJbKi/bh
 nGK7+ALiLgiRfLjdN9hisLIOC3GOdkNUb3xvgDSfnkJNkn1I2ouXjOHaZrJZYQ1kdwWUVJwe2AK
 mAtsX+4bZX1r6+VqIF36cG/63Ge/htEGGe+6KPMCdfsbL4RnSHfeM+1osJtOpW4yLYcItXS8T7T
 sT9v9gXoddqpLsVmX3XTqwQafRmP+o6sGopvedyVeDMCOX9yj63aQ8opkxNaMhc6EnxxXw9jfXx
 J9u2ZTKwIfJNJRQ+I+YoKeOpaEChLy4fc18bhtUsruTxiXMZFV9RoAPWEE46ypGbuWbVaLHKra2
 EwFSfZq7Go4h/HPboKhMiaM+VktnUBKKy+MhbGYT2HLtD8FqbXl4ayFLvGgQaQQQKJqyYgyuKh9
 U+Pqw6yQ+Fuafv6+OtkTZ+Ohf959jZ0EtBKKeIqdOYj4K8LqPAZ6j1dVu8w8QjqdW9wIcsSh8P9
 kDtRrkm+MJchQvXHKbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyOCBTYWx0ZWRfX2O3lm+BJN+YU
 brxT4J6+2BigKLGYl23b1kYaGo6cMB/b5jWqRJSq2EdA9w/FjMEGUEehqpljOEDq2FBgP0qxrl5
 jEIx43g71kTr4JzQUAxpl1rSnF05CGU=
X-Proofpoint-ORIG-GUID: qGuL-h9yRfzWx4JVJMrLAzi9K8yPAN3i
X-Authority-Analysis: v=2.4 cv=brt8wkai c=1 sm=1 tr=0 ts=6a7b3d3e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=y6BdAlClqxV26XkKDfUA:9 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110128

From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>

Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
needs to be restored when hibernation exits. ICE keys are re-programmed
during sdhci_msm_ice_init() but it may not cover cases where the
hibernation image is already restored.

Unwrap the pm ops and use directly in driver to add the call to restore
Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
same state as before hibernation.

Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
keys is not needed during MMC runtime suspend/resume.

Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4aff965f0e2e..460994164d2d 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	}
 
 	mmc->caps2 |= MMC_CAP2_CRYPTO;
+	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
 	return 0;
 }
 
@@ -2055,6 +2056,12 @@ static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
 	return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
 }
 
+static void sdhci_msm_ice_restore(struct sdhci_host *host)
+{
+	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
+		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
+}
+
 static void sdhci_msm_non_cqe_ice_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2149,6 +2156,10 @@ sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 {
 	return 0;
 }
+
+static inline void sdhci_msm_ice_restore(struct sdhci_host *host)
+{
+}
 #endif /* !CONFIG_MMC_CRYPTO */
 
 /*****************************************************************************\
@@ -2983,9 +2994,28 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int sdhci_msm_restore(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	sdhci_msm_ice_restore(host);
+
+	return ret;
+}
+
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume, NULL)
+	.suspend	= pm_sleep_ptr(pm_runtime_force_suspend),
+	.resume		= pm_sleep_ptr(pm_runtime_force_resume),
+	.freeze		= pm_sleep_ptr(pm_runtime_force_suspend),
+	.restore	= pm_sleep_ptr(sdhci_msm_restore),
+	.thaw		= pm_sleep_ptr(pm_runtime_force_resume),
+	.poweroff	= pm_sleep_ptr(pm_runtime_force_suspend),
 };
 
 static struct platform_driver sdhci_msm_driver = {
-- 
2.34.1

