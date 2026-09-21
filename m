Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC564F93DB;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014753; cv=none; b=kQgI3X+30OLEUY86PLe2tvHZcWKeB/99n54pXL8EaI5JHiCY9v1x2BwGh52TtEQtLJzZYt2S2e59MxmM0nnqzx9P0iRIwbKJYVN67MX6nDMKa2nC4BvKHFMOx72Ocs/9UiXlCFrIQ5JLGYdTxoV/DRx9/PbQlPqaIj+ZL4msK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014753; c=relaxed/simple;
	bh=nP9JBFmDkgEbQVHNr73hEzI+IZ+hXAhU1/AGLWE1Ck0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba1uS2XijdFA/hoiLMICfAh4l3TGiuiM/oQJ4Zp/JfvaqYWrCL5j58KhgKdgsOxIBjfqEn18P0HlDqvZgCOrkxqKgD4LCqBQODiLD27+zD8YXYASTVo6p/LtpsDLR68wjisV5y7PxfJmPtOw87Amv4UIo9JizeACtvBV7EQpe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw8aUJcY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw8aUJcY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1519C2BCFB;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014752;
	bh=nP9JBFmDkgEbQVHNr73hEzI+IZ+hXAhU1/AGLWE1Ck0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zw8aUJcYwtJ5e4I7FOUBhB3crzZg5ZzxAAlUWQ0D+tT0PlVp0JVGkR1BPfQJQ50YT
	 Q7VOm3OQY24Q/+UnDetDEPDw3U3JnUhxuD9uh+Aqmj42Z+ZkgC6X9o0au2zjjXYrZp
	 tAAZz8xAT+ohcJib+SSvLYtu8NiZ2zeaf8WEEVbasM1JuAnUB7Z6kKrlEBDCJySb8/
	 BPFY+H9y+ZT22toNLaxD3b0iSMCj6RFDqEzJbvKW9lkSOFQ3nbAqpMvrkqxAaPsh2a
	 yGGK/cG++vJp5D5yG/UJpTrdcrAEIYjxeIbHx4vHams+6b+d4gfUBpOQSp7W8yyh6G
	 txrJU+k4HyXVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB9C982E6;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:18:58 +0300
Subject: [PATCH v3 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-7-b96fd3fe298b@mainlining.org>
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
 linux-input@vger.kernel.org, Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=1122;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=AJzo82+GowJ1DrA4G+irwKKpUINfQlsq4w+qyJQ1wNs=;
 b=CR+O8eOXF6KRKvbHo5vhCWclRk+uo9iFwNap7htKZyOF6mJ9MdxFR+BdM9fiJlf/E+sL4tesd
 uH4IEOs9GAsDAz0BpjUxeDI+4BhjbiyepRsp3bA6NhUkOiTgxrsnScW
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the MSM8952 and add General Mobile shamrock to it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index cf9d940f7371..e3b3c9b056d5 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -297,6 +297,11 @@ properties:
               - wingtech,wt82918hdhw39
           - const: qcom,msm8939
 
+      - items:
+          - enum:
+              - generalmobile,shamrock
+          - const: qcom,msm8952
+
       - items:
           - enum:
               - flipkart,rimob
@@ -1342,6 +1347,7 @@ allOf:
               - qcom,msm8917
               - qcom,msm8937
               - qcom,msm8939
+              - qcom,msm8952
               - qcom,msm8953
               - qcom,msm8956
               - qcom,msm8992

-- 
2.55.0


