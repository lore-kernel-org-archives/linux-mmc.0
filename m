Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774419;
	b=dCecR1nOnpiOD9z1+rTFHmk8kP665X9Z7/dqG67W3uYOVdpKqJlGutdiTHcYZdQ1FK2c
	 irZ9VJj6LcmkqFvxWm6wrtgwU9anuxWJrWAQKUWgmVY6FNvXrrym5yw24YybO4dDb73Nt
	 UrCHyfspiw0OcoX7CKQfWvtUzfJXkRJlNAiWL7MyexY6lNytj+U7UtYDQcBvHjyH5CUcz
	 5tTCjTqTcQEaL+Y7/iFHXFwmhT3vyu5uWt3zmsnlY4EWhd25w4QJ1cK2VhKuX8iMEzTfC
	 NBhMq5KWmSu/M4Z7F06bXx5jc0Zr+slv/9y+dJfCt0v0J8qfSCIUI448d1Nz3JMfzug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774419;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UwDf2Dx9TN53qcF3/Abn62i/4UVSHTAvMalmNjk43/U=;
	b=4ijYc2Rx45HJl32zkplJnU+Umw7I5HnfjjdVsuD2N0RHjG+rZOkENYEdjoglXTrPAURB
	 pVNDY3ncTlwL0zK3yuQ6IHet3+eVUe4R+R/m6u2uiKIjGiMbNr2PPL7Pukrl4T+bMD8ls
	 KkctNw/csHH9X8nV6GYkMcwmSlkRPN3XqLdul1MhtpFhcWdP/RsHDkeP/bjphCfrt+c9V
	 PTGvw+LzLuumtEynAGDRCJdtzt2uv2j3gUT70PRUh05ZtwRqIwgyV/VHnFyl8kvLiJE5Y
	 kXbHRJSaBZjgoUEDfPR5TSq5zXdQO/wedcps3BnLD4MAJYTKsVmwZzW+YbuQATBU1RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvbxJEmV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C6606A6B8;
	Fri, 27 Nov 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvbxJEmV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774419;
	b=Wtrs93SdhwuYlrU6U+7OOHECU1LZlNgtRL/qDTQkU1r1ivw8B0+MNWAVfmHsNkKXxPC6
	 gsbl9jVAcdsjWPjPoZszc7U4k1TOkfPmWszpewHzDbR/hTB8QbchHYqDT9N5JD86xS+Es
	 5GQVlfXL9MTjh8XTdkK2GGKPJteJA79Re0CBFWRS5bHXIOSYMabg1//EcyRi7/vYSDfFS
	 4ZQajHQEtQ0r33PhH1yDMS0+TH8bQb1mcRY+UwiwHrO6fNXKTWQb9MtcYlR5yLXH9TEBD
	 MM4f2Cr2z3fmHBuwoSLtqTZUqpzsGwf8ztKeZhLyNie+7tv+d+u/uTZN1bJqkjLxLAA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774419;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UwDf2Dx9TN53qcF3/Abn62i/4UVSHTAvMalmNjk43/U=;
	b=aD81IecyLIRQnreU278FPiDpIeNBDHSMqFTicnsN5xYRfS8evZo5hhA0YLH9rUIB+mjK
	 CLPYd8niWE6b4hyJMOBoK8Oa42UIkceYGm/iSgzUi70TYkb35GGHced2WMeJn1in9y/8N
	 PoSreBw/mibVWXda1BEoX4RVHnsy8nvGF+EWdKhS8o9rJzrSR1gSLdGE0ICg7eIQQ9cWu
	 0KvM/stBKjTGjvhYlcOt12w+sqeDNp1eGUbcGXD61HbIKK1ymqg6+Lt+nppp9jUR5wFxf
	 SQ0gvYQP8eG8nAGizLIrG6t5eqkO32g30/R77xW0426GAu3ORUllBJ/2KykZEJswKsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3F7201F000C1;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774419;
	bh=UwDf2Dx9TN53qcF3/Abn62i/4UVSHTAvMalmNjk43/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GvbxJEmVL4/2jCQEPOA0aO989Tz9+GaIbwHV1yAEbQ5ljjKf3VB6DVUEDwG5fIugA
	 cmY7jALXNH8m+hYIHQuaG8xGzRAAjB1Ur4u73Hv5eb6ho9WfDPiUJEKB5mo9lSMHdQ
	 hqPnjcc1V+NYeQLW1fk204lEabmm+2ILm8sE5Ov4X+7cce8wvUNWOnNvujVQbdl5IG
	 lXL/HNxl3BUJDcLKWsgnk550dLd2fNuH3QqRly3xaEme7JZxNYiw+01K9zC2KUXiz3
	 nr0rQqhFur5ifYTFgjxCGGnI6e/ARWcLNsFnAFEOJ4AIf5gbPO6J3vw1aUiPTApaf/
	 0DbByBP6BzEzQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C33FA4B6DD;
	Fri, 27 Nov 2026 10:13:21 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:02 +0900
Subject: [PATCH RFC v3 01/13] dt-bindings: vendor-prefixes: add Yupiteru
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
Message-Id: <20261127-at550-rfc-v1-v3-1-f2221008912b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=853;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=65TJRYtIa1YUzw6sl3ctlqKpkKfiSeKHU3m69S2IQzk=;
 b=CdAoOg+4gZ2zZJTbl/tX+mdOwCtR4lvywQNU4aTsXTzfrM2X28LKKgZRByuO/++zH1cBhk5oR
 vJAAaHXPKOfDwIN4+6Hq0mlsvXXQd+m8hEu0wVQA7QkisjVaZWgTaWy
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
2.56.1


