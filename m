Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238725;
	b=EaTdttttzUPVorxcraHekntXBRs1GKl84JOhvpB5Vbkq9fgrLV53yHe/XxsrWG7fWJZD
	 znr4l5hWI/uUBlHN0qKnn2zFBTFri44BRBG71xCdtOmJoHv5w0muPtjyf3txG2VM/CW+H
	 DE/6+RM5jtK/GVj9S9mY3Z6pZ+Ma5JqjEHw3+lWNLNVUge9weKLqfAV6pzL42nRXER0Gg
	 1it/FrGyDsNvfFmANZVrZ6b8utzlGPYGB+pWI7fo5eBMIAdoRvAtrsnNhPWHA5tHnarsa
	 M+pYtpYxI5ykBAtcAwbSbEuG4nGX3var8C9IYpoafxBj3QdMqNLvGveQ9ifFBeTwFgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ss4lrhqPmF5SUHU4F1piOVZZ27/MP9CBwo9B8OYXbxo=;
	b=Lve1FB05cFo3dummPtWrRBM7WXorCI50JxPxTHyrQ21sews6gb/Heobrg+gL4Rm4it2K
	 vUYZgx1gxST7gkYPV8gBKamjsx8FIpqXb/EpvbP83FAh0WwpQhR0tvqMw8B39Z9V7Yr3N
	 oQ8Oh74B+ovXzOjRoDbw34BmGtkwZ/AralZdiHszznJPWyn7rc2kFmlM+JVm3xBdnEh+P
	 kMqZ9kEwQGaYeoLDx5u1F5tWo1D4Rp1UGauWeuEApF8Ez9+Tio+5Mafu/VuvXyO8kzlyg
	 MsMVeuFTbFkGgHhRAQMK5RE6xBaREjR0YKOishrEpaa7Y/2WKhKOGweiNbh4Wmy6hSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dhbhqgqO;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D1606A31C
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 15:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 032D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dhbhqgqO
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso331752a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238724; x=1794843524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ss4lrhqPmF5SUHU4F1piOVZZ27/MP9CBwo9B8OYXbxo=;
        b=dhbhqgqOP7Vq07GCl6pq4R+xXeHTbvQVruGCvp8IveIPKwZIHVS5DzI0pj1ZZF01HQ
         nz6k9wmQdp1HJT7ACl0J3z05Z2NL6uey0a1xjH5m4B6wGRG/YQgccqws1F8QQpOjjCCj
         gm6HD7K5aKHiaWTxhMn9HLkwWPzEVfg55TkekR5uYjOGfT9e6N54Lua6fBW2rEEUjFdI
         AKD102ckvoUdkMMVhM3GB1qMsYpmJubB9cGILKs4FVrJrCIjNgs1o8P/sPX09S5lnL3n
         3xfxgT2T+VTKsiYK4f00f8H8cJhXhtJA1Rkvy6DUinxNqCD8iZ2Bjiwey6DhKRF+U6HP
         2DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238724; x=1794843524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ss4lrhqPmF5SUHU4F1piOVZZ27/MP9CBwo9B8OYXbxo=;
        b=dfhw0klkXdAw5fGpLSP6jgPeSdGmVoJ74wRE2eYs0DE7dw1Yuluoq5gGXx/XiIVVAo
         5qn/oTAKpzsl0Zs0vfFO6aAVBzOaHT2OVGRDzlkdM23SvcjMhGLIMoW7NEo3542sIDgU
         nopaPOaAplC61EwNi/F4xkvAo3v150jfPz4CCY+hwKgEZXWLeqP245J1TSX/Kq0oXP4A
         vk0NFKXWnE3iFqEcRCXhC/HMyLq9A3MZH/w53Y2fBeztWuup91i2CMPi7FNVJ0S7wkoR
         l83QV70mTbwUPrRuXURy7zVTitMZrG59M/rVw9QHWVrdp1G+wdqvEFQUVVYcQ7SjwWw8
         5AiQ==
