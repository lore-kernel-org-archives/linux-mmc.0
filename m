Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AB204C04
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603750; cv=none; b=nW8Ry4ylYjue9EGLK29JYjZ7rTSZ3b3hfBvSe2woLV98QBhMotW1Ip8S2TpxC8CVGqLJaCyIlI34/hWiAYPDMSC81pbJkwlzt+2Gutu0Lr05xqCMtOmpetBavIA758LBaHjwWYLN7MFpz4nK3k0KLGOOEtHegIZmn7eXNOBnkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603750; c=relaxed/simple;
	bh=PvMsel52XFN2ROMkCSKflNxymglNpSXuyrVhSHatweM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwp1ZnVyAxpsF+4rDLKu/8dIdTuP+79DrfAnR+V9zFlk+i3o0oMzLfWjt3FrqTFsVbJL4Aa+C5vIyRpobbeCZDJ291IiBNWyuKhxokUGKLRd3jF0vHnehVLZe/Yj2ZWaur7K5z2MeFiRAPYX4ehxUdgkxFNILO7NM/cT8Dud0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qsy+K95u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qsy+K95u"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2162c0f6a39so99738165ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738603748; x=1739208548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AQdX3sSSejL6qHtqKIVm1rV4I9qXdIfDh86RuQnIro=;
        b=Qsy+K95ueY+nk/0t4mbV+34XIe8uYojwBs7a8Uzr/rrgIiDoYoeyEZVst1AuxMNLgz
         HclbpZFAoSUmJRbrf7i32/FnMoz4kmN/RG0XU2s4rPz9Oq0AXESCI9CFdeRbFXDQkyfZ
         ylQCmhdj4hDUWhyzzCKqv/v+okDFA92Sfdl54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738603748; x=1739208548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AQdX3sSSejL6qHtqKIVm1rV4I9qXdIfDh86RuQnIro=;
        b=qG7ubjvVFxaUQ3fQHIC8iUlhd/NfSnSDziMWEtjPgE/JBSSWoz3e6qs8MmnVPKbyzG
         a3WQ83CjUuL7e8j1zToFXHtIjWPaSzcIJXIE+Wx84qFsrtFf7x8jdyyOs3y/maZ3mQiH
         KfVfvOjCvunau31ZLwbtNqFDpvcm7P0r7QdfoOffCZe1l1+Gz1gxgO0/su/p1uuRgLuk
         UrIXkg2V4puldtI+wC0EeMntefzfyj5DAQ5p/mQAt+HVJPSDCBVgQIzQ3ewLCLZbrNot
         craf0+RYvQu38jweh11OPdeSGaVUK4ejGyDmq1RMPI41tdwxtSVZuBK3hRvkNsfBYDIk
         /oDA==
X-Forwarded-Encrypted: i=1; AJvYcCXRtvHvvz+3zw4FpjE6qxyr/jli3AzI9WLgYfYFBLNm4jj5FFIdsqc0ZTSW1PyrlTvU1tM6auD34iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNo3YVko6LFWjSXo3J7Q3V0LhALZdW7qZknBWi94aihIm7j6/
	NRNLeirMAwwNG3EBMxZBGk1UTMF9GYUxzXsjs16vzyNVPthoZ/X1RP6DXH8Twg==
X-Gm-Gg: ASbGnctEmqITFrvcCx+DGGUUjRcUULPY/lWrWYPzwn05sNGIU5Xd/w3arM4wOLxaUQZ
	Lo99zXS6sNEcVOq3rXb6Sqr13+lkJ+rMznFRKHD1wYY3KX/ZyWLRDBBf7RQogeSFGcs6aibXYW8
	ghGVFlguv57++Jnlxc4YBgZumBZk8jLMznlgRmsqM57C5eYTmvW5Brb6g1p2wZaWGuVaKRJnCMu
	PXivLgKCkZq9C3lj8e7eRYixfKsvhOWROOXrbF+cDQQ7zOT2iXtl4EEigX0RsVrrBomFYjeu6ym
	XYqjxtgo
X-Google-Smtp-Source: AGHT+IGKVzui55cGjrAO2ChweTuDVYJaqwiVi19DYrChLWvIM0RrJb69r0tcfoE7IKcS7LmXkNkPWg==
X-Received: by 2002:a05:6a00:ac86:b0:72f:c0af:7328 with SMTP id d2e1a72fcca58-730271edf17mr199841b3a.3.1738603748468;
        Mon, 03 Feb 2025 09:29:08 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:e934:ccb7:59ea:80a2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe631be61sm8971009b3a.19.2025.02.03.09.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 09:29:07 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: avri.altman@wdc.com
Cc: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] Makefile: fix conditional around sparse
Date: Mon,  3 Feb 2025 09:29:05 -0800
Message-ID: <20250203172905.463629-1-gwendal@chromium.org>
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

Check that `make C=0` does not invoke sprase.

Fixes f884bfe684f ("mmc-utils: Make functions static for local scope enforcement")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes from v1:
- added signature
- add test line to enphasize it is not a revert.

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

