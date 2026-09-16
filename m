Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5871513574;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=KMbBftS2xInwwqA9yc3h5S2OJOItgmoRrvokNDCBsVaIjCyDyoxX/UeKYtqw7eTV3cABgLIkFTr58+66kuvPan9SQsR5U+QtVl3Z1q5CHHpstLFRSPvjMZDJRfLBluUSfv8bYDL8VQT1CvfAMWOnZ3jD1bjOK+qk2ie2hjtrXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=68xt0rCfMk3htQ+CNQtRlu7SHWfHYk23uy9xMNYUavE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNCyzfWjElTG+CX1qifVuADPkF6EaQq5GxIF0uBpZTmyIbhixSSZZtNkPjRSvGoyC5NnNiajIIMPjHIFIFKZB4skeFOahKcAKMGlR8JIRbEnSukJ/hThoql2uj+st5buY51FRWW//YhY78xqmBuKhqMkgoj6bt+wbquBWObB+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdUQ5q7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdUQ5q7g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BA13C2BCB9;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568583;
	bh=68xt0rCfMk3htQ+CNQtRlu7SHWfHYk23uy9xMNYUavE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZdUQ5q7g+6VJixBAP2wzqsp4xZThg9LNCib9S0Y8CKOFMdD9+H7B1ll2XdemGHU6L
	 aqrqNgIxbM6y07I1kDY4l79ytFwI+XjMTNeoCO+yi/Tqqq1ZGH+tfP/ZdwA7OXjnyi
	 1cNR4SzzbKj/8RDqHjIAMQe34MfTzudT17+JR3/HrRBKj1CDE/7ofoe6WAn7sAQVCE
	 ZSSiSvDCwcZuWPUmrtA4xUKvGMefP4UmEhneEDj+qYfwVfwwmRK6amo4zkgDd3ZplM
	 91g4bLfIp6CwdmP+f3fMvEAIDg0tDRXtDJurucRMIBv5Q3TxJaFrY3bOv5iuYeEdBa
	 JBPJnFa8if7hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E9C88E77;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:18 +0300
Subject: [PATCH v2 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-13-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
In-Reply-To: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=2908;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=iJr3V7WxoPjZJBrBl5G8abT5fWMjrLqAWAzBrQzyHX8=;
 b=K6cMt2RzCyLTcNfNqQpFwSE97LtWUMtFbd+1vhHKt0SMEKwr64JQjm2aa/l3hLO13iuQw1Ezs
 2DDPYIFwNLeAYxaIHN0iF8IYhcIESviwBogVCfp8KTJbo9K3kud4JxX
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add the mdp5_cfg_hw entry for MDP5 version v1.12 found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 7c91fc1915f3..d34c94d6f7e2 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -744,6 +744,86 @@ static const struct mdp5_cfg_hw msm8x76_config = {
 	.max_clk = 360000000,
 };
 
+static const struct mdp5_cfg_hw msm8952_config = {
+	.name = "msm8952",
+	.mdp = {
+		.count = 1,
+		.base = { 0x0 },
+		.caps = MDP_CAP_SMP |
+			0,
+	},
+	.smp = {
+		.mmb_count = 8,
+		.mmb_size = 8192,
+		.clients = {
+			[SSPP_VIG0] = 1, [SSPP_DMA0] = 4,
+			[SSPP_RGB0] = 7, [SSPP_RGB1] = 8,
+		},
+	},
+	.ctl = {
+		.count = 3,
+		.base = { 0x01000, 0x01200, 0x01400 },
+		.flush_hw_mask = 0xffffffff,
+	},
+	.pipe_vig = {
+		.count = 1,
+		.base = { 0x04000 },
+		.caps = MDP_PIPE_CAP_HFLIP | MDP_PIPE_CAP_VFLIP |
+				MDP_PIPE_CAP_SCALE | MDP_PIPE_CAP_CSC |
+				MDP_PIPE_CAP_DECIMATION,
+	},
+	.pipe_rgb = {
+		.count = 2,
+		.base = { 0x14000, 0x16000 },
+		.caps = MDP_PIPE_CAP_HFLIP | MDP_PIPE_CAP_VFLIP |
+				MDP_PIPE_CAP_DECIMATION,
+	},
+	.pipe_dma = {
+		.count = 1,
+		.base = { 0x24000 },
+		.caps = MDP_PIPE_CAP_HFLIP | MDP_PIPE_CAP_VFLIP,
+	},
+	.pipe_cursor = {
+		.count = 1,
+		.base = { 0x440DC },
+		.caps = MDP_PIPE_CAP_HFLIP	|
+			MDP_PIPE_CAP_VFLIP	|
+			MDP_PIPE_CAP_SW_PIX_EXT	|
+			MDP_PIPE_CAP_CURSOR	|
+			0,
+	},
+	.lm = {
+		.count = 2,
+		.base = { 0x44000, 0x47000 },
+		.instances = {
+				{ .id = 0, .pp = 0, .dspp = 0,
+				  .caps = MDP_LM_CAP_DISPLAY, },
+				{ .id = 3, .pp = -1, .dspp = -1,
+				  .caps = MDP_LM_CAP_WB },
+			     },
+		.nb_stages = 8,
+		.max_width = 2048,
+		.max_height = 0xFFFF,
+	},
+	.dspp = {
+		.count = 1,
+		.base = { 0x54000 },
+
+	},
+	.pp = {
+		.count = 3,
+		.base = { 0x70000, 0x70800, 0x72000 },
+	},
+	.intf = {
+		.base = { 0x00000, 0x6a800 },
+		.connect = {
+			[0] = INTF_DISABLED,
+			[1] = INTF_DSI,
+		},
+	},
+	.max_clk = 320000000,
+};
+
 static const struct mdp5_cfg_hw msm8x53_config = {
 	.name = "msm8x53",
 	.mdp = {
@@ -1017,6 +1097,7 @@ static const struct mdp5_cfg_handler cfg_handlers_v1[] = {
 	{ .revision = 9, .config = { .hw = &msm8x94_config } },
 	{ .revision = 7, .config = { .hw = &msm8x96_config } },
 	{ .revision = 11, .config = { .hw = &msm8x76_config } },
+	{ .revision = 12, .config = { .hw = &msm8952_config } },
 	{ .revision = 14, .config = { .hw = &msm8937_config } },
 	{ .revision = 15, .config = { .hw = &msm8917_config } },
 	{ .revision = 16, .config = { .hw = &msm8x53_config } },

-- 
2.55.0


