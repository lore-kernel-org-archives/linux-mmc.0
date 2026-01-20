Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341C21CC62;
	Tue, 20 Jan 2026 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873744; cv=none; b=llayaBzaMMknw9T33Lpn7AbhyUhwhPiBPzCyqel36mEnGLUArxsI17RAJPqsIMd2Cun7tveeSoM986UNy0ocqEW/xIVND/NV0Ffm4cKbRkDeyTPCsEWIPLWAHS65RJVRpxJDrvhew+7HVPviIE3WOy/LMOlGuvvatyPHZCMbCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873744; c=relaxed/simple;
	bh=OsjbooI0PzsSGUgngyI7clHgsjttkcXNF84NTeIQn64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZEGtaed1ZyEl6SFzdMqWdb2g0jGE/T5cqvKzG9WGg0ihmu7NvB+s4w+Zhgr+0csNnuVKV4098xVXddSTsYRo5OStTjPJQBK64ZEpajyoS3YKTCPE5pVx+KMJGMAIzhOsK3CLwZ+eGZ37gGuxUr5VArKU97VIOpoBASpQmbOprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMyU05kf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMyU05kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D7CC2BC86;
	Tue, 20 Jan 2026 01:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873740;
	bh=OsjbooI0PzsSGUgngyI7clHgsjttkcXNF84NTeIQn64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WMyU05kfD6wMw3HNL51ohB+EWjX6Q11jMpErJ66tyqDx823smK+VyGSYwd0lpHM1j
	 yHmOPy0SxO1gU5B9Kh38d4kr9FSMTCz6aHhNK0cQdsq/Ewr7K/eG80QD96swb0Jpa5
	 t4m1hdz5rTUxD49SBS2HEs0nq1az6+Bh7ek3qTzV2+x3Sjbl90xU6MecvMMUjheopH
	 n3j4OvlvWVk5s1A1gqL6D0K8od0q2PM2JgFPgd3zUab7VHsCnsHoHI60iBWG1hcuRF
	 AT467ptvtQYTmK+LT7EOEeEtpyKl7T+PkmDvF+f5+DxhIe0cUaw5UU/LpHULSBxA1K
	 HKgtKUhDaQJaQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:25 -0600
Subject: [PATCH v2 04/10] dt-bindings: mtd: partitions: Allow
 "nvmem-layout" in generic partition nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-dt-mtd-partitions-v2-4-77ebb958a312@kernel.org>
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
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev

An "nvmem-layout" node can be used in any partition node, so add it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 568fac50f921..fe2f7d622e8b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -135,6 +135,9 @@ properties:
       but may differ if device has bad eraseblocks on a flash.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 if:
   not:
     required: [ reg ]

-- 
2.51.0

