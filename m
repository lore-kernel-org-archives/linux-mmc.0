Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383873;
	b=tmIJwuJyV9H2j6VmgBEd8RlkfLviQzhhntf9lR8WjEIizge31dNnWatMH1a+3oFx3FaY
	 111uHISvQkYU7P2S0+x1l4eROyHAYPIMbX88f/xjxQ3jE7a9EVHt6HVLkh/EJToas61zO
	 5L/CH7WlP2/V3CSpgf1qq4asyUUUMd3ExJa33ByupJCcdj56e825of42KuYy1WxKoFOH9
	 O6Re4/kbQa58JFPOrVVRmIvloj4bOU+MPjIrRF0CSlpBSywrOBKwdsJAK+WLtR6lmc/Pl
	 teZ3Bm/IONSY309caZJcIXZlwjIq2CvyiZ92ognWOADunSdYn20m/K+f8wDrHgR4Xew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383873;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=yBI12lOTPjK6azkSJoV3g3WBDvgCLjEWrbWWzUZMmOM=;
	b=3EfzqahYaOtj7H0mXOZOGO8Ah4ZqeqK5EIwauASQUHGBYuBimaKJy6M6fdNiyuPPc1mj
	 fGnbNX1GtwqPcvLMO9vCq9I5Tssa/pscvKD7qFvxD2hhazhy0k8gp5aNmVXO5YIfoHDXC
	 fb+nub7louCHAkQpZjNHmozV2gwQ1GLZYntG08piGAjvCqc+pQoNGpwiwnm1PNGap7j7R
	 rWlxs7gUyu19U220JZvSKg5o/Ut7l9tG6yqAuihn2NTTS/JWY20XQAUBzSeNmatdFhHlm
	 SLgSn9cWe5IkILVxaOheCgERRcq0qTPviR1gfnWSti1QZZpL+AyNWCBjorgQrql9oug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RkpZXiKt;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFB606A325
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98BFB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RkpZXiKt
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso482754a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383872; x=1793988672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBI12lOTPjK6azkSJoV3g3WBDvgCLjEWrbWWzUZMmOM=;
        b=ezxY7zN0gyCMoDpx5cwHgwjlcXeEe+vy1qg+XlDlrdSn1CYxHYj+P4C77BASfLUf+E
         QLxZ3KGEvR/TMFixnrXll8fYym4WzEPOmW5gL/0lbAmny/I3UzHicvGWKxU8ioYHEIbC
         ConZfkA2Jb5DpVhjzYNEWIYp1i9753MHbLk40cA7jEo/K74TxCsMzXyiuyBY0ZI2YCLM
         lnRmH9afW7qdTkmjFSCkcL4EPjd84oxl8NpJqprEpKodmULlsHU3Ryjkmx7gndgotr8X
         sidNBeuezf5bRvSyhHoPJJhuQNn9cc8u02BACuYUUMxd8D+0SoTcXLF6boN35R/6kIlz
         JOAA==
X-Gm-Message-State: AFq9FYKa0Jwu9O1Inp+TKHmaLzkfVReG3H20K98F6P+WAWpx/Ny1v9o2
	0eQ0ykbhzlpDddcvKVMa67Jmg82ewDpH7GBBsJAMfaGbJbH0gJ2xhoWfNvz4KNacZlWqIMGze2R
	jpFZ8f4iJKPy+NeGAyuQZsYB+AjBOBxXacQH3XhsFmdh29oRrkmz/Y0jmP/CideEJ1EyCWSeB1E
	uUGG1C7n66lE26g3YFczfszqKGx8c93MpViFC3IAlQL+MtUol+sfYd+Bew4P4zxOdZ/bFEsYHwt
	TU4xThfTL9P
X-Gm-Gg: AYBFou1nFCpSt64HsTlAEByLhmxilk89LwlNc5uW2u1b5JoqJAIyrSc/GNi55j+3cJK
	jvy3bK9z1tNAuhcIG1Ug+9306JZ/6CXmA1V7C0oZVnhiL3DSgyWU0sGr4Os0JMtNF4t4aNb+u9A
	QKIwVUd29q9kmHBZypGUmRQg/h8ed0GSPGxXB2sX4TEYqSX6pxHYLRvbUhZiEXRk9yyvKJnIfs5
	bpIWc3gQt3BDjW4IbqIUMx3v3iSzZZ9x6SC1u1cM/DYs9lEVjSbBQ0EbN1xEZdlz2FKhRS3m+iS
	Heh+iCyNXOnyGMl/FyCc9v6IvQ3lJNo4f/YcRykEy+43jHBDXPDmjWv4xJmCj7i4K+IqvlBFHUr
	TYLPbm5P1vm3OrB9S1ZjCA/0TEw5FyRbkPY9SOcXIQr5XN5mq0ArXT4rfAGQI47CLN4dwAczmAx
	E9O6UZVj6AxW+OZFxo2uG3BXHJ06Nr6DpF
X-Received: by 2002:a17:90b:1b12:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ae896f51e5mr2786439a91.14.1793383871551;
        Fri, 30 Oct 2026 11:11:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85f56a85sm878286a91.1.2026.10.30.11.11.11
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1663fb7e005so1234950c88.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383870; x=1793988670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBI12lOTPjK6azkSJoV3g3WBDvgCLjEWrbWWzUZMmOM=;
        b=RkpZXiKthQ69znt+KdT5ioip39Lc1LpAKKZrCNuAy5gFsz/l/pRzh9L1I2q72PLGGP
         nl1Z5Au2s+0CrnaC2+eYGvWXrPzLwZ3ELGohIY6nZ13kz87IZTQLHb4FmGD3kn0tvD5j
         NmRqCKKlVdxCm4wMDHwJL6fngxzsxwKtQVPjA=
X-Received: by 2002:a05:701a:c907:b0:16a:1fa:58cb with SMTP id a92af1059eb24-1ac56d95460mr4158720c88.1.1793383869391;
        Fri, 30 Oct 2026 11:11:09 -0700 (PDT)
X-Received: by 2002:a05:701a:c907:b0:16a:1fa:58cb with SMTP id a92af1059eb24-1ac56d95460mr4158658c88.1.1793383868479;
        Fri, 30 Oct 2026 11:11:08 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:08 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v11 1/6] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Fri, 30 Oct 2026 14:10:28 -0400
Message-Id: <20261030181034.3811225-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
References: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 8b9b3b036129..2fc8e06d5ec9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -301,7 +301,7 @@ properties:
   keep-power-in-suspend:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
+      Preserves card power during a suspend/resume cycle.
 
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1

