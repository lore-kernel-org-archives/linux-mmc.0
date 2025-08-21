Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224342FC014
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806856; cv=none; b=IkgblnP620N1XxS2PDWzWEYKV2yOVUNyVKUSBbd/tgKzzzE0+83TZPtOIjbabojHtRB7Jq2Msq4b9FP5DDSQ395C34bHs4hAsgRLXFe+CBFtujMv/DSJEZO6iazQAOfMIQ0scZaA9C5LKJbyLZSmfiDcleKLz1OknIUk2gqeAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806856; c=relaxed/simple;
	bh=ncGz2ZUizfxPtBenqYCMYHXawyPm3K75je3+1YWzFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2TM61uomDgkXl98kW0c2Pvfm1RGXQAby30cSl4tpT+8A+pE4pMv6vLpD6Tvj6YFri5ZgGsV8mRSh16pdWD0CvipBlxih/M9cyMghQMcO/J6Ktg2PDU4XdVbk3Rjkfm3+7feZsAiE8DLCel2B5SeYxkotLik04RPMel9UsOUnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYJH0cx9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYJH0cx9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
	b=ZYJH0cx9h2eKEJWEb3cuRVsFgX0y3Cr5fjQqEf7k8GOB3VTPvOrPjcxl/4AbHOtj2wMh9V
	C0Og/sVLEmsiUg9pNpuYgZ9ndgC3XzdsNYrkgT6y4pVMQ0jcIIQ7JDCU5RZ+9iEfamd7tY
	Ve14Rp9a4Lxb7T5fw1T53GKXLuWjIng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-hQY3Dpy6P_mTJaG39g0wlA-1; Thu, 21 Aug 2025 16:07:31 -0400
X-MC-Unique: hQY3Dpy6P_mTJaG39g0wlA-1
X-Mimecast-MFC-AGG-ID: hQY3Dpy6P_mTJaG39g0wlA_1755806850
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so9581935e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806850; x=1756411650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
        b=KVQfLEL5x5m57b8Pwriwp3Y756CzT4+jf8nRpb+/y1R98Tal4Q9YxcXg6ANjn3HIgD
         w1PZSAXcNKQrzkvjtobdlzypy60Gs3vf9GTgaGq3gRUrrVYHlvmffbNr3RiLUch5nd1U
         lS4OCtpFPKcYG4QJFhzTF4tzJMEXShF3LIYDnhXtSWxCdpBNtzDYNBpl5mU9MA0gbm9C
         aieCDirxB57aZiC/KkuuXBDrFdIWql/zaWyXzviSsGu1ArGObVC57Zx8EchYZgYSn9ua
         Vz/LRynrOm2btpAurbIrlsZoYf+6imKLwRCuzhJT9Arau8i9FmYq1XuZvVUSKhtWsnSe
         c0oA==
X-Forwarded-Encrypted: i=1; AJvYcCXP6OZcoGljbuWMBL8fv7JZiD2gQmrewXeK2kps07oWkHyJj+IKi6ltM76uxgOVESkFbXSgTryX0KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxM8tXdTVHqG4R4vMy+J7wHR3VlO2JcVJF8dkLHJ80Joobv3q1
	IpXRGW7ZjAO+QcjDIwXN8wD76ZWDvXkuU+6TZwIDCNK87KVwM6CyDhMaCz/gmOBkBTDEymSkTG7
	WcGqX2YaMv27+/Nq5aJFYKe6c5pl5BoHMCUVj84xJMdX7l09gmVkM5dOrdNDHAQ==
X-Gm-Gg: ASbGncvIw5ORNlFj44JMllk5txQz6IjvQYoMkc+lfvD8Yqs80Hm3k6akb9UEE8a/f3u
	Y5CSE+dAS6WGCmLwBfOziq6cNr30v/V9ZOpdHC9x48z6JXw5gpz7k7olpyU+JyA0wX+14z+L5tq
	sHRNroDQvScz3vYYu6jY+0FXJ7ASNV4m10ASGwWaeJlTHg1OC/gLlKkJGgr4y3u7/MAeAV+DMR8
	A4Zjb9DT2m3RCq0r/I8r5HgDXS6ZR/iA6qgtsNOexe+YO59CqJJ/DR70f8hFemy9xchtTH3IVux
	SEIqeCHsIU2Q2lUaBSdKu8vgNSiRWGGOB2Nct6JygIwglX43noC3gRvDUK4B/UkHcWJZNWYtcYV
	ZXc5axS39Rr+JCZf3j3IFyA==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955845e9.31.1755806850018;
        Thu, 21 Aug 2025 13:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNoTdvVqQJqQwQf/z0aFpcDb/7HunF1Y6KwbAqmFFF4D3cnAaKEmAnoGbjwE6N5eIepmoyw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955545e9.31.1755806849496;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm7242256f8f.16.2025.08.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
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
Subject: [PATCH RFC 08/35] mm/hugetlb: check for unreasonable folio sizes when registering hstate
Date: Thu, 21 Aug 2025 22:06:34 +0200
Message-ID: <20250821200701.1329277-9-david@redhat.com>
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

Let's check that no hstate that corresponds to an unreasonable folio size
is registered by an architecture. If we were to succeed registering, we
could later try allocating an unsupported gigantic folio size.

Further, let's add a BUILD_BUG_ON() for checking that HUGETLB_PAGE_ORDER
is sane at build time. As HUGETLB_PAGE_ORDER is dynamic on powerpc, we have
to use a BUILD_BUG_ON_INVALID() to make it compile.

No existing kernel configuration should be able to trigger this check:
either SPARSEMEM without SPARSEMEM_VMEMMAP cannot be configured or
gigantic folios will not exceed a memory section (the case on sparse).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 514fab5a20ef8..d12a9d5146af4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4657,6 +4657,7 @@ static int __init hugetlb_init(void)
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
+	BUILD_BUG_ON_INVALID(HUGETLB_PAGE_ORDER > MAX_FOLIO_ORDER);
 
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
@@ -4740,6 +4741,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+	WARN_ON(order > MAX_FOLIO_ORDER);
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.50.1

