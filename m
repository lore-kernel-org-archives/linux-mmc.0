Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426282;
	b=NdzTOuSTriBpdRs9EFQpRy0sMci2Qa2n96xEd7BZlb1AwQeAfEklNCX30p5X//gGa7/y
	 +Nu7XLKDTUhBIPA7PBh6MvU5Ut8X7BGp67tZM2rwEKnJCYDEWGZpHGXlDuFCQSMAJLgcL
	 3eHVwkwYKzZGcmiTIBd4mevAgx/YKPspSsSUraQ0+oyIpdKFTClw5Y8n3VS2KS9NAI64F
	 robTMvunxXG9uz6Ev4lXas7iyWKQ51JMft2uP6tEwEtL7swn+AzzTLD/K9V40PH3wkvrK
	 t2TIkFlX/92NlbrYRVGwKWbUz5J1byAciq0PVC4W7SMN7TCpx2N7DUD/8xzSuvi4cUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426282;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
	b=Hg3L2X2QXJTpLxU0xBKLyvKx4kQFQ0q8q4wMnPU4FfxoJSnI+r5YC0+RgEGgImWv0Pa4
	 8V71LdnAxCIsvChgekg3gNR5dsdTmDKTanhj72lsZ/Fyd9Jpl28gO04nYZap9jpzYTdMA
	 6PwTKGb7Q308ZpcnX1dwTCZzUtdLH8XTYsMIz4hTeyXHHkjrPmgg6jKRWUnYSdt/SlR5B
	 rvUdve01Q5e5YiAIVvuGCp1XPcE2a6D5DmDgVkJRIKNR5emBp02F+JGs3rEPzfwS6nzrS
	 lnaPe1vEETkxgsjbzNqPi83KwEmcFgQWjyMZg4/bTv62a8nprdf5J8Ww4cTRvymxYiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=guxa27zZ;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE77606A33A
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE77606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=guxa27zZ
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2214729a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426282; x=1795031082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
        b=QgsyqVYgjpRunJkchnKW5srQhcL+tmnvzb1YFQuTeskTXRAkTwjfVy7B9eeOraEhIG
         mSoNJxd1Gn+fe6HbaHhbkEzpGEnMi2L+a0DgcCt2DOjTICH9M0ccfHb4lP78ysmx+F2x
         DEwa2CY10vxGa4USt8/21RuFZKORRx8JRh0cXyCalDRPWbHbf8JZ7qkaqIB0La6uig+z
         7T38T1zOh5tTvTgGavcTMWKRdCSYhRnVpkmFqAP2LarMMSqJ284jmIZZuMgypvfKHHHt
         vh9V5nBAEVxf3ES/f5gAlXhbqMHdZ6vAMM4vrmYkanqkFVsfqI3pHGPGlbukh9wQS/+Z
         8M7g==
X-Gm-Message-State: APuU4Z/2XkCqMKaKzfFJIwNdWMgfHt6mywAsBtv2sS6xoi8H3udqNeOF
	8V6FH2FOlB7boVBuXY8nPnSwOR5r7cAthyTdQ8EOPC0AVzaXRDdPlJrEpV7NnU8AchHO4ZV+tgw
	L4a+/fUeuQehMKw4Uy+PVptRGdcJkvC4OWxTor0JCEQW4lkoBYb6poLZ3fjyPseYfuv5QBEzZSp
	FiLZti172gHaPlXiqlIBORAsDBbVAsvFCqR34G1e90JFvfCWYkXpm9zUl4hw4g03Sf4fIXF68/q
	Dztp3+9I0Ac
X-Gm-Gg: AYBFou0e2t6lzzAu0RIq9TpNt2xpHzv+uoFspa0h+hL38r1NvqSmOb69uIUk6B2w8em
	R5SBr8d6RqDiYCmP2AYcRoKfpgCHobC3hvSZeiQ2tc6NQb+kJPYyqixf2qGOHljzo4PLcFa2TYP
	wOheHQPlq4Jq6Nfod3Fx+cw09vZCSWRcjO3B4OWtqhFg31vDynKMnFKEcxIF8gUDh4lUFDZ1YTP
	Sa0v5d7xoPgKdyNxhJpgKDPvYtfcbMSwWoFe2YDB6YnkT+J2jyODrS8VwlwMfyph/AvIfRIKx/t
	J3uQegLD9bxZiqRBSV/FrpNNhUc5XmUAXZ7K016lq5DVhGV2nSkIZqNdq+XMgrY99kIxeB/dhMD
	dkM2tWP0ElSOVUCjIiHuqG+WU2L2d4tLucq8OvL+b/fTLtiukFcLbeDjHGfH+BUk//Zf5k7r0yE
	kOGp+dvPPHyxICiHFFrSvkivzEOgVbLTX1
X-Received: by 2002:a17:90b:3ec5:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b182f298f7mr3366209a91.52.1794426281823;
        Wed, 11 Nov 2026 11:44:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197cdc76asm257941a91.7.2026.11.11.11.44.41
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5733115eec.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426280; x=1795031080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
        b=guxa27zZRfTWtWfW1S/JEPoAe7KOwlowtFR/DkAOtesHHpBVawfWXxsq71ZQxihrlK
         PAoSAOJajUeRNgmwNGBLjmkvzr5WcLLpub1a2o6PE57Rc8gD0iAjILcDcsgje1yNQA7o
         oNIrKV4AIdOaDFiiHFxF3F+uO6XFQsHVjniL4=
X-Received: by 2002:a05:7300:5621:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-376850d00demr3734277eec.11.1794426279806;
        Wed, 11 Nov 2026 11:44:39 -0800 (PST)
X-Received: by 2002:a05:7300:5621:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-376850d00demr3734228eec.11.1794426278882;
        Wed, 11 Nov 2026 11:44:38 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:38 -0800 (PST)
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
Subject: [PATCH v12 2/6] dt-bindings: mmc: Add reset-card-at-resume property
Date: Wed, 11 Nov 2026 14:44:22 -0500
Message-Id: <20261111194426.1652644-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
References: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
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
