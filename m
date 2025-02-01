Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF59461
	for <linux-mmc@vger.kernel.org>; Sat,  1 Feb 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373382; cv=none; b=blr51o/aRzYnA30wzdTom9vJCbOdo62PfNLCf53qJEB6mwtjP377BYC8gTEF+4wgdAi5TwZMr+bIamHsvYjdhOuVgJJY+gHazre7/eII6KitqTHloiTE+gQ/nknM/fDr8tOqW8/m8j4WS2xSzGwlTe1Q5LCnjIbJBkSX01o+1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373382; c=relaxed/simple;
	bh=hAmiMt7weDFFHN4ZxZ/UQfS3btiC96PgxGS7mJuKNq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6apcjrwYGwPZigf9+lcx24T7rtKi3YT/KZT80AOVghdnmweomWo6FbwTlw8IPpZZ4UqlrylZ3HGc75aK6ec7afCsiRZlOo/NpgYasOSpJnEUUsVIypMfhpxkCMjF5e3d/OLXekmpOZPXXn9E5H1c4CLvZnTxh8T4m/75fwQ5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HHgIc2OG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHgIc2OG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21649a7bcdcso46382185ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 17:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738373380; x=1738978180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECCjujGy5Cc2LmvsTfFJ+NBouL7ixHfcPEvuQDQGf+s=;
        b=HHgIc2OGQYXHNgC1LBBR2GeEnBbOw5+cv+dUffek2SIBA7CMJ2kPg8a5GEFp1IFQNf
         FWaWC/YW4e8UZ790bi401JAYENs+5wfmWhDbdAEcivKy0yPw4n7pE3z/azR+QEhBtrsu
         SpNVL8uXTXkayqTAhvbwMcuNy7FSs5c4My0ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738373380; x=1738978180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECCjujGy5Cc2LmvsTfFJ+NBouL7ixHfcPEvuQDQGf+s=;
        b=KrgQ27HBunq4y9gPlknF66+J+eW252MuuRlUyzY+A9t6p5r7poINgj5C/eiOq95+WZ
         JLmSYVI+17zw4SmxJ51sbu4xgblrm16mFZRKTkGCpzryE/2Sazt34eYIdn6trZ2AdNhb
         Jz4YPsIy9FxuvmYJP0b/OYahbpNYUYCOvTBghrNyw2OwCvd9Qv0UzNLqQ9FYFqzBVRJZ
         uIAKlb62W3acPt3MQ9j5UehNqujPJNYYnaFnF07ebksgu7SVz6/cTpUuS0Uid9Fmu3rP
         GfgQamfnJYrjTDMGdHlAzbRV5ATiKzAIrJ8y5NYv50QyCfWsetnVdguSSt6EUp9pwjE7
         +WzA==
X-Gm-Message-State: AOJu0YyEW1wBDQStgZUD0UKoI3bwvTAt8jNUgFU4hFvki5iCqKODH9dh
	XXFUDySvUb73+bD03a+ErIKx9FlMlGamE5XYBLRdi56MMxpAdH3uWNK2JW4Iag==
X-Gm-Gg: ASbGncuuQ3eCUE7CmQ78I1KcVA5ZeLY5NEpm37NnBEeoEMl5a6x80agTcq2LWGLdmzC
	LNtQxNmk4qdYNKraEaA9evAqhteGkGzEWsZpnero8XT9NLO9A7gZ7oRwh7LLwUUu9wURCwZDXs9
	TuiixSodqGOc4Z7289m8r6rz/cKu7H6Wp/9VpMGJLm7jrMOhIsWoK9xGPtbbTLJW7NwQuXF/rri
	Q/gq0SIj9LheGrMCgVirgaw/POYlzVScQfAno1T8T4kfzW6CEBPm5gKXPkpEzPctMPH763GmWRx
	TLmq6dWj
X-Google-Smtp-Source: AGHT+IFKlEl1L8cgssT1r26n6Hu6VKhtTt0FskQFV6/80KacmFo7RRmSXF9TlwOE1msSGJxEAXuOWg==
X-Received: by 2002:a17:902:e54e:b0:212:fa3:f627 with SMTP id d9443c01a7336-21dd7c65839mr200018135ad.16.1738373380515;
        Fri, 31 Jan 2025 17:29:40 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:a8cb:24f0:42fd:5a4e])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de33200f2sm35769545ad.242.2025.01.31.17.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 17:29:39 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Makefile: fix conditional around sparse
Date: Fri, 31 Jan 2025 17:29:36 -0800
Message-ID: <20250201012936.2816101-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse would always be invoked, since `ifdef C` is always true afet `C ?= xx`.
Instead, use ifeq to check if C is 0 or 1.

Fixes f884bfe684f ("mmc-utils: Make functions static for local scope enforcement")

---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 06ae0f7..c0284bb 100644
--- a/Makefile
+++ b/Makefile
@@ -27,14 +27,14 @@ progs = mmc
 
 # make C=1 to enable sparse - default
 C ?= 1
-ifdef C
+ifeq "$(C)" "1"
 	check = sparse $(CHECKFLAGS) $(AM_CFLAGS)
 endif
 
 all: $(progs)
 
 .c.o:
-ifdef C
+ifeq "$(C)" "1"
 	$(check) $<
 endif
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
-- 
2.48.1.362.g079036d154-goog

