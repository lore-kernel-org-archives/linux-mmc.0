Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238744;
	b=Po16Mcl9gGtOQsp809oRciLVnyMKYUosPeP6MzXJ1KFxV/iuRwkXM6M6+DnaLOhO+HuV
	 msYtFLbhbytNrwnAN3c3oELkSHnT+MYIkA1K5JayGHsrffC00UlLwFm1tHYbiVcpW5Sso
	 SiNV8YU7hx7JOlihTKcBTDYwNtpD/9BHLTMxQKmjtblbi2nKK0MjKPg88GlBoOh9407Cg
	 1oypqdo1eEXxWh3Ejy0XzoExQAOtM598yJGjCZ2CcKCO0EJpN1aCAp8KjTGgJZHE+sisc
	 MKtFSzKqXNSRlWp7vUMt8w49bOeMUDcH4kpYsxT78Qw2U5+TPrZSuyzeKf5ci1qkMFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l4W7ehBvMPCBI0n1mDy1/8yluBi1nteYcIGECX5h9u4=;
	b=ojyX2sE7YrjkLohzy7pE+fUXYInrAMJsbxvOKq085jUDBGRsrJUKB618H/KwgxPfH60d
	 SnUFybgGC2oJeehIQV0fIxZL9dPvRk11JuKzAD2U86bPYquv6lcr4S+iFCSiDelneJq6y
	 KwVbxNWnprN8FLZK0pqwIGF5mpeZLHkqgoPk1NErQp07KUsETAk0B/SxptMlQ2kCSeCGr
	 JE5QUC99M9BBGp2v/+/8m9y1hmk4+ooMWk9sUW2qV/TrgHbgmmcr2PmdpyH6QwlaPLohk
	 FShWxyMGNNZvGF+j2x7QiPprXr+R87rYxXbG573EuWvVnva4ldJrfTsy2tIDdqrZxNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r0o+7ORB;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8C606A326
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 15:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F8C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r0o+7ORB
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso543215a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238742; x=1794843542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4W7ehBvMPCBI0n1mDy1/8yluBi1nteYcIGECX5h9u4=;
        b=r0o+7ORB7vMcbuwoWUHLXGDUYY3K0of8YAGx7Xb4s2TRpbEZBuJsClbxYDZfiQcR9W
         tKZ7dZMUSqrwFEkTSoa0bnbvAFwNuKb/9Q4I968ZRN9gELdlnMbh4isoWgxc6wQc5/tA
         PYWftT9deGHWCxTJPJNYG5zqLm0wGzbyycU6pam81mx+awUkRt2XDf+xyrJqdD2uYRJW
         M8ZlAXg8FxLLLU3Y+lTeun7a024KPDcbZ6Nm4d8JGGPA7nlwpb4cAcmlWtH5xwqFYHT+
         4aeL2M31Id0yMhE0FcG5uzQ5v1LFAycvYGBEsxN/9dqz1KCdNR9T9apSqSwSL1gtJOaF
         VkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238742; x=1794843542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4W7ehBvMPCBI0n1mDy1/8yluBi1nteYcIGECX5h9u4=;
        b=LTygdMXMne2UkmNHtHWT8vi7R50F4+xFG216r/2yw6ZpL7BQ4UuNP0CFBl2vu/I2Re
         Hyour+ggVhHYibifibHHlJ/BlSosaRR4xelPFmbr0IUryuuPxarR+1tSuADlnmFirpk/
         0gm4Q70c5LxfMRArSYJ2nZ1a2ma/CqBvZItutXyiBBFw1CCpJZB0sDFSDDC1qVmkf8Cr
         9EwALh6jnTx6oSoYlMm1ykntZViayH6mHueNN57bF1pH7iFQjVjCH6iek4ioPMuL1BK2
         RMpoFc2RUm+og3byFGpq9lnjwS/tkAxC2yWMp5ljP+xF1M1LoXTlIbSqtDcxPjTsiZeL
         lrXQ==
