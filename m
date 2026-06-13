Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A632E06D2;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343733; cv=none; b=LkzsVG200J2kpYGz6RZxCEdWVq++mzv8uKiZQIQTB/IA3fKo/spaAO98rCdeJlONwGHKUT5ZQdFdH+AY6JvcW+vbRvfZuFyoMGyWMszfIssMEUknoSRRoeM/Bnyzo0kkYhz/ArdXPdIouoBJClnRSh5EMBluC0xjvxb8PXs89Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343733; c=relaxed/simple;
	bh=VD3wegu1/KUmolrGMeczMtvZsTjBcVy9Lh73wJLBBpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZNLWm4CH8JwH0ZjhgiypWmpDw7i9WHIcL9o2aAkIY3/gieTCM4xPuBpFNpEG5L+53WETxtSXoDQ477wzt7iDvgyJfw4KEeBlDTNZ50RXhYjDd4TcHpdmUVlJ+O1I8ObYlkjiDBLCZ6UNtHtSfxaYX/Mgauaucwt0a6xw1p5yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exP8+YD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exP8+YD0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6181EC2BCB9;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781343733;
	bh=VD3wegu1/KUmolrGMeczMtvZsTjBcVy9Lh73wJLBBpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=exP8+YD0cA8lBIdBRwLwiDtCEtDnpjJgDfXHmfis2d9+mFPDh5Q+sECQjrkW6TX0T
	 pMc2Xu0NFKeDL8dZGosbGz+QiYawrUBntqayPvF+XDE0B2hVtaXYurGjhmLJeoQ/+C
	 ibJuHf8nU3BX6nfvdAZDTtH3br1c7iK2qnTAwEShMR1vaSwVdNSioDKlugdGELN8Si
	 UmzAqGSfu1qt7eblCtiTikeGXQuL1vO41oLkIq+RKLueUL8d+//e9aRvt69E61F1gH
	 B69Uu9nNk45njpS1d/tJX6SR0ocNJcla4PH+lZLVZhMTvp90pHI/kfczcwAcBUBGJP
	 FLtYtFjTIpbrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5030ACD98D2;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
From: Enzo Adriano via B4 Relay <devnull+enzo.adriano.code.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 05:42:14 -0400
Subject: [PATCH 2/4] dt-bindings: mmc: add Allwinner A733 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-a733-dts-v1-public-ready-v1-2-7787c94681db@gmail.com>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343732; l=895;
 i=enzo.adriano.code@gmail.com; s=a733-cubie-a7s;
 h=from:subject:message-id;
 bh=zVJKVu7EGuw8s8oGE8yMBHZdc3RPxLxGeUk2Y5HLBc4=;
 b=OwgC+JN5AxLkp2caqoaunDY4+/Rg7UispYVAhVzR01NX/xGu8rU+mT5ag15avNFEpQPgGL2xd
 w/SSVPmL2kfCkdwUaZJS/7zONdzg2abvndKPVpuP38+mOo01+0S893R
X-Developer-Key: i=enzo.adriano.code@gmail.com; a=ed25519;
 pk=5S3Wmdqa4XfCdeZF/HfeYqnQF8GN9JGt3SE1cxqSX8E=
X-Endpoint-Received: by B4 Relay for
 enzo.adriano.code@gmail.com/a733-cubie-a7s with auth_id=820
X-Original-From: Enzo Adriano <enzo.adriano.code@gmail.com>
Reply-To: enzo.adriano.code@gmail.com

From: Enzo Adriano <enzo.adriano.code@gmail.com>

Document the A733 MMC controller compatible with the existing D1-style
fallback.

Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
---
 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 9f3b1edacaa0..9e9590521210 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -58,6 +58,9 @@ properties:
       - items:
           - const: allwinner,sun55i-a523-mmc
           - const: allwinner,sun20i-d1-mmc
+      - items:
+          - const: allwinner,sun60i-a733-mmc
+          - const: allwinner,sun20i-d1-mmc
 
   reg:
     maxItems: 1

-- 
2.53.0


