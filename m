Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F9511210;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=HEJslvDqehtKHMUzygRFImz/ogtbrlRHb/LdAClVpNhVzKZ68/p0WhLURKHf2hlXB3Hb08Fpq3Ndg7H5NRYS/8rLMSbS4pt0Sj6/OJvT8ysx49H7WMfHl5JbKfytm0pzI4H1YkRG/uBz1oWq5Y0dPj6uWdhT4Kvokej8f7eMbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=eT5LkGareOk93Rj7V9Zm4FI9L73wsasq/yn696PUOww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcyQmhsrRm6sBYJOWsN+OZlRnwHHac8rcBC4UmrZlxzHyWyFDczr8xGxM6o5BEcH0NEOiXCZS5BQ8MXtrUPggQf4l/RWmwNkIa3H7YbEbDpB2K7W2CT7MHfh201yoNKsNzWl3f292FxzHPK8hShSD/mRvDo9xiRy5vqqwphz/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bivo0heI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bivo0heI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5FD4C4AF09;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568582;
	bh=eT5LkGareOk93Rj7V9Zm4FI9L73wsasq/yn696PUOww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bivo0heIW9CRqopRXmed+vMkaowH7ms1l3uk67oZ3GScVpJAI/9uOtcGPSC0gpLCQ
	 QAGihmj7l4bBTXU/kFDEfgd8JhVoT+ryNjh0VVgkZvUUA+6eUUyrA/xIFjXAbT6YCN
	 BPLepOYPzyOe5AY1jLTa7L/eZuqEqkrTgpO2kkRCpKPcKw/OvfGtjnCUDNFXTPYfBn
	 3VDLKT7dg/tOIbBzVKfHB3ebalLn88pbXe9bsGtTOBvJimZcwznOPZQ7r0LLeeRCKk
	 BbXdYnGlaOUsSnLwHpEuyUikYh4JYwku+FAq6qJVQ/+tCBzld87uDw1Bjf1Y19ISq2
	 7RAo9KqfZrG8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF389C982C9;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:12 +0300
Subject: [PATCH v2 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=1049;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=DQpSYfJxPOHEsOBbMjWNm3lqodBpWTMPFkqMOhmenck=;
 b=jz7ecWkwnZM/HdnR8m4zTZ4AagplhUpNs9ASvavoBsfD847uC24TMEIPJ22WU4JaE/ydfflpW
 5zpSTzTG6bcCyZvlWerLS5Dyce2xMH8YexPWDPhV+G6yqdThTyAzIH/
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
2.55.0


