Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5B34C155
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jun 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431231; cv=none; b=ud/bxyF65GllghLb6A+nJz7Fx3CvPDGbZeEnQq3Jdru1H11E+9whXHvEdoaY6nG4sMW6UDxQqyIDMjScdBt2sa0ywOrCm5GgiQoy+31VBR0BavQAQtWEjlZUExq+dDlNa1xg0lTx3ROunGTKPEAsVcjNdXtY2ihnOMphZAmxrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431231; c=relaxed/simple;
	bh=nkKc9eAxXqQ+Dnqg7a5iNB9iiMTxfr611IbVN0vr3yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfYQ2V/qoDA235RtFzRip2qAbd6MLgkx+R487UyMY/ZGg4TieIdAu7WvqA+SFXRDAZvfx0S9fH6+BQqK5/U1sZn61ZbcYo0VTxFHRFpSy2kknlFpwHbTrFxRVSvARaSBZBPw9cUQNpw7/UH7sNE0UV3DEa4ub4jiGo8gn/Yoa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DujbOkL/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DujbOkL/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so9250215e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780431229; x=1781036029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg5WhaKDN5P0G6TtyP193M1YCM4tZRnE2W1nIni4O0k=;
        b=DujbOkL/dJwStcwCC8tOaqiZK4y/msKUOFAqeeNcYMQxI3k+kIuEy9uRDBR8wNfnco
         3E2CAOmOtd4qEaxxuJ0qxfVUeQrJgeNhI/NBsbmodpNBCx4WumdjHd9r1HPCdaMpp1i5
         YGJc7SuOaoeO0bYEIC3FaHjXQKfyE0hoqKccxdmeXMzk0UbGg9VMrRuCOJpcWSw/zygF
         nJEgCJ5z35+w8nSWFWDKZwA4up4lI0YTs66AvA8nCmlfKCxbgj7SwAj8hDLvnZPWSNJd
         O03RmIAJmjmcp2abnnBV62ag1ipI3pOEN2hoV88pfSTnG5fH0etO7aag9rE4mVM12wa8
         4iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431229; x=1781036029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg5WhaKDN5P0G6TtyP193M1YCM4tZRnE2W1nIni4O0k=;
        b=og9kBvmIXjDIFkO/ZwCiOjUJ1UD1EKd0FuB0P6ptyNVZYXiueFW48/YytLpJyYGzg9
         GVvR8uSa4I7Hri3KNYGgpFZhCMF4Tl2sAvF77RZQ++sbkuWCO/Zrrtv2ZhnM1pyACux3
         427qoW2xwNAAPfJE/Tv0nM8U0rj6UPz9e51zhY+eU+kGMmTAuN4TITdV/IGKODEjCoxD
         QttQZs8UZmAPNlvGwZ6RfcEbPERp3k0g7sjyZIFEUM+9b77B6n5sXtA2qJxdY183Xgpy
         6uYndPHUPnUwtFjDWYxJoITPCMZsFimkvmOR29hYS1qWZFBedoFtTnLtws4pktOf3Ye9
         IuPg==
X-Gm-Message-State: AOJu0YwWtxg4uIDxTVTMLcvg0Y5IRZyjNgbNEbjAyzCCYhhN21kcT3vV
	2yI2PL94IRfdGbNmYYTca/grmUc9xfITmvwuHFoPCN+ta8CeS6m1vJYa
