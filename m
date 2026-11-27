Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761359;
	b=30WG208cXJZyTK7RWrJ2bHBao1Ntgq3qSBiGjafetKt6jjghVyJOgcAOzw38dkjZoAXk
	 JUf7TNIByIjMEwxOn0L7z2JEItIGSc3vj2GP9tAf9ysrXXjACqOkNGHuv0AoTsNXEjCqR
	 XC438s/4gzASkicQOlKi4Deqne9fn0CozLjfKnaIZ7kbDpcHmuLlrdG7nCiG1LsWo2y7M
	 k96ttcVkglRX7U5/BAv+PvWhmVmUy99CIPXl44+o7AT4frTwG3XTr8mMBmHn/9BGHcex+
	 1duW+hsAYvcBNXp1imfMakoR6a0EjWtPNBemBGfU5CW68GMfuQm8aABQpnQHoQz7r4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c58smJtIE49TlFZiCcn/5RKIJ2RiOGgb/XlEfY2liM0=;
	b=0FNd9X1oMIiYmH2IQYQjMIYSz3g9tsoVecPzsUMvS6G5EMbE7jNQCswZCO/aeYtpx/cC
	 A/6LQL056kRce7RzsXGdMpinlcZ0GCM7XlwvvhTQNHFqt2whTlNVxxtfJ9xYjX1X70+oV
	 KsGBTwEGtkxhPQZeOdXi8s4at+fD2umV5Gd9ViPL/YmQ8wSNecYEHTVgol6Ew1zcokWQ8
	 GBxM7tLOE492BaANjI6D+WFGrR9dXXPpUblh5e6XwWniJHfQaU8q7UY0y/qOQlump08co
	 R1z0UhOLcODakGPyM+Bx2g48rQ5GOPuEK8En+VgbdmyvPgbwb9Z805WV92J1Lxx74xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kE+tcPWe;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334A606A31C
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C334A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kE+tcPWe
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-18818daa3e7so4268928c88.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 22:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795761358; x=1796366158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c58smJtIE49TlFZiCcn/5RKIJ2RiOGgb/XlEfY2liM0=;
        b=kE+tcPWeRhYYIoWG4142usDFtudahlWUjC+W1SqgOY2s51+m+MtNz+gFWEN9Cs5OY3
         /rBtSCd2qfE2Njo5Pl5HjZzDdzku5gyFOgUC/58VZWHJB6aEHuE3JhCzNv06DN1SUtik
         J9T34M744Wb1UM4SE+crVS1hS8NipaIQZHb3XK3nvGExscL9FPOJvHTiHR4i4IWRa2sn
         gX9Wsxg/c9xanQ1kxtrq74lanMa9ujIXGmtH7hDtHw670Tqsv7IRvEIMneDN37YGHPw2
         NQC4oQbxMxUk9Oy95vRNogKtWnNVRRdmrY1q9KSAtuhwL8YdRQhf56JjUqmNi2Vc81A6
         wmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795761358; x=1796366158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c58smJtIE49TlFZiCcn/5RKIJ2RiOGgb/XlEfY2liM0=;
        b=EUtz9ZxpmcKPohDnzimHYbAAu7qxLqlCPW6NQW/2kTd2WwsKMGtkltTmuWCzAjSCoE
         qVs5IuSqxH0aNiYXu6wqpLlvd7UI+s0VJDgobJe5GjOEYiZfq751XNnwEL1bVP9Zz3bK
         YGeD/wIClWU1yNaSJta6yBlLGiueEEVxY40JZfOtEw1itraeKuoocjL+Xo3Bsc3LifXg
         DgjCuLn9CMYg/9bEJ7LiLstwo+zGNDzYziQ4bPirFad2eanhFJ4mIN+jMh6PkETYW/el
         h/ujwNi9rilETzOUmh3HsgGlq7/Fpf7AL4Lcn2Un+hrqkK4JEIsASQkG4oFaciEyrSYD
         j1lQ==
X-Forwarded-Encrypted: i=1; AL+hErHlfpWNZ++/e7J+mRUMzqZTi+LesIL0oA/6DCz+9pFu+QTgSYkepEoZqsnK8VkJCQtYrGU14jel8Tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d3IIw1WQgV2Mb3aIyFuV96SLIU9SNArrhLLpSoEnt/0RgR5JD
	TSch1hsAtpUimAoc1nywWPHRp3QwEF3+abJlqhJAcczBmcNK6134Vf0/
X-Gm-Gg: AZFdTZe+iOgb5kv1bui7MIuiXI9wsjHgDCASxwVTkCWtd9QeY+l/Dm4LUoxLSeUeWsI
	wS0yXGEWylSgFOJmIn/F4ZEUMnXLzZBXT7/LjaKkPh+mVRiAsRNA3EbVU4c0SrcKI3nVN+3Evfu
	f9soEdAhL6uJfqR4Ifisxlied6yIBJV4lu2uNaZb2fLA9j5uf91IaaS5i8sFcW6RX6Ks3qg52nt
	7H9zl516HKChEASyRm/yAEFtkBLxiRs0py59Jqv42MfaQZk+ZWH8y5aS0I5W7G6TVkMbrOelFGx
	rJS36U4VobBSi84X5h0tXr9bCun0PR4JVJKSGRAxQIKoTev6XyUOJyBCI5+f2MqkthqbIEmWPnJ
	/C+L6u3xjP8rijSqzFBkV0Cfp9ZDXdL4ld9i/W/7sjif8LcTATFBPXmPXq2Uo5jIbwll8ZvoE4i
	LheqyaT2ZZLn3rQebkSLSIO1T6Bx0PgpN+7eBHCIOqE2CnW4iVEXNXAI5j3mK/s2oEJdp6XKAZJ
	uindfitQf8ORfHxC+dIqCMuLrcB8xO7RGGqaexvRfD5C9DBJ0ptpSVjNSbdglj2Ltxbx5noUKQQ
	YkWOUeOv6TLXQisA6LXavYHJ0QlkDW/tjtO+2FpChX/P8kTeaDOO+Q==
X-Received: by 2002:a05:701a:ccde:20b0:13c:f65c:d5b5 with SMTP id a92af1059eb24-1b55247d471mr22377978c88.3.1795761357899;
        Thu, 26 Nov 2026 22:35:57 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm50746266c88.0.2026.11.26.22.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:35:57 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] memstick: ms_block: reject an invalid bad block table size
Date: Fri, 27 Nov 2026 14:35:53 +0800
Message-Id: <20261127063553.36734-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

msb_read_bad_block_table() stores the u32 table size from the card boot
page in an int and checks it only for zero. A size of 0xffffffff
becomes -1. size_to_read is then 0 or one page, but the loop bound
data_size / sizeof(u16) becomes huge. The loop faults on ZERO_SIZE_PTR
or reads past the buffer.

The table is stored in the boot block. Reject a size that is negative
or larger than the block.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/memstick/core/ms_block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index d4143a871d69..37b810760642 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1274,6 +1274,11 @@ static int msb_read_bad_block_table(struct msb_data *msb, int block_nr)
 	if (!data_size)
 		return 0;
 
+	if (data_size < 0 || data_size > msb->block_size) {
+		pr_err("Invalid bad block table size: %d\n", data_size);
+		return -EINVAL;
+	}
+
 	page = data_offset / msb->page_size;
 	page_offset = data_offset % msb->page_size;
 	size_to_read =
-- 
2.34.1

