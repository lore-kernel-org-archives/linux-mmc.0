Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774416;
	b=R8ytrXX7MtPTLnst3ig7Q0l36NfGboSe/2GhARf2xbQmC439nD6BuTLiFTAMs7nmUJac
	 /EfCq2eWSfEULRZ5E5zz34iHlBgF4x9AYLX02++9mYUuG3QEKRDoO77zD6Tk0HqaBLWV0
	 rrx5cWhftyyLoma3dA2pq+iyV4eQti1uYS8Dw/8HVbBV4k/J5vLdyrE1ls80moC2tSxzP
	 +eJ/ywxOAox2iUuFjY2C9bUJYA+Tc3X9rV3kr8BUy/VgZYAaPxTkvyKcomON/G9F5oNu2
	 ksqremcYeBp28aEXAFy3CYAE4uHvKlZVylj8J0hMHq+zROj3ryT7CuLfz0z9B460GjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774416;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Dno6YdXon0jNsrWO52jr41oaAToDX2QCmdvC+fBV8no=;
	b=bQsmGz4zy4dQySkMVlTK4YVSRvrPSiDrK2PEddA8rfZ37PyzIH/ZmKdpAsH6TNL3xw5H
	 +nTSjFu5horAzq1OiAWKFCzr/70YmW5QJoodIsWs2rlNq9Yh3Mu5GgbXP7s66cjP+Z7Ox
	 so/MrpX8/RPmzxQpeCwQsVMGU59ejgLqXadCitWYuVbGEX4f0CVtPb3d1rI/FXDdiCDCr
	 aPBRMyyiZUOhmoEr/z21HvaafdvVwVHF3zubfFWEh2eNNFS3lG9Bqs5R/AmcebOKeOsTm
	 8VlUQBOJ0dF95rnDh0dE2iihFltKOsJgfJIm2eTszO6Jg7DQEP9xqQULRxGLfgxP90g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVY9ZptP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934E606A333;
	Fri, 27 Nov 2026 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVY9ZptP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774416;
	b=MUQ9Ry+YmbpO0Wh29g67/3ZBp2aphRPFBZ3UfmBL+NiHixdEITXKU44an6Z16AmbNq5h
	 WNhXCB7emoxH5I8G8rtNfJM2WPrkstUlR1sVAOIjPtKl630AFSqxrJDHIOUpevT0agd+l
	 uPwfAWr81hOdYOzQM9VaNASnVHhE53yTxM46dHGHawHImG6g74GB5ce5FT/1J8y7cdjwA
	 JJR5eA6A+Sg3cWCy5bnV5zBHB2z28ZHqe25nTbDiaAN2+Evnf7HdTgEFV1NSNNOYv5Jli
	 1SURm3ff8PxOP2YIQpENGbn3ODkqb9OuxfoOlSvqE+a0hpZZ7Kihb7N7hfwb2T1JL8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774416;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Dno6YdXon0jNsrWO52jr41oaAToDX2QCmdvC+fBV8no=;
	b=zyDo7pNehUFF2hCQR/plwLM+UaFAXe0ZQ9Vgw76odO+QYtBzpH/6JibtmocWgt4/CbI+
	 x9iBJXfgxUIaVs7iA9R6fE3ulEolvJAjrAwwvKai6aa9h/5GdoGnG23Fg78qw8cSc7XiG
	 zm9C+C9CnrF1e24EDDmE19Zk/7eqOIOHK88fU6AmzhA6qoCPC/QY7NAyx7RNeMk9bckEG
	 yVbgXhmq64JQqCUlUFv/uc8zhOkK1xUS7m2Fr5G53jUAYuvSBQ0ms2F9rBBYXkyJUOWmU
	 +OUxY4DIhkBXfLmuIdppptpF7uLgZwEYePAM4qa3AtdzPi2dLB4xVkdmeyabOkqhLlA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5FFF21F0089F;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774416;
	bh=Dno6YdXon0jNsrWO52jr41oaAToDX2QCmdvC+fBV8no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BVY9ZptPB3a+M7FPJV9EnJDGqdeVid0TCCvCfovAYoNXb10d9SFoNugdE+RGShyKy
	 jUYWiwbzobxoxoxdxHlfnsgVfctXeiFUtpRxlDywSj6m2EmhpPjKVVkLboP83k4TKv
	 bSVSbWHkDuxvRfsc999qnagwSCC+b3uEtRiD7rulRBS2irr+zyMc7rmMEvso7wqfdO
	 hMNBsTGTFcIxL5g1qFK8WWvreSSkqjzR36jXg05M7e1NnS9KZS1CRpaYI8W0Qf9fgG
	 bufl9XfD1dv3gUJMXjD2mLunIXW9DOPyQyuw0H+yvJM+LrtTh8EFHgzlY6AGzOfF4i
	 9nMYxBbeQcb3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E3DDE4B6F3;
	Fri, 27 Nov 2026 10:13:21 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:03 +0900
Subject: [PATCH RFC v3 02/13] dt-bindings: arm: add SiRF AT550 and Yupiteru
 YPL514si
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
Message-Id: <20261127-at550-rfc-v1-v3-2-f2221008912b@gmail.com>
References: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
In-Reply-To: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev, 
 Yuugo Yoneda <yogo.0917.sabu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=1613;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=oTWW7C8LNvrBLMu+SxYnhZaZqTkEn0NaUocQIPGH7ho=;
 b=+iEGAm8OSpD4adNu0u+4u7L4gYDxWwQvrQGCUGtN3+4HqPd2SfH9wuhHTrvgKQKpxv1Xzv/f2
 xlXPbuu42b1CQjWn5wHQ6ywKICKrUTmYqXmISuPQ1FBK2rO1kQNpwOL
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add the Devicetree binding schema for the SiRF AT550 SoC and the
Yupiteru YPL514si board, and create the SIRF AT550 PLATFORM MAINTAINERS
entry.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 .../devicetree/bindings/arm/sirf,at550.yaml        | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sirf,at550.yaml b/Documentation/devicetree/bindings/arm/sirf,at550.yaml
new file mode 100644
index 000000000..0234324e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf,at550.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sirf,at550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 platforms
+
+maintainers:
+  - Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - const: yupiteru,ypl514si
+      - const: sirf,at550
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d73899016..a825b3bae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25847,6 +25847,11 @@ F:	drivers/gpio/gpio-siox.c
 F:	drivers/siox/*
 F:	include/trace/events/siox.h
 
+SIRF AT550 PLATFORM
+M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
+
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
 L:	netdev@vger.kernel.org

-- 
2.56.1


