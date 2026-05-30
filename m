Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9C33CE80
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157316; cv=none; b=agb1qKIh9bAW7NqWdi5KH1ViO2AVhFglH+R4zIvcda9cmXZi+Ji/u6hFCjmyC2V4PKE/aijnJYhSm3PKJUnXllaEoK3A199BO+25p0UUBwFvNhxMaT7kT1nUrgn+I/ZwFJGuqa3t4c01POF3gWxSWN080C+d2RZHKozUK3WHsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157316; c=relaxed/simple;
	bh=Owt4UhDYyoqlak1RP/aZ4wSyc0y7MkZ4NXK/flnkQTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB0sPMFo6UP9po6tOhcfXAQsUjQE5hILZqC5u1BV8i4QHR/2PkwUCWp4BM8ZAXShQfyN7sSKTV9QZVCjRRQ6F2DHFXkwHK3Z8UMO/SzwJb0A9UBqnxWkbX33kJIRdnzyRYn+hJotGLdVxW8IruJ0EjnHsSsK+2J6gc3s/Y1W7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTpB+7IJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTpB+7IJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49041e84237so71635365e9.1
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157313; x=1780762113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttG9dNHQjkNjpv+ijSMYFkL5/U5ISQtOPA8aCgiOPIY=;
        b=DTpB+7IJwff5+I4e4Oqefs1cJ+SN6qYBjwQGune81quSmW3zBgNm2N5HPKmhLwqiLQ
         Z9tbKnZUSlfNpOwEYejuz2agd+3ac0G98n+uuqyax9aWslIP4dGFGOT0ni8bOJKv/bP9
         KiMqIa4i9n7hrHwR2QOPYvo9dy7RBlHlNdAOra43rSZLFoPoQx96CXM9fausPmZa10Kz
         j4i51reP8YHw/HXBPsiBsir77L6RcQB+lSK9TU5Rk+thR/vSrZeiGgEpcyIj/aCw8GUT
         il7ejD9C8oAwJZIrQSxkRzuRrqi3uSaswfdwOsPmj+9CPrWAwf1Gnz0yk57ERAvKqCOL
         5zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157313; x=1780762113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttG9dNHQjkNjpv+ijSMYFkL5/U5ISQtOPA8aCgiOPIY=;
        b=Q+R/bxXPwoO41nfHG++Kkm8pJKLfRNOboqMeFys4uqVEVGXn0ro6uwdHPgqVwIxfF1
         +RwWj14WO5XpLqrsD1dipkmhsA627rzWB5C0sfnU9ntMpntlCGg0izQ5bkhU3QVPx4Wa
         RSckk7qOQVmEnxEdtzrvnYr768/DntvR3uGcgdj+tCf1zUIow5oP4znZwOXM8g0JYAtL
         NzqOemx9bgFwT1ZRlooT7eb5cor3LQ79CacBv74bf14mS1eEIAQoXwoQfiwEoyPrAZjf
         IiQvFP046rsHvd8XknkIOa/T/mm+aqhsaxyBZlxr4C/9FFoGFe+cowNs4klwIP9O/uKx
         ASNw==
X-Forwarded-Encrypted: i=1; AFNElJ+KovVCjezpdeWExICJKdznjeq7xtGRqxcKptfDCSjG5An3nFLBwh7B6uSR8uWOM30/eMRgKb9baP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahzDLbk2vmYMOrdDNeqcTwC4otZfsPy/zLsaOSfapT6DjwR6U
	c4ZzZYypZKLq59ERRi5Os64TkJrO4qcQ+PbaQN7yePZwsHIVdEtEnbIt
X-Gm-Gg: Acq92OGapUjS6VMqsWnOxSGi47z4eWRVFoCMsM0Gv4xB8tyQ63UJIOzGzfIl5EAueZb
	2VNHZS/cH4HeCt4TCwagFg9YQKu8X0ZozAZn/M9rR4ul507MxPpOhszuggUzWWcyHKKUL+UlbBe
	9l0SfhUVq2qaDkJ84pSifGoQGdkI9geoFVXXQKLr8QqbBDECdIMd1ws2djxlQ5um7q04/krY1fr
	RtDZecUNX3KN11kGozLvHiHalnJ5OgFNvNetqe1e0nMiRDjfYSmdMghQPKDgSRAK3Uf1F6ghHdx
	9XqIOJwhjWlybBvJorajdBiATaQQK67yQ4vuGGVLqQdQO6xxs+IIqbAYbf7ixO11sxy/SCKferV
	CM37j8iIuAJRS2uLRFkSjcPbdwtiBHv68TM6abyypthnyIcuLu9z+CovvePRqdDFgfTV8HMj/EB
	KK2WsXSColh2ec2JPTGwFRmaZrM8o6U1d5zIBpOn2VgnP4YjBAUOyYah+BM4BLbM/vlkDwSg==
X-Received: by 2002:a05:600c:3545:b0:490:50ff:d394 with SMTP id 5b1f17b1804b1-4909c1670a5mr114901055e9.16.1780157313534;
        Sat, 30 May 2026 09:08:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 05/17] mmc: renesas_sdhi_internal_dmac: Fix whitespace alignment in struct initializer
Date: Sat, 30 May 2026 17:07:59 +0100
Message-ID: <20260530160823.130907-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove extra tabs used to align .of_data and .quirks fields in the
of_rza2_compatible struct initializer, replacing them with single space,
consistent with kernel coding style.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 024edc4e5fe6..08cf1604ef1d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -272,8 +272,8 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compat
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
-	.of_data	= &of_data_rza2,
-	.quirks		= &sdhi_quirks_fixed_addr,
+	.of_data = &of_data_rza2,
+	.quirks = &sdhi_quirks_fixed_addr,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
-- 
2.43.0

