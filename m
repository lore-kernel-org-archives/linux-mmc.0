Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2A41F7D4;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202359; cv=none; b=GAjluYoh0LUCU2fozmYYpXfOce+ItoBlzV96wjr1diP2I/nG1ET2IK/kKXwp5z7wD6TPrm0c6yuOAR2O0F9KnXl5rpObom8dLidKjcxewJ05+/wKFd4Dj4NDo1iGyhtAYOowTEME01vDgdwP6KKJkw2Ak/vmW+sfi0+ttM3pWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202359; c=relaxed/simple;
	bh=N4cJ+1neKZ1MgK8R9M1x2BOiA+d5mi3obLJN2Tvd7kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O50akAVLxHqLeXgad/pnZUHGtnxbZuGbnbhIbuD3yg/5H9grKhAC+0kHKADkabB79WSZ+PE3mZjBXh+j0hx/91HVONdNsntYZoo+mBriq5cvsIY4EXP9SSnkd1cqLunYm+z8rawewnU6oGScyB+90RKfTFoGVwGTVynBOw4qs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR5HBNmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR5HBNmE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2FC7C4E698;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=N4cJ+1neKZ1MgK8R9M1x2BOiA+d5mi3obLJN2Tvd7kU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DR5HBNmEyxqjZNsG1H7AEARg553o4OK15OySMWTHAy5nQ8OtafNQkPbGY/nprkrRa
	 Dq9jLzgW1En6W3WyWBigcfGReBM+VhGAQYxDzDWcffau5oLhy9QmGvJWNcM98NSefV
	 Lc2pt2T/DusrU1Ih1V9dTYXw1YD8ojz9ZaZIbGVzovd7n0w9eT3x0jO76a0pYCaouU
	 edoPpEsrGJxeJ/kqpGtz7GKZAruZujgwknRNaRbpEBxck9SLM4svB9bhVY0KFMF2qf
	 V8zpbTA3HmUleWIqY/nMX1anrUMnE/8Ycu7f998xLv1D98An3l9xxnOIvj2H5+Iz1P
	 cjFU6m/K2DuBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B8C79FB6;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:22 +0300
Subject: [PATCH RFC 13/20] clk: qcom: smd-rpm: Add clocks for MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=2526;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=+fbbxQznzh0EAsRYoXyBD9lf98TEt7urc9Q1WfJgNWo=;
 b=QkA6CKY/iZxxVumpyHBKti6xBNNNjPEOZTgP8ktL+4FuOcB5mh12Wqar04/gVtSyc72YdRvRx
 gSHRBLEIIbIA6XL7tN/dseny4/Qk+50P2Nv+Mii5/RLCKH790m8lR7Z
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

MSM8952 has same clocks with MSM8976 and MSM8940.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 487d715ed5d2..4ed08cbfa8a2 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -740,6 +740,34 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8940 = {
 	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
 };
 
+static struct clk_smd_rpm *msm8952_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
+	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
+	[RPM_SMD_BB_CLK1] = &clk_smd_rpm_bb_clk1,
+	[RPM_SMD_BB_CLK1_A] = &clk_smd_rpm_bb_clk1_a,
+	[RPM_SMD_BB_CLK2] = &clk_smd_rpm_bb_clk2,
+	[RPM_SMD_BB_CLK2_A] = &clk_smd_rpm_bb_clk2_a,
+	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_rf_clk2,
+	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_rf_clk2_a,
+	[RPM_SMD_BB_CLK1_PIN] = &clk_smd_rpm_bb_clk1_pin,
+	[RPM_SMD_BB_CLK1_A_PIN] = &clk_smd_rpm_bb_clk1_a_pin,
+	[RPM_SMD_BB_CLK2_PIN] = &clk_smd_rpm_bb_clk2_pin,
+	[RPM_SMD_BB_CLK2_A_PIN] = &clk_smd_rpm_bb_clk2_a_pin,
+	[RPM_SMD_DIV_CLK2] = &clk_smd_rpm_div_clk2,
+	[RPM_SMD_DIV_A_CLK2] = &clk_smd_rpm_div_clk2_a,
+	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
+	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_msm8952 = {
+	.clks = msm8952_clks,
+	.num_clks = ARRAY_SIZE(msm8952_clks),
+	.icc_clks = bimc_pcnoc_snoc_smmnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
+};
+
 static struct clk_smd_rpm *msm8974_clks[] = {
 	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
@@ -1292,6 +1320,7 @@ static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-msm8936", .data = &rpm_clk_msm8936 },
 	{ .compatible = "qcom,rpmcc-msm8937", .data = &rpm_clk_msm8937 },
 	{ .compatible = "qcom,rpmcc-msm8940", .data = &rpm_clk_msm8940 },
+	{ .compatible = "qcom,rpmcc-msm8952", .data = &rpm_clk_msm8952 },
 	{ .compatible = "qcom,rpmcc-msm8953", .data = &rpm_clk_msm8953 },
 	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
 	{ .compatible = "qcom,rpmcc-msm8976", .data = &rpm_clk_msm8976 },

-- 
2.54.0


