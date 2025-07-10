Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55C2512D5
	for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148640; cv=none; b=d1/yJ3npLAMtwXneRY2aOHm4qtVWvrqcn3IuZZaNt+t/eQZw7x/F5ubjQf9lVdhZkTikim12c8t+NxTdk4VIo6HJ7txelw8fenBxKDZ20U3etGL1uMwXPMhKxqaPUvlia7xfq689mHRW1Z4a9HGOkeryZ5SPVJ6BwpDIycsF5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148640; c=relaxed/simple;
	bh=5CHUH6a1f97IIC538ZJby+c8UkArNLi/mhEXHzwRaPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LC+4tEXG/JMuckqAWFhEoL3jhRDb/fbum5QDKP9+di1Ytfnb/CBwYzYUKPhTbXA5b9G+YD8ZIoEcwZUq2fUEsJNpBpMetFiXr3tHgawD2e5wo5aGaLEgsTQdFl9M49zh23mLOeXFTlQZ2U9QRLQSygmxnaCWfpTyWINJlwDQXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYrXpEna; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYrXpEna"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so765606f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148636; x=1752753436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsS0XUmpT0QmMaxWYo71KlLo8Aaaxss20wqdq4V9g/c=;
        b=RYrXpEnaOxl0jM3RdGtuqYjfaGYXEbRbxC3ltpKpqhP5d0elngrNJ/Zx3Sue9Xc9ux
         ORlIMphgTh+jIP6pWWZYfKCZrebJeqYNAa3XPIZJJnE9rIPabcTlMpVUWKF1octUgMRr
         TCz8Bjxwn3ELaiDiC6DzcSQFCkKL0hDAujpbh00ajd8ZMWrVrPY0cfSj/Vhc3RbPfWvI
         ZDW8/uUMJY7S0rZggCUOBq36xoD0VXQLoobeBi2UBhVL0VuMZz40QQEC/S40Bb3cxvT0
         JX1T8A6ZMGVaSux0X7fw1jLm+Q+1flVpKGYTjmvGRGr2Dgmc19NeqinASPyAql8epkl4
         PeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148636; x=1752753436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsS0XUmpT0QmMaxWYo71KlLo8Aaaxss20wqdq4V9g/c=;
        b=UJRqIQfxhjTfHX2I8PnUNBBdRFxK3cfyfoAMYwhq2jYS9Rd4p4jKs7+93p+4mHh8h6
         /Eyk7k0mOBJWilF1qVNb41QOXow1hJOhWOkaIy2Jdp8Hqw2ZzZDtGw8iS2J8TM1dZxp6
         TEQ5PNmmcAz3s2q0Ggyr1HkRD2OOpqCGW6ei3JCYkD+EXFQCefjxQcY0Bao4Xpbqql+9
         brfe5aU1/uTps+4+tb2KcYmfG/Nk1czPKmiUXyuR9YMD6JH42zQ3IieZiJh3z2xN2kNl
         h0qNC4NT5X4MlXCpVXmC+S49FrJFLM9Z+LLsC57NNEIGPHtgIiYksLmMwJWgBdDIApDl
         hNqQ==
X-Gm-Message-State: AOJu0YygxYyp8f08JzUXzWMJ6CX2Z/cIDBNFRdzRfGZyMp4B1s4Htt31
	VN5uLer6rk8/0ThyoNK8z5PLhrGlJm6jC9aM8Ae0NJDPauFhK/KtckuKkB/1vA==
X-Gm-Gg: ASbGncv5PhS2rs2R2S/LyLf3C0JuRnOJOdk5DKK6bJDqssvDxzk+LaQgBnE0DTRub1t
	nbjZd1vgwmBAR70Hf7R0hUCEjJtOGz8nYtRTHHDPYkSK9srph4q7RNmWJ7D9GrGIVlSh2LqBuP9
	FC4kAYDTPEAYFrp45O109pQq1Nd5E7s1f/fMvgR2hEjFXY3HlSQiYIYqlHiaGT6cydIdMuq/A2D
	0bu6wPaD9gZn2lxYiMChJeUF+cbp7WcQfO4xFcgiwtKjJdysRCHrLv1L5OhOwnaZV7L9MyWM0Sc
	PpPrVOa/c4GfDKU7m55OEWhg/RvF+UUDRHDUeXt6hcsIx+ALBP2urqC8i1Rv0ELCLpgCSRbmlGB
	y68g87QT0bT2ssbVv0u2pEPN8FjQNARIYLlfjmlsoIKdpNVHoo2UNEg==
X-Google-Smtp-Source: AGHT+IGVT02aEcOQDibc28Ip9sEW71Z8cwalkc80g/oqIqVIqwtUkjHjZef07lbNyPzhz7W4HboScg==
X-Received: by 2002:a05:6000:41fa:b0:3b4:990a:e6 with SMTP id ffacd0b85a97d-3b5e85fedffmr2219758f8f.0.1752148636220;
        Thu, 10 Jul 2025 04:57:16 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2747fsm1652622f8f.100.2025.07.10.04.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:57:15 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	Michele Dionisio <michele.dionisio@gmail.com>
Subject: [PATCH 1/3] mmc-utils: Doc: add missing documentation for cache commands
Date: Thu, 10 Jul 2025 13:56:32 +0200
Message-ID: <20250710115653.2808619-2-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710115653.2808619-1-michele.dionisio@gmail.com>
References: <PH7PR16MB6196D50A37E3A318ED6B98BEE54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
 <20250710115653.2808619-1-michele.dionisio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
---
 docs/HOWTO.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index f2f2f35..9b1f1a8 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -107,3 +107,13 @@ Running mmc-utils
     ``mmc rpmb secure-wp-enable <rpmb device> <key file>``
         Disable updating WP related EXT_CSD and CSD fields.
         Applicable only if secure write protect mode is enabled.
+
+
+
+    ``mmc cache enable <device>``
+        Enable the eMMC cache feature on <device>.
+        Applicable only if device version >= eMMC4.5.
+
+    ``mmc cache disable <device>``
+        Disable the eMMC cache feature on <device>.
+        Applicable only if device version >= eMMC4.5.
-- 
2.43.0

