Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850517BB21;
	Tue, 23 Dec 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456751; cv=none; b=AzxJPhivo1iA6dnivagyh4sGRqltevOiO4mxOairMLByHMWIh8kb2Srgo9LVw4SmO6LZ9rSVuKsAm78D2OQO+cNsgavw6+NI+3FXT/Efzvmo1nE3Uzuwv8S+Syne1f2Bt8gxz+m6f7tBf3KQykw6PuXRChcFYb/RaUZh4MKp43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456751; c=relaxed/simple;
	bh=Tv4IIxbajJGdC0Qo4tZIq/kiXMWsMML3XzBX/R1wVC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWEiVvRuXc0K7vcBWir0B8hp5Zu9RUw0DyxeruF5pf9+0RH5p7H34n1xcCr4enp4tVmUmca+HxN164MlL5JbFzFpbc5lgQzAxOpaeo4Bu9waFOj9zaeV5KsTSg9Bm8BYOJi1MwafYBpcNOBbrN/XVDLFoeMsbHuQqdbBjIJ+qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E0DD93415D2;
	Tue, 23 Dec 2025 02:25:38 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 23 Dec 2025 10:24:49 +0800
Subject: [PATCH v2 1/3] dt-bindings: mmc: spacemit,sdhci: add reset support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-07-k1-sdhci-reset-v2-1-5b8248cfc522@gentoo.org>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=Tv4IIxbajJGdC0Qo4tZIq/kiXMWsMML3XzBX/R1wVC8=;
 b=kA0DAAoBMarqR1lNu+0ByyZiAGlJ/Y7I8qJX1p/wYpFnsoywTU9g9XUUIyW2CWKGIFxnlYYfi
 IkCrwQAAQoAmRYhBLW6uMnDG3EVZwIj3DGq6kdZTbvtBQJpSf2OGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjExLDIsMl8UgAAAAAAuAChpc3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9
 yc2VtYW4ubmV0QjVCQUI4QzlDMzFCNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqu
 pHWU277YFbD/9FnfELT45pvSQ81a+V+pOmcfKhnGgLnrQxUU/13qf9VwBCKGsfdS/w+jTj2sp8l
 LT5+DQYbQ1NSNyC27NQE96aJ5OAQVhaLu15LASyysu8DebeJeZKUiYT3LAP1tnm3rcNsVXQOU7i
 hHkat94/w1H5XR3UFPsaqj7T3bRm9cF8A0WFs3y49gPfdtN5GiRoAebWzD/m7PG2uFfiDvB5uSt
 +lUKD0BZcGJD6KfOj5hlCFt9mhgS9pc1Q1KpnYfwzLMaTjTPR9H9Ug5DXMTJY8OdF5ntWDT4cwK
 T6AY/8edOmApXZFvJkIX1RWRdJXDnVSuKXgeOFlDD494YjVvLbgoNzIiprmLPcorJQ+VKrm3C1y
 VvlJ0qzMqmKCyZqou6oqNhZs4b/qIuda2/dq0EE1Ry6lAUqbVKZLzdWL3o9iL+hPH6AhI3yumhw
 OjeApM5SUr4FjoCndony47Ps9U87dD5T+XZSbxAtEGH/6gkoYy6p3b/pcHWOM/ZnC/ECPUI49nu
 e72LVXx8lTaGtj4di0W58yV4HL+GmVDmILg6TVICkDGUmbkjBtQfA9rtdLQ8rRiABOuGce+HLdg
 nHy3/jd1bFdigNYg5umn1QhnbruAcHx8Mwu7IjwZW/N/cSIXN6x1AVS8y0OWJypNmQMdP3ulZc9
 6QuKDMNbYIGlYgN0ALZAg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SpacemiT SDHCI controller has two reset lines, one connect to AXI bus
which shared by all controllers, while another one connect to individual
controller separately.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 13d9382058fb..de4e9efeb666 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -32,6 +32,16 @@ properties:
       - const: core
       - const: io
 
+  resets:
+    items:
+      - description: axi reset, connect to AXI bus, shared by all controllers
+      - description: sdh reset, connect to individual controller separately
+
+  reset-names:
+    items:
+      - const: axi
+      - const: sdh
+
 required:
   - compatible
   - reg

-- 
2.52.0