X-Forwarded-Encrypted: i=1; AL+hErHPvFylmYxoYL8LcTpcBZjXBvFkk3DbcVIiTWjbeM10lwT0UleFsCvpcKeQRylkgk2ykbGzpgVtPEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8f0nEl9x53LYkpUd49HuApapa3IVko0Jl29WyrrPomwgCy4mOY
	sx9YOLXsg8ePE2a6cngJTLvMqIypr3z3o8r1y9iauoRLgvLa4RTiv5Zr
X-Gm-Gg: AYBFou1jqqFCP5OtOMKWnRWo1UoCmkUb4TeGbNzGW2WWPCklTUItqjAeNcuzE8PeRnJ
	MwqGDv34CvVbmLkexNKlVHCaHQwNomcLskPAZyw0kbAzGzikB1z+EMjTrXwpFiQVtvsG/BUoYrd
	awY49COhhPM19sRbaVzPEQHMH5noj1q7HF1GghNkwlizdcxaMje4eD/s6jblSX465PafF6SS5XH
	QQEiCXlw/uY9gjE1NlseJMhSwZ0AQiEAkfRY561V4HDYYce+WtFlrYbw8HESdopYJCI8GeqF852
	b6sTTdcr1P+o6OmkmR9IQ6Bivb7s4Cb6F9WZG87A0rjv1/fJ5QunTmp6bX9zEJEU5mJEXgFOHpj
	hmlL/NcB4pTxWTzS80H6lSjDxkIdNo99bGzPYGLAlXcFTIhsIyqoE+t21gu81HgTNEjmwUK7Rsc
	9prYAbsKTcVhTnIbpMUB5cZ92raHov2s2lZRRLTTNgx6NntcVuK7nb0Bh0KR4FDJj6TqNumXJKE
	93sDsMcdv1RW8vmJe0tF0zZq6HpGhxStQiTaalJgdGaJ3c4m44sPICgzl15+m9iFwF7T6e5dfPX
	13qhGWGDGozKLzjeS/sqO1T2tKM3ffZZ4J+EdjvVOzFRPwhJ2WxgCo8D9o/4XBxXU9+5MvKhV2J
	9msk=
X-Received: by 2002:a17:90b:1b10:b0:3b0:adba:45e9 with SMTP id 98e67ed59e1d1-3b12d41d8a9mr4389871a91.58.1794238742533;
        Mon, 09 Nov 2026 07:39:02 -0800 (PST)
Received: from 0.0.4.7.1.0.4.2.ip6.arpa ([2401:7400:c804:b668:b272:9904:c32b:2ee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm11062029a91.0.2026.11.09.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:39:02 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Yifei Gao <gyf161023@gmail.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] memstick: ms_block: don't erase the old block of an unmapped LBA
Date: Mon,  9 Nov 2026 23:38:02 +0800
Message-ID: <20261109153832.7377-3-hjf3108@gmail.com>
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

msb_update_block() checks for MS_BLOCK_INVALID before it sets the update
flag on the old block, but then erases the old block unconditionally. For
an LBA without a block, this tries to erase block 65535.

msb_erase_block() then calls msb_mark_block_unused() and sets the bit in
erased_blocks_bitmap with pba 65535, so used_blocks_bitmap,
free_block_count[] and erased_blocks_bitmap are accessed out of bounds.

UBSAN reported free_block_count[127] on the int[16] array.

Only erase the old block if there is one.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/memstick/core/ms_block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index cd4ff1b79a6da..e373eaf92530f 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1149,8 +1149,10 @@ static int msb_update_block(struct msb_data *msb, u16 lba,
 		if (error)
 			goto out;
 
-		dbg_verbose("block update: erasing the old block");
-		msb_erase_block(msb, pba);
+		if (pba != MS_BLOCK_INVALID) {
+			dbg_verbose("block update: erasing the old block");
+			msb_erase_block(msb, pba);
+		}
 		msb->lba_to_pba_table[lba] = new_pba;
 		return 0;
 	}
-- 
2.56.0

