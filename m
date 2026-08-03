Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836738333F
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774705; cv=none; b=pfzYvs8qiP4wX0Ln2foM/bWleAT1uWzhhip7B3nvc0NbLZA5iV2C3OX6Jh1phYTfr/juBtBBxAva69TtFJz9KZ8TNi4pyo0Mntc3XeqeVcLlk83eHNT/gy6Lbcf57yE9eeMcNiz5di0JTYu94jWeQ3frEgYJnmhP3JKD1fzGQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774705; c=relaxed/simple;
	bh=6OkB+L5CL67X6zEXz72wqd0v32Qzk0bcX704BWeU9r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcKRJ2BlXDKD1ibh21mm5pY53YExhXzveQngBSbw4fnfERsHVh+G8F5t8QN2LHLx5WmfgjIdytePZstPdfLXYrhRDDJWm4uuNf6goz93jfhXZi6e2lbrGNM6vhKFbHhZ6Yc6Rjim6IHecePUG4/hMByxs6z0UwbuA9Rr2OCOzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqx0p7Zc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j/GuI2Oe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqx0p7Zc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/GuI2Oe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EC5oV655746
	for <linux-mmc@vger.kernel.org>; Mon, 3 Aug 2026 16:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hMlaJt9K9sF
	E9o+mk6CgXYslRF/MCGoEZtD3O9kxsHs=; b=aqx0p7ZcLIKs/ew+2dCBffHyh0w
	B3I0oq4OuFxQv6/r07vd/Fl4l5C72BtFgK2OZpm+zFUVJ2R/oM1wQf0FS+M1ckYy
	Vw7akByU+YrGQork8ost8UWdgXAD50K5F6u2aHe96lmMHD7n4YkbpW+Uv7/olyME
	AxV38Y+4rfWynYMpeWigAn2Zt+pJOhZkGs5jwtGqeOnDCpLg6d3A1W50ydplFa8P
	elBL4qMJEum3tvLqCqiB/Qn+OiAejq870zGCK2aRsqPi/EzHvcrtYlP0yCp45TDy
	R2rZqeVYMN/uoKXUQZGgfaVZPAy/1F40M0Q8pcMcq7XE5Qjbh2lY8kMfZGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrnthu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 16:31:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc88e22f92so82542905ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785774702; x=1786379502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMlaJt9K9sFE9o+mk6CgXYslRF/MCGoEZtD3O9kxsHs=;
        b=j/GuI2OeEtkei4zZNCGJoFEF014mNDTinEynNCQpzrIpHyug4KJ0pzp5bCiVcjr6Oo
         Kd3RJ25lvM3dAp3fe716cONRoDPcKX7fibgsSTFOsjEz9zPEvO5jIET8VG+9RRGasmnz
         GbHp5+qOTSO0sdjabeQfJ4e60ZpPyr66ta1R8htzqsTeG+NC8Uv2IxR+667rnA9yPWBe
         57PSg6TMt+iU+gZh9ia4tQnElHpYqsb5eT5gTi4Qd+UVzZeSK6SlUR+jTCVYVNjYOo+L
         Ad/+NJ2HGcI4xOGNwwEerLXrt9oKnkTXPav1JyQ4sUBMYSiQ//5II9avd+X3N8koAXg8
         c2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774702; x=1786379502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMlaJt9K9sFE9o+mk6CgXYslRF/MCGoEZtD3O9kxsHs=;
        b=RIBfr+1NwR0QPMuTa2mxRzDn4Ui6eaE0c86OF4JZtuHQwc73QGShh0cJK66bRxQhsR
         7r7efl7frKyd1a/ShT7D16q9O5o1yUBpK1l77ml0QeIaRNEH3P1tpOdOEXVTLl5mcA7F
         wppp84yY9XW+tl4omkkwjjScOKG42JGAZs549EiDkSybBg3dnbpNegbfNg4ib3hpGexg
         EV9Qdx/riSJwlgVX+x6NXepiB3Y5x1pessEezbtNDwRyZch9WdunYUSfUBqqqEnqJXDL
         m+xrb/Fkpr32JVqLqLqC8lj8V4Ly4aF0eiKiU9CiWGBtsVPD4mqXe/8QcsVeOJyqYzkJ
         i4Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpM4KR4BE5MoDXOJE/D6tIJJK6YcNKImbRTFkzml6SuD3L2mMtL6vuNgm1nsxldZh4BLnW6ZXLikdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SyuRbu/FpKfbgMbs19m2hlHB8pg8XDPHb7IQwsJ4Y/Cdt18O
	vi+F1ljCi171tY5TrEzPRq796G7TTi++ZB2jnlF+ItbZYHiJX3kYnVPaNLy/19Yh9rMAYJcyRf2
	ddvqSlqPQvdP5JnvfChEtX4hOuJjWovkB6GCFYGl0MGR0R/iMM/2md+T3QTEVhxg=
