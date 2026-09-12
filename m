Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81841D11C;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202358; cv=none; b=kezDllgttt3CuxuBgqMrICZMZ7MsArqC+c3QO17j/WS2my7drPdmW01gXx9ZUGi/2yGEgcWK+rCmHI5GUWsc7zFT6iGIJzmhL0u6i6e045PukBlzjCg8UGhPf1+6sLgvyumgbpLg/7TXQwcfXWskD/yp4oP/TO4hI8Jjs3VT4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202358; c=relaxed/simple;
	bh=Dhsv6jxnEgsYdsiLMg7sI/bMzu9qrqEvPc9vujb6Tf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agQBg0yaJ8gp3getcR0TmUKnFgruTdKKBbalOL7gu1tWEzA5gNK0v6fTbc5yJsKQUU6V9Hc3XSdWdkmsvueISMvqM3L2N6CiYSDSB5TLkT5tu+6dpQD0OOt3ERDD/rtNMAT5S7j6QM+e/1J/R0vlPoauPhp8sASh/JMiGfR9KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Gi9VSU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Gi9VSU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53E09C4DDFB;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=Dhsv6jxnEgsYdsiLMg7sI/bMzu9qrqEvPc9vujb6Tf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b1Gi9VSU9idVc827MqX6kLoFg9VNAzESDJIv9U1mZrG9KhfZGrq4MIrAI/2kLHs16
	 rdfcBcxZQjFJPbzdk74L057ztylAvztcNP6lon/yjcOM43QM6e5n9IHa+cO9zBzBrH
	 Jgk3NSad80vqCeLeMKyTHUJiY1XWoVEQ0qdjA9gXaWVSTPGnBI1tkQ4DnbX90KeqSM
	 Wu/b/UkFTEjJuITKuabOE+5NOV6LnorFUHc8jvi0ruU0/3Hs+fZbjSPqj5nnGxwBoj
	 SACL1f3r6YZNZcwg/IaohHnifnQ0ZbbsRjdD7QTpchQNFlEYpGxbinimXls3/c2XYi
	 pJYEG/qv4Vi2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA91C88E53;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:16 +0300
Subject: [PATCH RFC 07/20] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-7-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=1049;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=IrdfYEEL5OvimAfTCyeFYw0PIvJN61JxPWVoerUdBaQ=;
 b=TVDUf5Go9nCED2Okfn9stCy1gKxseubk7rRPG7eRimzVN0gejMhc6hCu4pFtrUyI0Uslg/Ya4
 VPwmtAtA7pXD0Aw4A/czbxaOPQH1CbIOR2S6I6E6/7cZjIo/eWXc6qe
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the MSM8952 and add General Mobile shamrock to it.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index eddf87fbd0cc..b611ad40f537 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -296,6 +296,11 @@ properties:
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
@@ -1341,6 +1346,7 @@ allOf:
               - qcom,msm8917
               - qcom,msm8937
               - qcom,msm8939
+              - qcom,msm8952
               - qcom,msm8953
               - qcom,msm8956
               - qcom,msm8992

-- 
2.54.0