X-Forwarded-Encrypted: i=1; AL+hErEol7Dy8V20yZ8wXQh2jqXZNBB1zzyJpYj/AVvdKWR9Ud3XmIIgwyoKwQjz7v+tV/+lHDNTgl8/qDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eEXFU8oOCzH5T/bf/zU23Xo08yaO9zhnI03jzk0eujJOi8D2c
	YuPyZ31gZLihvwaGUpPDIFQDCX92Pf+aFomh2PP0AQIj1hI5u+n59SkJXs0+tDClA0qBiw==
X-Gm-Gg: AYBFou3z/y2AbkelJYh1CEhi+YhKampk+/O5oTjkc0GXCCqXr0RtSrSEhwS6djiYJqs
	U/ug+Es4V3ArPa3DRPrThhyOIoi5Uzfk3a/HLIs4ujKl9QvdNHsbIBzJiB1wP6V+ufouMNZh41X
	Px7GsZ619axVoE7PMAVaE4o3HHaHrvALSgyepZ9TOA47wOnJ2+D6CnRX2LPuqjEPFr9FzEhzs2M
	w7+c6IYFSVntz0qc0QdaZGQziz4RYlsT+WOgvfF2DdAShcwspsiBE3St7Gz6NemIWkrUMB0mKtg
	52VsamYCrhRpcb5KQs8e1En2C78clNLfug4bQKom5D7oPKIdmkwX8vJEMRFEAkCJWAxKQ/ksuST
	S2YH609uaUCffwrZdTER2tRE7ToLOziIMVJ09kJmbziUoNeDqvMTSNDlTsv8bGoK7WrZuGOA1tF
	6YHupf+mzyHSwImcwES+YWQC8MWEHC17io3hOPjGpgz/t3MEln/OUMDzGaWIgOh4E1/BXZV+fJM
	PIYFX3TTjnGDlJFqqZs8aedljjLpkFWvv9Y7F7F99IdtVmdA4ysjC2WcKe0fNMBnBrF8CtJ4QfX
	ie2RGsfTxzg/9h3hOp8T15sJNk29b3pmsS2+xz8eNCLevYK+CYmcuNBcJ5UxT2jTF0EdlNjfYVp
	slkc=
X-Received: by 2002:a17:90b:3c09:b0:3a7:9045:fe29 with SMTP id 98e67ed59e1d1-3b166ad25ffmr30988a91.4.1794238724301;
        Mon, 09 Nov 2026 07:38:44 -0800 (PST)
Received: from 0.0.4.7.1.0.4.2.ip6.arpa ([2401:7400:c804:b668:b272:9904:c32b:2ee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm11062029a91.0.2026.11.09.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:38:43 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] memstick: mspro_block: don't hand a finished request back to the host
Date: Mon,  9 Nov 2026 23:38:00 +0800
Message-ID: <20261109153832.7377-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109153510.7161-1-hjf3108@gmail.com>
References: <20261109153510.7161-1-hjf3108@gmail.com>
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

When a block request ends, mspro_block_complete_req() clears
msb->block_req, completes card->mrq_complete and returns 0.
Host drivers take a 0 return from memstick_next_req() to mean that
*mrq holds a new request, so the host issues card->current_mrq again
even though it has already finished.

At the same time, msb->block_req being NULL allows mspro_queue_rq() to
pass the check and queue another request, causing a race condition
that rewrites card->current_mrq while the host is executing it.

Return -EAGAIN instead, as the function already does when there is no
block request.

Fixes: d0be12274dad ("mspro_block: convert to blk-mq")
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/memstick/core/mspro_block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 4a52830026c50..fe38b42431219 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -706,6 +706,8 @@ static int mspro_block_complete_req(struct memstick_dev *card, int error)
 			__blk_mq_end_request(msb->block_req,
 						errno_to_blk_status(error));
 			msb->block_req = NULL;
+			if (!error)
+				error = -EAGAIN;
 		}
 	} else {
 		if (!error)
-- 
2.56.0

