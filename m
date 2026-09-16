Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75375511E9D;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=OSehsOyrfLN/U7jrLgFN9zmWBY3VvNsifxQhxTJrp8bYqBUh/ZFDSUywY8W0Yq4b/AOqPWd4ia79SzxZii495y1KkD5cNFg6NNiWD1eN3BbwKDz40JRaTe3YBQGxXXNDB/2P3TnKZyP+MUf6kjHF87hC5bCJh1j8e0aK8UaXd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=X7DSqOwmAcxIiCt2+nXcHu33pKG6YdQi8ZCCjwBSaI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smampHzopXrkLgeaYcDFW9Q59TublNL6bO8iUM7moZ5hICphbFvaB4eOZKz4CKfy+C1jRckJ+Km5gDavAIwYLa6tDXyrwhiUkcnu2wQw/6D84+6ZSGLXamwGqJQ/vw00dsMt0LpfXDEUDf0PeQ4J95sN6+Jl5oSMAVZ1pik7HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/svvv31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/svvv31"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 459F4C2BCB3;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568583;
	bh=X7DSqOwmAcxIiCt2+nXcHu33pKG6YdQi8ZCCjwBSaI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c/svvv31/3dySZzoA4DrnVbp+z/jBTQoUUeLDBF/WFqokVCT8GDLHO3kFB8ltC9w4
	 G3wUf9M+3gV2fiuRQZcZUPuGu2I+ZmYzu0AJrykDg0PNg67RP7Z6MJ5uAgCU0EXv7R
	 CqIFv/HUMMRtI8Md+yy2geZ8NHtRbXtDSoEgeOXcYyRMwtwYYVy8g9Ru11fkwI+B19
	 aCy1I03xWTAehMf/vjxr/qL9eHUfia2CAlr4LD0Cx4q1gLLVPp91jKOP8mDlQk7hZV
	 v7cs4GcNFrYtqAzJSb4/MrRat6qXgxDvBVjzuo5HbSCegk47PR9/fdbvr6OMq1T3nn
	 jHEJtbHiMvoqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314D1C982C4;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:16 +0300
Subject: [PATCH v2 11/19] dt-bindings: firmware: qcom,scm: Document MSM8952
 SCM
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-11-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=1326;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=OEY+8HQ+THyf1oFhHKgv6oxkhWtr6anAPLLMMsQ2ZwA=;
 b=JFQmYzTMCmZs6MQrVAm2QJblVknQeWsTRHYbbIIBess8d9dffHU8hRrAwir0ji9NCJDNFQprD
 BQXfCW7XdNzA88oF0kIkGQJ4o5fvzpGFyIjDhbJf72+S1VJhdlr2jDZ
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the scm compatible for msm8952 SoC.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index ecee5aef65a7..40a267c54b00 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -45,6 +45,7 @@ properties:
           - qcom,scm-msm8660
           - qcom,scm-msm8916
           - qcom,scm-msm8937
+          - qcom,scm-msm8952
           - qcom,scm-msm8953
           - qcom,scm-msm8960
           - qcom,scm-msm8974
@@ -153,6 +154,7 @@ allOf:
               - qcom,scm-msm8660
               - qcom,scm-msm8916
               - qcom,scm-msm8937
+              - qcom,scm-msm8952
               - qcom,scm-msm8953
               - qcom,scm-msm8960
               - qcom,scm-msm8974
@@ -199,6 +201,7 @@ allOf:
               - qcom,scm-msm8226
               - qcom,scm-msm8916
               - qcom,scm-msm8937
+              - qcom,scm-msm8952
               - qcom,scm-msm8953
               - qcom,scm-msm8974
               - qcom,scm-msm8976

-- 
2.55.0