X-Gm-Gg: AR+sD13n21ZXunU0qRW9cSla8KaRLRL5P706B9UJtScUFJ+KT04CDX7HJIW0KRoOaHx
	pcUyyjeU2ANLgMUHe2kv6WEJ471bFKIfUMUq7IYBiqrwVOA2aZgPa4fn7XY3784iTyoqsXi/sOs
	bOqPO2QbtHKNH6XglJuUrbVZHmRxRd8/jR2xW+T+ToAvy++ILLPZL6/VlvDtBQKNJ9kTQU6c0ob
	ViNYJs/riUml8DIgZDsx92comRqiTaatDUUHoAX3gFFcMNzy40HCU6vRfJEQq+lpLFmlvezYMnJ
	W0iQMxNHDc+PY0h31sn5sGdOLkL/zEo5F0vuFD1Z+D5WbIdEIvfywADOQE+Fryl4m+B3Y8I09iq
	lNx8Dq+7jtp6TkyNBtAfbeu/ndNnUtA4=
X-Received: by 2002:a05:6a21:3947:b0:3bf:a681:a262 with SMTP id adf61e73a8af0-3c92a83843bmr11963967637.38.1785774702136;
        Mon, 03 Aug 2026 09:31:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:3947:b0:3bf:a681:a262 with SMTP id adf61e73a8af0-3c92a83843bmr11963936637.38.1785774701710;
        Mon, 03 Aug 2026 09:31:41 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb50dsm54592761c88.10.2026.08.03.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:31:41 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 2/2] mmc: sdhci-msm: Use pm ops instead of macro to restore crypto keys
Date: Mon,  3 Aug 2026 22:01:23 +0530
Message-Id: <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0OCBTYWx0ZWRfX6WLIsYAMT5BH
 ApdWZN2cqugOMKTxcmZCky/xUdYVHWcnYbEN5x2p/Jy95N9OnXk9nCbRpW7ZYfWK5tLqssfgmA2
 XtO+gknrwvinT3DRmm0D45HGp1wGWMM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0OCBTYWx0ZWRfX9pidMtBJ4GKv
 Zzr1NrDLBPRkDeSSeFRP8bC7LEbo7QeY/uTcpfsIULsKXG82DOICIcfuuBwCmNNuZ3NDfjfICUq
 CD1ZZEHx3RmGKAK5d5VuR333KoMuOF6toHNAraTrXVz3JbtKP/fTNaDNGZMG6GwJjzmX2dUD/I3
 mPYPHgx7XNFSgdsdEO8oLGbZI5N4usdxH5KsvimjqnD/7IcBHONTdXSujaV1zXSg1PCLXCx2Lar
 BcylzmDpZI1HGaCLKLEzSYvOhvrJl4gajyJz+nLbqSLYcy5yMxQnKSFekfJ2fS6HNRjwTC+8u3Z
 m8p1B9POyIg1u/FkFgQ1ZKzjD5oupTIstO36psq0HzvO5vluunzaw/t6eosm3x/+TMhYZ+UyFEh
 LcX5AJxg896SDjlY5DQ1IA88Kue/MqwYVWSY7f4w5ELLXzb8dKr7GoLcaF2qx56TlA39l6M9IQa
 137ZIPvAm6H99ES9fpw==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a70c26e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=gS7Xm_n-xbDbWU8O4UEA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VwtlRyvhJBpOxeR_jEen3DVu8s9-3KKb
X-Proofpoint-ORIG-GUID: VwtlRyvhJBpOxeR_jEen3DVu8s9-3KKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030148

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
 drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4aff965f0e2e..f64788a70309 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	}
 
 	mmc->caps2 |= MMC_CAP2_CRYPTO;
+	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
 	return 0;
 }
 
@@ -2983,9 +2984,29 @@ static int sdhci_msm_runtime_resume(struct device *dev)
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
+	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
+		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
+
+	return ret;
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

