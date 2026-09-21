Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400704FB9D9;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014753; cv=none; b=EQcbwruYUEPKizVrvOIktfexly8Fp0/0zzGTA1aFayREuyu+PTC2R8wybcBnXf/6gQWGiRaME07NSuMnNNU4dF07+9Zp4FyQP4AIL81HSNgFT49tiy7pbeE88KaQSoP/oYwTBaomjEl36lidBzvYSVZjeGmJS6wW2EZ7l4D9xS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014753; c=relaxed/simple;
	bh=hMjOLXi4WnOlJoO4+au9mXBLP0X78laGn5iNJX8n4Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uz264CTZrvZebrv7xWjbLDNxjePruHWjvUV719iv9JNxCKM4xX+vjiRHMz7wtxCwoWzQVev086p2hs8GJYoLXZanQV5da3FfxiFlNegRt6CcJTSechCccDJMLFjz3iKiEPz6IvZdZmNFqmgLCB/TSv+7Yx4IHUlLbBSwSUvE+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCJhmdzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCJhmdzB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8587C4AF18;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014753;
	bh=hMjOLXi4WnOlJoO4+au9mXBLP0X78laGn5iNJX8n4Zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gCJhmdzBI4uafFPyvz/NA5jy3K4661cIKRLEWqXYA66qeSgJqV9exOmWUA0VKDd4l
	 +nS8f3I20mvJabkMJZBRfF+nSWZq7QTeGaeN2Js0sXnvyO1h6Zjv2jalUzuDfr7iJW
	 8nU9SsI9fjMBK7Bi/nGUrfJTTJRwjkw6YnycAMRWez1naS1e6vg4WrgNx5JYzZ/8Tl
	 4hZv7+4h31dCR31KsN/vO6U0cVJyUZYyL8iPbiZE9Ke+xmt7C5orR0fWQjm5oUBWxD
	 x1RI1gNLVtu8xzlVPNVHVLLdxvoL/fHUShCNi8sYKdKc4E80o8x1A3rW17OLV0nVvJ
	 HeAaHHqUr1xKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB94C982ED;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:18:59 +0300
Subject: [PATCH v3 08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-8-b96fd3fe298b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=899;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=0sCdnuV2zL4qFCD91/lsOBAdGEuX14F5OA12mUrh81M=;
 b=3wp/HtNlPzHfkvZaPzAf7wFmwQ5obdI7/17EfTPBGkMnmfiGf52VEGUMHqnrOE7CV5nhJqmeY
 Rd0C96WIDoSDfuPn3kcGfviiTLQElgFV64SsStjh2VK0GOAXGdTrSHl
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8952 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 93a489025317..9952b9da9a6a 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -27,6 +27,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8952-iommu
               - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2

-- 
2.55.0


