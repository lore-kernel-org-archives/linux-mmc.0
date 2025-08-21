Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC836C072
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806892; cv=none; b=NZkv7w1+OlF3e+pqZVe4hp8uc0RZdBx/aZNLcrLar20WOr8w4StxCz9iwp0d/rJRGod060WwpNpXVP4BzToEjklYba2wkhGgtK1vYuUOcYgoeewtU7Dmhh+hwsjvoM+UaqTItRwwX4Hzu17mmbcDAMWPU2Ep9mxr6T+Ddva1ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806892; c=relaxed/simple;
	bh=u7U0E5UNosH6c7PaP/scUrTgiGRReCYM/RkOjp4OjeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuzwlGSGtWdqz2d6/VTqJfccHB9UNPT/WBLqX5RZNYz85Yq/mnwW7PDKZASfHsmMyjT/EqAKkdYlTIJ7d9hawISADKQmyzTNojhXvBqzxR1q5HTeOXTe/SNFu1c56LwvhqYVEYpPPADMJ/rObT27yy41hTLA2f6yfz4zYhheTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePtuCqPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePtuCqPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlD9YGSFbsAaeSHrs+lmfmp3eNVZAqkWDWaUN3GbxpI=;
	b=ePtuCqPhLrEUIRe+WA9npteyGCuGmlLqnp6Ixdc7k7oFTWDb/aB04DZk7E3XDFeuAqfuF1
	r2Kx3ZdBv14qvyVf7+aNG4Acqv5pTKNE0Sjt09jom/eJP0khKhLdLLK/aRueImewJsHRwr
	R1GezbwiEzuyGvwtBraRg8U7lX+xAR8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-NHpIXXLVPr62wXnKYOVHCw-1; Thu, 21 Aug 2025 16:08:07 -0400
X-MC-Unique: NHpIXXLVPr62wXnKYOVHCw-1
X-Mimecast-MFC-AGG-ID: NHpIXXLVPr62wXnKYOVHCw_1755806886
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so675620f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806886; x=1756411686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlD9YGSFbsAaeSHrs+lmfmp3eNVZAqkWDWaUN3GbxpI=;
        b=wt4Gh4QuiQQFTF3tccERjSIMypLjrthlhN70N/4q1SKSnb/LcvEHDTkJdOPey7afPd
         2clLkwkKZgYycYElcWMNzZeTX52yps4iYa5s/Gs1zosSsZVov2K0nnulk8/4WCtUcFBC
         P6vy5Z2/XSFSyBjKeziu1q4Sk6NYpzfDl/FU6MDN5RXjOWiADtFOboCsf6EiB1UTGV6k
         5VpvYwKlbvnHDMiCCqRyGV+nDQW3kwioi+5B9QGrHlq+GyAsdkMaobHlBMHWZrrql0+P
         9j23iMh+m0adFpIKEyxzPoFYrGfbD7dRgUocbiIa1NyQ6oPtqSzuE9aR9FZwMYBI0vaJ
         Zi7g==
X-Forwarded-Encrypted: i=1; AJvYcCURFR4iodcs0h5h5+3wxRhAKHEv1q11C0ZRecxdunmwPySRK6olHRpXF2NpatU0XQag9OQwkdmJKNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS39fzNh7iE0zULC0YobSz2jZQyuXLto9Z577AvHj5jdhNnESU
	a0jXktXNtfyz0TFQuDKhfwONpACGOa54pYZ3AdHsTfpmVtl66ach8w0wXe+YZ1h7guCbs1XBn9D
	ZtonJjtcJc8963ZJffCz2lwRPmESizqAYjpXVe8qu+UrzrJM4lUM8KiWOaqhkSQ==
X-Gm-Gg: ASbGncvdVG50pDWbGg9dCxVfmCobzqX10F+qg9/nKmX7OLfQZRYmDGKncMCnCXddI2Z
	aAJrHz1OsmC34HWfTOFMhJpZT46uszPTaIVak2rXReGkKxUkZ9s0ZBvW7sJgi+2Kzl5k19AvMAh
	xDaVStoGADFDQaqr+c8smqp+NwWSCA5tgfJHuME0QZduLFSELgjl42+BYRYRhB0Iu9oY5DxrTTt
	p2xYBH6kgIasGKkHEsBZjzWWU5j1u7USZufPMWgr9BudYke6sJSPmN3yqmyDL33NYvPE87kecud
	NcuB1Tp9DQs8f3t5Rps/3MBy26UXmi3T0eskah5o7Z0Y0gmhE3S2oHVVRYR39oSgAGuchvHBAdz
	cxON2onBTSWhyUuVifRAtVQ==
X-Received: by 2002:a5d:5849:0:b0:3b7:94c6:7c9 with SMTP id ffacd0b85a97d-3c5db4ca226mr187807f8f.27.1755806886191;
        Thu, 21 Aug 2025 13:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN2zPHDTqkDZIT/HT3QVvSDWvKglll+HTpAUltvzBh+S3AYz2M0rKfptvzXjL7aLPeFpS91Q==
