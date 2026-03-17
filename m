Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2F342177
	for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775992; cv=none; b=cmgvhcAUx3BcDH7WkCjnQ++gHJuwIPw/Sjx+VUX4R6CXSt90RQsT8h+qig0/XWeWijkGf1qB+aCJsGWNSyyffSg4Pi5sp6r97+DS0lvE0ahb49prIXCOBYKpxFJPUDmxInwsWVAtlf1erIU5xubHayiIqIaFC6pC6QvyKIXYWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775992; c=relaxed/simple;
	bh=YC9IEDm4P+XCFI8cekWPlwUxTufi+lPvC35nRVPRi8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sdQnl+XBXnVwxqSXP8Q0RR8uJYaHBX0AE/CgeEX9CDo2dZWp+66B3FkNjNNvkCxhUubcS3KefybUUJoghlSDQ6oHjaBnjfwKWUYqVuFYhVM1ZdlqiPwvAa5X6nSjVPCwF2vIZEOtRe14kAGmDs8gQTDIAw3OHGPfu/Q/ofuOjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZNORol7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZNORol7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so71611085e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773775989; x=1774380789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NlxR5Tgrx776rhivqN5ADbhhNsF2/lblG4PiOUD3Eg=;
        b=MZNORol7E8hs5QlC+/CvIrJZ7pZhpecthh1hTmjop/xVdZsPjI4T8L/m2jIR7+6HxW
         1FlLSuU2S3F1X5cCMcvaYHH/PxNCJyrvlpJvFCMRJ/wYRnTYu57W0wJnE2c/3WUB9pxI
         5UWE+cyoFYMlBEOTXbHDRc/BfhFeD9NvcWbP2jfP9KArWZ6GG1BvqHToxsGWSBi1CrVH
         P6mr1vdahJSf66SxcOMRsn5DgXj/6qNfePeNqpOQ4QDpSigM1ByMO86GvPk8ohIF+iEK
         TPOEiCysUO5znQZQHbEXM7T1mSqaH4QwNBN97TmXF6kttOvYAz0aarTxay/gmfYUiQrK
         Qq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773775989; x=1774380789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NlxR5Tgrx776rhivqN5ADbhhNsF2/lblG4PiOUD3Eg=;
        b=Dmxd16a0S2Y+8cLDE58/GOlbsJWRv+y9hNMmeP7ZKaYC1E1uAad8wvpPog7PPwHVc+
         KfY9Qhs+SVHk91MUHCO8kFc+W3ubGru0qfIKLJ8X3EnIALyhIJcycMcqJBWKJFYMCl3v
         7NNCVbJ0cEjsun/xo7iPfamzdoi9CB3ypvbyz28VMQNcrlQCcldXMQyAdNjhaZaFxhUX
         fZCuG6I9hie8cUPIQTr3lih8wF/SSXR1tEROLiDy2RQhrwKqZ9IfwyAkdpcVK6vKHEBH
         a/TBLn/H0MFt3ofcoaJTjDlih36oUstTls6WSFIwxzkGaeq0tUBAL9lpsNlwmFSLJujV
         dP2A==
X-Gm-Message-State: AOJu0Yzb000uxf47sSttLKR+vAeyK/RsDhiWbXa68pDdM4upv3BGMU1n
	9J9OcBLyWABu4PtdLaN6RM9AIFCkzWZJOJoVTWKze6Tejr49S4LrZPTK
X-Gm-Gg: ATEYQzzPxpI0JNyOYspqJlqRlm7m7RddRRAx2CSEkWn7tIpALx1bDAvFDWNDe9AzqZ7
	Dg+qNqX1jvj/6/tM0RBdUIQvoCusyyVMj91pwnPqOLaoAeIO1xf1WCDeL41y/1kffXmtmAsbcjv
	jz5fyZtoPsnWUr7dSfxLChv2U4dWVVethM/hqUFKC6STZHLqXIEEXgqbkBafJj6X8w1EnapGs8M
	45v+jixjTE8EQjjRaRNLdhFLz0bZpyB/TpGhN7ZsKPikYsXhGp3MFabtifdMasFnhUXtbBd7F8A
	W03eXBw7PY3hVHI6lTeNxgw2E/K2zNzu95IMYVN7M2DAoZax2GWzCXP5cq5DKPZ9/Ye6p+6CwHm
	nxMVUCcHqsjMyEIHGXzLS0oQxzYlf/jfChur/sEXom+4ItGFDAqVdV6LR5YyaVCCu8cmx6qxcl/
	mEX8D2oL6pw7YgDPPQzyO3yHZLnfcASjQTzCs0Gy8apvqW
X-Received: by 2002:a05:600c:1f93:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-486f446b009mr12557155e9.18.1773775989293;
        Tue, 17 Mar 2026 12:33:09 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f442d5b6sm20657885e9.11.2026.03.17.12.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:33:07 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v4] mmc: core: add Kingston CID to quirks
Date: Tue, 17 Mar 2026 20:33:03 +0100
Message-ID: <20260317193303.14000-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the CID_MANFID_KINGSTON definition for centralized management of microSD cards. This allows identifying Kingston cards that require specific workarounds.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/mmc/core/quirks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c..d736bb4be 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
-- 
2.47.3

