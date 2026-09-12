Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793C41A4EE;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202358; cv=none; b=r0AFWmGGKb74V3b/YMeCDUW/NUObEC7hGrU51IKvI8dmq44bSC3QRk8vBVPMgp6MvxtTQ8EDtMAwjdVy4+r5megWMG/vGPI+QG8yUFXOMpnTym2vzcpwtAeTzyEhjrzhh82OkadyJW+LHJRJ+DWSMzdalrp01iS5sm/OeQicdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202358; c=relaxed/simple;
	bh=O0kT64kOTJwuDiHyBHnM2gD4dPmv+9xtS2nhSWCx4QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAZ4xDqK5UxVuz/Pc9TMyGs8KnLQNHljMX6QiOXKLbE+Ya6Q3VSxIacB4ykoadM8DpJuvocw9FVLcd91aro0Po0pelS0XdkPgyprbDe7c6GQAenqkdmveLw6/a8WeyaIbHo1TFEWC3IFS99tCQxrMtjIKIgnDMFIVE1SSsOClE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2wuXC/i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2wuXC/i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0700CC4AF0D;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=O0kT64kOTJwuDiHyBHnM2gD4dPmv+9xtS2nhSWCx4QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P2wuXC/iSVJ5bn0B/3MYay/qINm68niTM/Glg0Bb29gIDdSNnz4rWmPzN9v4Eqq0/
	 BwUELaf3vRNKvnUA7zJVG4cIjnfsDKefSG9NLDPKNCV23eT/RM7bOWm/NdDcVGU7Fx
	 h4P1H5z/Y9+fOUn9EwSRpTz+qWSCHDUGcHn/Y7rDzPZ59q95DkBJDjBAun+FFmytGS
	 rcbSk9Hsj6DFZuu0p2/JX2RjXwnxBoUnv/YZ96T7E/bgTCgJ01LkBkYMScOhZ2/fLT
	 lPWrIMKhgzFpWBeHqjIkfvnq/m0LsiOu0ikJ/xPWsVmo840+Rwfrdp9s+IHGkEMW0b
	 DcFxpMN/b3fVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3ADC88E5C;
	Sat, 12 Sep 2026 08:39:17 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:12 +0300
Subject: [PATCH RFC 03/20] dt-bindings: nvmem: Add compatible for MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-3-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=797;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=KPWh3nm9PQmseVb7i0DEMou+AXydIuwF+UdhOvlk108=;
 b=XMWmcJJQTiOZvONwNP2Fc0z27vfW2XM7BgryKDkrLcGwWYCxhIbNgNlTvKN27uEkFjmQ7W0F4
 gyTaFBnj1YiBP1X78V44RhU1VmeSq1RtlZp3MrUSbQfBjLbcrloNpx2
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the QFPROM block found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 566304ed4c78..646f2e8dcf4d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
           - qcom,msm8937-qfprom
+          - qcom,msm8952-qfprom
           - qcom,msm8960-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom

-- 
2.54.0


