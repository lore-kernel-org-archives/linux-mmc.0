Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6235206C
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806871; cv=none; b=oRyEIq2x28Lapq0G5GMRbVLKrFmYjqqazGyqjM3FHcDBPggCSJDrH5e7r2nK5FITmBGyzIW+E8INSWhOomGPXHzn8xHNNPFWRj1UhdP61mNV/R2HCJNMAlGmKG5erpGIUyF0/M7cH8AMWJh94JY1n1FyUWZUfbR3Jr6+0eJcLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806871; c=relaxed/simple;
	bh=KQhGj4yMV2JJyYTphSuwtYusktgVAWzYxv4GDdmnyDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxPHkbhXTip9t5t8LUT+yrhC5Ms31P9+fci1wLCPX7OPMwCDrPlC7v568BpfwFm7DDD/W3SUN4bN/QkYDZcXjk5YfgPJTi2/W5DxEaoWdJoL7D01+DeUkiGS34oFtyV8xhYbQqbM/YqhX4PrL1IBdWKtrpFpnVVqjwNVYA5528s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQgtOEQX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQgtOEQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkrXh5PHMEq3NY5i+0892fbAshOERsmwyMLhbVIa0Cc=;
	b=TQgtOEQXAd+ZqMtryRdclu2CWcywwWPcGCzMrZFbaM2gO/NUWiE9zbd6emxjpl4PAaRcmX
	Ja8dVAi+Ww3YWP2K5jdURjRGATicOACA0zIstYunElZfkqNE3+Qa+89Se5oMOlM8Yy0tDq
	RsY7hoM2zfwfOUwYF+6vwfncgXNx/+E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-v3-jhIZYMpKOGl7ScKWayA-1; Thu, 21 Aug 2025 16:07:44 -0400
X-MC-Unique: v3-jhIZYMpKOGl7ScKWayA-1
X-Mimecast-MFC-AGG-ID: v3-jhIZYMpKOGl7ScKWayA_1755806863
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso837897f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806863; x=1756411663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkrXh5PHMEq3NY5i+0892fbAshOERsmwyMLhbVIa0Cc=;
        b=JvdM2iCfqPl8Qf79Jm2Lb5VmNDIuAJetq43iUaU1AdWJKLNKH+tfCVcN+EC6xcSbCQ
         gWgCsh2SruoNW7F5ND18JahUytGYjQdT8ZZxxVcfbeDF0bPfsm04EO0dxOYw5qhXmpfS
         pgxS7W40GhThK4S88xEDEbt2InJ+/zt6f6d6AyRq7Tgg4v9V4saEBlMzgp2pDliTBteU
         8BBbimdLLanoNsbffxbEFZDlCjQ8PzZOwVZ8Zegvf0PeAkPvgO9dQMw8mc/024gpqQPI
         qHL9PniSrmg+xvc/YE4LZi60t1NtaPDsW/l/XV3u/NNNtysrYRUR8f+x0bxMLuVB0BVr
         wOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdf8/tnbA67xqdGkTmh4ZkuQAsBIl5aQ62fwY1+k3/S9Ct2SCzFfpMNUs9n0kYHnE9TNRzQfqTgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oecE2nlpplRYmiEgK3adRzH9Kp3Td9IDcrh2MPjZ1LPK+WFx
	rJoiOIAmqO0WkkajFR2ShWpLqbIOFcIiKxuoPzmRsvTmmPuT5ECNV0CfYTkci8+XLCmT5zUMAPj
	ElRTYbvoUvixcHe7gaT/ZpVa41QGXwQ8hO9xK3ZwSAUS5/ed821mi19cy4qGhdQ==
X-Gm-Gg: ASbGncuL95eRvE5ldmzlf35JNqaawY9vAPkGFCt4sDqQ3CXGH1u31DMys24Qiu0llNA
	u3nO1XutvsgMnXQDa0Y0NfRvjeL6FOp/dEsFNzj4zxA5uYoFrMXYkMDt3RszaxVlluBlmWA4MfU
	wFPf7uwZyuYdfcOsMJikS3aKuWEPn19+UzRD0xd1ke2IM9PyruKwBPY+Uo1/+q2juuR3QlYngqi
	hp4mxql8pR3SwFdx5y0jmwSp/koqSfkO2lCIufk8ZU0eO3r9iOXOjylY6y6LXDDkg1myIpC0eV1
	ngWvDx4g7K7CgW8nlwczCUZ7mqan/479tIjRv0fO6l74ZXbiptYJKHtaL2AcYsrphJZnhLsGQxs
	P/Jf7GjsajXe0pUIo6cF8tw==
X-Received: by 2002:a5d:5d0a:0:b0:3b9:14f2:7eea with SMTP id ffacd0b85a97d-3c5daefc2a3mr192578f8f.18.1755806863503;
        Thu, 21 Aug 2025 13:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB28V/U3gI+p1afMr2c1HujEN1g59N1A45YIj+RBO5vrtdOMlsNhrN6BtrkE7YShkW7nBB8Q==
X-Received: by 2002:a5d:5d0a:0:b0:3b9:14f2:7eea with SMTP id ffacd0b85a97d-3c5daefc2a3mr192518f8f.18.1755806862961;
        Thu, 21 Aug 2025 13:07:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b51b61256sm1742995e9.3.2025.08.21.13.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:42 -0700 (PDT)
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
Subject: [PATCH RFC 13/35] mm: simplify folio_page() and folio_page_idx()
Date: Thu, 21 Aug 2025 22:06:39 +0200
Message-ID: <20250821200701.1329277-14-david@redhat.com>
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

Now that a single folio/compound page can no longer span memory sections
in problematic kernel configurations, we can stop using nth_page().

While at it, turn both macros into static inline functions and add
kernel doc for folio_page_idx().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h         | 16 ++++++++++++++--
 include/linux/page-flags.h |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 48a985e17ef4e..ef360b72cb05c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,10 +210,8 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
 #else
 #define nth_page(page,n) ((page) + (n))
-#define folio_page_idx(folio, p)	((p) - &(folio)->page)
 #endif
 
 /* to align the pointer to the (next) page boundary */
@@ -225,6 +223,20 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
+/**
+ * folio_page_idx - Return the number of a page in a folio.
+ * @folio: The folio.
+ * @page: The folio page.
+ *
+ * This function expects that the page is actually part of the folio.
+ * The returned number is relative to the start of the folio.
+ */
+static inline unsigned long folio_page_idx(const struct folio *folio,
+		const struct page *page)
+{
+	return page - &folio->page;
+}
+
 static inline struct folio *lru_to_folio(struct list_head *head)
 {
 	return list_entry((head)->prev, struct folio, lru);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d53a86e68c89b..080ad10c0defc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -316,7 +316,10 @@ static __always_inline unsigned long _compound_head(const struct page *page)
  * check that the page number lies within @folio; the caller is presumed
  * to have a reference to the page.
  */
-#define folio_page(folio, n)	nth_page(&(folio)->page, n)
+static inline struct page *folio_page(struct folio *folio, unsigned long nr)
+{
+	return &folio->page + nr;
+}
 
 static __always_inline int PageTail(const struct page *page)
 {
-- 
2.50.1

