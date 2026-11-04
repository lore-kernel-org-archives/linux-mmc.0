Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783995;
	b=aFgkUsqfAfeYWiJ1cq9a74RwR91HFDUU7SlgCxYaGSvXINAC35HMkCel8JXbGqzL6wOK
	 i7L9DlyhGE1VVdjtj/2AYyYgvOZ0nRC7E4zJ0tftodlTmLMKLJAGTORoHlVr6ublK2Cow
	 ECM9jeU8WNtjrTUZ77ER2F0bbdndCN1VfaT3KvmoJJbskyuvLerq3jtgAsH1KDnYP87Gd
	 HCRXfv/QCmkAlAnKxXesCa46ZlvkkGKQX0IiXYBNOqxderxswkIj31Ovg7AN9Go8cDGxu
	 WuahhJDa5zOycSbrKNGo7tJ9E+vlPMkoeX2MzR2FAEpi/BOlaQ7F+35MyAMyDvrY0TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3wi9u/eNIRBlM7umBIrwlsoKNh7GC57CM/HYHoRIVHc=;
	b=43V3AYZlcnVTrA1Ksltxq5dmsns/DXqim10YR9lFV4QOk8hOt+/LoqJ7UMhREHlTWqTZ
	 Rmf/+RPQuLtwYZmgfOkFwoMOyRrGbM1yGWAnzD7dJdLm2yMCviMXOgBttxfhYsifc/TQb
	 ua2+r+4T26J1fqgr67ZZ/K0Ck55ttIl/AV2RbVX8FryexVyeGGxsuclPU4G6DtEdiJAZ6
	 /NVTjqkjVjHUMYdie0D/Wy+0jhmjrWwnjxH0DNx0g4nZnzKy5UIsCanDKpj2QtNiEWOby
	 Bjte9d+ULzVIJfLL3praZl40bCE6dNFvJxiY9Kv+um/mFnDP+vPnXmS3h5IXh6eAHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qb7dKu04;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D18606A328
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 09:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D18606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qb7dKu04
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso1980425e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2026 01:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783993; x=1794388793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3wi9u/eNIRBlM7umBIrwlsoKNh7GC57CM/HYHoRIVHc=;
        b=Qb7dKu04/rfXYFJB9h1+I83jaG8W95u36dD98yda3f1SRixyn1nPlYwS6XLyUCvlk/
         vTrjID03LALoWoYJbS3NyVS3RnYMp5mg9oaaJ2Exp+iWy9RcjNUy23dIcd4yzwGIPbZ1
         SSTSFmzjnW7LRvYvcWHkWBaFycF7R+MJtmHmwZ69d8Ly3Xs+yNaoEze6IRGUNnSaMDKy
         YPn/k9uXZ3xKMu4muI76Gqd+TSDBfRQpWcPYdDtgE4Xord27hzchDSvljDlzeCNdN/XH
         QSlIKN0aHMCgqrDDvLPyUsC01g3DCASpZEhSoKhXlP3hOW88kMklJ9wXCoxeod15/Kef
         9MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783993; x=1794388793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wi9u/eNIRBlM7umBIrwlsoKNh7GC57CM/HYHoRIVHc=;
        b=ydIaPuZdDeX2NAR1NJp4EhseDh+LfjDNz6bOMOK8+QNZhsF7NEvLE95E0M3IQpVewK
         hh1iECZjQb0CjUcMdrU1uZOzRAuIQxgSMtPU0ONtrow38qcztj9lRpo+f75jT01qlWKy
         5sWbMyhrOJewjqt8q2mLAjFPW0dHoqvd+VBUbX0L8q2IhJViDnanlUKl6Wc5ZKl4E0b2
         SADLRZ7HIik/fQNqk6soAKXjwOK292ljF7WUONVQqYvq3FaB1B8D/hN/yiKPEzQjvkCC
         lIyKBtdL/G3P1l0WF0/m0Clj048MVfZDlaaZblUC8VxIIPcWRak63xV7o5A6X0J2Da+F
         Erbw==