X-Received: by 2002:a5d:5849:0:b0:3b7:94c6:7c9 with SMTP id ffacd0b85a97d-3c5db4ca226mr187788f8f.27.1755806885705;
        Thu, 21 Aug 2025 13:08:05 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789d1dsm12697993f8f.49.2025.08.21.13.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:05 -0700 (PDT)
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
Subject: [PATCH RFC 21/35] mm/cma: refuse handing out non-contiguous page ranges
Date: Thu, 21 Aug 2025 22:06:47 +0200
Message-ID: <20250821200701.1329277-22-david@redhat.com>
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

Let's disallow handing out PFN ranges with non-contiguous pages, so we
can remove the nth-page usage in __cma_alloc(), and so any callers don't
have to worry about that either when wanting to blindly iterate pages.

This is really only a problem in configs with SPARSEMEM but without
SPARSEMEM_VMEMMAP, and only when we would cross memory sections in some
cases.

Will this cause harm? Probably not, because it's mostly 32bit that does
not support SPARSEMEM_VMEMMAP. If this ever becomes a problem we could
look into allocating the memmap for the memory sections spanned by a
single CMA region in one go from memblock.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  6 ++++++
 mm/cma.c           | 36 +++++++++++++++++++++++-------------
 mm/util.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360b72cb05c..f59ad1f9fc792 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -209,9 +209,15 @@ extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+bool page_range_contiguous(const struct page *page, unsigned long nr_pages);
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #else
 #define nth_page(page,n) ((page) + (n))
+static inline bool page_range_contiguous(const struct page *page,
+		unsigned long nr_pages)
+{
+	return true;
+}
 #endif
 
 /* to align the pointer to the (next) page boundary */
diff --git a/mm/cma.c b/mm/cma.c
index 2ffa4befb99ab..1119fa2830008 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -780,10 +780,8 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 				unsigned long count, unsigned int align,
 				struct page **pagep, gfp_t gfp)
 {
-	unsigned long mask, offset;
-	unsigned long pfn = -1;
-	unsigned long start = 0;
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
+	unsigned long start, pfn, mask, offset;
 	int ret = -EBUSY;
 	struct page *page = NULL;
 
@@ -795,7 +793,7 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 	if (bitmap_count > bitmap_maxno)
 		goto out;
 
-	for (;;) {
+	for (start = 0; ; start = bitmap_no + mask + 1) {
 		spin_lock_irq(&cma->lock);
 		/*
 		 * If the request is larger than the available number
@@ -812,6 +810,22 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 			spin_unlock_irq(&cma->lock);
 			break;
 		}
+
+		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
+		page = pfn_to_page(pfn);
+
+		/*
+		 * Do not hand out page ranges that are not contiguous, so
+		 * callers can just iterate the pages without having to worry
+		 * about these corner cases.
+		 */
+		if (!page_range_contiguous(page, count)) {
+			spin_unlock_irq(&cma->lock);
+			pr_warn_ratelimited("%s: %s: skipping incompatible area [0x%lx-0x%lx]",
+					    __func__, cma->name, pfn, pfn + count - 1);
+			continue;
+		}
+
 		bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
 		cma->available_count -= count;
 		/*
@@ -821,29 +835,25 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 		 */
 		spin_unlock_irq(&cma->lock);
 
-		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma->alloc_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, ACR_FLAGS_CMA, gfp);
 		mutex_unlock(&cma->alloc_mutex);
-		if (ret == 0) {
-			page = pfn_to_page(pfn);
+		if (!ret)
 			break;
-		}
 
 		cma_clear_bitmap(cma, cmr, pfn, count);
 		if (ret != -EBUSY)
 			break;
 
 		pr_debug("%s(): memory range at pfn 0x%lx %p is busy, retrying\n",
-			 __func__, pfn, pfn_to_page(pfn));
+			 __func__, pfn, page);
 
 		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
 					   count, align);
-		/* try again with a bit different memory target */
-		start = bitmap_no + mask + 1;
 	}
 out:
-	*pagep = page;
+	if (!ret)
+		*pagep = page;
 	return ret;
 }
 
@@ -882,7 +892,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(nth_page(page, i));
+			page_kasan_tag_reset(page + i);
 	}
 
 	if (ret && !(gfp & __GFP_NOWARN)) {
diff --git a/mm/util.c b/mm/util.c
index d235b74f7aff7..0bf349b19b652 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1280,4 +1280,37 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 {
 	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr, 0);
 }
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+/**
+ * page_range_contiguous - test whether the page range is contiguous
+ * @page: the start of the page range.
+ * @nr_pages: the number of pages in the range.
+ *
+ * Test whether the page range is contiguous, such that they can be iterated
+ * naively, corresponding to iterating a contiguous PFN range.
+ *
+ * This function should primarily only be used for debug checks, or when
+ * working with page ranges that are not naturally contiguous (e.g., pages
+ * within a folio are).
+ *
+ * Returns true if contiguous, otherwise false.
+ */
+bool page_range_contiguous(const struct page *page, unsigned long nr_pages)
+{
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn;
+
+	/*
+	 * The memmap is allocated per memory section. We need to check
+	 * each involved memory section once.
+	 */
+	for (pfn = ALIGN(start_pfn, PAGES_PER_SECTION);
+	     pfn < end_pfn; pfn += PAGES_PER_SECTION)
+		if (unlikely(page + (pfn - start_pfn) != pfn_to_page(pfn)))
+			return false;
+	return true;
+}
+#endif
 #endif /* CONFIG_MMU */
-- 
2.50.1

