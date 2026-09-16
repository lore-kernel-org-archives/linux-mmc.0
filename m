Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F725111AE;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=oREb3kIEhaJwD5F5es31/2CRxIKgomAO0TirQl+krI9fPn0W/YibRqFDEOk9w7w1Zy9awa1q20S1qme9KuHXl2GvLScnyGI5FZDqbICKBjJph3j65Fg8GjspmJdeNeyhrFxVW+eFAhxd/9uWbraRtG5nwA0HkVFuxxXe3oak3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=ADWyIfwE6XuJB72wx5ZNO3lUTF7XQSRGu+OYhU10h+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EimqK3KtFWOoRABZtrNCrEstTlTA5/WxyMhGa+odsx+REHzrQ5FyUrCyI7d8nmkkGQQZLZwBnVk3zB2Ht4GE7bKLhK7E90PBRUEwPHYtG9RZsXYQraWHT1yJybPPVAjutBHrnJzz57Hdi8UAef1h4vye8JiprpVPpr/QSxaA59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA7aynPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA7aynPf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A915CC4AF55;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568582;
	bh=ADWyIfwE6XuJB72wx5ZNO3lUTF7XQSRGu+OYhU10h+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MA7aynPfjZ7Sh0gdKu6NLA2gt5MV0COb7GgOva2ho7zAGNVlKpdPR1ItcfulaCOr1
	 kB8/WWIvIMaz578oVas69qMT2SHWrNxvbpCnzp13DY/WYWERFy23WhZMN01sPvxThc
	 If1u00ISA6Sejy4LISyV7B/oe7mnzwrABznxE427dCgsZw/fHtaGfyieVVDzoz+pUY
	 HF/Jj/bCDxo3hvmknklNO/6iWRKV1cLpGT5KzBjAvhuYDhxzS0joFlmPk0fI0/3Dlz
	 A87ZicJYwidHe5WEM5SGk+Zd7PgE71JU7CddrlEp0DC+QeuRnEqXHn2hSdAo0cR9tB
	 g8I/yvpBnLg+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F4C982C4;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:10 +0300
Subject: [PATCH v2 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-5-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=861;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=VEXyO75VAF+/9sYwg1Lpbpy6HMe2dubE2oLqqBz7xuw=;
 b=70uWfb9JjA1sdyX0YTQ8rD0SsQLsXi/4Fn/zmirZHVh1eYxxPSFrOCpMyd4XjUITDMsttEKHM
 WwswHYY3A0xAF2ZrQfMlLP/dx6tY2Sz8GCHI7GF6nPEkAtJrQHJagIJ
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the compatible string for the SDHCI controller on the
msm8952 platform.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
index 69bd44e65ad7..9d4409c958fa 100644
--- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,ipq4019-sdhci
               - qcom,ipq8074-sdhci
               - qcom,msm8226-sdhci
+              - qcom,msm8952-sdhci
               - qcom,msm8953-sdhci
               - qcom,msm8974-sdhci
               - qcom,msm8976-sdhci

-- 
2.55.0


