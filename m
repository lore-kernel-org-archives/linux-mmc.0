Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36033E7;
	Thu, 20 Mar 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506571; cv=none; b=RXweGGl+YdqM6vBQmjdl2teh/YQsYec7Nmcvb9+ySTyut7DGCdvI7bofn3aB4JEDHPMIQIMvw5hTVC4Q9d7Ci9vBJxWqZVU7VWOiIqrB5ehzsNPxqly/vHX7tVlLzKccNpPqC0EAka+gMDOBoUAY+c0cVughtFVJG5QSzjHYYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506571; c=relaxed/simple;
	bh=rN904yvS6LUlvzNs7MUBSbq3Pe/yzlAlW1Ee2nN1rdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ga0Y8UoR0wbLR9GiTSS6vr61Ne68X4n+8MO4bxbXRltbz4N1DonQK49L8w2/TO36QqfYeRW0LDoZygUaDD7BbNo4LI/kqMQDZ5lLWjHybO2kqdk3jKD4nR2xyg2Pe2xtcO6zrNOKNWtQv2iZtuAIZm5qboK+AznbNJvDIdCdSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyYdHh9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyYdHh9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A5C4CEDD;
	Thu, 20 Mar 2025 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506570;
	bh=rN904yvS6LUlvzNs7MUBSbq3Pe/yzlAlW1Ee2nN1rdw=;
	h=From:Subject:Date:To:Cc:From;
	b=GyYdHh9lOr7jWf4PAtuaJ9SYeN7MlmEf7AiOlsa2g6LwLZJO+GKTJLbiIjNHngdWK
	 y1/7Az4tEDsJtkWa8VTyfu7DzukNCIf6xKaZ3+HbfAK4A9VzqvV2Mp9GESrpdV7jpn
	 N9IoY5SqoGPs3dqFsPwcs5KbcNexVKmbSTgArICYiTShbCJXeQXG/STpQCHs84W230
	 NsWGWRguFwZ655KQC78xSQfwnwwxn2NO+ejzpz9xpGS9kt2gjKbNVvm8xCCslljpQB
	 VUX6Yz79YdZfdG5dAcpVwUXx4wc517FNSbzyTmpTQAS5wBGYaOMuPRT4BvuF7MAc9K
	 /ENmpBYCvbLYQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/3] dt-bindings: mmc: marvell,xenon-sdhci: Fix several
 validation warnings
Date: Thu, 20 Mar 2025 16:35:45 -0500
Message-Id: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGK3GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMD3ZQS3dzEorLUnBzd3NxkXRMT46QUAwMzA0tzEyWgpoKi1LTMCrC
 B0bG1tQC5yHL9YAAAAA==
X-Change-ID: 20250320-dt-marvell-mmc-443bd0060974
To: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

This small series fixes several validation warnings caused by the 
marvell,xenon-sdhci binding:

marvell: mmc@6e0000: clocks: [[4, 4]] is too short
marvell: mmc@6e0000: clock-names: ['core'] is too short
marvell: mmc@780000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
marvell: mmc@780000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
marvell: mmc@d0000: Unevaluated properties are not allowed ('sdhci-caps-mask' was unexpected)

Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
---
Rob Herring (Arm) (3):
      dt-bindings: mmc: marvell,xenon-sdhci: Allow "dma-coherent" and "iommus"
      dt-bindings: mmc: marvell,xenon-sdhci: Add reference to sdhci-common.yaml
      dt-bindings: mmc: marvell,xenon-sdhci: Drop requiring 2 clocks

 .../bindings/mmc/marvell,xenon-sdhci.yaml          | 27 +++++-----------------
 1 file changed, 6 insertions(+), 21 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250320-dt-marvell-mmc-443bd0060974

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>

