Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFE420482;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202359; cv=none; b=nvprFyc39ZluFz9WA8dKYTxAEcu8AaDIJXk0VPrIgW3roffHZJB9P3hpz9GJN2ahTq7dAgPBohN9P3mt3Hp42qy0STj9nFp2y8CSyqgvPbqqQEEeovQg91NryqqZkg9mV7QT2ZNNwuqGRWaJpSAv34YHo+4b3nu5hrWTH+y9C94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202359; c=relaxed/simple;
	bh=yIsy9UjYKr48teuGGm616JWWSBmaNjaRJetlhs90SOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFI/p2EYAhhKKiz3iPxNjEk+u76tTZaaB5vU+IOceUDg6TvquVhwJfzTVIhGsFBT75GeZdOnXINZVlYJ5dGy9EgjWm/Y08hDaonPrhV+L8GZODsn2mKg8abSolWXX23bJvX90f6TDq6pXLzIxEImtYySZQwBfaSgD3HFaldV4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6IA15cS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6IA15cS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5937C2BCB9;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=yIsy9UjYKr48teuGGm616JWWSBmaNjaRJetlhs90SOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B6IA15cSXiQV44NJFrZDrtCfAMJVJ3TPf9Euoggk0M0vOIBiFwCjtvUBKAquGWS/u
	 ty4V9fnwH/E1HZQi6AG3pJe2ImD+c7Sgrq0gNp4jwwZvYEDgsV4ufbeeKXVauhnrOn
	 nGI+ANT8O5juEFQ4KnwQLNHkj3qdxAGHo8fxPdydN+c+NEsdBu6nWEr0XUD/q4VhMx
	 bT1G6NgfQ226BFdsO7M9/m+lcbKcTIyfCIf6843Rh98RtQ0J9KXI5wU0Me/Nt87DVD
	 U/9ZUSrQunrhzQkz0Kxp7uJBP0xMQJyyYZ6mh0Z5IrnUUig2+rypHTuu9l4nIv5zj6
	 KQXdqyomEEJWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B44C88E56;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:23 +0300
Subject: [PATCH RFC 14/20] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-14-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=2908;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=tN86AwIVz+/4z2KwlUplPpbsNM+e16O69T3qlIbXC0E=;
 b=D+Mx3bXoA7Gp2aJrzbakliBWsehboQQCDHUiAE6mtMMsP3Rz+XXR7XoC9JCqMmHP/BbvAqRJb
 pM6YBmDSDrSC8nbOgefdBSyahFuqo9ikgTtGT80P59kglzet9qZyeZz
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
2.54.0


