Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A041A508;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202358; cv=none; b=BVRu9gmHDds36/ahuXF1IwCnzjk/IXNJzgBSCGXOib5peN9L0yHiX3MDL17/4uQb/uB4ZTDtdjT5DKTRVJBhgMkAtYB4xhi5DFZq+0FOnQwi0KZAeWR13L8FxYlmo2YiK/Y+FxlsrUk6our3w8QV5CWl9ah0Qbtx/TonUgNqy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202358; c=relaxed/simple;
	bh=WqyeewKom7P7COh88TTOK1qoXNFMd40eFyYNGK/7f3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSJcCu8IK9T1Ut0coDqRwtPlcHPvi60qQiW2agquKEWIH93YPkAPGugqTGVizlTqRawwciz29E6bXJFW8WnZEhyqlQv/7e3SRV6ZgZib9l3dK3Hr0zo2stc0Vdbg30psJbxBGn2OWqcnqo4Qxm3a8E2ZgpoJAhB3KHQ0tZmWq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYFNi8rp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYFNi8rp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1735CC4AF1A;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=WqyeewKom7P7COh88TTOK1qoXNFMd40eFyYNGK/7f3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KYFNi8rpdaBuE5Rk5sEKltTtnr8LUL1b/rzSaOPU7xPGXavKGJUzb5ECBGhK4lf52
	 R0TgDun12TYO5Nu7kCw3P4hkQqTZTitA6ELUbRhswrlRmORR4Hzkx4j31X13rI3vZw
	 aqHZqIz/znpyXMHy1Kl9ql0f7nML936js4W+zvrOXNRdmQ2CWd1A1iB39puFOCq9FZ
	 yx7NVWrSn+pVAXczEiLGfU+0M25rdQK6xrbiKZFmBb6xtB7vYaI9wQmSLa1s9ukgL2
	 U16M4npOBW0FZuCMyYNZgqsnWjiWeFreD8bZXXiPh6RbT7zmL6t6dJRjYRU50h46lH
	 6KOimrKYSe0jQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235FC88E56;
	Sat, 12 Sep 2026 08:39:17 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:13 +0300
Subject: [PATCH RFC 04/20] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-4-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=754;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6ZI51ceEaOIY/u/VVB+l7JnsBp7inUEcGIBHgiYAiBE=;
 b=dztDjXymTNo98gMcgzcAM1ZlmGVG6mQv95qqYW9EttJLlaVnbTxsMMBF33je4lABvOJ+nHxUo
 gFM1b8UvYs5BFp5RzBbSVzQruiYPNmdITMMrXf0e6F6EM7uMpa5ttXT
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
2.54.0


