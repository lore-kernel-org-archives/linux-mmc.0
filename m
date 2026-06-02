Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABE3C276E
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jun 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439075; cv=none; b=cii+lG9e0EkMhCTVHxVM2ipKU+pdbNVIY8Tf1Oxw3dzKVWy4zw+ZGwEU9Wgx9KTlnQufQAaAFzVcIo/phDXJFOUPSKwMBKSA/9yqw7XLsmT9fiaKzLiTyDHntlIr8/W9ynZ/4WCgrInzSps/TQEP0ZqO6ZzcmqqAtaA6fy2Kkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439075; c=relaxed/simple;
	bh=3ucCFxqVSmxwv3tYV7K9HtEXpSVQKpaawldrvOaRdUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWgLKdV68CG72ODp4joIme17A3LYbN+b+xKfIG2vGNIC/X7ASV/Rv7KrDq8Tp7eLqIWnB3Ub5gqTuCLEGS8JPVU3VZ++u1mPbtrYucnAkT9k/Wp/ALJP0AadbVIl2ZBCONZVTpvKt6QfYF70kg3BFxX3jMqtppR4Cc4Mq/az1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CvbwE15D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/AjUwFd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvbwE15D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/AjUwFd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652JBN0P4012412
	for <linux-mmc@vger.kernel.org>; Tue, 2 Jun 2026 22:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N77a8rPBNXCEfDhtEGoBDQai/waqHZnCNGqwv0a6lQ8=; b=CvbwE15DcR4FVPNY
	ZTlRJ/94ycOQFhIpmvmufYfd6l5BOntLQQ6kZm3W73/a8Ngnab90TMvfT0Vd90hB
	WJfxX6lJFShIaSecHNZxVYldzuYypbo5tYnClU8T38WZ5kWyw5ZFcy40gpdmiYbc
	5bPabw8sIrei4+0+dO8Zo8ETuGqcD9XeVWQAYpX9CylU7HtHIBMJdIgFLm6ScO2u
	G5Rm4bM18F4vhVRcAGf2HrnVWRBz/fmoxhqEQsmXoqKYcyRAO989ZV/wtrK757kH
	7X3oYw6cj/rgS+k6IYbljBL49TIvJsL0bLa1JRXjwXkubSmUEK1Ve5B8GYKA93XP
	whYIqA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf4m33f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 22:24:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so53840065ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780439073; x=1781043873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N77a8rPBNXCEfDhtEGoBDQai/waqHZnCNGqwv0a6lQ8=;
        b=P/AjUwFduwh2DcFlnfmwssU7UBrXx6y6zY9M/CcIRbP25mhrtaARjoGTl8+RWSqG56
         FT/uVlqs1IbGmdccUuf6BKcIdAgrBBvWrInYkqBkpOWz3Y3AyGVacYTVdbfA+TdVmX/w
         1MBJduq0pSoDGXhTKaAzQIphHjlS6wyrVSeNlsoaYT+g9+WRTSUcoJMvb+tXvwefLSo0
         TRSlAYvYG5B8soTOkJmrra/m8POmDMVGzUfvE7kM4SLhc2g09ApGO9lSKYLohtVmZaLN
         bJUQbrsOfWxsJ6K1dXCycbohqVA8KLGCUUeycweZRZ/5bdJ6IkrQ3aLU4Is45BWGrn+/
         42oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439073; x=1781043873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N77a8rPBNXCEfDhtEGoBDQai/waqHZnCNGqwv0a6lQ8=;
        b=e2crP+Xx2QrFFK9uiRlTgrqNaYmsT1bDunw68LvYu3Fe0+dQ8u54JljLKuEE5jqfpO
         5MGWJSYw/eGThz8y+GUTGK0PaVGRCpbSmnna9LyuACOxQtQDmXbI9rVyWhGDM/rZO2VZ
         KzqAApoAoVvSZrXeOJQYsHI6qEK95ciV7ApNpu9oM4Soo3QTAQh2hO8wrLR5EG0NsYhr
         cEgENDsv6HS4acZ49sUYIASOpcik8ikzJV/L/YxotLJivg0wrELwAMZZ8Oqb+WjegdAv
         rxujd1Gw70jXa7s6ty+ILg42LngpX9D91mquqNwTZsNXdUjzsR8hhspNSaBgggq+r11i
         IQnw==
