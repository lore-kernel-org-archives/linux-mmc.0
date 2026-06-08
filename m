Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE33AFCFD
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955317; cv=none; b=j+9LlskAnK1VTUKKE3ON1cz1O7xIl9I/u0ivHtuKrQVe0CqSOCFgtL33oXyfVNEZ1CS/nC8uNG7EsvI8P1XA80McxLDIkkagyQ9RHVGQcFIvN9Mu0c43qIxzgoJQuAxQFQUt8v+dRIRhrAjQPqTOfYLdXHm448i/yVWgcLpmsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955317; c=relaxed/simple;
	bh=3ucCFxqVSmxwv3tYV7K9HtEXpSVQKpaawldrvOaRdUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFgoH1KjjPlqzAZ4H0xB5VS+RGBlyLiO3P1c16dzcXqiVsRNaH1SBTZmushGcnf66XsVoRuRONfJgUsml2mdnkWd5Mb3alHBSXVvN81tVbFQEOmrtf1IzjKbAMkCjJjNl+AiY3dbMtwPILU6PVbc+j1Au3Elx97Q8qCxOIB89dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PX4ZSUF9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/f31yIk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PX4ZSUF9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/f31yIk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Ix9io315007
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 21:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N77a8rPBNXCEfDhtEGoBDQai/waqHZnCNGqwv0a6lQ8=; b=PX4ZSUF9TJgWZRQc
	M+S6adXkoER8YRCAXCwrjbxv3FmWlqGIE3sQ2DA9dOw2eWh7wPWBZo/0MdvLfqIb
	ZdjyoMwkarou91GIS3OvqEh4U6kv1NAoUPOLMmEm11ssIaWmO+5UQuwewog9CtGR
	immSFtJ2cQnAN4w3ggz1NdV7MlN47rclnTfsVTDr75rL3KwVNKaY5mdywifOp0vV
	VimKVopp2hxwbQddySQb/VpoEuF1RQaaN54M+yw9NPA4CvWUQcoyZHFgS2QYuCxb
	XdNXI9DFZdHYsIIzaVnVSxygT8qaGtDIfR9oYhIemZs0+fB3C/pCZdSJG6JG6rrq
	/OhZCA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0kc77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 21:48:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842278a630dso6205221b3a.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780955314; x=1781560114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N77a8rPBNXCEfDhtEGoBDQai/waqHZnCNGqwv0a6lQ8=;
        b=P/f31yIk4fZFrXxAkJgYxvA75uA3aVad0CSdCx4ZJVk3Ob5hAwnT8Uma4E+NCKRh+A
         5ZzD33K7GbzZZ57vzqP/lGH62/Jq9Wvgm/VnIUDktZSTfcmh5N0Z/x39R1ikDCfH2v3/
         4QGm0FzML6Oir2dHs973orXkYZsNaDezDUpYbVxHtVyD/0ShRMipbzUDa/aah3KB2yY+
         4JNomqKgZpcPQSfp+WkrNoFpEbQzZ2HaPuVbcrUeyDifGolamnwi7VIUrsB0PKv0Own9
         UD08y5rEGFMK730s5DtmUFIL86Z4F4J8+wUNWXK4jZs4/wh2ec7VJZHTSNI7U12fC+8V
         hSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955314; x=1781560114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N77a8rPBNXCEfDhtEGoBDQai/waqHZnCNGqwv0a6lQ8=;
        b=HqLNBwfqKej+znXZeHYWmfdzciVW/Oo2yN2OhtxcFK5oGk5KE6PL9Xlk68UTuJ/J4S
         mpOoZiuhmvdUaD5GVNctO6QRALfBh14dkUtXWaHrW80n7Bvc3ZxgjzxC3ZEFFGc+EOmy
         b6eexsRCtHZTiMeg2uIqABZQ+2gbOypeiaKBIgH0fqay9lq5rjz8TmINVUX6IM9xwaEo
         uQcWgmVjnmG/CkdrJPYlI/2Y3GqmbKdDdIa/gmVIWtbdT77AcCufHh6AOUU++UZTGG2D
         vpAfYldNU8PpWJlTk9upqCTG6/jKBy8kOJqDr/OeZF5KpkrbuKznfo1aeWRN1sYDOgTk
         wrNg==
X-Forwarded-Encrypted: i=1; AFNElJ8zUwL/TWut3MlREZ4Yu6sDRDxvFy1eM+IVURxYc08im4L/F8jge6PO3g6NOLO0QNmcCh+/g/7PGvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lfb7kF21UD8fibfPDlIwXGqCF052Gwayt//oj3VObsDKZisE
	+lvwmQ30659/D+C6MX4Po/VP1OrFVkU4+JKaY0+l0Vf1Spi/ZhutMynFDCyOxin9C27U4ylDKtA
	A+tXV/dgPzuenOzY1WdqT7YDH5KxkQ5oewEDIGjiYu6+Tg1SyjQFLNClChP6gpPs=
