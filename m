Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B883421233;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202359; cv=none; b=uI3xR6doN0jv9mx1Aqvskyie64WDvwLHom5CZn20u9YJNIj+OrWYLxrGzNJVBVqvZmaONkQdx3/X0anzzFsnadBzoxM0vJhvop4UXIY611dFQkNLUTC0vcqrmMkfDGKfstUupb/CRwdHlRTGc7oe8xcBttoelb8Q2/DWiSOuHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202359; c=relaxed/simple;
	bh=JJRJhySTsLtcFd8GQW981z7R0SglGrCnEEAhSveaKRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxGH+nDDNpLJYvVDtPwXGwHvpXSDq5ZnMdsUocKKZ4Zz8OyNArlqSXPYr0fD0HwFyip1b7LlnX834udzRMlrvIEHXO0MNMLjhWALcIrIs64wdhtBCFAJruwtmk5vvV9XlAuTM1iWot2dHiHxxDNLIYnoUlEz7vHWNrXAGNVRmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU/5eFnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU/5eFnx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ADEFC4AF67;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202359;
	bh=JJRJhySTsLtcFd8GQW981z7R0SglGrCnEEAhSveaKRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BU/5eFnxpuoqCYjnzZhrz7hlpOYJI1RobJPIZ9JZtppVJ/LLYphGeg77vQfLXiESx
	 H3zoBgcPA2yk5Z9/IJY9kT1W1coke7MicjZgHBP76xClPccJy5yTkKhpUudfA6zMS4
	 3dfipeT1jKGKiPIB7LgDzYDFA0VHlh0veaLsLwrGW0M9OwVeX/MNfp9cYhNncYqBiQ
	 1We0i6YGYGjGDjg9VFeOOnQ8qddnXWkfhUVY1T0iLJVMtcf2YWWDwT0ZMw/f8lrm1Y
	 9i8lQ3nhJgYdy9G7RATuYqneg/nc9uOTK0VQHoPSu/rvrcTATg7tfxinGkA6AK7rgm
	 vrpPMqbMJ3oRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B5AC88E53;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:26 +0300
Subject: [PATCH RFC 17/20] thermal: qcom: tsens: Add support for MSM8952
 tsens
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-17-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
In-Reply-To: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
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
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 iommu@lists.linux.dev, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=3766;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=NwE63NVSkM7PuI6TKSkbUbPMowTu/Nb0hrYPBEBZEM8=;
 b=qif+Ybig1msGLGYO1mBqVUwMj+daZ4OeXh4dt1RlzYrgo2xguH8VvfynZ721wMKjqbX2/e427
 NPprsdgOQobCRixKnAlaaA1Ir6qZmLLmI3FeBuGTIQZ451psQ7CRNPt
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

Downstream reference: [1]

[1] https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

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
2.54.0


