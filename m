Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B542E8DFD;
	Thu,  8 Jan 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894819; cv=none; b=PlF9mVPYMX174w1DVyx9i3jbsy7Bl6sfLfaSwDIf09I1AnXFJjPVE5XSMAq+Ycur6GzT64r4BcitJvuSFqmrnVwrmnwZzZiraUKqk7ZqxzXNBC3VacktbjWA5cD8CKDFBRNOdswKkP4x+3uELniaT9VDDZ2XTaVzZbAH5rKzbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894819; c=relaxed/simple;
	bh=6HFnUhWZUEk2RhQKjWWeyOvTXPTWq/QyXuHiHZxW6SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XD5Ma81fINWdfDdRcLoEMjX9+En4pPKyhNXoycRl4n2fmRm/n2CU/ZiXoc98D1wz7jx+HsqzcxJ70Bmum+jwTN0ISZK2zbLfikJ4peUskL53JyVXsRVdGn6qchhA5TWASduD9zvSCg5anhHvFYbjgD51d1zqzyQG66IK5vLIjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR53mHtu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR53mHtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3951C116C6;
	Thu,  8 Jan 2026 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894819;
	bh=6HFnUhWZUEk2RhQKjWWeyOvTXPTWq/QyXuHiHZxW6SE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oR53mHtuR+WC9a8UxTBOl0S0MXXcm+UnxBwAqixphHrAt9JEv3haRYXjPBWPQtXjF
	 nUFJlqMMkFT81PQHYuX6AdlJrvU69Trlo658AJtnz2tprI48DKqWy/FjCP374CHkEb
	 zk/l05dYUw9ZtbWjtUGuDjlq3At7y8NIP3aevNzhd8DDQG8cTabDGi2AsyOovnz6jN
	 s742reOiRQPzEm++Hu0+2QR10FOxqYz+d7wvc7eauYtL0xavv5Ty6kdYFbTJMizdA2
	 x4RgllNX/96v50bQpeIL3fGaOcQMJsLd938KjTRIHvPpa6CXXQeXCHnXBpd/0GQH2R
	 44MIYPIHlGQ+g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 08 Jan 2026 11:53:10 -0600
Subject: [PATCH 01/10] dt-bindings: mtd: brcm,brcmnand: Drop
 "brcm,brcmnand" compatible for iProc
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-dt-mtd-partitions-v1-1-124a53ce6279@kernel.org>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
In-Reply-To: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Kamal Dasu <kdasu.kdev@gmail.com>, 
 William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, 
 Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
X-Mailer: b4 0.15-dev

Some users of "brcm,nand-iproc" include "brcm,brcmnand" and some don't.
The "brcm,brcmnand" compatible is not useful for iProc systems as
there's a separate driver for iProc. So drop it as a fallback.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index 064e840aeaa1..3105f8e6cbd6 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -66,7 +66,6 @@ properties:
         items:
           - const: brcm,nand-iproc
           - const: brcm,brcmnand-v6.1
-          - const: brcm,brcmnand
       - description: BCM63168 SoC-specific NAND controller
         items:
           - const: brcm,nand-bcm63168

-- 
2.51.0

