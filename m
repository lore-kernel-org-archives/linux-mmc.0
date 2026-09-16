Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7B51476E;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568584; cv=none; b=SOuhDH8CCS1NLIigQOjcSzCSPNwS8OYwD7o7BMrlNUYM5N0atM9hLhSXpMoafnswV0sIbObnIxT4b0OQa/jznKi0lAOEZEPbk/tc3Iv2KZ0RjDML+SG7PAIeqsVLLb2yrP73QNzOMb9MWCOz+40HKCSc1IE9kiIxGZlJiGgBlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568584; c=relaxed/simple;
	bh=I4CTX75TF5hVx5UxMd8q7ZxWApioKhsfuYRkgccb7/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ho7u2xJ31TC0B1/gfbSvjEaTWYgAvYv6I0qMdT8u1Z5BgEb56b6YWTc90gjU3Vo7dOgHrrxy3/8Mple/lelp3FTqG2QRubxTB/khrriOYVi7syldP68m9ghr0eb2u9zDiOCAlLbJ2SU83UyB2frJfGzeWICJ6Xi/50q6r9zkk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPBfGnlY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPBfGnlY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2336C2BCC7;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568583;
	bh=I4CTX75TF5hVx5UxMd8q7ZxWApioKhsfuYRkgccb7/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SPBfGnlYryT4By6nB8pUwUYaohWMigVzZz7uhPW9y5lcm1TIPhKKKL7nRg3yQMwWo
	 jXHVb/bVfxefxileDbJ5gvGRR2UPD+tM+vtGAVe80k3Jv+MzODsNxwYh4oR7u/5c+R
	 suBqA+m7cuv4wMYdlZA/h4WbK1zP4qqxMwaQa2KBuGzggjZMum1m0e2xKysPp/bOtN
	 JIEX5ZQbz5XLmbDd3HIIMnMy/sagTWiUV3fTMhCY6XTt1ozxEIA7YPBeFWsBrD3Fpj
	 lBfs9AyN1l1pndTSCrlRDelNJ/NpysdoiM21knYQ+7/sQWT8K5x6L+zFTVZOv6XILm
	 7ddTa8quypoHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC0C982C5;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:20 +0300
Subject: [PATCH v2 15/19] dt-bindings: thermal: tsens: Add MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-15-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=797;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=qpZ4iKLD/3vBtZO46iDlquc+pQ/AKxoxvg54YFCLw48=;
 b=2XsdEXnBXh1Az36JsopU3NLkX1Igbws9nWi07z6oO8aDEqtGI6mtUKxfnWg2d+BBR0GxtQ7e1
 qJLGLY6WuOpDgkI9y1IxqNf0lYodueH9m/FsNohPFgxWRIecX7ypuRI
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add compatible string for tsens block found in MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 5a8f7673e730..c78074fbcecf 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -46,6 +46,7 @@ properties:
         items:
           - enum:
               - qcom,msm8937-tsens
+              - qcom,msm8952-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens

-- 
2.55.0


