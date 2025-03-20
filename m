Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EE1DE3CA;
	Thu, 20 Mar 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505567; cv=none; b=UmmWoHK7Aur0cPQgZziE5qhsSHqjXXpcFfCuckQsswz9IyekKZr6vELzTGzmq8KMa7o0vM6SBpD2AreXaNTVvhP2o+BnO/SDz8S0RqOXHGhLc+blls/UZpNEzHV4/GIUgbXr9NLuv1Ocu/shrlNS/j6s6SaC0ZZ0v0L/cHidxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505567; c=relaxed/simple;
	bh=otPRo7MmZtMEwZMgORvrMe6BrsQxTxxInq8ef2QgTbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DS/TMBcD0Cip9Z0M5QPYTQO0llZ61TdaMo+zfIlD07T4DEvkp8bFL+80Buba84eIrdCkVQ3Wx+VxkfCi+24T8dfGJw4oMrF/Ni6A9nFIgvFvTMP1r5xTVCNDShJ2OEOWJlJEOoh2aKfKk7QM6UoiR7Y5ip42iDVgHb9jLntoDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Ksx6nB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Ksx6nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBE3C4CEDD;
	Thu, 20 Mar 2025 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742505566;
	bh=otPRo7MmZtMEwZMgORvrMe6BrsQxTxxInq8ef2QgTbU=;
	h=From:To:Cc:Subject:Date:From;
	b=X3Ksx6nBkLL4MQtRy0ldgQlodlZ4OcV9FPmmlmjvRuHMLjiURRJYfrp+vk7Bv/10v
	 xM2wmURnunFDqT64Kh5MPMYwPA7Q11fPNOlQRAGtTjAjAlPr4Ck17zCvE1zihc9Rx+
	 vq1+VvBRkTJbjyUO9k1UlnDqwYFI/BzYW7R0QNip/thXFiWcmHPwoWotyzr+hzTRTY
	 h+kuvrw8KO137npE/AcKudn5gGmfjoccgTbVgSnLrOX54Y+QN51Mo2X69m7x1Rgd5o
	 Sw3eiE5p+FfIWD0GNEyaumWPpH3jko6uSxpRJbrRNt9ORL+F0imzx1dObmXH3+VS0k
	 EAcarm/H+DfRQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Remove redundant sdhci.txt
Date: Thu, 20 Mar 2025 16:19:21 -0500
Message-ID: <20250320211922.1135669-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The properties in sdhci.txt are documented in sdhci-common.yaml, too.
Remove the txt binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci.txt | 13 -------------
 1 file changed, 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentation/devicetree/bindings/mmc/sdhci.txt
deleted file mode 100644
index 0e9923a64024..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-The properties specific for SD host controllers. For properties shared by MMC
-host controllers refer to the mmc[1] bindings.
-
-  [1] Documentation/devicetree/bindings/mmc/mmc.txt
-
-Optional properties:
-- sdhci-caps-mask: The sdhci capabilities register is incorrect. This 64bit
-  property corresponds to the bits in the sdhci capability register. If the bit
-  is on in the mask then the bit is incorrect in the register and should be
-  turned off, before applying sdhci-caps.
-- sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
-  property corresponds to the bits in the sdhci capability register. If the
-  bit is on in the property then the bit should be turned on.
-- 
2.47.2

