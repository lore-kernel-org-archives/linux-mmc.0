Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C435C1A9
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132902; cv=none; b=jCG9GjVUKfJpi6/QG5Sy1qeSnKTYK62zkARBkv/ikQerB0x95Hy698J9gOolTP6kvWF+vv8k2ImklmFs2neM+QXEWJ2awvX9W6haNkEKwl555A6YBU3suEQJnne1lPHbyxBzsFc0ETgUBPVd3P/lq1gMqy3DYv9EUHkaai8T7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132902; c=relaxed/simple;
	bh=vr/9876nQ9Yqa2p62Al3XaX5d9J+sOFIuHlt/3IXgHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTF6jA1aJJpUWz7o8l2pRWamAGGTRNYqlOxQzkzMQCFNGvCOGcQ+2OjwZga8uhJZsVCUkdHeBKCZjd/P7FfQcFyj2zjSDzcoKmfqrCMyxG4/9Qh0wHhkeixV3rRbfmUzQvee3TdlfqhxEZadUyr7AG60wnPb0kNyNTzRFl1SP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aARHbHSP; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aARHbHSP"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3789427a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 13:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132900; x=1786737700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUobKnTJDW6OHCpTnuG5AIhSRJPdO7KkwqnQ+2e+QDs=;
        b=rgLMl91zdTDAp20POL3W7Bj0ruv7sW7wlpzmjwf1LCiTrjuZb+/05jV0fbcAvCM2Nc
         tH/C2MxqbiU2pDBOQAvilPlRnwbfeiBUbthu1s/dlmo29u5SqJTW1TeHla2ezyMwm1kr
         I4+6GYgJSJGzOuCyeT5NrQ98ihZFuyBo4Oyw4B0aEueRWjKm41pjvmDemW5KMnpYZJR2
         dpP+auw/VCQGu627a/MStUt0Z5h8Lce20wah2jT4XQLv+yf828ThCKoAvGr6rhZby0+x
         SqqAbJXtU0VoEzq5rNyvgScs01SvWZFRiyZPMynyUJu7BKeITg5aE8keAh0KlradKgKA
         UXZw==
X-Forwarded-Encrypted: i=1; AHgh+Rpl3XITcLDDJXC2Emn2Y/XR7enLLYtD/j/BzrAuHv37hHitdLkA1OI0UEzTMEK0n29EK11wfV8af1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dPhR1ORJvjdElsUG5WTnLp2zaOB7xLxApgySioloAwgJj0TX
	KSfhqRYJnwuh+hOEa34moCc+f4XS/hkp04YdC1Y5eM3VRaW0TpMMSz8Ay+2N/QoEgkB6MDhgy+Y
	wfyg8Mi/NkHigt8rMRdWnMhNl4HlhUxfQBB1mfVZp2zv2wEKFaQpbKKa9bz6S+YpUlJwVsxM8O8
	P/qZTJpDgu/vBH7ixfE58keA/brEeF+rDAs4eGIj8H9xkeEssCtFJINBg6NryIlPDjkq1GSEBOP
	NJ6NDq3rzVT
X-Gm-Gg: AR+sD13BFOeAsyPmARHFzNPe1lRdx3q/4lKAhK5+hMXBAWRPmlcUZqFRdceKtzXUJED
	btrIVYI/UJs0OS+IQuOqLObY3cdLChd3lTMsKnZYzWfblR01LroZ0Qa7oU14ZV+6HpiPaVQb6RP
	5uFxgF/KXOCVVEDkO7BinSRlKKlA5vSeKIVUx60kUlVK3Bbn2kRF/HdpdYl1a5nL8Wg9+3XmaSN
	o4Dm3g0uggcj/Xn8JbwJP7rb0KRZIQTaorj39FVk0nL+OL9JjM7gySampSeaGlYIQNnCzX1bnSb
	egIQ1bAtsHLnFUmKdxMwrEIcV28wm4O7IVBBLE8XQdAUM1qGQ4GMEhLYQ3mP+sj5+x39hnppGwf
	6l6GnXPLzGNpl58qw+87ksWRlTFtDG1Oj8QdwzFV6AuWn2JVRA9UgH0+RdSgcEquPRnafcl9H9H
	C6f/f8YhHB0o2cPWogMi6ARQVVVgSRIS7r
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-39261fdab5amr7808216a91.7.1786132899733;
        Fri, 07 Aug 2026 13:01:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3925fecf768sm1292038a91.6.2026.08.07.13.01.39
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:01:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934979ee9f1so409313985a.2
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786132898; x=1786737698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUobKnTJDW6OHCpTnuG5AIhSRJPdO7KkwqnQ+2e+QDs=;
        b=aARHbHSP9Nln5FSWL23V1aPIp7cgZpK55smAoujqOSMoOVK0eYbhBkFVRMrbwVXnuA
         NCDhknxV5/WgsgDRhU6X5qnowMEM9/MXqR7DAOWjdx+QIilP9zWJQzFgdhvBPVJvsptq
         jXNTlF8Y4nv4sWUGw/jeK0HMIGb4mNrHIqi3I=
X-Forwarded-Encrypted: i=1; AHgh+Rp0Dkf+AVJvNR5ATGdX0b9x0BCZspTLB7e86Fnjb9qHQZrsU+kNR4gfvfemUK7cKcFGZdsIJKlhK1o=@vger.kernel.org
X-Received: by 2002:a05:620a:440b:b0:930:b19a:9d5e with SMTP id af79cd13be357-93671b4bd40mr603677285a.1.1786132898166;
        Fri, 07 Aug 2026 13:01:38 -0700 (PDT)
X-Received: by 2002:a05:620a:440b:b0:930:b19a:9d5e with SMTP id af79cd13be357-93671b4bd40mr603663485a.1.1786132897374;
        Fri, 07 Aug 2026 13:01:37 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366dc51b43sm225839185a.0.2026.08.07.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:01:36 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 2/3] dt-bindings: mmc: Add reset-card-at-resume property
Date: Fri,  7 Aug 2026 16:01:20 -0400
Message-Id: <20260807200121.2590202-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807200121.2590202-1-kamal.dasu@broadcom.com>
References: <20260807200121.2590202-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
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
Changes in v8:
  - Sashiko's AI review of v7 pointed out this property's own
    description says it's "expected to be paired with
    keep-power-in-suspend", and patch 3/3 now enforces exactly that
    pairing in the driver, but nothing enforced it in the schema --
    a DT could set reset-card-at-resume alone and still pass
    dt_binding_check. Rob Herring asked for this to be addressed on
    the list. Added a dependencies entry requiring
    keep-power-in-suspend whenever reset-card-at-resume is present.

Changes in v7:
  - No other change here; patch 3/3 now requires this property
    alongside keep-power-in-suspend for (e)MMC rather than treating
    them as fully independent in the driver -- see that patch's
    changelog.

Changes in v6:
  - New patch, per Ulf's suggestion: rather than fold "needs a reset
    at resume" into keep-power-in-suspend's own meaning, describe it
    as its own independent property, so the two can be combined only
    where actually needed (brcmstb sets both; SDIO's existing
    keep-power-in-suspend users are unaffected and set neither this
    nor a reset).

 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index c18bf0d6a56e..c51e9184384d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -293,6 +293,13 @@ properties:
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
@@ -361,5 +368,6 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  reset-card-at-resume: [ keep-power-in-suspend ]
 
 additionalProperties: true
-- 
2.34.1

