Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937D423EB7;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202359; cv=none; b=e85nQNxIhSmxqj1P/R85FI+ql61Wnepsh3AU8n+Mn2Z3u9bqLTP+S6P26kot/EfInfbHV9NIwJoLAPT+OedggHOQPb/8LflOYKAnuPv0R4KPciSPWV2WPzHi1igq+gtGrxDmpgOYDj4evoOb8iFct0kPuSGCUY4EjePDNMywI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202359; c=relaxed/simple;
	bh=gM8hG6xV7HvUkbqiaFbAzfVdHPBVSRS6JDUjLTZIt2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6+KxZ/KnKJOfqAPCGrxCAP9p/o/nFkGwYXWtwnIzOjTUI44sn5UWzcy3cA3Oop8+CUrhn3KMpsF2CtWRf1xCUb2geBYAAg5UUsWydgM+Zj1hJlaMiDLrPgMgqGzgGcPG83W8cpyVgIYlpFfeheXoo6HH1TFaZc8wKgF6DpdAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQP7qEAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQP7qEAK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ACBFC4DE0F;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202359;
	bh=gM8hG6xV7HvUkbqiaFbAzfVdHPBVSRS6JDUjLTZIt2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bQP7qEAKHeRMUl1hH0MDC7J7a9cCAh8NKn/od9sIQW3Qqur7s9MIoLz49zM1K9lED
	 wk2WyoQsBEmExpBPmQSFL6zcMYW93eBNhgINqZnD+eO5keVyH0fZrs8mkPo0d+vbmR
	 hYmPmhDM+tSHIqPmOxxEaRB7T6+lnlcgBV1Eg1a9bspGZDBBcEllathXWgWBR1Tn7p
	 d9ZAr39TWKRa7tK32TmUJN0XVOAjxH5LhUacvjl91WrtCFV6r91kvX/nyj5XcomssG
	 k+/ybWKw7jotEbXa+l6k4pT6Mr7cjX43L3pvqeq+VkChPBvmRj5rvgdfuc1RrRva6T
	 bddc3dSaEMpgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B5DC88E60;
	Sat, 12 Sep 2026 08:39:19 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:28 +0300
Subject: [PATCH RFC 19/20] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-19-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=1586;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=Qoy33EJn3v6X56PtrYhm3G9p9Sahcex0RkQOCVhpJ3w=;
 b=bdZyKcCT7IdWUsls580MpK+jGBXtthmOOQm6HNiFHMVSEF6gRr/EocPv5cO4TZRwkV2Y2986M
 ppD+uWM839hCCUX+1HyoRAqVC0StePZL2tApZJf9FJXPIhcPKJU2fmt
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

GT970 works with GT911 driver, document it to be
used with GT911 compatible.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../bindings/input/touchscreen/goodix.yaml         | 35 ++++++++++++----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index a26a54d63a1c..4be2c137abd7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -14,21 +14,26 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - goodix,gt1151
-      - goodix,gt1158
-      - goodix,gt5663
-      - goodix,gt5688
-      - goodix,gt911
-      - goodix,gt9110
-      - goodix,gt912
-      - goodix,gt9147
-      - goodix,gt917s
-      - goodix,gt927
-      - goodix,gt9271
-      - goodix,gt928
-      - goodix,gt9286
-      - goodix,gt967
+    oneOf:
+      - enum:
+          - goodix,gt1151
+          - goodix,gt1158
+          - goodix,gt5663
+          - goodix,gt5688
+          - goodix,gt911
+          - goodix,gt9110
+          - goodix,gt912
+          - goodix,gt9147
+          - goodix,gt917s
+          - goodix,gt927
+          - goodix,gt9271
+          - goodix,gt928
+          - goodix,gt9286
+          - goodix,gt967
+      - items:
+          - enum:
+              - goodix,gt970
+          - const: goodix,gt911
 
   reg:
     enum: [ 0x5d, 0x14 ]

-- 
2.54.0