X-Forwarded-Encrypted: i=1; AKwUvBzQwGjD94xoJntMyZX0IP3edkkzXgwgimufGABUcWMKv9o8BDyNFPeCFfKthZZfsz1AoYYr0PMIdu8=@vger.kernel.org
X-Gm-Message-State: APuU4Z95/yUA1NLgriG+eDroMUhmTHY8iWpbZLkfctnvQ+wOTd3LucTy
	FX5R+tYQLxMDxS6vjG7hjbhOVbWiKrUmcRgTx3EIZ/o4tvzha408K7GL
X-Gm-Gg: AYBFou109jNYfWtVtaWEHuReVtkUW5sNgBpa+if0s2cDF84//PD7FFrlbgYYaD7ILnD
	Bj+yJ3CuYWcZUw4Rt2ShQhLf/8rKCnps/TY0696Xeh1MRJ7IJXMCTw2htcwaAvGKyPplMlP0NDk
	ViIutQzZT3/V9hq6PCJa7iCvq7uhPpV4ZS4HUf1I8rHZWh7iOd1rL5rX5as+GWrAbhyPof5PvLu
	LzHA0QGQTU0JjITS2CJ8yMM4Z+TN7UEz3oNs0cxR6yyZQr0cwAlLRPrAjWTzYOiGFJSzO/nu97S
	pVzUAbHFIYHzL01OvSo/EHiqmz02gVDgHr0p/elwFFQac/mlQlzDHO3aNFlVLiTNtVH8RZUAo8l
	UhvA3ra/g3V67d36Lkyp9NTXO0Zt6dZDgMVI4oGxdG0hgO+bjeY8mKH1clUUR5xBX41pnaHWz5r
	WLBoN+2+S9Df2yhGtuZ01LkSWq9uH8Nt1cJJ9Aea56McrbJg7YFg0sJBg/dpZtuqPqz6R+z1yQl
	VrLLbSqlrnwAV4NrMsG1WbrASiFZVorgnnMbS4vR/gNo1ysZ7ti1GmRwgTg/iiT3ZPw/Hi1WbzY
	JJ5nTxkEltgshW3zrLskNbrzC0+XeUgatD095ntVWMt3O/6Zqx5PF5EU8ECKJPIU3Mjd8eSqesd
	zqqfjX2ldhwKzX66kfJwSoqs/x9TX+WK1UIKBk0DO
X-Received: by 2002:a5d:5f48:0:b0:48e:6ff2:606a with SMTP id ffacd0b85a97d-48e6ff2609dmr38662659f8f.6.1793783992626;
        Wed, 04 Nov 2026 01:19:52 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fea18175bsm2720804f8f.7.2026.11.04.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:19:52 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Yifei Gao <gyf161023@gmail.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mmc@vger.kernel.org (open list:SONY MEMORYSTICK SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] memstick: ms_block: fix double free in msb_ftl_initialize() error path
Date: Wed,  4 Nov 2026 10:17:25 +0100
Message-ID: <20261104091731.16500-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When one of the allocations in msb_ftl_initialize() fails, the function
frees msb->used_blocks_bitmap, msb->erased_blocks_bitmap and
msb->lba_to_pba_table but leaves the pointers set. The caller
msb_init_card() fails and both of its callers (msb_probe() and
msb_resume()) call msb_data_clear(), which frees the same three pointers
again.

Do not free them in msb_ftl_initialize().

This bug was found statically and is theoretical.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
---
 drivers/memstick/core/ms_block.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index cd4ff1b79a6d..26a04cecd94b 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1351,12 +1351,8 @@ static int msb_ftl_initialize(struct msb_data *msb)
 			      GFP_KERNEL);
 
 	if (!msb->used_blocks_bitmap || !msb->lba_to_pba_table ||
-						!msb->erased_blocks_bitmap) {
-		bitmap_free(msb->used_blocks_bitmap);
-		bitmap_free(msb->erased_blocks_bitmap);
-		kfree(msb->lba_to_pba_table);
+						!msb->erased_blocks_bitmap)
 		return -ENOMEM;
-	}
 
 	for (i = 0; i < msb->zone_count; i++)
 		msb->free_block_count[i] = MS_BLOCKS_IN_ZONE;
-- 
2.53.0

