Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604310;
	b=F3gBUqEBL7qytH6yE0uEjTVzK4MCsgcRXSrOdSQVvERqdSpdqbm5tO3HT8thIWoETui2
	 0bLECchGvnZiIP8Y+IIrDXOzqh8eEd+Ju9fcqX2slzRDa7ndwdqbrbqR0wJHkIXmcfzNr
	 b02WVpuDcmJoK+pHHLymbwlJM/iT2JzYmkmOuEkdiSc7S9DfUEUujav6XqUFTfRPYPERh
	 mGEA1IWY9anh8c8f6AR5uw+xVN5EQgOOybGtvrl6YehMfc8rB0YulSyDKM8Izl9bHJ1ZP
	 eqzNZw69QCVJckrcAlrvxTiLfbSNbv6L+TqLLabcTXSy1eCQeer7hUqnWuu50lUphkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604310;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
	b=BfrVEM5Xk/JWtvL8za41JF2DQrCnYDU2E4Anmdv2EAK4AuONeOgW7NFjPfctKw2GetEC
	 /VCqIxbsx8gk61Vy/E2fcY3yUojBK1inqI0IRR0rJ53znxo8XB5aavunzvjbulCFVP5VW
	 caIm5uTOc2MCUU9vtKyDJwI5ftvnAnzKmjIT1+r/1okhn+vaxu1fRo+MjoshvT5DZ++jx
	 VEupECbIROcv021xb6zTjqrwqLvCDvRGhgaKpDMBrhdXEs+yOZKlQWiEYZl22z7FhxLEO
	 glygb8nHMxSu4v5jpY4cnCal25zwRunE/PQlQa2/bFLBUtsLcxbHryCK5NNzLewSNKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bfO4v8q+;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D1160A261C
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D1160A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bfO4v8q+
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-9495e8ae239so114264185a.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604309; x=1795209109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
        b=ltNhz+1PR0f0c+uH+yryjYJ84d0JSo4U+PGEGR7Mn1hR9tm70/iXg7RMheID5j/79Q
         Q158QNgHUQf0Wx9yPkrv7QMz+qf7S45AXk2cUaiF9M7BbP8VS3A7321btB/aUyqbrIPx
         tbNCVUF9FP3KLsfbYqxscguDUGkmL94TAEBFrkDAAq0Aif3uDuyf2sr/X97SweplyC8G
         D+dvCWX9XmvVsktQ6AwnY6YX98K9ffg/mSb1RnuRvep5XF7p+5B3nZzgLSHhaN56t2ky
         fmVs0SSKXYDMSKVAWb+dQ/qMROYXe+WqcmjOahV+MHs0fOE1a5bOPeXZBMzyPThf1aPY
         2gbg==
X-Gm-Message-State: APuU4Z8o9s5ev//7zxjlIrgUYehT6XM9wPciA5A4hr5QSy0dSYSOSM7/
	XLhi3jvPvgG4C7k0pwiByiVbdyhj16gKB5NGfGgrvyPu/59oSTZK+NuMDYTo2QRqZsUXs5yoQf9
	whFt8ha2iCC8mZnywXR5e9z/vfo4X5MxZI9Avq3aw9/1f0ygqQhiYzP+S6u41FdeGL2+/sdETBD
	OISClTthV7z5sEjSTrj/gcECX1t9er+shdVsCzmmByUB47otEKkhgrMx4wrQctHTZHPkLjj9WiJ
	6QFQSGNww8W
X-Gm-Gg: AYBFou0rll2NPbzzgryL16qkvuPRA/qo0UmWyAEOFrvcORYgXdidwBneQQjywUAJfYs
	tyamxCibYVc+O78xir/3rDLbuuIoIg9ERmgF67cWzBchdcUgyrOmWuIEaIdHXXVEZSd3pWB2/s+
	qq91sB6/LKC6xeJkFvzx2qIDbqLKbqXXfvTzw/CXwY/aL4jkHqc8LTjQYRsi84t5i9cFJVglk/t
	dvdSPmlQRaj96H0/tc11rXzHiLkVnhwzK8ld/AkZL+OfH0y3Uh7+jjMqF395wCyCro0LHsfj9Gy
	5Rmctmm3dZe6QByxjaX3dpsa/MDA8wQKi2WiIULDbej1VHzZ7iKbG9EAVqKFHg8uRXTOjx5LCGh
	vDV1Xq88Q0vNd9p/OwR5NWwRh/VJkLOUcU7lXqLTlYcOFT+SoJdSX0nN5YHoPvf8hc/zsz/rqv1
	EaPdLoL0w0ZnqI2RSmOlMTikEV1uX3zJfd5xc=
X-Received: by 2002:a05:620a:1b9a:b0:93e:869c:43e2 with SMTP id af79cd13be357-9494bc1551emr631193085a.50.1794604308713;
        Fri, 13 Nov 2026 13:11:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-949622ba8d2sm6936385a.6.2026.11.13.13.11.47
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91e987a4099so36689186d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604307; x=1795209107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
        b=bfO4v8q+lp////xEV2j0oi5KAOX0MClclRh+IM7a5elQU/Tfp9rP5bgPQ8c+mTeog2
         MIHPIRyGaxNeVTl70ghoSEH1yIQ1f4P4/kwtv1C+56kRXo2VEOgw41Z85YagWo4byUP/
         MU8EGY6Iez3jckVwC/2IMVVKP5UDTAqRFiQBg=
X-Received: by 2002:a05:622a:58cd:b0:536:d47:22e with SMTP id d75a77b69052e-55ac937f49bmr62688141cf.40.1794604307125;
        Fri, 13 Nov 2026 13:11:47 -0800 (PST)
X-Received: by 2002:a05:622a:58cd:b0:536:d47:22e with SMTP id d75a77b69052e-55ac937f49bmr62687481cf.40.1794604306410;
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 2/6] dt-bindings: mmc: Add reset-card-at-resume property
Date: Fri, 13 Nov 2026 16:11:39 -0500
Message-Id: <20261113211143.3759154-3-kamal.dasu@broadcom.com>
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

On some platforms, firmware or other hardware accesses the card
during suspend/resume, before the kernel's own resume path has run,
leaving the card in a state the kernel can no longer assume it knows.
Add a flag property so such boards can tell the mmc core the card
needs to be reset before it can be used again.

This is expected to be paired with keep-power-in-suspend on boards
whose firmware needs the card to stay powered and live throughout
suspend: since the card is never power-cycled, nothing else would
force it back to a known state on resume.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 2fc8e06d5ec9..c824b95f2ae2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -303,6 +303,13 @@ properties:
     description:
       Preserves card power during a suspend/resume cycle.
 
+  reset-card-at-resume:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The HW/FW may have accessed the card during suspend/resume,
+      leaving it in an unknown state. Hence, before the card can be
+      used, it must be reset.
+
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -371,5 +378,6 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  reset-card-at-resume: [ keep-power-in-suspend ]
 
 additionalProperties: true