X-Gm-Gg: Acq92OFPIIwOEJsspyaOsgKmV20AH09bCk+tiLSvq4k+P7gpC5V0Wl5feHL+WkPXJWK
	SlheJvdC24et1eXeQTo+VuJHitZxOxP60yovZb1QUJGq+L2U0JjV8syq69WIwnRx4lOC9bDabHs
	n3VD1+c2wwtu22Jq5YDy3UvkRoJOkWqSUpwofBj7ZUlBW+F4s5vS2cHDDROgisMf8BxPhC9M8eg
	XN/LmEN0QRTLm6dJXAFM2eeohxI4mGnC3F2fbThazsgXYOGRMZNvHc6+QsZrDB6XvVOVh8iFJpA
	9ccQmkQZqaFOQK4xrwfGnnxYpqc2To2/TL/SpFd9449iGagytLMllrrQ0WlyvwOD0J6EcR6A2H3
	mCARR30MxNuMCe5tBhIvOJMQ6ELgzMHfiGikpU2O6wu1G6veRBw8fdUU234ChxjDx6DBDp4/jQj
	zsMAn/stqWhHE/9RrFM9wr1KYpAh9aZb5YXq4fb8ZnjYyM1vf5IYtdHo1QccojEusUnwYvg/MDa
	06EWVXtQg1t3Tkznwh6qwv/wIlWmggMnmIYHNyoJ51XxGsx8GNOfLkRZCZWv5VcsWE=
X-Received: by 2002:a05:600c:458b:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490b5fda3c3mr5787925e9.23.1780431228585;
        Tue, 02 Jun 2026 13:13:48 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b613f167sm1017515e9.22.2026.06.02.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:13:48 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] mmc: mmc_test: Fix __counted_by handling after kzalloc_flex() conversion
Date: Tue,  2 Jun 2026 21:13:44 +0100
Message-ID: <20260602201344.1809801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix logic issues introduced by the kzalloc_flex() conversion in
mmc_test_alloc_mem() due to interaction with the __counted_by
annotation on the flexible array.

Bounds-checking sanitizers rely on the counter field reflecting the
allocated array size before any array access occurs. However, use
mem->cnt both as the allocation size and as the runtime insertion
index, causing incorrect indexing and potentially invalid bounds
tracking.

Initialize mem->cnt to the maximum allocated number of segments
immediately after kzalloc_flex(), then use a separate local index
variable to track successfully allocated entries. Update mem->cnt to
the actual number of initialized elements before returning or entering
the cleanup path.

Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
readability and ensuring only initialized entries are freed.

Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
- Switched back to v1 version of the patch.
- Addressed review comments from Geert.
- Add RB tag from Geert which was received on v1.

v1->v2:
- Started with cnt = 0 and incremented before assignment to ensure
  accurate tracking of initialized entries in mmc_test_alloc_mem().
- In mmc_test_free_mem(), replaced the while loop with a forward for-loop to
  safely iterate over initialized entries without risking underflow.
- Updated commit message to clarify the issue and the fix.

v2: https://lore.kernel.org/all/20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://lore.kernel.org/all/20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/mmc/core/mmc_test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ab38e4c45a8d..4dc16649e61d 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -318,9 +318,9 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
 {
 	if (!mem)
 		return;
-	while (mem->cnt--)
-		__free_pages(mem->arr[mem->cnt].page,
-			     mem->arr[mem->cnt].order);
+	for (unsigned int i = 0; i < mem->cnt; i++)
+		__free_pages(mem->arr[i].page,
+			     mem->arr[i].order);
 	kfree(mem);
 }
 
@@ -341,6 +341,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	unsigned long page_cnt = 0;
 	unsigned long limit = nr_free_buffer_pages() >> 4;
 	struct mmc_test_mem *mem;
+	unsigned int idx = 0;
 
 	if (max_page_cnt > limit)
 		max_page_cnt = limit;
@@ -375,23 +376,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 				goto out_free;
 			break;
 		}
-		mem->arr[mem->cnt].page = page;
-		mem->arr[mem->cnt].order = order;
-		mem->cnt += 1;
+		mem->arr[idx].page = page;
+		mem->arr[idx].order = order;
+		idx += 1;
 		if (max_page_cnt <= (1UL << order))
 			break;
 		max_page_cnt -= 1UL << order;
 		page_cnt += 1UL << order;
-		if (mem->cnt >= max_segs) {
+		if (idx >= mem->cnt) {
 			if (page_cnt < min_page_cnt)
 				goto out_free;
 			break;
 		}
 	}
 
+	mem->cnt = idx;
+
 	return mem;
 
 out_free:
+	mem->cnt = idx;
 	mmc_test_free_mem(mem);
 	return NULL;
 }
-- 
2.54.0

