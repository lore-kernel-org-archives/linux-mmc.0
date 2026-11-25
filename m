Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630863;
	b=G2EZTv6G0Js25ZH9lJeIuc3yzzNhCR3BhAQzKI1sX11u8GbP/L1tssyS8DEbgKFGKTiF
	 Eok77dxCv65lIOCz9tlrSaHvNcbTaJZwSbj1wgnyQ+CDVBhU6orTx2A9mmb7lZKcg0SrW
	 yKLlsWGOH22igIlC+UFhnwcS9meXtmHWkVAEq3W20p0QiZiGSFHcFXWpOOKivAhIsH0Y2
	 +FzzfuFiyA8rcBmuUAL7LgsLKBUL1SCGnb3rKnDi9d7vRWCaW/iEorcmuj7xMVdsXebNc
	 WB2KYHEz09Ao9KXtcpoCOXSY1CfT07BzgZwhxyhwBaphgFD8PwZjb4ZVlwS9SHdB8zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630863;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
	b=0fERYdBBRuX8uGyzY2uIigBWpyaOya8AiPPqUpfh8p8I1sVrjyblvH1+PBkehxXKGsYx
	 A2OSKdaexH/sb8WvfukcF9+bHNyJd2RP0IHANGhEmhK1uIS11xqs28RFxX+1tfd844beJ
	 03RRaWMLNYYgz+Ne2SVdCz5V2vThZOU3ufAztuvN+KmlpCd0bDmpG575q5ehEREl2+QBT
	 LnK/BXQ2NXUveEO5TplOojoQMcQ+XarBTVXg5GjyhUCC/uNEIXa2ofgaD0V58n5TCtorJ
	 3BlOp3pcy3W4WGeFVaqblqwMBoth/gr4QUSYCWEU1dRPLON8EQfhavTXXRfc8ILaK2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Rf9p/iyJ";
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217B606A333
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2217B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Rf9p/iyJ
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-949680e6d83so549611985a.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630862; x=1796235662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
        b=zlbXGHsQYOFErUCOh91hymtvxSJd68mpFB+2IhuC/D+cGeFgIO+fizIwzjVIVab6Xr
         n5BLkIsBguQK/bm9oMPtkvISlOGsEAnDTADLSCExxENsDyxoQIYoFNmtYV/Qobt9sq6R
         Q44/S+4kA2blLqwAI4Tq03s9hW39JN1i71uus9fZznNw900kRXj2w95309aICxjqdjSh
         yLVTRcR/fPf4nuEdsppqEl9iLUWQIykrsPwpAYDyz80mVyMcbz54Wx1at2oJcVZLa4Q/
         8YQi5Eb3/kH6tG5VNVMZZbwIPxZNlT9AJAET8HZoe9uf7JDrjkI71wzwjCoBBdwIxXtq
         4wMw==
X-Gm-Message-State: APuU4Z/OG6St1xr+tFcI4o5u4qgrowk0NBtI/EwMtfmoWduY0bDieZ9c
	d7hK1yfOCs/kTanvDTR9rGF9Ld7bxv+2t2r7KvJj7CoTadOFrmYRBH+dDhL2GMz9q7ynYSx09Y/
	vndu0V3lpQraY/qOmRgr0O0/jgFyfXUYu5IZ5o5/0aX+vIqm0sA6XWkJl1nna2UbLGXHi5PthjF
	l009UWZi7XQVTirWAM6c/HejzKFFT20jVX1kJbXYnrZY/o9g6lrUGnMB+0gXX1OfUw8zHrpZmH1
	r7aGWWsry9u
X-Gm-Gg: AZFdTZdTGfapM7WJtrpBOXk4lWNSly457LZvxH3MxHCW6QhykpsB6JMtgZifJlCi3rl
	6iGrjn+PO/USdCoUbPGwn7QOE0OMv9fN8SvZOhSS1WrTCxbVcFXo0WSYRxDXPwZwPjSH1hwd53J
	upd477Yy4dcKvdEzcd4xGupklFML2iWg67HNfteX6CP4olVquMCqDSIPOu6phWebOC4DQCWoom6
	RSppNQ2QkXPYa1oFXXWkg+hhZPo3w+mLb04F3YAV+E1qwuaAXBXCOzv9z+8Wi2WYP1rXllvKBtI
	CSkhZBUvErVZ4HoffzM5KAFsbrJ53zr6+JOoNa6wx42m9qzvqsto47uAKgHgFDIQFvM+4Dd98Y6
	gpRdxy+UOI6EVQ9s/Va6feFvjdgnB0lJ8IbemPRw2nB1ZUztCF18icxbZ4Y22oU6AYOAJLyd/YN
	XsmgbY3SaD5JCYbaMo/CpqTB7XYJ5kCQSr
X-Received: by 2002:a05:620a:414c:b0:949:2ac0:2a32 with SMTP id af79cd13be357-949ba96e760mr3608443685a.26.1795630862012;
        Wed, 25 Nov 2026 10:21:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-949bb01b456sm153978085a.2.2026.11.25.10.21.01
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b937ecbb4so101600786d6.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630861; x=1796235661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
        b=Rf9p/iyJ1C28/hw3Kfubns0Cj2vLebrtpiNw3JHIKxX+JV4+3uGdJp8dUgbBoLTh2D
         Sq6hQxM7PO2t1FittueI2QHLktlSqxSSuJYZKS9v0Urg1YeDvTiytyiY9GJuvX+0RgOj
         6Vyaf4j1J+iph2jS8XPiUhZxVBlP0vkzk/Hjs=
X-Received: by 2002:a05:620a:460e:b0:949:7792:1106 with SMTP id af79cd13be357-949ba823b70mr3245216585a.1.1795630861337;
        Wed, 25 Nov 2026 10:21:01 -0800 (PST)
X-Received: by 2002:a05:620a:460e:b0:949:7792:1106 with SMTP id af79cd13be357-949ba823b70mr3245205985a.1.1795630860597;
        Wed, 25 Nov 2026 10:21:00 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:21:00 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
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
Subject: [PATCH v14 1/6] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Wed, 25 Nov 2026 13:20:48 -0500
Message-Id: <20261125182053.3915833-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
References: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
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
