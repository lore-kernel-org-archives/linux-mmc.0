Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647895;
	b=zeVGwdW2P45XAAdmvwFgxbEepRFpn0jYuAszJ93q10LWNdlGFsqve0Nhx2j+WCR/jaVO
	 8gB5Kbwkz32Tx7lkHjfSJTNw1DtI972vTUsUbvGZIfrR+f4zu1W438bX+MzagbFJaZ4UC
	 JqIsXUA2DIsL35mVjW6B90PttRf/uS06wvehypDi6MTl2cWoVbJhhcn5XO8ZOBLmWH++E
	 0jcOKRtQ9D7yWMYKKbfMOvBJZgNflZhMoE6x4/PIWYCSjNKyfGziZ4mqim8I4HTAPUhQU
	 LNDHnNq9ST293hzmLxqPZH2mjjnDfhaozX9MpyrWzoRXhhJXuYVwwt1T+NZE879pbVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647895;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VHeuitJP9vddzspc29UV0scFtTGU1OuMS5fNcziVF70=;
	b=QuCG+vjUqtMaDuqUjI9teFpXM6rOkT6OJgUHaNm41i6j7WTL8L/U7uvwUyNXkwXQ9vpB
	 tdr45Ze9MIN0BqiljjMMVvUnQT8kIT9ja51scXSkng123GXUffKyDEV88yujTL5iJIph5
	 KnANwg75oXZD0GugYRP7sVOKA/pHFo1oXogng/wr8aVbosN8ECuK3foE+70KHuJ4zFFeH
	 U4csRl9zi3HfHxXW0NDPPeo8m8Z25T0n3m10j4dK2GMoY5lvXARZmILMb+Fg3nCFIZSkg
	 6XbM/MhsnwXW+uoSpGboSML9H0pEUFXRL41CKBprOxgC8qg8H/oHoF9gD30/D/L8+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQq2x4CO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C36606A32C;
	Wed, 25 Nov 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQq2x4CO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DE11F000CA;
	Wed, 25 Nov 2026 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795647894;
	bh=VHeuitJP9vddzspc29UV0scFtTGU1OuMS5fNcziVF70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DQq2x4COkXdfkFWHw/zzmTQw9f5vDGgzWVT5KEswOQI96rrRnRQlluIJ8vt8h+/tN
	 6UoJOz8PIfoA9FpVRuL7GmBQuot2Tq8b59ClxVuD4xj5YNiYlo06iR+ucMot9HTs+d
	 wrsykJX/4+h3J85gSP0tD1Wjcx2eLSPQUEFAqBFOeB1XOkCAx2MhGCEytN4o1A3yUl
	 ZqdGejeTinqV7DXSBEGgIySrx+tekD1EfpmNP7chP2/sU4+uWmliKI36jA1ILjWfwe
	 sNJnW3FsTAnzTXyKn9C1EYvn4OcfFK5YmuQNfG+NHakFqWy71Kply5cJGoI9FqklZQ
	 yzQcURk/0hzqw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 25 Nov 2026 23:04:37 +0000
Subject: [PATCH v2 1/2] dt-bindings: mmc: spacemit,sdhci: Add tx delay
 property
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-07-k3-sdhci-dts-v2-1-a069659ba025@kernel.org>
References: <20261125-07-k3-sdhci-dts-v2-0-a069659ba025@kernel.org>
In-Reply-To: <20261125-07-k3-sdhci-dts-v2-0-a069659ba025@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=dlan@kernel.org;
 h=from:subject:message-id; bh=860qpvL1n3nNzeJAqEF8XFOw+kpybSxzsA3ypMKT5eA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrB2mLwAWqzq/T9KBLeEKZxEybp9fNlFdYndS4K
 Z3kDU2J+ZaJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawdpixsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2SYg//QnDRgZjFby6xjoUdhB+C9ckZmTZdQaS3EbIPP9KAoUhWO8WROvFYi
 EZKZsMU6Aai5IH7NPoI0toRCaBL6wWMq1ZRPz+lB1f7fLinQ1T/3qnmeLCi0ODpKSWLg0V38mnU
 7zGCVyQWfbC5DB71e5BogSlqgcdYADpgxHwTf/2qkbyVxb/VqF5T0TockB27QpN282Bh1+BTpRx
 2DaSKY6SqVmLnAk02v8P5tl7LH6QXohzvA2cxmGU9v9KHKWv/vbekn7ybnWuK8H7MJrygDbIZX7
 BVA1Bokpt7wzHEhWTNdERXB5fsJVoPIeiBpH1mWfzd2/w/zGSfC8r0PLAcYfqhMKiY/kqKEDz9h
 L3JHrQ4Iw9UiLsP3TRwlLvdq2YiHdQXCjRuPEpVj7WKHBvvVspSZlGJFjm/t7clH/n5Dq+aGbwJ
 rhQeo/iA8pX9yRWkKU7Oivdzl8v2ytTwdp88kLy6sqSrEPJAWIBZUQvL0rSAT/QK/EzgPdFrKQN
 uf650ikCd+iwnAFyPz0YtG803gukqMWC9z2a8bmcAh/TlItHO4328KOvll2QyAs1i8B3yar1JHQ
 MmsI/DWsR6/6wmLrRSivBvapSW1DifNPCKY2f0Dxsd3YBtVB2xIVSp++QR2sUqQUjGU2uo8BKP+
 hgH3GbNKSsqoYh+jagsyqs4c80v2BE=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Introduce a vendor specific property to configure the step count of TX
delay line which should be applied before RX tuning, compensating for
board level trace differences. The TX delay line result comes from test
out of real board which vary from different hardware layout.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 34d202af909f..7df48fedc982 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -56,6 +56,15 @@ properties:
   pinctrl-1:
     description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
 
+  spacemit,tx-delay:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    default: 127
+    description:
+      TX delay line setting applied before RX tuning, compensating for
+      board level trace differences. This is a delay line step count with
+      no fixed time-per-step conversion; determined empirically per board
+      specific, used on SD/SDIO hosts.
+
 required:
   - compatible
   - reg

-- 
2.56.0

