Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B2176AAA
	for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063916; cv=none; b=ckSLhHzUp/awjRrM5aKctdk5R2AtjqQU+Cx0b8YELr49t7TCWqvLJzHilIYX6xCnBTjO0Lq9PZJiXpeKCzLDC1/t+mwUsQCRcjcXxHAAXIkiJ+o9Yi8A8if4OoLiqebW4vye1dXrWE6aECMeN5Sw+rPO+5B5+6IWtZsufr8NTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063916; c=relaxed/simple;
	bh=wEWzUb64Vc7F2Q3LuJkl752STUy+7RzVyEj0EIa99AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTCc9RByEoz1TQkyNZC+BFqSMAJrHS1fCCKYTGS4anuz01MV+fkrtXokr5ju2fBesV8zC96U1TY1SROoag3fLuCSEr7knOj5SmFCrT6exp+paz0nX6ba3beLx/ZMik6PCu6oW1jB02cBfA6j555cDI047Mhs207yib3Ni5Nw3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DR0iGjrP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DR0iGjrP"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b7fcd1db4so396846e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717063913; x=1717668713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4ruLk9Ftm9+QjaAcWOvP48LMnKLjWaDjJj5/jKtjp0=;
        b=DR0iGjrPS4QuMbaSjqmYLQZncSxGa/Bci/lJQ6iLLPWgCGgY0FNGNyzbSh7KPPu653
         RhU+Py9BaZoXN3/zFui+17x/v/3jRhde8np9wFQ36uQMt7CkKgdubkB15gRNZK+uymza
         E0zmx8dS4TxVyz50mChK5xNaNfdD+8atC9Wef8q97H9lHAA31N4Z5V5Ftfoumj/laVZL
         P3UpmJMmoWG1PHxCCavUT61JDftfUqknUrmMxj3WQwWXXPLYmZz4WMqfJHU2UWa7TaTh
         E9hj83bQBPYxwLh7huOSiut2ewgOyLuiwAJP4yFMKz4vOqb6qvrJA5tYmMyZyWswXYDl
         O/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063913; x=1717668713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4ruLk9Ftm9+QjaAcWOvP48LMnKLjWaDjJj5/jKtjp0=;
        b=pUdgnE6OP72bwdc8LKO3xIi1ZyfI6FqpTkgmKEaJOjEG7SMTVii6MNZScoWP/P/d2d
         ztxixxMgNppwPd4iSgjTgJTBXhmrDecvcKCY/wbUy5kJklo5utEGGYxaZ7FvPaJ+3pJ/
         aH+OFSIh10Mp5Gptn08AG+cnvSxc1cRsE8Mw5hJzVa6XpVJpkorqy9E7FclDVhtZJoVz
         UIkzPm9Nmp+0nzI+67pA/rZLZehyKGI2YWIikninwibbO9+fEN2eo03X9/S20W50JTtw
         7uYHGTQCcbknu8Q8cUv1MVzD68t9u8Ok1VaOU06SHuZdusJ+Mc3c6EAXuDH/msH0rPlo
         kU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRBV7mrbZKlaHU/mKyzB42Do3BbEBl/TrCvUn0ellAX5bj9dwUCvt3HgrpxsvHIXyLdxJQIlPJsn2nKSUAvLvfwuliGFC8OkeA
X-Gm-Message-State: AOJu0Yy3PMcLGQsga03KRclg33BskOWHfoD41pA4dR8/AU+hA6oTV33x
	QWI8OaeAVAiE1ZG1A/lOGvGVKtOdC2yHyV7SoSjCvIZFwWv55vCe+q91zbYveYo=
X-Google-Smtp-Source: AGHT+IHKELWEC1v/nerdFhSEuhPemYySFWzIWZQFDT3Ps3RHOrqqWa9HWxlgaztorNoQN9pOQkFXRQ==
X-Received: by 2002:ac2:5496:0:b0:529:1dd4:3e76 with SMTP id 2adb3069b0e04-52b7d480865mr883981e87.59.1717063912908;
        Thu, 30 May 2024 03:11:52 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a22aa3f8bsm530025a12.22.2024.05.30.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:11:52 -0700 (PDT)
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
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/4] dt-bindings: mmc: Add support for BCM2712 SD host controller
Date: Thu, 30 May 2024 12:11:59 +0200
Message-ID: <f6e0d1fbc6c5e620897b5c65c95147ceaeed1485.1717061147.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
References: <cover.1717061147.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 has an SDHCI capable host interface similar to the one found
in other STB chipsets. Add the relevant compatible string.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index cbd3d6c6c77f..eee6be7a7867 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -20,6 +20,7 @@ properties:
           - const: brcm,sdhci-brcmstb
       - items:
           - enum:
+              - brcm,bcm2712-sdhci
               - brcm,bcm74165b0-sdhci
               - brcm,bcm7445-sdhci
               - brcm,bcm7425-sdhci
-- 
2.35.3

