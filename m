Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB83E4C70;
	Mon,  4 May 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905972; cv=none; b=F5Uh1gZ0kP19iTa03hCOT6mE5l6duCQp2eJP4zENAltUOOLzOvKsTBcf2P3Ov4kKneuLPVCEXiezM3IirE15LJIjvj+z7ELwWy1c8SSMqmd82e9RQfvRCzARDNZhSUWNIU92ecFG3IlO0CCcAl74i9eGdqziCjgK4xyk6FFWC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905972; c=relaxed/simple;
	bh=FYlQ+Hrk/yzU5FIirpmcykAnWQii+fps/090jKxLFEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9C7/HcKh0QaeSgMc5ToP1lqEydVgNWrV7OUAjG2MI8VvGvibUl5am7I/6dZVqap+yf5Tryat6g1wBcgeVAH9+IYrIuQYvxoDgDxv9wFTfuhmyDe9cLqVW2dgdEsMaIcG3sW3nEPoO6snhK2oOJmSud9Vvkexc/GSKRkdNWgzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ykHhV3z6; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fzAAYaac; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ykHhV3z6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fzAAYaac"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g8PbN56Smz9v0Y;
	Mon,  4 May 2026 16:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777905968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlltQhIVxMyq1e9Ro8ltY+5K8aCIgHvVGgBB+YkVAF0=;
	b=ykHhV3z6oaBEp38KY+f8VJ8xq/RjUUWoigIT0l2zDJCPuAII1Z2cEuCqZsUe6JFdlzwVOO
	wmeG7+t8jPONckJZX3pf502vhNGfqWLVWNBtewNQzUn/ErDFEL33SkgqjLnWyQ3L8qILR2
	Yqr68PxCNCHkVCMzV4ujm9RKf5vxX6HziSP3TE+tcc9p68CSdE9lFUBeY9x8/tFlJn6o9L
	k/6+I+xjwXLJwDmXslFs1uaMgXc9ce1qpY39mBduamE2DQ84PD3Ex4y8rkWY1KN/5a6k48
	1tXObpKBMvJn8LdAelWLjlq05VCwvgKdU72s2oQjRYqSgCqFfIoHOA3D5OL0iA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fzAAYaac;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777905966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlltQhIVxMyq1e9Ro8ltY+5K8aCIgHvVGgBB+YkVAF0=;
	b=fzAAYaacp/GBRhDAr2uRp93/ep2GDcqzlZYiBx6cBYGFFxY/p+MMYlLJ56Jvgo+tZKe4zi
	u2OxCv8ELZetLXXxJXa6CpaSN2psTuNIag/4ig72clqektIgEXnznf/zGFPMGzneqPPo0B
	eAr41jI7IA6/IUW1TsYNFziL6vZYTSGrxpS99LUNO49eQ3T8kWZSJnvfK3SH9MN9QAz48z
	AxLPfWZUUixvP9Bk+vYDS2ZsKVXNq4wUB8rh9GeYdCMMvmJn2CLVw4bZTwGMQFb2jhVxLD
	dd1sMASq/HwqCEU+i4A2toe6lDiBV9y9uBXFgQcrwHwvUGwyL0SxtTsw36SeYw==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Brian Masney <bmasney@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 4/7] dt-bindings: soc: renesas: Document Renesas R-Car R8A779MD Geist
Date: Mon,  4 May 2026 16:43:26 +0200
Message-ID: <20260504144534.43745-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org>
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 90dbc4e7c687e2116e4
X-MBO-RS-META: f1nshgbcpf4ioiirujq6fmkunfwxmjb9
X-Rspamd-Queue-Id: 4g8PbN56Smz9v0Y

Document the compatible value for the Renesas R-Car M3Le (R8A779MD)
SoC and the Renesas Geist development board. The Renesas M3Le SoC is
a register-compatible variant of the R8A77965 (M3-N) with reduced set
of peripherals. The Geist board is derived from Renesas Salvator-X/XS
boards, with adjustment for the R8A779MD SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Brian Masney <bmasney@redhat.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Add AB from Conor
    - Fill in Geist (RTP8A779MDASKB0F10S)
    - Add RB from Geert
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 5c22c51b1533d..eeef34e3d7d07 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -473,6 +473,12 @@ properties:
           - const: renesas,r8a779mb
           - const: renesas,r8a7795
 
+      - description: R-Car M3Le (R8A779MD)
+        items:
+          - const: renesas,geist    # M3Le Geist (RTP8A779MDASKB0F10S)
+          - const: renesas,r8a779md
+          - const: renesas,r8a77965
+
       - description: R-Car X5H (R8A78000)
         items:
           - enum:
-- 
2.53.0

