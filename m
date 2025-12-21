Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB5245019;
	Sun, 21 Dec 2025 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766305264; cv=none; b=eVIBByYkWlQgNp2pXs+wMTgFFcHnb3BnPPcDTiVM8HIEJR01lnx58EYtUGgfnMKlNnoEydLCu1ejdGf78yS9Sbc2Q9RwcVCyacq4ZJghCmDEf6xlg3xqN/oeFc9WciYopT7RydlfbVE1t7loSJ5jEu8wRoL3R40ul5AsQuukxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766305264; c=relaxed/simple;
	bh=vEorWhnLPp7YW7ZFYoqUseTPIMHGtfA1RoynKxTuZgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8R2xOSH5XdNlBzz8L5X1hyZbxIkZ95T/sNlZQgb1F0X7M0yS+CW7ClIIG62LE9fs33AF1SMARWpDcJLE/wM6s2L1pcXshoX1X8rmGvZmH9ZqlBWH8NvtL6K8O/DWDmC4S5ed7rWHOEciMiGVL1iJiyT0Dso7zeZekxU43/V/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 65B60341083;
	Sun, 21 Dec 2025 08:20:55 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 21 Dec 2025 16:20:26 +0800
Subject: [PATCH 1/3] dt-bindings: mmc: spacemit,sdhci: add reset support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-07-k1-sdhci-reset-v1-1-6780af7fa6e7@gentoo.org>
References: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
In-Reply-To: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=vEorWhnLPp7YW7ZFYoqUseTPIMHGtfA1RoynKxTuZgY=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpR63WXp1DZdTgz5ZeTce2A5ZzQyE+rrtOAkZ/u
 oLIpCmXWW6JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUet1hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1j4Q//dmpM5t9BNfPvoXxmOFjwe8bV9ABJWEn2i9xJO3pv8ReJIhaHDtIr/
 reNUEaPgPDN+dOPwhQXxYyAfPv2MxKZcvUcjkVwomRU7y1nJSboEsBwoS0jCE3UuZecuWE76cgC
 72tNyaRzuuMVTmOH91VbDgRKolVrukvjN1nwci2l38uzWJ9zxPfmLC16ikTXZ6Yht0ieaxEnBBL
 +JqPOuX8KW3ZY2lRUmAwStJNBbXZWRTVDc++YocGE2hXZxCoM4PZM87iz6sqb87EIT7K1I2BGeZ
 LR2t5rXH14KwFJXBlc4DuQdalZKM4hZKLRj87oMgF1UO8vGVV++FADLal6k1ADWIRp+sty3hyrU
 Dp5aSqmMf5XPY4Jy6/pEbI9n421fG23lI5OD/P3kTz0oiZsfjCM3bC2zyLxsiN4MZtQ4yOEQYCw
 JuB6qVUOCKNvQ+AU8gj4ZMDiQ3XZ5CKKZfzkKeUMs+Y8ENl+yxtw4UHyjlqLQuJU7DVpQXPb4QX
 h3btfjDN22bWZ2kQ4SS+KN3PH1W/MdxGMoE9yiEQeARfor9ei5nuLKf8pL2BtE8uXblncQnnrpG
 Tax51Cpe5JdTP5sPiP5qhfmEiunzCR/Qjyf1Z62IRg+0gMwuWPRWozYXRz8ynnMoqJXHC+iNOKj
 BoZgNdOMQY2b78ts2pGflvonmG4hL8=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SpacemiT SDHCI controller has two reset lines, one connect to AXI bus
which shared by all controllers, while another one connect to individual
controller separately.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 13d9382058fb..322c69b056f4 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -32,12 +32,24 @@ properties:
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
   - interrupts
   - clocks
   - clock-names
+  - resets
+  - reset-names
 
 unevaluatedProperties: false
 
@@ -50,4 +62,6 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      resets = <&syscon_apmu 2>, <&syscon_apmu 5>;
+      reset-names = "axi", "sdh";
     };

-- 
2.52.0

