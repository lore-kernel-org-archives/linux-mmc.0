Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A30511186;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=IQXTNy8yRIXBKJZovJH6xQsSlhQxe4Tdi5vCa5hJHw+YT4Ui6TZeY9nJX++z3yXvXxVYOycizX8BA0HRpfDgYk2tDDItDZQmoYpInwr4tROorabsshn27McgRNnz3RBXi+DFKeh+AqP+HTAss/XuOemXyHdBw+Hhjhxeb9J2Iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=9xqG+3+WmHmv5lQsSS1zepKcYxP21tK9ofhGCGMOOlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RyvoTa2lWyEJ+sXd57/Ksf7gqbLQ1K5imMhotFLOWymJKuSwlgE7bZwpjCNLWdP2tIWCK16Rn29syF8y1kw7dUAa+Rz64QpYc+eiZRIdAA7x2EWKhcF9/GHdtoHB7HE2HI5rtb71h3xaqlkEy3lLO0zMWeVqzUnv+ltHlEV3HzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN6psvww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN6psvww"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 812F2C2BD05;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568582;
	bh=9xqG+3+WmHmv5lQsSS1zepKcYxP21tK9ofhGCGMOOlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mN6psvwwlx20wI2MywztYgMLqvRThrsmttpyncBMavnSQD0Wx3z4qoR4LNI42JdXx
	 /xV9STCqqlhtP8ju7swWT2ZZOd+9ztl3nnR9Sl0iAv1uc7Hc9B655gXjLQC/Ug4Mf2
	 jQeSOsx14NFT+ZQZoJiob79nHSZNML/C5ckDyeSgky2odA6AuvLqkoa48zvRgRyN8W
	 rNAPVwIzn2aFbdkeBm6IwPNuvoD64GRzRBJPTCkXQHd22hbsKOnBJgnhHe49IAcxX0
	 0SuB9vGzxG4uyj4gY6zF0ENhbWwWczZgBYafOIbgboJe0+JzLXtcfQzsGnWld4eqa0
	 7X75wPAM87hPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69927C982C7;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:09 +0300
Subject: [PATCH v2 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-4-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=754;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=z3YwdcIAvY7eEvL/O1RSkMfScbVn/9IEcdYfTg2p+uc=;
 b=k2HY+70CTYWzFxnB0MMknEq61jOrV/rr6qzY++RxCzSv4ElVtzFDdeZ4AJrux/oO83JrQhr7j
 woY4pCZESpKBBJArxHT1PPEA0PqN0uppThvfylRVTpZ/Zo+nIIty07M
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the compatible for the rpmpd found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index a70bfacbc5d1..8ee1c25a7c9d 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -76,6 +76,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8937-rpmpd
+              - qcom,msm8952-rpmpd
           - const: qcom,msm8917-rpmpd
       - items:
           - enum:

-- 
2.55.0


