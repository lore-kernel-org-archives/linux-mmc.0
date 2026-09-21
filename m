Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655D4F96B7;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014753; cv=none; b=QL59/ct01AKOWYcNmUlDODoiBYwSK+F2lSWM5ztgA7O6UDNRgog+k4v4QHvHEA8BN6rpU/Yosp+b7t9IyFsDzAwPYgdmkW3CFHvEyGtW90OBoVUcBKFztNMKrSKKWf2QhMyGKCpEDVH1dKrnKQTqardG7zope0fS50fM14aNSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014753; c=relaxed/simple;
	bh=uQxBZuhyzSRvVDvx4PG5/I0odnbN9g2l43BKI3W/H7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Op7ijjNyk2cyzC+4yaJ9GY/+8y8wULlFbTadw+zEIvvzXj3rBaUXLnsSyDfo1p59WH0EAHihCDhlH/Vdjll8qS/Q11EUKs0vAcs5XmPjpe8Vgoe9zoe/6cdxeM9jD+BB6Sn4s8S6tG2FBq6tpiQriuYemAaI4/3rI8On74TmdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmWp52f7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmWp52f7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FDABC4AF61;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014753;
	bh=uQxBZuhyzSRvVDvx4PG5/I0odnbN9g2l43BKI3W/H7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QmWp52f79J9r9i7HjwALgvUJBvBJzUUTNhnafqlpSTNK653PQHaoeV24sI725vUHB
	 sQB8TIpxT1UXb5bvzYAr1WeKvxakBaYCg/qApgC+/y+doXqeoxsrrqMypHKoiBuQIS
	 f1ANayemXiBWyGLXVyeE6Ro4Wce6BrE/ctExV+3n3Rw9PuuF2ibUJNTUW9/jNCEbvT
	 zTBZDsyUVX4YQbM8WvDrrzdQxpL+3/XtFR1sywL7i0bY4D1JEfh/IJwWlQ9plc1olw
	 ZxZbuKCKss2WWmLLS0XjsibKFLgnYUhW4KJ33ZCmWLR1PFXh/7rJ43HZC5/1K4Zkus
	 cvN9pRkCFfDiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439E6C982FB;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:19:03 +0300
Subject: [PATCH v3 12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=845;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=CHNYHQsphKuLRM8ear9uJQ14PqO0HMwJNgURPd6NrV8=;
 b=PEp+BwfKYQUrAQIcgVk3NGd8VQhuG4/ZuLc1L3bk6bGK9kDA9TN5L9SKfaW7UpZgsCanXP/IY
 HMP3UZ9sfQ1CdAX+ULyy+UkLjKCluSLqsyYjJbKuIc4elbdkOKHyUrt
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the rpmcc found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index 17332aa55886..aa532f208f5a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -56,6 +56,11 @@ properties:
               - qcom,rpmcc-shikra
           - const: qcom,rpmcc-qcm2290
           - const: qcom,rpmcc
+      - items:
+          - enum:
+              - qcom,rpmcc-msm8952
+          - const: qcom,rpmcc-msm8976
+          - const: qcom,rpmcc
 
   '#clock-cells':
     const: 1

-- 
2.55.0


