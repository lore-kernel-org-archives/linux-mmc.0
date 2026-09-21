Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA74FD27C;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014753; cv=none; b=YVULsyghEgCiCGaTrNXsubSwX3Ti7p7s5kK7WaIvIBXASHkcut/mED7eQXHH5WFrh3TfusHN3R5gddd67k5qGHFUSgJuGE8tEV0PZcDLfd1sBb7277ib23mkR21kChREQP3nmqlqrbyhQP4R76mAZzBCi4AvEXsnVengq7DHE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014753; c=relaxed/simple;
	bh=kL7kpIG3qA+4AejsWI3BHXBQrYH/6KaVhM51d9C5+XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdzd+FMrV63a/Vg1TtoUcknpXAl543Fr7zdRnqwciH1czCTX+tXiA9Diza+/oH/rG0xB2zyfeW3wxiY/M0ubxPkPyijiFiJ7f3lG6s6/Ff4kAeA5F0CYjgAapWzcQ8kqENP+DejbVPu7HoEXdFM1hsBaxWDey5MrEZNWx+evYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7pSdQwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7pSdQwt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C5BDC4AF68;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014753;
	bh=kL7kpIG3qA+4AejsWI3BHXBQrYH/6KaVhM51d9C5+XE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E7pSdQwtBN+vf5f/hhYLeG8xpE0N4+NCALq9uBD5VlncGsQMvh3af8JZr2rtF7Dyx
	 ikd6eSWg6IwdgaL2UKXnlJU52qcsXZbVK9kC7MfnlueZNHsxRJ/Uj6FiR2VWYzEV7S
	 TC12pgH/xVVQPar4Rud3Z6v+TaBRIPuyeWVrQoMNeWSWreW3e6vlzQyW+kou+mLcnV
	 oReDWBMkrqGEHqbrU0AD8Xys1AgGgdO+nZkXnnKCfbt8Kl028ak2Bjbh219yzwPowQ
	 EaWeRkcTKgfTf4NoxVQGL52nXQJZdhVdk148bzkteBWVmn83KZXFEGOhjRO6eYX+Ci
	 +uqUNWgCL3Afg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA48C982FA;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:19:01 +0300
Subject: [PATCH v3 10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=837;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=j1cyFUrA8K2mGnvaltP8lasGm8e1/N+retm6o6lMinU=;
 b=Oz1dz2ZWoRrkM/lfhYIwn4VuXlXdCrNE1OFmUAgmF8wpQEAerYbZSuqZHVhP2np2YFdFeO6HD
 5osVLs6URJpDrK6+Y/vEPtnRtTZBqHeXZbh+19I+KrwRcYqfF1+xj01
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add the compatible for the MDP5 found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
index 2735c78b0b67..2f0a32a3f586 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,msm8916-mdp5
               - qcom,msm8917-mdp5
               - qcom,msm8937-mdp5
+              - qcom,msm8952-mdp5
               - qcom,msm8953-mdp5
               - qcom,msm8974-mdp5
               - qcom,msm8976-mdp5

-- 
2.55.0


