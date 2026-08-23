Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CB31355C
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514480; cv=none; b=lfD777F1WfEvoeaYxto47BXUePIHOtO6VBom54QNLdWIA7TlcCGHMPcBT8LyrrciIB58X6o63jJTh0UXvyzCQYyZqT/LxlAPuukLuUtoZepBytCEQGJ1P23NCI99qRPY46sWmJoIoui8AFnxKGL7XoF0RxQArJhgg8+2b6uygEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514480; c=relaxed/simple;
	bh=s07n3zGyKTRgJPko42YKE9eClepjokuIZv+mP2hp+u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJ0m5V9FRikK/R8DUPBKYRyCg02b/BtUk1l2rc3qAcqP1wKsponyzasjcSnaTI44cvj9GO78jyy2Ol9srpr1fukimB5ucv8Bz0xBp4Un/YZUuZv09Ik1wTTy8XYqfRG1qOocnvOdIVVwD2qI0WRKPIr49r8+GcocRaymA5G4hRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/fqd0fE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jl4oNrc7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/fqd0fE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jl4oNrc7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NIU1de225314
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rQ+w/bYviLoJPls42Bjsc8yKlWdYtQ8gvXqF+HhAlTQ=; b=D/fqd0fEfU6deNWN
	NFuzWaq/qI6ZisS5C0oMtYzW4ANmt3d1oNSiAoNO/9aQ5KQaxhYqkRMT0gFY7YMw
	wk+CjIrJd6noLjEefijEd8Wqy8mjdsW54Kgp4Mv2hB/IhjELvu0QpZEgUEcn1TMl
	93pRz8SGqa0TaqcJ2zePGl5ehrtfwe6Dq0Bvi80USM9An72SbWwHufDSczobmCe8
	eDAXDN8Iby7VbIwiQIKIUJj09AEGrS+ZfpBlAQwXIRrCG2o0QrfBgcd96r17bOUz
	EDbWlzQETdXuP9JpxrBezRhFPGRHvq1v0xplT4zTzl9xy+4BVB0JTD3PILwQeQ+w
	1ZDNpg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7456vfpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:47:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2405339a12.0
        for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787514472; x=1788119272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQ+w/bYviLoJPls42Bjsc8yKlWdYtQ8gvXqF+HhAlTQ=;
        b=jl4oNrc7l1a1RrtUSMTJUsduQJ4mvufjFK6PmvHPHCBJ+QnsKVHwW09ViUZsV10mxt
         5s+XX/UqJrQNz5TnER2gFyRLPrhOstYQJhof84KduESCbBYW150pYLA1zxt/ZTjd7ucO
         r2CpQOhs2MdCTxvEqIcZHQZcvXz/78bf/Bp+uRGZNI0fZmw5mZn2X54BBI/Oe07zT3S/
         gQ3m+c3eTEAcYrOaqia60wkygVoFwd8vx/mKYtTEkib4QtyvdmnNrq0JyM63xtCB6vZy
         iBV3we3SiqkoJS2xFg54L/GEDbpefQ5v27US4roOImp5zT+1cgYmD1GyFFGX2YoR2D5o
         xiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514472; x=1788119272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQ+w/bYviLoJPls42Bjsc8yKlWdYtQ8gvXqF+HhAlTQ=;
        b=FlgQpJzkiFY3MkGanEN/S+Fylg/JIXps88V1wxmQED7bHscXcosQm0+3SL+4hs6Sjq
         xxextowEbQ1lKUwY5FiF1a2ABI34SHvk9u5oE2BFH1FF7+VUHx1iOfI0JKByCwpOu3sm
         WvRhSVaHhnP+BEIaOHMQtKxzYozkYvRZvjY1cz3ItffOJOEcCZnSJSPQXvRYl4g68NuT
         mZ6m6QbcVY4AWnmz3jT09NdjtiSuCwA0LZjCpL8FF23kCjScoXR6Uuo65I1a9T7as6w7
         AeJeXdMt6nB61SLl7KmM/0QPD0MBqMW/wf/Z8vMVcesyN0wJCLs+KwfJP/e6YBNCPC5n
         /Wog==
X-Forwarded-Encrypted: i=1; AHgh+RoCYfjEFQF8yl7U9rzB/+KthNaD8tqjNkw/NLXD7311IAojUqKXhklmPNZzTnbORJG7cCOruYO9DNk=@vger.kernel.org
X-Gm-Message-State: AFuF++kVkkgNZDgNUf0b5VP2z4z7Pyoigu1yXIB5Z93euoqwXdUu4689
	/KZfjQfbfuqcY8T9CH4qZhFVJ2aAyXurMiCYVD2FPS7+wySKRhxWqPgrcVqED445YeI2PNiS/wi
	rD1P85NXo8EPdEcMOX55vGtxp14M+o1uGVKuC0uOS0sf2rXnWh6h2B2fTbD+ttOw=
