Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803C285CB6;
	Tue, 20 Jan 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873746; cv=none; b=supilsacqMU3dsbWY8CeRGNMUKACzAjSSmgX2CBIdh1O/2eomLtjxSwf1qFujA6lBcMfDMyboOnA0aR1MSMyXKrWPTQKV+XZOl2/UgawPmHVfBjjLppNb9jVsbzZuNyh2F/5Z1TTnurx4geIHK3aypyhsJAk4MfoydArRzvNWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873746; c=relaxed/simple;
	bh=/xLQMDY+Z5c201pwV6drsWJD9hut61CKQg2Ohei6ByU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9Q4YjegA9a6bAob7jLzOJNHmbi2/BiX4p1kTPlo7AwkiaLyzTAms2Q3LEAGaLJFTBOJIL7M5NXeszTK5sLTxIef7zTho3+fz2ozPCw5aCxC+sZ9A/EWzkW4iNZ6ISEKHtmSVtOt8iIHPJ3EpqKGxqMYp1+lpgk3vneITimyutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1lAb+jD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1lAb+jD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F3C116C6;
	Tue, 20 Jan 2026 01:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873745;
	bh=/xLQMDY+Z5c201pwV6drsWJD9hut61CKQg2Ohei6ByU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p1lAb+jD/p3Y44MKW3bTvXJ5NYdQMa8AEUSC5uJr1IAxeLOcLRfuu8VWjz7Pb8B0v
	 dmkyYekGm/JrrhZcLt9e3Sp6VY1uYmG5nAkXKq7YOxFTcSh2erkUivaUNhdjWo3k/N
	 oOzaIqfmAwSbEp/iTpvMeUhcuGiz9P5ErYRZRXqH8EtoASk7vORDUfIFqWWLRJOgUW
	 hNqTnLeNrl02C9Rr+Op4CV7Ov/UcaCyMdL+n06rVylYtg975nDJhU3uv+N8BgIUYlc
	 7vaIZbU0VMcUvHOybwZK7Y9j8Uol8cvpjdTMuUzwRqVI7zgoaNiudzGORTq2VHxeB+
	 f+M4t3L42kWtA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:29 -0600
Subject: [PATCH v2 08/10] dt-bindings: mtd: fixed-partitions: Restrict
 undefined properties
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-dt-mtd-partitions-v2-8-77ebb958a312@kernel.org>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
In-Reply-To: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
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

The fixed-partitions schema allowed undefined properties in order to
avoid warnings when there are nested fixed-partitions.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml       | 7 +++++--
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml    | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 4d79f786fcd5..984823108f9c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -39,7 +39,11 @@ required:
   - "#address-cells"
   - "#size-cells"
 
-additionalProperties: true
+# fixed-partitions can be nested
+allOf:
+  - $ref: partition.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -115,7 +119,6 @@ examples:
             compatible = "fixed-partitions";
             label = "calibration";
             reg = <0xf00000 0x100000>;
-            ranges = <0 0xf00000 0x100000>;
             #address-cells = <1>;
             #size-cells = <1>;
 
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 51fd48af55ec..2397d97ecac5 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -144,7 +144,7 @@ if:
 then:
   properties:
     $nodename:
-      pattern: '^partition-.*$'
+      pattern: '^partitions?(-.+)?$'
 
 # This is a generic file other binding inherit from and extend
 additionalProperties: true

-- 
2.51.0

