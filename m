Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10236CC84
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806895; cv=none; b=jQCe5RL3g8tUNlrZTXV+G1PcDhOd6wnayfPuSE7gwt2DlXBsw8YJiLSYBrBIkqGojttcITaCiPKtCjxD0xZHRLBFAV7G/sn7fiteTPvyABtHsLdP6JDvz4SjpS6wI7So4Yf8QCoK2peQMjinmSkD+bOLYpNJAJLDEhEn4KxejR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806895; c=relaxed/simple;
	bh=35i5s1BcLEONuxohRPeqiFHOreLIpfTF289+ZIXZu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8gFAGS5Q7VjzlclU6oSlPbHMYPB7TM7ssWGe8PKEtgrRTI7CA88WPM/Rr91o9a7l2MUp7+n2LoPJ9BDBDBDj2Dot0u/Rxsj768TCG7dPL1Ai/QEifj1NVtrQaZhv5HBPgTKP4cgFCUs1y7pCKh0BraLwa0+HY+9S9RAVkaEyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZlew0fn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZlew0fn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq6EMCEhMXNA7HGNe/O1qYHWHhWZrBzRdRZ7YmKumJw=;
	b=YZlew0fn9yanqGXY/1seRV6wT2vgOciG/hX0Q45ua4vsRdrML+125ma75cOXCR+S3XlEVI
	TSwmRzYKSMyLrkiJxZv3Qv/tg6S6ORGsmiNfoIC6mzNCRgkKiST+XUkvxNUviSYKAN2UAU
	MksAdv2sInfM6+cOrBJSnAstrV/ANrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-QHmW_alyOVa_mAX_WgWBnA-1; Thu, 21 Aug 2025 16:08:10 -0400
X-MC-Unique: QHmW_alyOVa_mAX_WgWBnA-1
X-Mimecast-MFC-AGG-ID: QHmW_alyOVa_mAX_WgWBnA_1755806889
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso838239f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806889; x=1756411689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq6EMCEhMXNA7HGNe/O1qYHWHhWZrBzRdRZ7YmKumJw=;
        b=JA7W8Qs6K0bv12HCZzqykm8OpNLu6jVzTfS0RtIjzl93N/yfHsKdG5uny1mcbnZ6To
         8pQwvzvzxtzW4q66qLa3a/aDE5gCsScNLeA4To0TwTAuH1eOd4rDPif2kUtaWc9r5uuT
         guFCzLzweHT/skz4Mm7h0cpXSeEFvAJz2v+t/cFVR8bzNnz+08xkrZtCy4eznL2fIc20
         8AtayhwCwWs7qJdpKVCYGaU+TilPC6pkQqJConQOp0iXKTAvDqQXoke2qWl1PhdDkp23
         BUps/g5hrCeYTSsPc44Y/EFeAVXqZrhjjAywgTiUr/9QlAjVvvecjDYA5sFIB4t0OZgu
         E+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb0FhOy62/qC9LFUBksIOAWv3OP4JDiItMmipDiDSKULc4vxrSOu2fD0m7F2w7AyMyfmWEjlQy6h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRpceLLSgh2xJApDlQTqb2lhgNp+5AiJHV3bRldW3E7ZNaJs4
	cWYnxNFjJ5SEz8RMEoHmj+Ico/4zgLARPaMAT+w1xXD0Dv+RWpIVwq899iT13Hd4ew0+oBnJXhy
	jN2dgUtXP961ACAkbRYrTHMAvh6l2E1fwwvFt+S4O67bCFZoQ8WIuwAoy2NfN5A==
X-Gm-Gg: ASbGncv5I/dg5K0O+E86i/AgoOFPnFR/mU9l1WDrjGTlUAxZkShVHZrIOq66oMb9wa+
	OI7EoDxy6PreLxjoNkqOp56IWOOBn+mdcFhP3snqUciFWhThYLRMV31vr5AJ6mew8Kx62N0hEwj
	A/JFcf1o1/0KnAAj+UT8/O0bSxU7T1kE/kc9czxUPJlNhKRXW8vzAy7wJCcu5iFeQU7SCzmQIsk
	CIMeVJ/E04uFSj5tz+ljmFeToz/G3gXbEGXiADFp+TLeTqmvDMFGL+91nLVzZGt1DgIg7em6k8j
	o+F5Ddiryv/3+FsLSp6S9SqtSruNdGRP1rYThqdVrdzjN50mtWk0TZYol1v3y23As6bQajhh7bu
	4fdR4rmxT2pPejr58tlyC3g==
X-Received: by 2002:a05:6000:40c9:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3c5da83bf5bmr151942f8f.9.1755806888887;
        Thu, 21 Aug 2025 13:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeHEkncn914iQLB6IDJFbFllUgyuseH1VcCPvg+Bdgchh7CcvmYDhAXktPsYS0hqHcr6hQuQ==
X-Received: by 2002:a05:6000:40c9:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3c5da83bf5bmr151916f8f.9.1755806888456;
        Thu, 21 Aug 2025 13:08:08 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e2790a8sm21120815e9.1.2025.08.21.13.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:07 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 22/35] dma-remap: drop nth_page() in dma_common_contiguous_remap()
Date: Thu, 21 Aug 2025 22:06:48 +0200
Message-ID: <20250821200701.1329277-23-david@redhat.com>
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

dma_common_contiguous_remap() is used to remap an "allocated contiguous
region". Within a single allocation, there is no need to use nth_page()
anymore.

Neither the buddy, nor hugetlb, nor CMA will hand out problematic page
ranges.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/dma/remap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 9e2afad1c6152..b7c1c0c92d0c8 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -49,7 +49,7 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
-		pages[i] = nth_page(page, i);
+		pages[i] = page++;
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
 	kvfree(pages);
 
-- 
2.50.1