X-Gm-Gg: Acq92OFVvPwyhOBxvCnprRcmGAyljD6wsdOn8bCPLCh/AjjXplpA9sLZ7XmuunhnO46
	kKCm6/i+SivR3vL9Feu13az5SXIVsDUPpPw9m4dV/ERUNeJmJmtJNqJh2KykQxFbfPMLgTGhaWR
	hd5UMs1XCmsqnJ44hJutlC89WzYjybj7mhqiMEpkY047ro+LtdU8Tjy24OYoR6F4vUBnxIgyL5o
	q/+blkLApRBlWJvU5+5VJBflRpiX8bHoK98E6MQe4JQzDmDMIgzbjZdSx1dW7nhkqr/dfW58GJR
	NWGnlxWN2CqM4F2PagxyJnW8tr/tThAXyvPsfi5FYaqxQeQj7AJs5kUwwI8g5GI4XhKDvN5Uu4X
	CcwHRUyvoecyGQFGoSFalxaXyDEqBmU91Yf+9EEC4SieJNtMgTWH95cJ9/dpJVnkZ5gnnOA==
X-Received: by 2002:a05:6a00:8d0:b0:842:77ab:35df with SMTP id d2e1a72fcca58-842b0e4c733mr17654143b3a.11.1780955314014;
        Mon, 08 Jun 2026 14:48:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d0:b0:842:77ab:35df with SMTP id d2e1a72fcca58-842b0e4c733mr17654106b3a.11.1780955313407;
        Mon, 08 Jun 2026 14:48:33 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm19607485b3a.40.2026.06.08.14.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:48:33 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 03:17:23 +0530
Subject: [PATCH v11 1/6] soc: qcom: ice: Add OPP-based clock scaling
 support for ICE
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enable-ice-clock-scaling-v11-1-1cebc8b3275b@oss.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE5OSBTYWx0ZWRfX7tTwP8WdRCMW
 vGt17zQ6KZgUULuI/Io1LSZXFe12GlSgxchDuOhmlzkeaeF9Pqp7kRqjGPFne9V5A2joza1zxE/
 yawfpGHWM/nZ8c1RoxTJK2Q+oO1HdMYJtkT9Tv6oJsSL6+xSgjLW5vTqd0Z4K+Nnee6z7TD19BW
 sSPqpz1gpZFLwPU5tuMtPWhOIwVwYEPRMg6Jf2hRqtXGZsZXSFO5V46fXYSvNsGx0Dc52KKemoT
 2NpGaNrRcTROqGTu4Hsi5QC8pYFlspMxTHEj04LsZAZsnLhTUm9XIEfUFrTj5EqNrY6ZMuw4Ulp
 boGz6yUFLgcEmRTDpwFEB16TEc1RBkkacaMbZmHS7c43+SdnmwVPVGd8hsI7PRDTnvCgpI5pcvw
 5WApS+HBYg3UpNMNTTSZtVyH0t7Qf0bf9fAwiPCGNp8RjMyNGuDKrcYU5BD7M70gq9Def7OjDjp
 kqoZTYpMiE68161ThjQ==
X-Proofpoint-ORIG-GUID: Gr6NEWy4vmVHRDVRtRHPxGZARL7MLd7O
X-Proofpoint-GUID: Gr6NEWy4vmVHRDVRtRHPxGZARL7MLd7O
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a2738b3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=zlodBCVASgOsPZHI1q0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080199

Register optional operation-points-v2 table for ICE device
during device probe. Attach the OPP-table with only the ICE
core clock. Since, dtbinding is on a transition phase to include
iface clock and clock-names, attaching the opp-table to core clock
remains optional such that it does not cause probe failures.

Introduce clock scaling API qcom_ice_scale_clk which scale ICE
core clock based on the target frequency provided and if a valid
OPP-table is registered. Use round_ceil passed to decide on the
rounding of the clock freq against OPP-table. Clock scaling is
disabled when a valid OPP-table is not registered.

This ensures when an ICE-device specific OPP table is available,
use the PM OPP framework to manage frequency scaling and maintain
proper power-domain constraints.

Also, ensure to drop the votes in suspend to prevent power/thermal
retention. Subsequently restore the frequency in resume from
core_clk_freq which stores the last ICE core clock operating frequency.

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/soc/qcom/ice.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h |  2 ++
 2 files changed, 95 insertions(+)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 5f20108aa03ebe9a47a10fba9afde420add0f34a..519d08c4727a6cb2dc5991216a2c042ed6218857 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/xarray.h>
+#include <linux/pm_opp.h>
 
 #include <linux/firmware/qcom/qcom_scm.h>
 
@@ -113,6 +114,8 @@ struct qcom_ice {
 	bool use_hwkm;
 	bool hwkm_init_complete;
 	u8 hwkm_version;
+	unsigned long core_clk_freq;
+	bool has_opp;
 };
 
 static DEFINE_XARRAY(ice_handles);
@@ -315,6 +318,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
 	struct device *dev = ice->dev;
 	int err;
 
