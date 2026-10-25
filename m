Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937085;
	b=s0WScP7meu97MBt4wBzceyatdy2QoNVJMvSDNhrg5aESMnYsnT8mTzi011+Yq2Sozh1r
	 uu1zJe7BEErR99jJzAlp7HK+BuPda54j5vqKDWc7+S7G4DcKxQdR+jNiuVTLfrKl/AFuS
	 J53fDhgsJL9XFt22/NJjO0ONJn5oIGcp3zNOGTlH2/WG4xbuXyIcDPElPjaLW9CJv/WAq
	 PGaCXuUq8rXfONHIovF7jgErOnvabMUAiyR3kkXwi3og9aLNnu8Tgz+nuwTsKJ8TlMsSN
	 Ebm/ywXSU3nTdYY3X9nfSYl2N66KFfQillmiCzqyDUFJnEsyCjZK0oHr6ICpv1oi1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gf2N8Nd/TL/v9Ty3pc7g07aVuF2lX3oZKxasqQ7SD9I=;
	b=lvKCIJObv5kAk+7FvO1a/8n3O+3ULD38yTf4/8A9v2ufDxlnN/M87Irbu+t3aqv2N6Ao
	 5riEBMl/PysYe9eJOgDQOHJjdglr0TWZLhISNCA87zCHk6L+Yss1o0/LqYDBtT31KG579
	 ELqczU3AD1yKZb5ev5qBr55iyd/D4B26KrtdDtjeLOrDCAtFlNLKqu44sgM31Yg3HWcY0
	 15OP3ojjMB8b30W9Al3J7UytxGJ7NIR0b8XjzoRc/yVf9elpxIBpbx5Kq3Q9o++FRDSER
	 CPMAzp6AiSUe3kr/573QdjjS7LmfHpldpmAsfmeNkbcabzF2Nf4bEtkc9068PNIuoBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="JvkyLz/Z";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B70606A31F
	for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 14:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B70606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=JvkyLz/Z
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so20999365e9.2
        for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792937082; x=1793541882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gf2N8Nd/TL/v9Ty3pc7g07aVuF2lX3oZKxasqQ7SD9I=;
        b=JvkyLz/ZNZaUn5KvDlRMFowHcFjJnQwtRGtucdh9VQYbheAbLH5l83M5ujW1w0K8MG
         t/M2ycE/8cXAyROJC8vJ80SmRrO29JVPGxugVEkAAztqPVJxz0oYRBhT6N7oIRiroxbd
         pnMnWQ3UCMLFgxtDDkDMO8Ci1NRIcrBH+pheYYOhWnJiV+4A/PE72b/THGoPbVYsHu2q
         8vXAm68b4hSIY76GjyrBKtef/M8p9wIMsP2M0Y5C4ikEp/LDXcI1MlG3LTUMOmZudL7/
         xfwG3qCrQ0oWW50A3SVc6hypDeRGOQqA6AleGsmiadzHOtXL/jCSFa7b5qs91zUAL+vM
         4fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937082; x=1793541882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gf2N8Nd/TL/v9Ty3pc7g07aVuF2lX3oZKxasqQ7SD9I=;
        b=R5FOoeFAYW+yA0XUMAEpoRL1WNl+ov7ABI80OgcbFXSFdkx1o7NI3viYcCf/Ve1XA5
         DziJGF2FGOcaPmMYmkK3oIzl1L3ut/35viB4VVWi1jyrmhwNv+nDdBreYoFzxq2sCdE4
         XCaVTqmaS86WBFmUNMDk4UE5CRYOmkkBH2BhWRFwvj6ELVevf8ypd8SeEklHo+knKnw7
         08PWc4urajzRtyJn2g7wkbtDWmgqchYO/u/76CHpdlEEzhpQ5/wsy7DVIJzN8sZJ5ZRB
         GF52z9k2OMVnBrySKttJrXClVuL7Rd4w6qVKfaYyOVtch9cy2lTM51ZQZ9RgcYljIIoQ
         zjbg==
X-Forwarded-Encrypted: i=1; AKwUvBwYgJWFCI2NGAEEekOrzr+Ebe6StllRjPTD8cHJH6PEl+oPa2ULaVvBRLihTwJOi87f793g+isowWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgiqyKk3/9h7aTp85XX4Ih2tT/cdlakjz68t2iIFYmN7sIopEW
	DPFJEe6j6x5xztIGBgcDzi8XiChZdLTUSg02mBZVER2zmRoyPH4C3wypgrekQcJsLCM=
X-Gm-Gg: AYBFou2w5DZVd+fdBPzwjO64IzvuYu5R3Dj1VlOAxi4XiUvfFTqsajHE+4rRcTafo8O
	7vs4gukCfMKu9Vsf9aiBq/j/B9lsrqwkPC3DH+noTFMUokuGJYfh2MB7UN4Fd4jLKyTTZYJRVZB
	BrfoDPDiYke3k0SdvfdSspRufA+wvzhn6bwU7tW39NQqrMpVM3Ds8i1pZm4jWE4Sg7EPm4rRMYJ
	tuknra5PSwZoybbpMG2ln/57mw83nmAim2mgNfkk0ev2nQ0+hYvO4J/WREFvUSkVe/e+hJdllOq
	J+QgDqHxwrvEE5RbYWSMByHZH0O5vpZMM6tvMg3c9uVUGp8fduicjY3b1nvfBuqdX9j5pYFvC36
	ykp29Rcv+5/HLrg3sHG588si19MDkInxnzfaxyn1dDHJ4t64kvCFU9nCCq1B9keLB5FG7qR0k36
	1BOKWbQD1WytBZhQ5Lr8v+zKembLh/FmP+eE3z6IeLBmfR4RI/F+z5B1CqPUSv0JXYDA0U6CbBa
	tDKH5QOUErh/i10RMBRRQo5kBf03LKXKXzNOSUQwfgtOz5c7LWiQ9efANN150HQhvdDksSElSqA
	8UZm0hIXfMT2JZuMD4XyXtPakbi9Wt4Nh+n39w0TWqDyPfFdyY1WF8Fp+9HWSwIi0eqMXIewhw=
	=
X-Received: by 2002:a05:600c:37cc:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4a35acaf08fmr74313465e9.24.1792937082605;
        Sun, 25 Oct 2026 07:04:42 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm112317695e9.9.2026.10.25.07.04.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 07:04:42 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH RFC 1/2] dt-bindings: mmc: ingenic: Add the X1600
Date: Sun, 25 Oct 2026 15:03:24 +0100
Message-ID: <20261025140325.73204-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025140325.73204-1-olivier@mgcrea.io>
References: <20261025140325.73204-1-olivier@mgcrea.io>
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

The X1600's MSC has the X1000's registers, so the X1000 is its fallback.
Unlike the X1000's, its MSCs have no request lines to the system DMA
controller: the driver uses their own DMA controller instead, which needs
the X1600 compatible to tell them apart.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
index bb4e0be0c893..6b26a17982f3 100644
--- a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
@@ -25,6 +25,9 @@ properties:
       - items:
           - const: ingenic,jz4770-mmc
           - const: ingenic,jz4760-mmc
+      - items:
+          - const: ingenic,x1600-mmc
+          - const: ingenic,x1000-mmc
 
   reg:
     maxItems: 1

base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
-- 
2.39.5

