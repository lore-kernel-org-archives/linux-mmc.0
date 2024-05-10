Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5316F8EB
	for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351729; cv=none; b=qUSCXe2gfG5dNszzVQIGCDixBrZ5oGrslxs2dcQc/Jmwbqa/6/yQJzEpGBpIYbfytpHMit3EJYgJbBmGRL4FD5VI1PPIyzL3JYqe3ZqO5+ulEIUd7Lwl1usZS/eRE/qgjhry9NY9HucceI//hwZYgscoYf8cezbdc3MHQ7ZUEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351729; c=relaxed/simple;
	bh=kATQMNOhJrdbief3Fgl9OA3f1yYFHp3atah9Ebe5p/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSHWSNafo/KIWCUbJTp8BfFR2NvbePH0Kg9CePJpnvJjm6yLtV3qw9sxmPh64gUgFH+DiJE/lXkMaS7fLHKl0GikHg2AkBP+15kcmleh4pFZ1DXQjmmyXzcmI2i6r3w6Xq7dYJHLkMX4xAqJm0C8RoAFeQ9jB1SdAb+yy2kGtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ntflsule; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ntflsule"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso37382671fa.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715351726; x=1715956526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhvBTKrIEHNw+3a6hb0Xwmt+4VWhx+P/N8uTLnP7/w0=;
        b=NtflsuleneyiSe8fyggklJJCyZrlNS+7h+NUOYbNLGh4/vwTPZgbtMd3BZFsbmNjje
         VYvWEWwBduIMmrhEwpmXXkFUl6JFDr+ZEtbkKQNKC8V9DySLTyHeuXQtOxCWepoSWz7e
         EniYE7vSwdJ8D9jXdLLN1Li1JMbnbs2+jrqviSzSQ2H5DJF65ONhQSfrF2yqoSXnDkr1
         C4asEYE0AYlkhj7LbXjNmRsr79sMEa5lcf+Lg/pV8SvNQWggoSnPHBq40D15pEJ3ePxi
         ZcZ1J5hRaM50gYV0yuCn6dbBeaUyH8VG6HIuyOhfsxAiJDvp53j06bC9fR5IQNOisQ4i
         iBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351726; x=1715956526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhvBTKrIEHNw+3a6hb0Xwmt+4VWhx+P/N8uTLnP7/w0=;
        b=A6oJ645fpJtr5vmwRWKE/LT3Biw7sCIpmU43+5/iG5bZSvgiCEv9DCUIyUbihrDddz
         7UUzdEyLGcGvbS1VDDTFbG3LXP8Sy4NSj1Ih2500FAvPrrbOq3WdCizv4adk1nDfr0/1
         PHi44cpa9cIy6gvpyOFb/CqPx+YJSZYUj+cYV2h1ZiWq9Y3nFPg1yQnYkgXJ692SP+PD
         ExBB2EQRr4XzP06SZPYRLs6A3cG03F3w7viThqDNGUALLcnGBOAzJrOkxoRE6CUBfN47
         1lgeIE+uxb5lTgnCyIlQ+GgB00DmWwHVWWqXhNRuv2ArqTv1WunlihcNwWlsE/nMSHTT
         XTJg==
X-Forwarded-Encrypted: i=1; AJvYcCUfu4AcbDleiR6+uxsfgvO8JqvP5uzZwDEtbin5hUp+NwvfkIp02MxtuU+vX8ipX8ls+gIl454qsiEj100iMC4azgLHKRa+9i2n
X-Gm-Message-State: AOJu0YzSFUC+pjA4I6NFfkWBG4EEv3IG4+lz17UlPNBMc5RU/zc6hvFU
	0xSQD9aHVpn51vKfde8f8Kt3CKvCfkRQwgs+ZaiDZr5+H5cuDoJMphwR+AUfab4=
X-Google-Smtp-Source: AGHT+IEAC9dVjDMT1UPdVqARhjQhRcXJv3fsVQDnUMR3w47CcGcW+O53nF2+nRJEW7ujUyZvmdSP2g==
X-Received: by 2002:a2e:bc24:0:b0:2e0:83a9:e385 with SMTP id 38308e7fff4ca-2e51fc340a2mr28548151fa.6.1715351725643;
        Fri, 10 May 2024 07:35:25 -0700 (PDT)
Received: from localhost (host-95-235-217-160.retail.telecomitalia.it. [95.235.217.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fc4sm191151166b.135.2024.05.10.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:35:25 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Fri, 10 May 2024 16:35:27 +0200
Message-ID: <e60ee068f06cb2325e3d09c27b27002ba6db8572.1715332922.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715332922.git.andrea.porta@suse.com>
References: <cover.1715332922.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3

