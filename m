Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C13672B8
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980872; cv=none; b=kwlyaoUP7mRRyCJFL0IEU1TuntKCFJlD1GpIMycNyLajJUr/2RhWQhndq1gzRP6VilY15JYQRQWdFgv5cxgxZFGfw3EbIidZW/4w7kqGYfNNFEKfHLv6GrWjnhJIUhUBjM/eugpZ21t6LSlPFZDNBHVvD49a20/8grlsMkdXZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980872; c=relaxed/simple;
	bh=Qek9Yemwl4vUaqsBqUb9Ho8bk1UMP/x4qTPBJwubhaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8QdQPkKFLnsT9yBMqPNlAYfyHXwlbk83CyeL6wn/b2fZ8sepQqlwE6V0P0OQUhePAEthIS7cK72LO587Dfsh+AG17IvKnlY5ZM9r+UDwg7Zxe0Wc1WIAB3BMlG47eNrw1NguYnoTCtOyOZ62LpO9BHV+/dVFSHmbsBiJgo8NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/c1TStR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/c1TStR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-380d9481551so601882a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782980870; x=1783585670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qAwSQ1LknlyOEsts4qb8f+gHcGdJkzpR6pYbN5IdNQg=;
        b=p/c1TStR/xb7nIJhm48p5zLcSnbPaAdghWqATY6UEVJgV099wYmkAk53A0LreQOYpB
         FHJNDlirAc6LR13R4ZMCcQYSWtkln491Vo1+d10oUE3KKJ4hJx7x6ipwvKW6+3G4BOLa
         fycFDZw8sfGpVoSxoMJJYp3Lcl5Lhex1ncCWIfVIHFcl1PE8NqkpBM+ra9BYGZZqLDSw
         /GMFlF9P4N3bB03n2/E4jVmy7Cs+Nx2FWbb5s2ZxULAlt7dtDFS5MAzQ2FsDKzLWrTVL
         UQtzqLHUh71Bfxe5oluOemz7T9NdLDO7yL162e3gsi0Dh4JxIwaALUtKfcxL+1WjAhUn
         wtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782980870; x=1783585670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAwSQ1LknlyOEsts4qb8f+gHcGdJkzpR6pYbN5IdNQg=;
        b=ICYyDRfb/ANV02KHNCumahSHacjoPruv/4gqFuN/ALKixjg7g9sjXv7nQzFKQ6Di1b
         izZfCPjfDapf2VW6jk2ZbZVp0ZxgjdVCIzKD/LxAcUbIdaJjSoWQlZaNWgP1WzBpvKFY
         wbc0I7NcbYKctJd1erP0AO+AXsSfUc8/+l+T2I4Kq5XZROukE9qJXMllikFpRqgr6Uw+
         LH8bNsa3cNOrFPi9s6d8PbkLTgFitbn9tHNLYcIInF7r4cSe+g4eD8Zl+AJNLPc7h3zq
         TVgTxnVfJomvpoJqHytIEiKoBngRfxj3OxY0EzRvMZUE/Hr2eTXa15TFeaqq5X7Nx0Vn
         CQNg==
X-Forwarded-Encrypted: i=1; AHgh+RpBPfS7nFQ8YjD16CmmjKwb02kbq0iVGvg9Zs6BGu8Jz+ElrCgCJBZpdnpfW/uKILQPfrN1dsn6lFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuK3f6VDDq0g7VBJVaR7UqJMar0G6WbFaK4i/vePkYC/2w/HS
	0m2mw/xkgDtTJXsXAlAwWr6TJz4PjyKFMuq2kS7h7VVBoTHx8w2Aph79
X-Gm-Gg: AfdE7ckEeEpZzJBT4ccIjNv1rOZTBXlbLNjinlk3t2H6JsVn8xB0y7qwghrz9kST281
	xbCTYtNIDEZAsjCYA+ycD5gp0RAmuYApi3MTsZarsjPveMs79GuKZ4S/1jikEwN0WSp4Exhzd7t
	80lNlUW1Py9edZQ4iacWRM8a71E9u9t/4CUJ4LZIKyzvJ/baU7WEkEegxJ5kDggg6nKnnh21HeE
	HPefruoXwq34WM3fDH2NkDTAQcC81k2M1MswqrMhWc+L6ZZTc5MIqVg0T7AX9oSi12g5twC2FQh
	M2QZvVox5t4TjcI5DC8LiAwDzTAvhNupuyNQwmS/uY6NsblTYnPi7gK4jpEDxNhUb9WVwZ/ob6C
	5iuTpSwPWmbCv/+2UotlQn4CTK5El47PkCyGwEKQHjIVhapvybXqCwleaA7uG46Cs0pH998V5Vx
	83Wm/i0Nrb6WArNS0HeXddz0WDtLCqh9cTS+6s5Q==
X-Received: by 2002:a17:90a:ec85:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-380ba868183mr4288109a91.10.1782980869794;
        Thu, 02 Jul 2026 01:27:49 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e165be46sm671663a91.7.2026.07.02.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:27:49 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: ms_block: reject a card that reports too many blocks
Date: Thu,  2 Jul 2026 16:27:45 +0800
Message-Id: <20260702082745.1887848-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msb_ftl_initialize() computes the zone count from the card block count
with no bound:

	msb->zone_count = msb->block_count / MS_BLOCKS_IN_ZONE;
	...
	for (i = 0; i < msb->zone_count; i++)
		msb->free_block_count[i] = MS_BLOCKS_IN_ZONE;

msb->block_count is a card value. msb_read_boot_blocks() reads
number_of_blocks from the card boot page and byte swaps it.
free_block_count is a fixed int[MS_MAX_ZONES]. MS_MAX_ZONES is 16, so the
valid indices are 0 to 15. The init loop above indexes it by zone_count.
msb_mark_block_used() and msb_mark_block_unused() index it by
pba / MS_BLOCKS_IN_ZONE, for pba up to block_count - 1. A card may report
up to 65535 blocks. A block_count above 8192 (MS_MAX_ZONES *
MS_BLOCKS_IN_ZONE) lets the pba index reach 16. That writes past
free_block_count[] and corrupts struct msb_data. A larger count runs the
init loop past the end too.

A real Memory Stick has at most 16 zones. So it has at most 8192 blocks.
msb_ftl_initialize() now rejects a card that reports more than
MS_MAX_ZONES * MS_BLOCKS_IN_ZONE blocks.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I do not have the hardware. I showed the overflow with a small harness.
The harness replays the store loop into free_block_count[].

 drivers/memstick/core/ms_block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index a01fe31355..ce33907bfc 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1338,6 +1338,10 @@ static int msb_ftl_initialize(struct msb_data *msb)
 		return 0;
 
 	msb->zone_count = msb->block_count / MS_BLOCKS_IN_ZONE;
+	if (msb->block_count > MS_MAX_ZONES * MS_BLOCKS_IN_ZONE) {
+		pr_err("Too many blocks: %d\n", msb->block_count);
+		return -EINVAL;
+	}
 	msb->logical_block_count = msb->zone_count * 496 - 2;
 
 	msb->used_blocks_bitmap = bitmap_zalloc(msb->block_count, GFP_KERNEL);
-- 
2.34.1

