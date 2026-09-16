Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF851122A;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568583; cv=none; b=ZrCCJQf0SU5LISrZi8Y4e0HkqCXh/cQ1iJVP2kgMj247L/hNzde+0t5FFxwYBoQO7BafBiR8xpHkkVrwJ7mdlR/kEcbW5Oao/h0S3SHz4mf339tq0+8wYfFaWzWHYaTx/wXerZo/I5lfKH3h74/igdH7NurYogOgO+Whif+JT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568583; c=relaxed/simple;
	bh=ZxMzSJkRAAT8q4hnIB5+u1Z/6/ziiMQZPOtoIyl9iHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3P1IxoEnWd8uAzd1NvbFNlwjheRE9q9sTmfvlXfPtovDmHUFvk/omWC9MA1eEjxVUyxTtJYmJM2qhq/PMenh6pIW6ox4ywNp3LQh7fLdnlHqooS8p3yIvN4IMvPZ2nBpHCr0pT5fLThjT0ew1SAzSIb/GIEXodNVdvKhQluuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDRodZd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDRodZd6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18B81C4AF64;
	Wed, 16 Sep 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789568583;
	bh=ZxMzSJkRAAT8q4hnIB5+u1Z/6/ziiMQZPOtoIyl9iHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kDRodZd6gnJTresbwpA7Al/pmxOc81wqcHfF7sxXnTpuwsZCBi4RhPBpHyiMpCLe4
	 taZx4eZkIAUhBGe8YhIpfw8smLVivHp8cptG5opGIMiAg7YJfDR2fTiIzpqCWYp9Fm
	 Hr2bGaq83gQqXELi8BgbIaUwjtZloUIWF0AWeHqgKo8ZA2kR+DpkG3r8cKtxGw2vPK
	 I/6hZLnbtLaCIRO246+BZAYZZ782rXD0TitI6O6vq1dwxSij0xrkLlmdWYE0f0z5dn
	 qb6TzNsEi68R73JgKeKrr1XfQL/GEMv2+df5o4/5wKuZiWQmtrkGjiqzPPPWAqX47H
	 B3ncaWeYO0GZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A3EC982CA;
	Wed, 16 Sep 2026 14:23:02 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 16 Sep 2026 17:22:14 +0300
Subject: [PATCH v2 09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568579; l=762;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=qeaBGCeLrtM04JD/SV5a/sI/wkX12kN/dQisJFr7ioM=;
 b=4GZxS8t4nccqh0sc4Jny/8OKmUy92ItLBP1t71gGRWV6HupZAoNiHGn5D/lPF2t8gKR1HvCc3
 gBo2bsR4q+dBwXuGbraEBu8xhpF8WZQZ07T8qFfYv6d003mm+gAsZH6
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
2.55.0


