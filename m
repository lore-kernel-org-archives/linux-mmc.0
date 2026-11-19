Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110615;
	b=y7JwDAEjF1FbN3VzpahX36l4ve0DPj1ZSYkGJZ6UZ/F/PFC6CCp6QUcUWx29N48kJdnk
	 z+jvb2lERpZVzLW47YU/XnLSSJ3ia+pte6LOIYoV61+4NdCt+/dLJZS15o9j7LldFg1us
	 34LCW92xVq8EbhtdPW6j+Xkij/I4yE/Mqi4gWVqn8SReXOQs1BhBu5ctPac6Kaauc3Fdv
	 CmJ+Y5UrZ/IT7m8NITNdTbaD/FQ5BP6NwkFv29Kapy9jNxiYSyH2S30j0UsW1iSURy6MM
	 CLTxXtghba73xJmn5X9uzpwNS2g0yO/bkzTi6G1ERbFbURp/PS1PqWaHp6TzWYuUDZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VaJ32hdTW6OdgBsH5EJWCERCqsHcMt1Z/thd7ws6mpM=;
	b=051eoRamGRm+89+KTgk3E2T+W+v7ao6NnogtF55e9JxI2ZyuB0TaX3qO2vkbNrKnhawn
	 VJ7Mkz77cBPKB4h7Lgyv/lGlNW+4EPWKvMg0PHBSrYbGlwuG0VIfEruCPJd8WkSsiQpYb
	 0COpnLiwS4yU90tzcr8MmM1C7py9zRZbiEl2Yjv464SOToBRJRJY2ppJM/dYnVtd/cpAs
	 qCGBzAeMeKl3rGy+ZYAwN1J8FoFY3Edxd/thjrihEyAY5Kl9y5iTGTKrgoOieSj13dwfq
	 E1EkxgQy07KoA1FlpI1UI5tIE9SWIXgzUnzW7c7Z0buGmUPVkqieE1XQX5jpx+7EaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=g3XD3WOn;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1760A3828
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E1760A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=g3XD3WOn
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a42b34e930so2198685f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110613; x=1795715413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaJ32hdTW6OdgBsH5EJWCERCqsHcMt1Z/thd7ws6mpM=;
        b=g3XD3WOnMdsJFDEykQoDr1yoI2Ub/9w2hyjJixXgE5sY7EuEC6aXaSUX4dGIt6DqNK
         SOHsRGi8PSmlch6qy3qjIgF7U9PrEyx/Jy5IwrJXiqkDYDivx/QbQY78tg96+LVHBKtD
         jbxR3ktY4KV6imDUzRuVrMSdMHEbXesVNc+sD4j4SJrJlCTtIC7/El4ddJbDNzU8+L7S
         yOLiDZW9FtRRJz2KmT4q9auuwU6WN+ZSLQ+aZgBh22Ix7kGanQOsiQW+gJEeCp+2I5nS
         Kfn5BrHHYT2Q4basE0JG9NfGfgEbWJvvk/kaVA/RkyaskTLPbViRN/4qaEOoLdLTYB0I
         G5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110613; x=1795715413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaJ32hdTW6OdgBsH5EJWCERCqsHcMt1Z/thd7ws6mpM=;
        b=YTZB4QZ9m6ewrjg8dHfHpOy35w4u8MSOXCf5CawW/azpJPgxkevjv4ApsgCRXbMa0X
         haX+6JkFMUq15BXLhSwcf+fkbI8t+E9wbrFiSpZDVgP2zmUSV6k6J+XvE3zedwfSrLYb
         kXujtSjWln8L+sN2og2DZwiiA8ynDX8n5yZRrZ5KrWFB2TMNcOsuIu7zUWNNEkX/icGC
         6I/D+18WzMec+XYv50fMJN3DPKgbygMwEdCRpdEFuiCnxGd9puhoCAe9xtD6ON5NlpSf
         2ff7OvzRwgq8bOySyGjsCk1i/aisiLY2S1Gv4GWazwqb/3LkaN1K5Jn+WBEHp9pCULvm
         Sntg==
X-Forwarded-Encrypted: i=1; AL+hErG1PExGHI9CDXzEc9QI9jrfh9TD13Zs5We7MNwLIW20pnqZ49LYl+WFSvjU8wuuu/JvUhK5QQMQWbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9y6/wlwp0paHBc33kQEbUe0PqMA6jtZafSpw8Q50O1gOEn5gZn
	TT4b7itqrROePNc+IZYva1kgUEFRRcT8vZGiMWKtS/DCt8/MQHWuqRGNYw29z9jsbLc=
X-Gm-Gg: AZFdTZe5LM4RdU9f/r0kGpshFyswlwq8JeB71QLhSpuGHgo6ODvKMMlAsVYOiPXfnoe
	tFxVCHS1SLCSbacZ+rlUkp+JJQ+ILbj/No6E8kcDIJUDBBwTcswQI397ar0dM5bEvxDg1PJXEH7
	8VGru2HW8XuVh1o26JC6dS1R4sAarVQQe87RvyfePri3Vq14lYiBEg3roCTZmzjb/QEv4ZhaA1z
	tJDhT+yN+DGg8OvV6O1qNK3kD/GiMxnghR5aG0A9kybIiF01Z5aICpzCfi20LTUZeqVFofEsmsx
	BOWq+zw/oliavgVooNzCwbrJyjV+J3vGPv9WN6Jvf811FxSFMNskDg40YTnPWJhTky1jBH6JfAC
	4W4cTkvVffVLzb/ZCzq/14sGAf0j+cBehd1/noqsEHkRJao0jQRSj65+KI6MFpwMbvpV7iDCbUx
	HICD7k85d03XzceZxdFl/ZasgoiQ4QEEFXNKPT1mM7JB8h8IAGmoMmTQLtcA4jqtCZonmVA7CO9
	3mL6mV+/nbR73oKw4MBdTvZKiIR2wKC7o9X+71/YrSHnudBRZr5PA+o3diczZD+oHXRJ+a6neOr
	B/DnB5v3ATb4fqVsHtHfhQXImeAwjm/CIf9gPEbqnYA1diCpfePgGQulIuRPYZnDCAeX4ioF9S1
	yVv24m9FVt2BSJY4cWoQdyQv0xrg8ZgpfO81bqUPCU2qJAMdidj6WHDLTQvozlh9KdgUlVU7uAg
	gv8w==
X-Received: by 2002:a05:6000:2313:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-4abb4d70071mr190135f8f.39.1795110613162;
        Thu, 19 Nov 2026 09:50:13 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm310363f8f.45.2026.11.19.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:12 -0800 (PST)
From: Arthur Heymans <arthur@aheymans.xyz>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH wireless-next 06/10] dt-bindings: vendor-prefixes: add XRadio
Date: Thu, 19 Nov 2026 18:49:58 +0100
Message-ID: <20261119175002.458988-7-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119175002.458988-1-arthur@aheymans.xyz>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the vendor prefix for XRadio Wi-Fi chips.

Prepared with OpenAI Codex.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..066c2e90f289 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1959,6 +1959,8 @@ patternProperties:
     description: Xilinx
   "^xnano,.*":
     description: Xnano
+  "^xradio,.*":
+    description: XRadio Technology
   "^xunlong,.*":
     description: Shenzhen Xunlong Software CO.,Limited
   "^xylon,.*":
-- 
2.56.0

