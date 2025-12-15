Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E07334C20;
	Mon, 15 Dec 2025 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834054; cv=none; b=b5hnp4bSfbPnhBZYHMoxQhhX+Nj2dOaj7a6Tn5NRUv5762/HTM0/S8QFTZZViutF6UmKq3OPVrwTA0YhXG2WEQhKMbxbMkjTxocKLIP18QB2uto0kIsod2N0jW7r+SiaCS/IqaOle/oso3kfYZqkjbJfSYy3aqD2Wfn/LWxhp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834054; c=relaxed/simple;
	bh=YVuLGATlN2h9cJd8MQeg+vX5tYMnlfhZMY4/8lRcrYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n48ltT/KU/DUa04w+JCmyeldfT1VnX9s4gfyxvcjcqoBhQGHo/ywPLQA/halhRA7mX1CXjerHJYiYZhoJ5UEhqXl8Q6fFWcZjIZwSNdmaSrUupNZy74SPeaxnf0fC+jE1qhAA7GrEi+Rhwpl7jH/uAb2IoVja+ulWBlardLYrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5vQz36H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5vQz36H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD849C4CEF5;
	Mon, 15 Dec 2025 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834053;
	bh=YVuLGATlN2h9cJd8MQeg+vX5tYMnlfhZMY4/8lRcrYY=;
	h=From:To:Cc:Subject:Date:From;
	b=X5vQz36HGMvOzHuStIBNzaYqpusVlvlkryJEJdBD+7yL1LPHdC4JYdZ875tXyL3oL
	 qaaLpgTBvyB/UCe8mZRPHQpDS+cLGzrOE1hFt6g1fYSwPfGXnFCHGkA6OdsFpYHqgW
	 MYQ3BEvwolJkN0UO2hrI24bvJIJMe00cl/sgRoZljIsM/XAaYxNbWjAjpuKiuq0cKA
	 Fdm6WQs5T0/C2v8SVtL6BTXDfgQCuzKHDJ92E3F9cPjkbeleJ0HZ8ExxnU0A7COGG7
	 tH0h8DRP2KfdoI9iUJFl+fJ4zTt6efUL6uyTktTABQ9Gwh8iWu26OOAtsSVR8/Ctgi
	 ShY5MH4UtQ+gQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: cdns,sdhci: Drop required "resets" on AMD Pensando ELBA
Date: Mon, 15 Dec 2025 15:27:27 -0600
Message-ID: <20251215212728.3321308-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMD Pensando ELBA DT defines no reset for the SDHCI, so it is obviously
not required.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index ac75d694611a..6c7317d13aa6 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -134,8 +134,6 @@ allOf:
           items:
             - description: Host controller registers
             - description: Elba byte-lane enable register for writes
-      required:
-        - resets
     else:
       properties:
         reg:
-- 
2.51.0