+	/* Restore the ICE core clk freq */
+	if (ice->has_opp && ice->core_clk_freq)
+		dev_pm_opp_set_rate(ice->dev, ice->core_clk_freq);
+
 	err = clk_prepare_enable(ice->core_clk);
 	if (err) {
 		dev_err(dev, "Failed to enable core clock: %d\n", err);
@@ -335,6 +342,11 @@ int qcom_ice_suspend(struct qcom_ice *ice)
 {
 	clk_disable_unprepare(ice->iface_clk);
 	clk_disable_unprepare(ice->core_clk);
+
+	/* Drop the clock votes while suspend */
+	if (ice->has_opp)
+		dev_pm_opp_set_rate(ice->dev, 0);
+
 	ice->hwkm_init_complete = false;
 
 	return 0;
@@ -560,6 +572,51 @@ int qcom_ice_import_key(struct qcom_ice *ice,
 }
 EXPORT_SYMBOL_GPL(qcom_ice_import_key);
 
+/**
+ * qcom_ice_scale_clk() - Scale ICE clock for DVFS-aware operations
+ * @ice: ICE driver data
+ * @target_freq: requested frequency in Hz
+ * @round_ceil: when true, selects nearest freq >= @target_freq;
+ *              otherwise, selects nearest freq <= @target_freq
+ *
+ * Selects an OPP frequency based on @target_freq and the rounding direction
+ * specified by @round_ceil, then programs it using dev_pm_opp_set_rate(),
+ * including any voltage or power-domain transitions handled by the OPP
+ * framework. Updates ice->core_clk_freq on success.
+ *
+ * Return: 0 on success; -EOPNOTSUPP if no OPP table; or error from
+ *         dev_pm_opp_set_rate()/OPP lookup.
+ */
+int qcom_ice_scale_clk(struct qcom_ice *ice, unsigned long target_freq,
+		       bool round_ceil)
+{
+	unsigned long ice_freq = target_freq;
+	struct dev_pm_opp *opp;
+	int ret;
+
+	if (!ice->has_opp)
+		return -EOPNOTSUPP;
+
+	if (round_ceil)
+		opp = dev_pm_opp_find_freq_ceil(ice->dev, &ice_freq);
+	else
+		opp = dev_pm_opp_find_freq_floor(ice->dev, &ice_freq);
+
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	dev_pm_opp_put(opp);
+
+	ret = dev_pm_opp_set_rate(ice->dev, ice_freq);
+	if (ret) {
+		dev_err(ice->dev, "Unable to scale ICE clock rate\n");
+		return ret;
+	}
+	ice->core_clk_freq = ice_freq;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_scale_clk);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
@@ -738,6 +795,7 @@ static int qcom_ice_probe(struct platform_device *pdev)
 	unsigned long phandle = pdev->dev.of_node->phandle;
 	struct qcom_ice *engine;
 	void __iomem *base;
+	int err;
 
 	guard(mutex)(&ice_mutex);
 
@@ -756,6 +814,41 @@ static int qcom_ice_probe(struct platform_device *pdev)
 		return PTR_ERR(engine);
 	}
 
+	err = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	if (err && err != -ENOENT) {
+		dev_err(&pdev->dev, "Unable to set core clkname to OPP-table\n");
+		/* Store the error pointer for devm_of_qcom_ice_get() */
+		xa_store(&ice_handles, phandle, ERR_PTR(err), GFP_KERNEL);
+		return err;
+	}
+
+	/* OPP table is optional */
+	err = devm_pm_opp_of_add_table(&pdev->dev);
+	if (err && err != -ENODEV) {
+		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
+		/* Store the error pointer for devm_of_qcom_ice_get() */
+		xa_store(&ice_handles, phandle, ERR_PTR(err), GFP_KERNEL);
+		return err;
+	}
+
+	/*
+	 * The OPP table is optional. devm_pm_opp_of_add_table() returns
+	 * -ENODEV when no OPP table is present in DT, which is not treated
+	 * as an error. Therefore, track successful OPP registration only
+	 * when err is not -ENODEV.
+	 */
+	if (err == -ENODEV)
+		dev_info(&pdev->dev, "ICE OPP table is not registered, please update your DT\n");
+	else
+		engine->has_opp = true;
+
+	/*
+	 * Store the core clock rate for suspend resume cycles,
+	 * against OPP aware DVFS operations. core_clk_freq will
+	 * have a valid value only for non-legacy bindings.
+	 */
+	engine->core_clk_freq = clk_get_rate(engine->core_clk);
+
 	xa_store(&ice_handles, phandle, engine, GFP_KERNEL);
 
 	return 0;
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 4bee553f0a59d86ec6ce20f7c7b4bce28a706415..4eb58a264d416e71228ed4b13e7f53c549261fdc 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -30,5 +30,7 @@ int qcom_ice_import_key(struct qcom_ice *ice,
 			const u8 *raw_key, size_t raw_key_size,
 			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 struct qcom_ice *devm_of_qcom_ice_get(struct device *dev);
+int qcom_ice_scale_clk(struct qcom_ice *ice, unsigned long target_freq,
+		       bool round_ceil);
 
 #endif /* __QCOM_ICE_H__ */

-- 
2.34.1

