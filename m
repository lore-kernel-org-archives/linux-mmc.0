Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759623;
	b=u3M15RWrMl5oxt1KDdKzOdYXaRfexPkGdX/oTcImhwtAgM9UI8gmf4tP/AM1NXJCUOsA
	 L8G+MYnGOA/E0DAivN8mC4tEaXcc7/dcSCYibfdfvPQyRbcak/f9x59NQ2L9fTtzNXC07
	 TToGBmH2yZLwEtqBUkoHcf8aXc6epkF1p5hHduETrZiPGa0s45Pic0LT3j9gT785R9Ex2
	 RBihH6Dks8nZu2AIgYPBCSkISvNyLpJXvF/8Zx7nWwujlvQFlSVr8QlUzTn+gUDyNAtwg
	 gTmkrKL5LxqpFfeQMiObBZpfE7CHLUYcoJi5QG20kwSjfhSFLNaE5aDt2oykzyn++cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759623;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=wHzXUragbJFP4AN2zkeV0NABzfzD7WztD3VyGEjgztA=;
	b=C6Jhe6T5DxhPDu/Q3qjmUdEyfnsvJBS+K2Dx5WOUgzyDpMi1PJQssf3iMGdpwbobGMf3
	 15+xgYzd3tW9YyExnCGHvU02NgvFH/KV2hOuL8jfR4W+4W9PyCkpKrryrIxtkzHNQ4bHs
	 9VphYyRsGChgkylJHVOIVgUwobVJ5Tep4qJ42cx1vsQ8XuXXboJwkW0J7eIQSh+ZqKzWV
	 o9mDDSREwgSXUkOsU3haXwoSKDfTpWphqmxSDY2IblokO+y3q1euEPiJQq8ukA6F7UxJG
	 PM8FzqOeaZgYkVWIxERF2s1W42nc1jxP0BgdQWOaGV9q/WOiGTIlB3U+ujdOPdn14mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=M8dECHGz;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA05606A329;
	Wed,  4 Nov 2026 02:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=M8dECHGz
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5367d0733;
	Wed, 4 Nov 2026 10:33:31 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: ms_block: Fix potential block buffer leak
Date: Wed,  4 Nov 2026 10:33:30 +0800
Message-ID: <20261104-db9e3c75b3-memstick-1@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a4678baa03a1kunm303dd045163690
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0xPVh0fSUIYH09CTx5MHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=M8dECHGzdLcH9vT6wjulSRvYW83/XDbY7za81gxyk2rTYbWqNrJEwwsFilmDKvMMGzz8XxGOapU0lPlABxe5zwcXsXwCuWbdUQgvJ82VFY80BtiAk882vSYEki1NtHt3texaxkvGfoTj2H86GlsZ/wsFmB5Z/JWDyLbHM0f/doE=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=wHzXUragbJFP4AN2zkeV0NABzfzD7WztD3VyGEjgztA=;
	h=date:mime-version:subject:message-id:from;

msb_init_card() allocates a block buffer, but msb_data_clear() does
not free it. The buffer is leaked on probe failure, removal and
when discarding the temporary card state used during resume.

Free it with the other allocations in msb_data_clear().

This issue was found by our static analysis tool under development.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 GCC W=1, using defconfig
with the driver dependencies enabled. No hardware/kernel runtime test or full linked-kernel
build.
OpenAI Codex assisted with source review, patch implementation and
commit-message drafting. The submitter has reviewed the changes.

 drivers/memstick/core/ms_block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index cd4ff1b79a6d..d62350f9ef5b 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1953,6 +1953,7 @@ static void msb_data_clear(struct msb_data *msb)
 	bitmap_free(msb->erased_blocks_bitmap);
 	kfree(msb->lba_to_pba_table);
 	kfree(msb->cache);
+	kfree(msb->block_buffer);
 	msb->card = NULL;
 }
 

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
