Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795264995;
	b=hVHSCUBO2lFS6lpLkRi9xtSh8X18gQteJBNEF0eX0PjvQN2dN6iRv4XzGdbJpFv/Pyyp
	 KZ1ourLzze7ixsuI+lSjnn9XdkxVPPIw4YkEKAbbdSvDv+PbogR5wsAuAzB50tFq31xGJ
	 OUC39gnIhTacyZOGcqqxRrwSPtLPBeq1MzQqIxyKO4OvJEtDzGaipbJOvSk8MmzjTHOxA
	 dOfUkDVdMyfYy5XeZGlz1MTAYpw0Qev/nc+2YjUvZqVxLsf3fyrxU1dSkWMwO5Ggm5mug
	 SdeApLsEDifNvb3ARh+Ll4jodWbn3HSKK2tcbUyqKAQs6Ny4c5kBaAMv9TO8ALagfSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264995;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1yuakmTQTH2nDMkgihJWUJR+XjzHNUnODXcOI9ROkNg=;
	b=XFlrrc/vUjZgjNzYlO/c2/rBSjtMY1wfVjTrByyvvo+uYViTcxhKbMCKRBUi3RnefoAW
	 UgICt2pg/nbEFOHevjvA1hMg0DgNsqYENPOmQ2X1T9loDyIwP1KxyY+I3Z5t15fwefc2A
	 gXafblWZ644FTs9HQ4wH97UaMEF48iVEUda9qqa+JSwk0KHI40jdk8JmoBP9QyqzUhYki
	 HW9a1lAf3WzOOPGUkLzLgAB3sh/0Wg+VEgLdwFMt4869uM7EC0hrFOqWBnLDGdmdE7lwb
	 4iy3EpFQecfCyTIZAwDBO7TSZeZ82NOOBogv6BiFBtdzoSHhF9/mfv2fmgl+OIprlGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtKelhFb;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C95606A320;
	Sat, 21 Nov 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtKelhFb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264994;
	b=syC4y7fC3UMUnV3qLtg/1PVeDGDPN6Ghj8vIrSKL8MeYtQtZarznEuwbIitn3Dn4u5ng
	 b+SWR8okkANr29fK07aTPYZfydp/vm2k2HUlOnunXzMWG6F8ccIztanz/90goMReK3XZb
	 1bkMQZU+iCqMfuM0wha6KEe1qsYU0LQEDHuBC4Ekj43iw3gbYEfM46fiqBuLJHgl23/8L
	 3DupiKG3L9oF9WZ0IesHqjBtd/yluzD4fCnXX7wIO+BjnNSn1mdMsnPAmmz2adnj/DY7f
	 98i+6DOgu4M0Cyyzt616+23PKPz45/V7YuVPHvmStA/mhQr1MXQZy9XqX/kLD9gPUEg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264994;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1yuakmTQTH2nDMkgihJWUJR+XjzHNUnODXcOI9ROkNg=;
	b=Zm+gX4IOIieiGo4rxdBCu4G7gk1YjbA7JKPWTyogwMBIFmpIygnMQlizgTNqQogKnx79
	 KOqop9+UR95NbIsEXeLUGmX+xFvvh9b0LhHcwXjFOqUCZa2OZAB2WPmLRvUVgRzsHL5fw
	 2gpEOA2+MtN2E7eM1MOenvKgdb0/wfwMDkuZ9NFoW8PcbcbSp/iSL8ROMeTg03Fqiy8DT
	 rpDQTDiw0AabMMPXcv7X/4eFq+tCoboQQqzCNr7v7D7t4oFN2ayKksAjeE5DrlpBm4DhO
	 6IaANothrPwA15DARLXUktPzs2HN3cnYLSezF0wubIj1tosVX7E0xVbK9QhjQcF8tUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BDC61F000C0;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264994;
	bh=1yuakmTQTH2nDMkgihJWUJR+XjzHNUnODXcOI9ROkNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QtKelhFbc/SDLCCr/emMuEHSq1hudODoU9eYLLumjbE1xbNm4jNO5lLM7zvWx5MPp
	 xXTTD+xj9jHq24BqaagF3SUiAQeuQa8VKEpIiIoBZBktmrH4A8Bq8JPijzUHTwK/xX
	 /sVQNa5bKBEdYegY0VWulYCi0bpyiLA9tXHLsAWhKFmbymdZ+lcqoNQrGsot1T6mri
	 CKqnKOGa4A7GcVU2LbZV7ABOYGEST1IojSfv5R08QEWjnQFcw7Q9QkPFnCsXBnh1qa
	 1U82O6dqPi5E4hZCs6TTKHRYMjER/EpXIIzrvOyMRGH+XI9m1ZS3Xq2z/JBOqlzXzN
	 CWV0a43uPdAEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 004964BC28;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:11 +0900
Subject: [PATCH RFC v2 01/13] dt-bindings: vendor-prefixes: add Yupiteru
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
Message-Id: <20261121-at550-rfc-v1-v2-1-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
In-Reply-To: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
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
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=853;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=iTb2YlDC2bx8pU62e20oqkil7g9/9I3ZNsd6Gavq2p8=;
 b=l1YtOmr9CaFokZU5dpeyq/EVoMqxnwB90l19866gxNAwwvsVxpoZM9f+hkdODTQxJVZV1+iyg
 POP1Rn6jT+MCi+07TxTe5oOi1aTSOsHRAL1ee9s2Ap7LzWBvyNfrOMh
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add the yupiteru vendor prefix for Yupiteru Corporation navigation
devices.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f9..a8927fea3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1985,6 +1985,8 @@ patternProperties:
     description: Shenzhen Yashi Changhua Intelligent Technology Co., Ltd.
   "^ysoft,.*":
     description: Y Soft Corporation a.s.
+  "^yupiteru,.*":
+    description: Yupiteru
   "^yuridenki,.*":
     description: Yuridenki-Shokai Co. Ltd.
   "^yuzukihd,.*":

-- 
2.56.0


