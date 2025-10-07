Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956272E229A
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845895; cv=none; b=X6RMJZFCDGWY0TBKYlN0nOH+mbOXoqHpuPW+aTz+yd3GEiUGQXB+AeUZqjpBTUR2CquqoUGZl070pi3J3GuzS69+3Sak6MRT+WFdKvf/HJzT9njfayngEWbOFps40859n8DgN0xkurPHjpwse7JG/EEZ/HaoU+dZSqTXRPeXWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845895; c=relaxed/simple;
	bh=IeHBJkm43o7DbIgNrwfftBjDn16UM0EotoQTOZb6iXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZ83pDUaT4dserPfL5FqXmFWjHkB9vRMuPQrSlRDmzSlcaSFOFBEus47ozm5tAbN5xyydp8kgvLfug7rrs6WGGU5ukOqiGqKkS3S2+xEIF8sAAG/JK/X3OR5ccTqhUg3LXb5D5aQ8DweEhFW6rVs4onMzf86UgXGACdmPQad+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KwvfG/PR; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KwvfG/PR"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so6396127a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845893; x=1760450693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px5PBDWoNSxvQicSvlQGDgd/7ifZnaEp1y0M1jncvfs=;
        b=TmoHRCW1q3T6BKYu06bqp0RuSkwae0r7zHEYJtwZiF00qkLWW+I2w9uQLSeU/Iik5K
         agAp+4ykVL47nfIkpRrC1s1Yb1OBY+zMWyjbH+9SlDJUanFg71AwDUh/gyueBclUfnJW
         MQ1zY1oth5U96gkmhlnMRXskTMiRFQOihiCNmnzmelMiMshjA7cg/7q2ZW1n0zO5cHUA
         0qCD699IooP5FTSqxjUcG939hAzhS2LkH/+AR2r0Mgjpa+fgL6RYvFMRC5ltQs9sNu6I
         MBfZ3CPkHmzOlQqdS+jEurBwKGlBQq0Y4mUPXmc+5XdzGyRPf2s3H6ls4IgNGSgql8N3
         A8bw==
X-Forwarded-Encrypted: i=1; AJvYcCUama+NwX6X8RurYlZ0BdJabadAN3+tUaZfvKLQYp0fdAbRODsKyTTshqqaEDYZdb4i++RvZ6zSf/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLgVkTjrtvrc49jlLdWsDd+QKD3owPatSr5VHnZ07+xKTOMon
	s81AcdxT15VLViTJ+lFHwYRb4W0kWZcZ96BTNFSebOoH4bgFRjPCJrBOS98M9IdsGAal1AgFKaK
	UHD6mj1AaAGJL34NEynTI4u3Dp5si0ttYSF5Rxno/0hC7z0GHMXYVtbqYeQF0VpzOVsnbv+uyYc
	ayuBR5J/VH416hrPPlHhUwXfa9UjZgRY9qCH8yje8NDW7FrREFDEnig3+O9P+EvcpvUqiO7KQVk
	RcW/WD7yNne
X-Gm-Gg: ASbGncv3rvNDdGrMrpSWS/9UI8qbp2X/6rPtTg+hIUejxBH+sPVBrkP11bLjsdVhZ+M
	veGN4boOMh+7n4purHwfDeZMPpHF6PBCuh2rNL1lUJb1mq6zq113Zp6pbf5jymmjAwUPgUgJ8LO
	aPuQVPZvU+JCfqfh3Tanj2Nw2hyLthWLAXrQrQAEZa90rHIykIxLT8cr4jXoEUn4WZpI/T/g5mZ
	WvU+ocCypAmZI7dOL8cAY9r852xtxZsm7Z/7DcEmJUO39lTDXEet5NYufXnc/Ya8nVK3rPQ6DAs
	a4Mmuz207aTvx/EFtb+hXUdRI53tlN8rG59INsvg5ZjeAGmOm7LpM3BtpvXGhQy+XJv6qLIYJxC
	13DNrj8ks3HxF/EKYJMVtIxFsp3amHHrrX06Hjvoh01wDFleby+UbdbTnzck0BFJQId9sqUbrCK
	/6XGCq
X-Google-Smtp-Source: AGHT+IE0oGe1epUa7THcZLPlNEJa4Trbn9ASJN82GkEkGkcs+zKRGXxFShElLEBJ47ZCr6s4lB9k2ewKbrTN
X-Received: by 2002:a17:90a:e7c7:b0:32e:38b0:1600 with SMTP id 98e67ed59e1d1-339c27164c7mr22967429a91.6.1759845892518;
        Tue, 07 Oct 2025 07:04:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-339b4f22f9esm1591030a91.6.2025.10.07.07.04.52
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:04:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79e48b76f68so180009286d6.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845891; x=1760450691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px5PBDWoNSxvQicSvlQGDgd/7ifZnaEp1y0M1jncvfs=;
        b=KwvfG/PR0ngd3PbHlS61WAjVgazkNsaKQHwp63pzFb30dB4aJMBCvcxcf15UYTrC8G
         NonoFNs8YUSPK4zDQrG2F3u4nlWOWTPF2vYwQNmAy/OWNT+w8ZMWWZHNTDv0wmY7WrIH
         yJDzxtN4eNH/kcDzw2U7edapQO9HTw2D1CG+U=
X-Forwarded-Encrypted: i=1; AJvYcCUIc4dmpJrNOYQHiQ0odrxihsm+IAllKu6a5uZ2Avy/3r+NGcEg42XolgqQ8jtzmm3fzZVPeWgB2G0=@vger.kernel.org
X-Received: by 2002:a05:6214:f6d:b0:792:61c0:beb0 with SMTP id 6a1803df08f44-879dc87f7c2mr226138996d6.67.1759845891159;
        Tue, 07 Oct 2025 07:04:51 -0700 (PDT)
X-Received: by 2002:a05:6214:f6d:b0:792:61c0:beb0 with SMTP id 6a1803df08f44-879dc87f7c2mr226137866d6.67.1759845890256;
        Tue, 07 Oct 2025 07:04:50 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:49 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host controller
Date: Tue,  7 Oct 2025 10:04:29 -0400
Message-Id: <20251007140434.606051-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Updating compatibility to support BCM72116 and BCM74371 SD host controller
similar to other settop SoCs.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index eee6be7a7867..720d0762078f 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -21,9 +21,11 @@ properties:
       - items:
           - enum:
               - brcm,bcm2712-sdhci
+              - brcm,bcm72116-sdhci
               - brcm,bcm74165b0-sdhci
               - brcm,bcm7445-sdhci
               - brcm,bcm7425-sdhci
+              - brcm,bcm74371-sdhci
           - const: brcm,sdhci-brcmstb
 
   reg:
-- 
2.34.1

