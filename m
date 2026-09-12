Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4A41D23C;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202359; cv=none; b=sjxgJV5QemCfOLrirp77eeD9R4DzYdCagRFVCnIok2TwyxLefH9sy/cC8eGWJLkyw8u6KIQpbk5hCsL0Up2/140GrtVuTkm8d038rY6P6HF9vke+CxWWJbO+jLIh1HYPjTHZNyCA33Fb2gR1sC6vhtpJdhGnI48I08JW4Ff5tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202359; c=relaxed/simple;
	bh=SGxzZ78zMyAPGfHj+Y/wCCSvNMOZMOTutYr6UmYwbww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEUmYs/BKFvGDfHi7+gOkYRjrqxg7hUljRkVyNgTNVJiAPG1jrOXaWIBNOP2zqBBrjMrOkSaJ+l/oeLR3NrM0YvR4ywRP8MjgGngTyPDP4uSCZLkIdWISGhSovCxW2C8Bob5UMCasFVUlN44zDuPU7NJcbbtEU3OOyh07raa/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcJnV4hP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcJnV4hP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75F95C4DDFD;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789202358;
	bh=SGxzZ78zMyAPGfHj+Y/wCCSvNMOZMOTutYr6UmYwbww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZcJnV4hPZoEUmcUBY/h2oY1NvRUJR5RWSS9wgTbIdLMdL4g1NrWP0mxzIOTDjoMLj
	 C8CbWXqMBxN7xCVsK80tt0ZYqTAS2CqIQMHRkFB2iXId69nKVhqdiZS3YAs/GdhX9e
	 +wJui2cKScV8dIpRdFWfBfPmVSL/Gg8kt/Xz0nmBr5RpogyDA+QQ0S9NLa60BB25LO
	 ntvZNW7LTAZsjscuRGMDDyGRG0ZWHUtEwrbmhVhCgYRQ483qY5RTmOQ4rODqpbfisc
	 nzfetBOZsMhqi9gbcKTAqtFFZEKZOedNqVlLbWZ6I9E9DjD4y8dYQcO3Xx3Jsnk6CG
	 uSULsEW3v8z1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601E2C88E56;
	Sat, 12 Sep 2026 08:39:18 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sat, 12 Sep 2026 11:39:18 +0300
Subject: [PATCH RFC 09/20] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-msm8952-initial-support-v1-9-0e742578b524@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789202354; l=762;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=UXP5FYqQk5LMDz6EEMbHWLm1DRZQe1v+vfaQe/3iLkY=;
 b=bcHzWWSzSSuWF4BYSsHbZbr+ya6y+s5LZoYdg2J+JMsAsGE366QxlPkofMHX7ybS6T0YLyukt
 C+QxDSlhHGiDdpzNwyoI6z7n6RVeKBhIKN5DtMTOMl/6SSn2Qf2sdtk
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the qcom,tcsr-msm8952 compatible.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index c3889f974ed3..a021e4dea486 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -60,6 +60,7 @@ properties:
           - qcom,tcsr-msm8916
           - qcom,tcsr-msm8917
           - qcom,tcsr-msm8937
+          - qcom,tcsr-msm8952
           - qcom,tcsr-msm8953
           - qcom,tcsr-msm8960
           - qcom,tcsr-msm8974

-- 
2.54.0


