Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF424466B;
	Tue, 23 Dec 2025 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456785; cv=none; b=GB/M0K32l22mBY8ycwXGB/n2EVQS8+UFXumSwbDSR71+ouMbOtbdaUpO3rldD8bNnlVRJYi63yzKRixZXq6EVxh5SPbT95QK9b2lTXGK1R/aBqccI4uybpHetE3xmugSSxbxY2n4RMVisSEOX4stg4SnwQPmmZo2GhP9vS4yx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456785; c=relaxed/simple;
	bh=WfOYufxvp5VMhrnMCPsjsrXQPRkHTzjLxnD+Xz6ivlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhqUN120W6TvSXC/q0078/Pa5uZppIBe/MDt8AQMVMIzFupDbTFyU2NYmaXT6yQP2S2Zpy077/n6R6ZtMaobl/WIU7jhflqLbXflwb4MgTvzZu0ItqIBEZ1mcRlTDwvINZDjxao1mYikjrlbGgO0fPsAFgr5dwWaqnHURZI6D+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3ACE13415DD;
	Tue, 23 Dec 2025 02:26:08 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 23 Dec 2025 10:24:51 +0800
Subject: [PATCH v2 3/3] riscv: dts: spacemit: sdhci: add reset support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-07-k1-sdhci-reset-v2-3-5b8248cfc522@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=752; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=WfOYufxvp5VMhrnMCPsjsrXQPRkHTzjLxnD+Xz6ivlk=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpSf2Uucl1qr5TmUawQcdzR4PIfSp9kyxzSv/yz
 PhahUxU5BuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUn9lBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3XNQ//eYdMzOQ0oNwD8UAs4I2h2FebWTvA52uAR5X/c4zETbSMw43ghGjSi
 W37ngE/k3didWdZtkpkP1ddewJHTwjVWOgtXZ4GbqQ892SgNS3UShz9P8KzcEj3Ip1KIMl01jAf
 CdzreJN/Im3YzRv/+E8gRp0FZ5qy3dXs33gmBm9Ts94T43DFuMqQsUUyxv6kG6y1zwKD3OXY5Ix
 Tt1vfS7WR2/dS9rd6bD5FjU5EzKm5ol/4qoe6Ugr8KD+pc6zjJUBZpgIoifqE5NMv/HZT6KEgMH
 eWEhmwgb1VOoW4BvgA0LzQ9a04IgQcFQ9uNI94/iFW3O5KW5nrGQMbTbzMu5INLOkv+xqY0RIvv
 tqfhG63qLUbVEz/vl5LF7nUUS+2/2Ew3CUuDQn+Y0zdCBD0xMrD6e4sfYaBgWa2Q/qL0aoN/STc
 Y534dyH+YrtUiuxX//I3HtZIsXbyV6F2riQrD6P6sYPSm9BGruACul2uo9/06aoiMSIB5sTlJnV
 geR8EhEb95iELSRA9hNKoFuh35d353FtyF6RFX6dPGD55M3URtJl6TLvlVZ4O5KVsHumUgBM7MD
 XG6sCnocTCuU9jol+SlnyeYxqVHWGpwniXwlGmgabt2sTdBq9OdzlBiLula9myjbbsbr+ilx7Lk
 hXQhyoFwp7osS//19zV9oSMphyj/mI=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Request two reset line explicitly for SDHCI controller.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 7818ca4979b6..7dd41d6dcb85 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -984,6 +984,9 @@ emmc: mmc@d4281000 {
 				clocks = <&syscon_apmu CLK_SDH_AXI>,
 					 <&syscon_apmu CLK_SDH2>;
 				clock-names = "core", "io";
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH2>;
+				reset-names = "axi", "sdh";
 				interrupts = <101>;
 				status = "disabled";
 			};

-- 
2.52.0

