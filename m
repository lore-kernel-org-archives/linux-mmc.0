Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67D511E60;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=jqqOu+LMzlsv3xXDTU36Sqyp+67VyaCrNPRSFdzcocdtm/gvhQo/Q/P+PmE2nl91tXTABONwrIhaAVVKv7MlkWhMq9nXv9ddHn5JfkPk2P28/547BfUSuNsrsW0c2fysaQxmQKik6LEmAbQL3bHkBSYeOIRp9dZOC8Vn3O2qxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=kL7kpIG3qA+4AejsWI3BHXBQrYH/6KaVhM51d9C5+XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TD2PxWLc6jfi35QqlsDbAMHG+Nx4oiPdmWBMFUWificU4agievQITRr61dbi4zgal5A05k+5T0a3t7BhB+Z5o0P7ALdwtUbpWxeOwX9pHcPRIVlkKhni5mh+U3/AbSCLo04165iBz85Y7YNMZgjQsDkRuv8AfNey6IuIRA5OFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN4XZ0Xb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN4XZ0Xb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F354C2BD00;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568583;
	bh=kL7kpIG3qA+4AejsWI3BHXBQrYH/6KaVhM51d9C5+XE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iN4XZ0XbH7ZSY5939J76DcOjxQd40aWBMdxb1yLM+X3ruSQRps3dTMB9VbJVxg8OW
	 C5nH9t+vkXxZD9HlpX9spThfWpNfXfXDgjkuGHVu6wVMRulRN1JsWUwlc6zLjCA0jG
	 nWw69bsWGt9psGSiyryMAOAfeI7oBUT8B4ymsPI9jYQjV4sepCpGjSTdWui5NiDrks
	 kOYiCP2DvcPQpTgAAEJZLTWaSMGxuEzne692qhd+yjpciI1+buce1TIG3Xp2hAVhTA
	 B5H86kztNYwWocdFd97ZJI4MT4l0Si8Lq0bAboKq2+5vcrfad0tp9ublM8gg3Kjqlw
	 jNFmQk7lRMUkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19091C982C3;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:15 +0300
Subject: [PATCH v2 10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-10-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=837;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=j1cyFUrA8K2mGnvaltP8lasGm8e1/N+retm6o6lMinU=;
 b=Sd9tzlC4Xu7TGLcWPZSbxF86KgcgyzvvPzeBb0XmLLia8ok8x+YRMBOuc+MkIw6ZdW/DgUnx2
 G+qU3ERkFWRCw3Jz57IG09IrV5ZbH30BPOxo/j/eDslCfWwEk4LsBgD
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


