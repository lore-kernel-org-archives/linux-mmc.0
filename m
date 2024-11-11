Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976F85C5E;
	Mon, 11 Nov 2024 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288652; cv=none; b=UsTCOnh9fC8djPl2o7eiUv06yYtQFbcOZBPtLi9Y9jDTC4PtMrJo/gB2PllnFiuy68YWv3Mgbzqi8FLYN8mq0vt/Ts+AUOzN1DXrm65sVV2BqVBQ00t2+r2nlFQtMwbmuObivEnPI/IkP40ebt4r4ArqUwBphKvJThTtPjE5h2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288652; c=relaxed/simple;
	bh=MSgyfh8JQ8IhWBVSCbM3Kve8T1LhHCLog5V9N7pHy1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiI/wz1TLPXDPRNk34ozjoBYOEM6kGSPWQuEE6AphbNG5ookS5Y+pK5vYoSaUrBdLwh5Lpk1HG89rKeKe8p6UYyfccmyzCFT2ijexEnk0+R1R9y1iIBOWNlUdPgxo3mNAnFXxzOEtNBnri+xO49O/gkRta080nAQWyXNiinLqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E6E1CDD;
	Sun, 10 Nov 2024 17:31:19 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5003F66E;
	Sun, 10 Nov 2024 17:30:48 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 02/14] dt-bindings: mmc: sunxi: add compatible strings for Allwinner A523
Date: Mon, 11 Nov 2024 01:30:21 +0000
Message-ID: <20241111013033.22793-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111013033.22793-1-andre.przywara@arm.com>
References: <20241111013033.22793-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523 uses the same MMC IP as the D1.

Introduce the new specific compatible strings, and use them with
fallbacks to the D1 strings.

Also it turned out that the A100 is not compatible to the H616, instead
it is the same as the D1. For compatibility we cannot change the fallback
chain, but any drivers are from now on supposed to match on the H616
string directly. Mark this fallback chain as deprecated, to avoid new
users to be added.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 8e4c77b7e4ab9..40b83af02c3f9 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -50,10 +50,14 @@ properties:
           - enum:
               - allwinner,sun20i-d1-emmc
               - allwinner,sun50i-h616-emmc
+              - allwinner,sun55i-a523-emmc
           - const: allwinner,sun50i-a100-emmc
-      - items:
+      - items:  # deprecated fallback chain
           - const: allwinner,sun50i-h616-mmc
           - const: allwinner,sun50i-a100-mmc
+      - items:
+          - const: allwinner,sun55i-a523-mmc
+          - const: allwinner,sun20i-d1-mmc
 
   reg:
     maxItems: 1
-- 
2.46.2

