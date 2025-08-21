Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC7393DC8
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807768; cv=none; b=C9vB4GsrkmniUnC2QLgCcqO2YBREbnxDcD2f44lqD519C7AWZOe/ocKw1qNmbYfpfsb7bqYorpe10xiL5gVX5o7asWlqJ5feJF7DM04DtSIK19oyChXiT4MN1k2YkrSQcfhGuA7pt+Fhfl/Eocoax9V053UoLw/9dl6jIbTZMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807768; c=relaxed/simple;
	bh=g5Pqhen6+TGsZaJhVjcxjHrty8uEIOPaJGSbz6Iayeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxzL0u/uvlbK1U3cqfgTkrwTzwTUlLnEQTo4txWNo+R2RMKV+eu0RkmFteLsnwyzXR7z38SChii9siYjXMCOi2uKD9ZSM5hWGrxRgqNIanew9E7adstmdHelrHgyLrvPF3A0xHYjPG1L4YIN/u64qiQrxsSWfmJsq8HGz1EtMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxFuzkCN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxFuzkCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755807764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
	b=KxFuzkCNOZgrSZ4uhaDjj7nSdLKuk0MsoO+1Eh3vag1l146Gg+r3qBEUihIiZbHNyxIimN
	2cESPBTvK80VLJjywtmW8ShTjAouzYFIf8Jd+hcAZtLfxeM+82Jvl0Ju9IROkwD+Yi27aN
	JrKoyuwIIgVSxJ5sWSIKSyyw/KEdDYk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-FxWPjOIjMhuZhHC0w7_i-Q-1; Thu, 21 Aug 2025 16:07:47 -0400
X-MC-Unique: FxWPjOIjMhuZhHC0w7_i-Q-1
X-Mimecast-MFC-AGG-ID: FxWPjOIjMhuZhHC0w7_i-Q_1755806866
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so6976795e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806866; x=1756411666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
        b=YIwR6xsn5b0k7I3O7hPDoDtd1BkzFjtSEuHwuFHKwVD5O26o/8pVYPwhdoRAMeWA0O
         GquK0n5rI0nccgLkCaAnyERsLfNxKt60IIwfFtnfOQv7kRj9+Mc6yEyws+YrK9SoNGKb
         NG09dLPBLodHRsV+MlcarenLiVmRQhFUoZf1bNSlM8zMN3p53+GzwKUQEhJbLY2mK+3d
         wyDAwuNdR3GUcY03puP11RISPBM3+kCSpsFdFbGU+pypAgTOoXSlpJAD+bk4Pt/C+bNS
         F5vJGwPIabpeTbwq8ri4l0gGs6zm8q0vkryodRluwFcB1bJnxev2s2KN7MXbm0mFz80g
         OlIg==
X-Forwarded-Encrypted: i=1; AJvYcCXznybowhMGyVv8FcN6LDYsYJL2jctDo3FPikn3M/Y2IRICNn5jHAcFZm094JsiJ1S40EZSTUizOvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWlMC89+Lzf5iLVLla9vrdmdtsMgRN7nh7GVIhDC3AqCxasiS
	S4NEjAgeAtwo3XPxiN6CG5zDiqWprRqC8Ix+8Q/VuMzGYEz8mlhUOLl0gSq6zyrbJG2Zz1zP6aq
	wACD6bKstjjJjEg/tYK8ztpIfxs0evJsbt6OtZKyxjrFDYqZODXt1rhkaxjBw0Q==
X-Gm-Gg: ASbGncv3ZLrca4Anm5nGa+fdL284iH4es38uO3I34uXWHv0SvDOwPTxFri5VhSR33xV
	pBqH1pxwjMOS3m1ZQC8gf3VjPz3VFKKLyllr8wDq78VDqsjX+7uYlvisa6PzWW8NuniSQYgPj03
	+2Jr/hK2mfFQ4xKN4iEBoaHWn3hVyLB0Z/nL1Vebi0yu0NEAS/jgxvhHnn+i8gr1YLHSVL/KeXn
	dT1p/CTKenvuAcU1AoEUsETmHLkMY3yzp/6zs08CdrVSA0oAH18NVbVD1pUhLG4JTpBZFiKqNxK
	xrnfpI1N8WHfCA4SXIlfYIn/E1aQyyhdCvQN08eZRYecfftcPfpeaBMA6aGWNY/DmCDMXGdmGvm
	0r95qmM/7NIcj5rR/empO1Q==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819425e9.26.1755806866186;
        Thu, 21 Aug 2025 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtzGc4rPv18tjnV22wd1xjfGI25AJiVbHUBF3o7jj7YvZLrrv8XzLc39l/Z4dCqHj4yY2QA==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819075e9.26.1755806865726;
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dd0380sm8632985e9.10.2025.08.21.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 14/35] mm/mm/percpu-km: drop nth_page() usage within single allocation
Date: Thu, 21 Aug 2025 22:06:40 +0200
Message-ID: <20250821200701.1329277-15-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're allocating a higher-order page from the buddy. For these pages
(that are guaranteed to not exceed a single memory section) there is no
need to use nth_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index fe31aa19db81a..4efa74a495cb6 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -69,7 +69,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		pcpu_set_page_chunk(nth_page(pages, i), chunk);
+		pcpu_set_page_chunk(pages + i, chunk);
 
 	chunk->data = pages;
 	chunk->base_addr = page_address(pages);
-- 
2.50.1

