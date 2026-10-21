Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599155;
	b=zz8a9uq8ygjFLCFLlww/wzqiH/gPRjtsIzsB8ZEskabDtuE+z9XrPAHzOARSu1t+BMwn
	 1KQ5d5cWcvPkSwFZ+7D99iQMTBn00Ip0SQ/tRVTmrdiR8Uhao7qv26HeGedDuK3usukOW
	 sTBWm58deiDUPm1gG/TxzKA8RFvzvZDW8PKfdC24SaEHZ2EzpmuCENAy55a9Nyp30oN8L
	 A+Q58WYoWNxxxlFe7UvuDZt8Z5AViyiCcffO+aF3x3yQ96rSCF8I3LpePfakHEgmbiQnE
	 f/uZYjV+oWUo0Vd3jk4UcntzJ8eQ5J12MwUV62f+yOKW5qMDvRWRAlyQrjjmfY2ggrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599155;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vvkmrz90lF2pcovbtpnAs1y6acEdyFSaoxmdLGdJVnw=;
	b=PrU/2cFWZzcL/KgP+dCpC64cuWFLAvBKmEaorydQnCpXGI7oEvOcmWiSnEQuV6o1Wm6f
	 JjG8wg292VrytC5xFdfp5UVC+50H6l0O0SQH0WcEbz80DIkkd5lKIEdF/3x9KjPeq0Mo7
	 s2FRztjdusbjDLQnsFMF86U8fU19rw9GAzOX8xC5Ehnfy2W/ltGMVfPh2fRjwSFfYcSv/
	 gf+TbXC25sHfpxyip0aEJrV5s6d02MBcocMzGgkVn3+9DYkku+Y9wzZUEQFj6dZBhqa02
	 TBKUC8EFurYAqMh12YuSgD/vB8Ulqgmk6UVaeoYlB2mFbEKdHLQb+BzL0X6njzUlfqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReZIjlQ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489060A3839;
	Wed, 21 Oct 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReZIjlQ5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599154;
	b=WKvc8sv/1/T2+K6MVf7f+HclzXWGlqHvn9Cxwj7JFR2kMPEnZzcyGL25G7Zcns2uPCs4
	 PW+yEqFI8hARZjvzlRyMprk67XELlxfRym5Jpn6n7dZtSayVDHMNQaIRFw0TarTgN8OYl
	 VCydgxg3iA8/zBkWOUJXnZd7uFBUtEwQsXP7U+VdQIEw7qcUySf0t5k9Q9k0bzFi/yQKc
	 svYRRp15a9/xLvYYJXqxPetVSqZ+MhMVB+YG48iID+inivGdn6Txn95cAV5IMm4a3jiZN
	 lZEUTyHEFMOzOgws66f0NpqsPGBOYQj/4pJWqt2hYi5CHsnCqsfVUKJqCy+PqBPnbSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599154;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vvkmrz90lF2pcovbtpnAs1y6acEdyFSaoxmdLGdJVnw=;
	b=El1LWNFxxd2sQaBtt3xe30PqbTyPfUGxGRC4LAsA7g+t5+qDHdzC4HzpvYifjau2dJ3y
	 dGTh732Je3xVSloIXNjDsx+dtB0Xwiu8DqXLq42bJNo2+7KkuFcHtq8UylMxBmtaRLhYa
	 65ut3BOTDXt3c3NF0vF0gsKk3KTC3O6n15Kt3X6sNNuH/2EExPbZNDNZoXHsXmHr239Dp
	 IZTjwOrV3ksWtCHYiOYgaoW+19+q6TDkd/qw6KX1RPZZ4919jNmvb6CxrMdJhiAh7JN6d
	 yef2PDx4kduAJ4NoYkoF4UTAZy79iCdqcYUvU79/n8C5/VGLQ7N3sfgZa6/5WNQR5SQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 360AF1F01576;
	Wed, 21 Oct 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599154;
	bh=vvkmrz90lF2pcovbtpnAs1y6acEdyFSaoxmdLGdJVnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ReZIjlQ5QaDD5UaFxbO+dFihcIQeMa6gsvpNF8gxxE7xFOXOycEG1BXW2XBeL3Rem
	 1YbJjUc5RFgAB84+BUmTVuHYGDVySQ0OhwjSIzzy2niUXt0KmMJPZGZtcWk3UKRA5n
	 HCuFnrnRNNU0cMrPXMsfGrzoUt/q5jG3v2nD80IvLQbqtJ8d7/qoaIo+97XJ8PO4LJ
	 AiAU22PQb7As8Y/UnawztlZu3aQFRTMrTLoPl7Ln2tKpfDsAUeh3/cZY4GVKPidG4B
	 ZqpaxEmsGGKVrN3UzeCqHI0O0L0/o0d0MC5pMjTBPeGnYdS2MhHWSW5lD2UXuUD7Mh
	 YPVs2opX/yLkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5C0C8433C9;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:08 +0800
Subject: [PATCH 11/27] dt-bindings: i2c: rk3x: Add RK3572
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=799;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=Nx7+ntMd3JyypCSa/70viO2nR8hCpuFBxGmHD3dE47Y=;
 b=vZBl8Zt+3PSebnH2r6ILhisukiqHp80fAWguymShkduIHG3cLZaoRezGCGlFih4pVzb/lfVDO
 EGF0Q9iKVaBDbbgmigC8Jx1ymQfI4QjpxwQrw1EM57mcUJ142fiq1oS
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 I2C compatible using the RK3399 fallback.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 91805fe8f3936..bec2b9cfdd118 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -41,6 +41,7 @@ properties:
               - rockchip,rk3528-i2c
               - rockchip,rk3562-i2c
               - rockchip,rk3568-i2c
+              - rockchip,rk3572-i2c
               - rockchip,rk3576-i2c
               - rockchip,rk3588-i2c
               - rockchip,rv1126-i2c

-- 
2.34.1


