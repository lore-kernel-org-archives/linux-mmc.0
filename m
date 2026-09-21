Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD164F93A4;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014752; cv=none; b=t/zbzTwMtwQ5ra0D866GzuWGr0/muzd1YVJ8bwtwaLoo+kvdAq7izE6dvn8bXfBbmu0QeB9WciLCIKc8kXpo4TP3Mv6zjUmY+9Y8EXMpvrUItltjIW8HOLLzZGYSDoOYIMtFv1GgEnlp9KM5UW633b0B6m3Qp+Nm9W4111YEuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014752; c=relaxed/simple;
	bh=ctHaSGcvyw3H8wQm3ii/7WZwBxWZ9vwphTZ5+6+nWy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZ+ef419dMKRsNFnr7B+L4oMw4G5MAF+UQH5PEJWhTq1o0AJvZRLqVVvpT/CXvCsx9dmy06UVzEknZGL9L6z8X849q5q7FmFqE9o506qWa7G1/RJ2CDQAPC4GPQS55hfdcjbz9HbdBhgot5ib9wlr2BthnhxlmYiXpba5vyM7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzdMzOkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzdMzOkN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83FC6C2BCFF;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014752;
	bh=ctHaSGcvyw3H8wQm3ii/7WZwBxWZ9vwphTZ5+6+nWy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KzdMzOkNOyXx50B/mZAp4Sr3zCItKvax/K+/7to3JTSZmuEkg1Fo6IXp/QiZJKhLE
	 XlfgK9Fx7h8GzEkjNVF5OzQqudxluLBsMXvjSLn+TjAUMgNcJwXhR0wCWb5c3UD0t3
	 zmQluwH/ZBvdatwRj30JuTC7k1/JI3j2yEBULT08SuwWm23olKKXxHCNqH+h8F6PtJ
	 /KFiKIboebz8ab6lnzRlvfqJN7KkfD0qVeE1ECPHB3EKJlEtcer86q+5SOXnOO3+OR
	 PjS79Zr/bqC8g6O8LB9V3V0I8k9tX/YXyQ73mkP8a3mg1GoDES2DbVC/CaGIRCMzn4
	 CIDWTjE8Chbjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E0C982FA;
	Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:18:56 +0300
Subject: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=861;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=uQuDsY7sKCtxhxupdBeZKbofdc/eOc+AEju250sV/h8=;
 b=5bo6Glg8xIDB0IqcOMpsjfx6TEdUNtAcAjWM6/Eh4Z25sWgteEFdun/P28zIXLJvbvsvxvCxQ
 F2N2run4UfSBrJoz80bZGUEy3gF9319Y08wgeBv0AX3+8jRewNt1abb
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the compatible string for the SDHCI controller on the
MSM8952 platform.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
index 69bd44e65ad7..9d4409c958fa 100644
--- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,ipq4019-sdhci
               - qcom,ipq8074-sdhci
               - qcom,msm8226-sdhci
+              - qcom,msm8952-sdhci
               - qcom,msm8953-sdhci
               - qcom,msm8974-sdhci
               - qcom,msm8976-sdhci

-- 
2.55.0


