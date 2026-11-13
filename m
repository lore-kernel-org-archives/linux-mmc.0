Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604308;
	b=ztbSYrqa+6gAuVz3sJiu1CJP8TwAOfuettu98XEh4hcBUyD1mFFJPvYUJbN5FTwlYB1D
	 5FjUCUxcFCA8PwCpIskYuaTF13CTjnrM1BKTYar15C4+50ZOPCrTmWQYzhX3nMNKcMCfj
	 XWa1HOsW7JI/LsTfPVUAdvrB+xrhmHDGGA/auLydGRa483rrRydfa+KJD0HabMf7Gfp5D
	 dMS2E+Op/zTnZN6AM9E+6C91P1DMDXY13eHXJGdw+sfh6xQTRtqilVPwqUnNuCEKHcdcO
	 rz3Iv9/RwI/MoaXp6oZNQatn5wNfpzAnfCDctK0khlkClX7jQlpzfGVJzk7nP2Ac1Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604308;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
	b=gJRKWxKcZ31vPV6OnMtka69FecqJdDwzvWqvtYMk8FVZXTCSzCUoRqQ4B4QZr/ywisQS
	 zs4dM1ZAqkKjzBukGwB6/F+os0pJg6a3mJIDlP30GH8HoxSVEcbRcslwpFBAAE/3yi38R
	 s8cyGg670+DIyxO3toQtBmphKvWR3zbKH3MhsePF6e1TjegUa9DlFBb7LO/u2PKFI9pj0
	 ksQqBqd9XCqxn7PEsa+BxzfXZPofnOy6MGBJ0VnYVYmbO1VXwL1ylaBwekghUmuUhIPbZ
	 rnOoGEKhFiwr9+2CMr3B+mgLuGB+HaCQf3j7GGNmcWAmK8Xu53xq4Tqy6ipgtPRAWdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="GgmcS/kg";
	arc=none smtp.remote-ip=209.85.128.227
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CF606A8A8
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF1CF606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GgmcS/kg
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-8b4b2bf375fso4981497b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604307; x=1795209107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
        b=S6ltI8fZK30jMVmYNe7tFpq00LtYMxA6334DyB0rNFaY5cpMVrOc0K7MrwwlWTibnZ
         3MQPxhvECM/DqTZQYJO/6vPyrICkI8no6GwpWdjSUtvQEqEwOrt9PffPYsWy+w/2VVCr
         6RpVW9cCP8dc17476iruWQIiTXwp0Y+OOnNbvYB5PEl3pgHTaY/IpDIuHHBdKrvFP7my
         1JVh70bxwUExM0uKq1vMD0m+dl12HZzB5HmAfCYbQyaEVHi7loQ5uO66lZtlzOHj8zex
         c4M/+aeXffE7L4BPGnSY/mTBLGdqaOGPGhb5Czgxw70LxCQKC0yVWTyAUyC9a+ST1tnc
         v1Bw==
X-Gm-Message-State: APuU4Z8tJdGwwzuUL8G4T+HGsPRgxmAePT25g9yQignBw1f3OpRRpWNm
	uyTcUUb3ob1BViB/5XX0dAMo7TSdJ+HFydzejJ4FzNo70iFRGcD4NSjI7mcXHsZLOmVlKmolbV/
	aYvGRlbHzYidjEDFeipxCv3A/5vzrph6+gwgQJ7PdpFuilcSq1HW0SFBBfmy51Z2n40L0OjZ9D2
	OrMcHomrphBc2i6olp4sheaRGrKjZKHT0if7sqdXCpWZtcPP6Khlnkk8jIpmQX0bKJR4+9eG3w7
	V1+wMnePSe6
X-Gm-Gg: AYBFou05aafZEp+KtOlSGX7z97cyVJrjiwB5Z7c29rppRXgN7TwhDt4ddKojR078cuT
	IA2edd6hVYIs57j1Sv/t0W4MNjRfs5wxw8bRTvNrxuqJ3Tfwg681S0LvtL7vDRoX1Y7fIWA2xs9
	O9g2Q5hvGnHWUIrhf0GH3m9pnJG0xHXgxdBUgPnul0rWBgUA5fOTgu2K187gfuQBtB1qG7KKigv
	7FQXL1Y9VGQQ4QcFj1BQk4GxNekVUInNIrcdsDpdaLDjqcE26fYa4drHx8PGoaGkLrWCB4qDNpc
	IvATjBqrEeULMrRMfO6gR3sVyuYIVdswGDejsp6NTpPQlmBwg423h7YpIHSBNLaKA6xnmjC4wKW
	Zb/xCEo7tKLqT6RXwgwhl4RNjnWYS2W7ptnS0y9oZ86P6w50zt5CX9+WCcsfp2X0eVxT26qXFDW
	uQeStjvVF54x5xfvApWbgZx3xPZcw4GZ6ymEQ=
X-Received: by 2002:a05:690c:e3c9:b0:8b3:7621:f695 with SMTP id 00721157ae682-8b4aa2ff45fmr28259857b3.34.1794604306862;
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b4aa876d71sm525897b3.9.2026.11.13.13.11.46
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-534f3fe0236so29559131cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604306; x=1795209106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
        b=GgmcS/kgUebEIq3LDrr+Q1x1Uoge4Yd0+omkSlFNm8OVwus2mf+V6Qo8d+VMMhWJYB
         e0lEVhp4UO+AkWKv0mOkAb7FAh6IJ8g6R1TlTUwU/2L5DtIgtVn/eME+xeqmFCAh3soV
         5azbVoWsqutXf8AXdxpKNrz1mBcVs0Z3Tk5vo=
X-Received: by 2002:ac8:5ac3:0:b0:533:8cc0:2e17 with SMTP id d75a77b69052e-55ac8472777mr58141291cf.50.1794604306180;
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
X-Received: by 2002:ac8:5ac3:0:b0:533:8cc0:2e17 with SMTP id d75a77b69052e-55ac8472777mr58140891cf.50.1794604305723;
        Fri, 13 Nov 2026 13:11:45 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:45 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 1/6] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Fri, 13 Nov 2026 16:11:38 -0500
Message-Id: <20261113211143.3759154-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
References: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
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
