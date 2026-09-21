Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191D50129B;
	Mon, 21 Sep 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014754; cv=none; b=I7Zy5JVZc5ygxe8dBbBmMX5s/1RMmivN5evwzDgNAWKSOmQYxHjOCgmJig8mAjyRe1OwlqRH3NPjxuTtSaAXZkdUow9OWBP7TaqG+TNPqsvsYNz9ou/jj6EIObvHc7hK3Plii2m+geHlAMfK2Rw1AaqL1MV3bU1z4ZzTn6rR61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014754; c=relaxed/simple;
	bh=e8AQbyRP7RLyAcm9yJ1C4l2EkIpH9lqpf5eaVeei7Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p691ERO7/jbKLJPdlt1IDNmuivFpTxNbizdtunE/krxdM2ScaNe8mM+dFP05xoJHqf0P15ZnKrjHFNDpFyMJYVcm64KqY3idzM25Ev0rFJ776rbYRVR/9tPQ5dFUMnAg7XZzYcMYJnbFTzRqsJnkt3wNgDueSGoc9ApngVgNS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEG/123M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEG/123M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D272DC4AF5F;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014753;
	bh=e8AQbyRP7RLyAcm9yJ1C4l2EkIpH9lqpf5eaVeei7Dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fEG/123MurnebPTYdvQOnlmQaXZNfKGbqUaD1xJ2etLNuyhGWdzD++fnfrWtnIc2R
	 daTU9xlgdXtvhJjrOYMFHgpZn2EITzN/SKIC57Rt5KeqcOm6ZweExerzRocgrsQPLF
	 oRO79M+4XUbtn55daBdn7fMErdLIk2mYIWS1CjyfMvWkKcmVOqono0DVGCTGk+2sXG
	 6oTu2MO+tzDiQRhkjrmPJDmxDT50L0SdDwdLtSff8JQe6XPFsDoizPOJk4pJCM6s8s
	 SZ2rZMtJ/iZZ3a9O0LRLtfCrad/p4nbNOPUHDfoqU806H4QPhEkgaXfB62BE62tizT
	 l619JsGL+KO8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30AEC982F7;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:19:07 +0300
Subject: [PATCH v3 16/19] thermal: qcom: tsens: Add support for MSM8952
 tsens
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, 
 linux-input@vger.kernel.org, Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=3737;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=vXpWx7d9wR4FUlrmSi9iyg3W662IEtM1fT94x3Vg7pY=;
 b=78/Pu94tu2l7kpYjz44z3MaPWHG5SSGXtcpdajtedv2cwzshsRC1ZgvRYzpKsZrP0j13Yqie6
 92aoKqLvUytD7TPwM/myGsZrJItU6un7mRPmesJYkVSFVMntWAPd/oD
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add MSM8952 support for tsens.

Downstream does a lot of advanced things with calculations.
But seems like using tsens-v1 directly works too.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index faa5d00788ca..f4201748ea29 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static int __init init_8952(struct tsens_priv *priv)
+{
+	for (int i = 0; i < priv->num_sensors; ++i)
+		priv->sensor[i].slope = 3200;
+
+	priv->sensor[0].p1_calib_offset = 2;
+	priv->sensor[0].p2_calib_offset = -1;
+	priv->sensor[1].p1_calib_offset = -4;
+	priv->sensor[1].p2_calib_offset = -4;
+	priv->sensor[2].p1_calib_offset = 4;
+	priv->sensor[2].p2_calib_offset = 5;
+	priv->sensor[3].p1_calib_offset = 1;
+	priv->sensor[3].p2_calib_offset = 1;
+	priv->sensor[4].p1_calib_offset = 2;
+	priv->sensor[4].p2_calib_offset = 3;
+	priv->sensor[5].p1_calib_offset = -1;
+	priv->sensor[5].p2_calib_offset = -1;
+	priv->sensor[6].p1_calib_offset = 0;
+	priv->sensor[6].p2_calib_offset = -1;
+	priv->sensor[7].p1_calib_offset = 3;
+	priv->sensor[7].p2_calib_offset = 4;
+	priv->sensor[8].p1_calib_offset = 2;
+	priv->sensor[8].p2_calib_offset = 4;
+	priv->sensor[9].p1_calib_offset = 0;
+	priv->sensor[9].p2_calib_offset = 0;
+	priv->sensor[10].p1_calib_offset = -3;
+	priv->sensor[10].p2_calib_offset = -2;
+
+	return init_common(priv);
+}
+
 static int __init init_8956(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 3313;
 	priv->sensor[1].slope = 3275;
@@ -223,6 +254,19 @@ struct tsens_plat_data data_8937 = {
 	.fields		= tsens_v1_regfields,
 };
 
+static const struct tsens_ops ops_8952 = {
+	.init		= init_8952,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8952 = {
+	.num_sensors	= 11,
+	.ops		= &ops_8952,
+	.feat		= &tsens_v1_feat,
+	.fields		= tsens_v1_regfields,
+};
+
 static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
 	.calibrate	= tsens_calibrate_common,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b5ec70201e2f..4d7013fc79d6 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1191,6 +1191,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8939-tsens",
 		.data = &data_8939,
+	}, {
+		.compatible = "qcom,msm8952-tsens",
+		.data = &data_8952,
 	}, {
 		.compatible = "qcom,msm8956-tsens",
 		.data = &data_8956,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e8376accdff3..a35b15312961 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -669,7 +669,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8937, data_8952, data_8976, data_8956;
 
 /* TSENS v1 with no RPM targets */
 extern const struct tsens_plat_data data_ipq5018;

-- 
2.55.0


