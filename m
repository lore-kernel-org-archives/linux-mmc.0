Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489241B8CD;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202358; cv=none; b=URSMHHcHp6cRwdm9ytSz16lEI+TRmUtLuv0XPTo6xcvTux6/CBn8QGHc/oxiQVxY0u2OOpbBV4l7TaaYUlm73z67sOETtfUuIDkGfcDYbqxI37gEIUOWcM+DSqtBn1dfKOYDSwHfNbSAjP1tERH44Y2EOVFv4OZ7hr+E6Y7WdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202358; c=relaxed/simple;
	bh=6aztPucHhwcfvtH05KLuWDZknFBinjt+ASMvoTJAUkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=An8RhrkvmlHK9Xuql7kUajNMHsbkna1/PAIMdkimn2Cy2PFJo7alSsUX0Tk4toueRg7ehClbEaFFK+hCWfgksCyki8eEGeL7SFZ6oeO8tYK6T3veU9h8JehfUxKevA3wEyKncY3+N89/xhZ36SknsKbBcOlqWD/BeoaeEyA9l8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXczFAQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXczFAQz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D353C4DDE4;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=6aztPucHhwcfvtH05KLuWDZknFBinjt+ASMvoTJAUkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lXczFAQzzArIIxIdFVmrzdQnBgfrhXhQ4M7zUP1N2uZkVth/gPkXGf1LQSDL10OrO
	 zLpLXnLS5b/w8fAcK+cx/u/Jto0/5+jN0mm2uBSmSGEjhuCNmfPd4XMRrqxOSOFlaJ
	 algO7oov0sL0GyMmOMmJiy12TXYOro/Z+Nf64Lh/VrEF/lpdnuBv/0Xa0xKaPded03
	 Y4o/52c2f1TeFoPWw8nhTO53Kdzo4MmYviIs5CkMlnBy9AKtxyHBinB1txAfYnb6M6
	 hrwyYjpjbCABWXTGmyyjPXXnFcizBFXKRtR1s3ANhSjgQt7eSlHouVudutQ6krG4MJ
	 pp8a1Cm6yBxPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25014C79FB6;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:15 +0300
Subject: [PATCH RFC 06/20] dt-bindings: vendor-prefixes: Add General Mobile
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-6-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=851;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=r3ZLJrtM9n2VHMSFrmIfF7hLeBB7OX3rKnjug6/4v2s=;
 b=HjCW1YfrhClV6QDEqd2tMP79zA2T3UvNy9/heINjnpQPnPG7PQc2eI2U55+9ASYNYWq4IOEeJ
 LSKyO0FajxVDp2KCf3ltIwZ+8Kt4jK55TaAd8XZ0d0yyGzrlScJmi3l
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add vendor prefix for General Mobile.
Link: https://www.generalmobile.com

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..37f991d9352c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -662,6 +662,8 @@ patternProperties:
     description: Gemei Digital Technology Co., Ltd.
   "^gemtek,.*":
     description: Gemtek Technology Co., Ltd.
+  "^generalmobile,.*":
+    description: General Mobile Fzc.
   "^genesys,.*":
     description: Genesys Logic, Inc.
   "^genexis,.*":

-- 
2.54.0