X-Forwarded-Encrypted: i=1; AFNElJ+tsxkAJFJDRm4AGuWTEcpNIMk2UTWzUP+awcup9+BLLscS4aUctYAZUVrqpfr3T98uHZYqctetphQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOKVd5ki/LV3WrsozJr/D3urhuT3AmEBGY/i8nwhHDgQ/Ha3c
	KJNj/a0zsm6OY2/5FOjjt1ydLRYkPIqs4lN3KisP/TAEQNww8c5FWCKk4hOQmBrCLXybX55XNYG
	WGflZK9sy/G442lihTbt5WKvWWVA7APB3zU5Q8awYalH405BdrzNV+33VixLqgkQ=
X-Gm-Gg: Acq92OEc1+vLxj6VU96F38V6o1Sgcac0mEnKgKB6B7mTelrM9xjJs7g4g3TehLctTJ7
	/B2+ue0TzfU+LagKLWBxR9GUFMYrEScd8kyPxRlEqBZA9y4lMSzYVt0SXxD1zlnJWUesYSdr/TZ
	gqlzJ7CfLE8S7XPsJmHCOO91Klcd2ICMCxwszebqhcTSaq0eSX1VLZ1b+SYNO/MFlIC4hHH1Udz
	1YDm6xqLqjohzGpW+18SNdaesJ5ovye6RfAb71aHKCBkyEjP6zQG1PzTKFS20bnyFSJHObdZFBI
	mu4QxJsyZarPa0NWn/ToEwZyoOfDFu5vZT/8lXPSNyE/1gDCx3DdzSlctpl1RJMExA7OobSLPxf
	/frXNCeLbmJAIX3tHsW8RN/GgOWanBFu96BhlztWi+JfkXI4ouLvpghuXlLwYWbzvF8q60A==
X-Received: by 2002:a17:903:1a4e:b0:2bd:8dbb:293e with SMTP id d9443c01a7336-2c163a58d7fmr5515945ad.14.1780439072691;
        Tue, 02 Jun 2026 15:24:32 -0700 (PDT)
X-Received: by 2002:a17:903:1a4e:b0:2bd:8dbb:293e with SMTP id d9443c01a7336-2c163a58d7fmr5515675ad.14.1780439072166;
        Tue, 02 Jun 2026 15:24:32 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm2698035ad.45.2026.06.02.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:24:31 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 03:53:53 +0530
Subject: [PATCH v10 1/5] soc: qcom: ice: Add OPP-based clock scaling
 support for ICE
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-enable-ice-clock-scaling-v10-1-b0b728435356@oss.qualcomm.com>
References: <20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com>
In-Reply-To: <20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIxNyBTYWx0ZWRfX+d5qRKkpq4EY
 l7vvYyOW/fxyRXaf1C6bLcgjI/j8ql9aMpZ2DpiXkGT13fI8iCak2Fjgy4bg+hsSqGyCgBcQHPP
 pTazJMwMRxnvytY96Zy29qoMZ0F+FTAt6JmcpzKqWNvrW2tVpvHM19qYZYPAAQxus1sBytjREM4
 uCXtgobrb/v96Rp4y7IPNjNjLbxvFFrRI37V4IXyXmaICQQAKbE/E/cz3GHWKRRHYd29Pq7Y+Rc
 il7BiWCXFj8S0XlXN63EdyemCJphd/gxKzEEtV4ciZY2QjSHZDsL9tJYBAWt10bK7CQvEok3KDQ
 g6RFoCJ2wCsYWxsuAt1PPw5ATgOmiqbMB+cZIi7LRAVqewkCI8zQjHozayqkgBa2UtMvNNTBr6+
 lWR/9JVuev/1xtuuXIYLF5snGiYegywaS6i6Idiaap4ai0tzjFj9yaMV/fWcNzLOG8x4kJ6J19c
 hZkDtsqXubIlre9Utmg==
X-Proofpoint-GUID: Hjs5OBy1-OJms3gELYDhvAAuBLGBBL2A
X-Authority-Analysis: v=2.4 cv=AJZ7LEvz c=1 sm=1 tr=0 ts=6a1f5821 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zlodBCVASgOsPZHI1q0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Hjs5OBy1-OJms3gELYDhvAAuBLGBBL2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020217

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

