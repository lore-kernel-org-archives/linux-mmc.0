Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383877;
	b=rgNPCXMVXVDWEycY7V9D9H3748v+eBYHX25on4By3HLJye4fkc7z04LPKsyzRk4WIgsr
	 v0iBeNtQZ5XnjAQnRvR29mlaecfNRpnEfy6Zonw78kl5WZCiw4sioFnlEoTfFrsSE77V0
	 CZzAx5l+Cy+FqzAZ8aK+pn5PaOHbV3t0Hka/efAm+nNDsCAboQvJS1dZdGWdKKpUR/UV9
	 sQdx2BNVNGHL6SAVmxC7AgXCPgf0M209VTrokMG8jcw6hSpNoJWlvBPaYg9I77WdwcR8V
	 fjrxWwvfDkYqK28K6EMAekJsxq51MyoXYORVDsiG9NpXkz6hyqDq4Kgk5FQI/CBffeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383877;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=xJErFKYPU8d+wmmwqjpCjFo6vbn7aqgwgH2UyvNH/5A=;
	b=Phh8h6SH6SwztKjl2NCEdYL+yEihdFUUNsXXSO5btMZxh3Snbp2s5o18i3C7L+jLC0xn
	 YA40Uq1B2dLm4wVze135EIHzvPdxfXLQV5PIZchz86ncSmgarQ32gWTfKJBkZuFh4ouM1
	 HdXFR1Ny+69EDPzSOpPlb5+zq1N4zmQGnc8RuUmktrGV6FiaRDMYQJTftXmRTYsd+fv/F
	 0KkVJA4UiuD7BVFSQmqJqcZl93AHfWriiAbCJfckYmIp8lNzzR5lkXaNhvkdU6zigpuGq
	 x2cQKbWODsyOK+XdGswkrNIUoibq+zj5c5h3CJCOiFhq44Hpr1STuGcEE0l38LMYNig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WXuArCAN;
	arc=none smtp.remote-ip=74.125.224.99
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB740606A325
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB740606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WXuArCAN
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6798af41644so693731d50.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383876; x=1793988676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJErFKYPU8d+wmmwqjpCjFo6vbn7aqgwgH2UyvNH/5A=;
        b=hF9pjkSKKUxvCWBM2W+iFWNcQ9kmYlY8xCpl16FpZ+6+2pHvPqc5q9SEIz+AguHlEB
         X2vQ53xID4+KyAfxJW1eViD4Gjrrcls6cRXKefSacLmf+M5cOXzUE5He103kZuUJEbED
         2Rp12m5R20RFR28FUD4d/1dpbe28QWqBw//LlIZ7ceR2BdpSnTfFD0OvSQfF07LJgiFa
         RoseinlpoOMk9Z8fQ7tNHufUCkcqrp65zhr8Y+bRPiyWmmVUgADFaVDgBkLIW5FdLm5J
         97AH4APEYChY3KduFXBEq5AiAjETsGIOHQjhyWhJsAdwroNNtWKPRC3uSfc2/1IVWQht
         7qmQ==
X-Gm-Message-State: AFq9FYJUc4p8vgzIj3WZRGIiluZg+G41TwhY8nyyRMlo8JDgE855udle
	vkGe9TPGPs0Cni4+Mv3+KaReW4RVByYLbxzG6ZcOvAAHeGyMJobiZuUjVDxHoJUoQIgrLcz8nGn
	2Jm6KbT99aMhLbozHyjedp/ljMMUsOq7byz3PB4QHD0m7nnz9ilfki/TggV1cybe5dAQ9aQAXAE
	PGxW1V9Bqp2XPjkMYrgU7x1eZ3xnNS3XmN6FzyhcyregEhUIfOlGrWMs7lfSlcp/rHVHaokJX7B
	tISrcAmyh2s
X-Gm-Gg: AYBFou1mWPxLLdQolntcQKGU4OTgA9jDcV6kdCVMQB6udvPFWs3VeLhr8EEyxSGwBvb
	HQSB6XwF5vQseEAxTwzZZK/zBcJFs3bwa99NISLA+xLQeFX91Ueoo90HXMDl57vXW2S7kV4A8qX
	4gbUhuitlhlltPEMUtQPRGOWaPrTpoSdXqOqYrpjTdiNpJOETdY8CyfoM4QAWR0VNmewEtxHlsn
	j+74UTSus3WRVT7fpaeZkE1J4ih+vI57sSYMX45BgEfGSO+MseFpuF/vdWmKzBl7QKsyIpWb7Az
	NiX8jBAfhWH6ln0jlzwbXkybwHiemzpCOUFLe0I6IB03/Dj+cYxTU/0EofSCmkU/pbpE7cAv7Cs
	6mfS8v+0OjNgn0qBENZuDJoFgB1w6VgNj6TBu11I/lDP1xXMgmAvhYam7SorIbzmJChxAupyuDT
	y78yvdja6iHdE/xTOGBgYzzNQMVdGsA9Hf
X-Received: by 2002:a05:690e:4554:20b0:679:ad60:a9b with SMTP id 956f58d0204a3-67ba502ffa2mr1423158d50.51.1793383875557;
        Fri, 30 Oct 2026 11:11:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67baf2e6c0asm7618d50.25.2026.10.30.11.11.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-154e9d2d94fso1898522c88.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383874; x=1793988674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJErFKYPU8d+wmmwqjpCjFo6vbn7aqgwgH2UyvNH/5A=;
        b=WXuArCANuNRrlQXK1MvdXaHrH1tToNgzIMKsqHm0o9nSqld9JthB43PP4jJoGpmmOQ
         LOBjmTXh5el8wW78viuBWgDnH5yF03eZvLT4XNrcs7VM852QWZiAoIrLpDLCUn3SD8Gs
         k7l4J2GBoX9q6cfm08HdVzSK5mRAgNa9rFm6s=
X-Received: by 2002:a05:701b:4181:20b0:153:4a27:4ea5 with SMTP id a92af1059eb24-1ac5b7e02cemr4125496c88.28.1793383871607;
        Fri, 30 Oct 2026 11:11:11 -0700 (PDT)
X-Received: by 2002:a05:701b:4181:20b0:153:4a27:4ea5 with SMTP id a92af1059eb24-1ac5b7e02cemr4125437c88.28.1793383870764;
        Fri, 30 Oct 2026 11:11:10 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:10 -0700 (PDT)
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
Subject: [PATCH v11 2/6] dt-bindings: mmc: Add reset-card-at-resume property
Date: Fri, 30 Oct 2026 14:10:29 -0400
Message-Id: <20261030181034.3811225-3-kamal.dasu@broadcom.com>
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
-- 
2.34.1

