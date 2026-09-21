Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1F4FD7A8;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014753; cv=none; b=LFAjsAMiz8L/yHhtihCID0tecIuWWL+kIY3WX0vntlwNfsY3s6MOWxq9zF/rIm7BzyjEpnQhulbi4US7kpEiG1VtZ2GOZOobZyMtIYbYPngYCueoyFSDqLBXrCzOkVUyl48bLLyIG7tl2mKuDAxg1bHizhkZ8bZw1nvvr8jfc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014753; c=relaxed/simple;
	bh=X7DSqOwmAcxIiCt2+nXcHu33pKG6YdQi8ZCCjwBSaI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEUr3iDlkNz5INZMamN6Kxl+wRxtCFwDhMTUzZKSLxpwgUlzRGncJUasK0tltORJrSXcaCh1zoowy+5a4HbtF4vAwNUhW9Pi7LYllU0KQ+JcChB/3Mc+0Kq29eAlf5gMvKXbsXCR/qVU+QdETxZ61AfJ/nolCddjdSGrpNMXrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umHpaTur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umHpaTur"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45AD0C4DE01;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014753;
	bh=X7DSqOwmAcxIiCt2+nXcHu33pKG6YdQi8ZCCjwBSaI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=umHpaTurTr9vk3pM8b035xwH/vbJkvVWqsZnRGFwz5xW6leqUBj0k8+3w8QdlAQZn
	 DC6zkZZvQchCseNTY7L6+3Ta3NuHcHzOfcHgSCAaXrV4ozuAn+JXT0WCrmdwgSoACd
	 jMHVpMRSmr/E41XP10AWhglrbClfLQo224q3Hsg7vrCJZ+ZGOutK3HFhLaN9aBifj+
	 sCLEhGXAamAosOhf85LEatdjUimvq8fPF97eILjzYErQc+XUfUrJO70bwK3fKcHqA+
	 fJ09dM2lN7PmhmdX1I90g5TA/636L2aMbX6NKWIksQ4VRqPxZw6ayPTnhs5nPqYuGt
	 hD23DJeU+TlDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F9C982E6;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:19:02 +0300
Subject: [PATCH v3 11/19] dt-bindings: firmware: qcom,scm: Document MSM8952
 SCM
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=1326;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=OEY+8HQ+THyf1oFhHKgv6oxkhWtr6anAPLLMMsQ2ZwA=;
 b=8h2g1OsNVLQZ5G58JlmRNcIUzDJtJFplX7XTNAQKmEmnFCkJLkP35NBDD13XTbe68Xy3K/Sxe
 b7LmDiQhaBlDlh2nqG8YNRFGaVYsF9sg3PIH2TStKZvnx21T3Ei3Zhk
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