X-Gm-Gg: AR+sD126y78WSthJsIjBJ5bPX9lccDcqVcOf98P7aM7RGTKu9Ipcj7950+yzC+Qed7Y
	/Ccy0uR1fDWhG/CPwiGPBgZRfhi2ssWFe0NCyHKc2jT2I8FMEmx8M7PpQmtnuDvWWD5VxefjwHK
	/JTCMUgz10YqSJNm6W8QsaU67ASMVZLBVgXmApPN4d6xIMu0z1YAof2FOzzP5rLTJseUbvWRODl
	kI4YEnQCS1rCHOIL7HERRYO2M4rcQPZ1GuuVdn4Qqh8UnJLzThiEskez/Rz6sERtmZ8yxV8Vrfc
	UVglVc+IYVRk/FgGqR/8TRfUyxfH30qYtoaiVh5TH1K2SG8EQi7nLTLy5S2wWys1sDz6OVnoAo+
	5C73SQ5GXqWQmxGfrP5V2otmAqpbfNjv4S7gZxA==
X-Received: by 2002:a05:6a21:3a45:b0:3cc:fb7d:a9ab with SMTP id adf61e73a8af0-3cd4b9ea5famr26997344637.2.1787514472486;
        Sun, 23 Aug 2026 12:47:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a45:b0:3cc:fb7d:a9ab with SMTP id adf61e73a8af0-3cd4b9ea5famr26997288637.2.1787514472039;
        Sun, 23 Aug 2026 12:47:52 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f925190fsm32321623eec.31.2026.08.23.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:47:51 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 01:17:38 +0530
Subject: [PATCH v12 1/6] soc: qcom: ice: Add OPP-based clock scaling
 support for ICE
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-enable-ice-clock-scaling-v12-1-09271f583dc6@oss.qualcomm.com>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfXzVftkgP5ShUt
 2EuGIwwIHneYigjaA2ppjzV+lrA88mKvW++5bnvUXJoa7zZlOCv+bVvTqQ0pTvaom+bIosck21u
 zfPNBQAhDUifvTP8Itp4zYPjpPwzHqU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfXwd4WNEBEqj4B
 7wgVTa2X6QqN1wE66AjZbqc1PoXY87RxlZkLdUMJwkThCpb9dZNnwqIcU9wzkV8YoGFO17R6tEa
 Cxzxh3oGIP4QoMJi/5pQoQMzZhYS+6c12EoVlQkfIIZ8tBI0ThCVtzUWMAFDc3ztoJUCVMavitJ
 1RIewqP5U+dSra3ZXsFBXDTDNXAnj8eR52CUURf1H8sGp895fAEL87TiFe0IJ89HXX0ImjjCkej
 aXXJ3qsCjSrbWOWqR3u2e3mijycHtWEeMnh7pT/D2r477JeHJ9GoLfVnCg/OPk8fz2l8PJ9uaaF
 Buh6PQ4mVUz2X3CVOxeMgjiTMfqAh6U4yiOXKnqR7RduJKvewOa6F+RHU6dl8EIa1wGJDmV9pMI
 Z9qwtTxjfXSMB+PP7dL1eEXw3tDNlVU+jsJQZMX3DVqpa6FCuo2ASViRsI9RLrusQeWQvRaYWLG
 mre/fahwFaqxdJ2b2zA==
X-Authority-Analysis: v=2.4 cv=RtL16imK c=1 sm=1 tr=0 ts=6a8b4e69 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Ncwwxt0CvNVXG9qWacgA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: L7ZkeAKtb2foErcEyHes5DWb9MJX4Yh7
X-Proofpoint-GUID: L7ZkeAKtb2foErcEyHes5DWb9MJX4Yh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230181

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

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/soc/qcom/ice.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h |  2 ++
 2 files changed, 77 insertions(+)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 5f20108aa03ebe9a47a10fba9afde420add0f34a..a7112b4ebab0c76ccb3faf9415dc22b28b73bdcc 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/xarray.h>
+#include <linux/pm_opp.h>
 
 #include <linux/firmware/qcom/qcom_scm.h>
 
@@ -113,6 +114,7 @@ struct qcom_ice {
 	bool use_hwkm;
 	bool hwkm_init_complete;
 	u8 hwkm_version;
+	bool has_opp;
 };
 
 static DEFINE_XARRAY(ice_handles);
@@ -560,6 +562,50 @@ int qcom_ice_import_key(struct qcom_ice *ice,
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
+ * framework.
+ *
+ * Return: 0 on success; -EOPNOTSUPP if no OPP table; or errno from
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_scale_clk);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
@@ -738,6 +784,7 @@ static int qcom_ice_probe(struct platform_device *pdev)
 	unsigned long phandle = pdev->dev.of_node->phandle;
 	struct qcom_ice *engine;
 	void __iomem *base;
+	int err;
 
 	guard(mutex)(&ice_mutex);
 
@@ -756,6 +803,34 @@ static int qcom_ice_probe(struct platform_device *pdev)
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
+		dev_dbg(&pdev->dev, "ICE OPP table is not registered, please update your DT\n");
+	else
+		engine->has_opp = true;
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

