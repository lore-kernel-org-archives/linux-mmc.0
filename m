Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C734F483
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806880; cv=none; b=JZczE6QhBdA0RIljpXUthVZPcXDEIeilhahfVKs8EURuQzp6YqJEr5xFRhT0uzXEEOCENHjpLhu3jJACkRjInTFncX9G3f2u+5WLX65VG53/bfTjJKc/upsvEy4+X8zwYW+o+qCmcMev0MQNF9yhC1LRPcLTFQ+oEjI3rt3Rp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806880; c=relaxed/simple;
	bh=jeuBd6AEd//7dLky0U/9/K8CcfgAIF74DmeLEQ7xh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzf4qT4eLFy47oo8P/gk5pmD6Vqpx5tS0TqMDqlTztN57XKoS/5MN+98UPGfGyxEcG++8o5WdR4ei8LuKN4BcopEhsP0RUu2+nHvfjV7K+1j9Yn6ENxdvv4uIhv9tdFkTAlTrGHZ2ITpsrhn1GcGZCn6zMSQ1+l1vO32AKaVpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc7k8vzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc7k8vzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
	b=Cc7k8vzI8vWyxlhOTg3zj5LNGjaDshsiz6wO+Ms72EVhWwZd1ayoq4w78xvhwzeswURLhd
	sTkMrm8c281eBuTMugA4EQ0gLZR/hym/wLnJuwYj0b/EGcngrTVom43mob3elWoOAbQwg8
	yXIaPVKhDlpqvvHwwbMbC25+SHd0wvM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-6e2VfWb0O_GmHtxAZVic3w-1; Thu, 21 Aug 2025 16:07:55 -0400
X-MC-Unique: 6e2VfWb0O_GmHtxAZVic3w-1
X-Mimecast-MFC-AGG-ID: 6e2VfWb0O_GmHtxAZVic3w_1755806874
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso7028845e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806874; x=1756411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
        b=C1pb6UA3D5j1izizA6EuZ3ugNm5JMQFIP9CaOHSbjeS3jN9PUZLH1cb9GzXKksvXzL
         wFBc88qhG8WBHkHJqqWvjkmVzoX9Zq0gLLHW1VeY7IkaUUWEjltUz7/dF4MQfcCFBV4w
         mCjYUprjmVCmfnOaWbKnxu3YjObmQXDdXSWSz3Q9sm2Wn22oc005edACTJQUbiinz/El
         hrxMuieMHQ6xspAvmZdKiAjYeVdgKzyULipqwYViWgZ7jgIG243ZI1hQAwdyHsBrTaQt
         S4D6ZHoKwpPbrUttwxVW+WJMzekHLYJyrTtOnDzfGTy/CQwW3/40clAHvabHHYlps2eq
         irtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcgC3DJkacvcmWk7GFOLOL7+P7fwkh6nJi1S9S4xa4XrvaP8hvrhnpzh01rYVMWBh/vlhe9Wlv0cY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32Cc6UpUhxZa5g+qcTf9n0G9aXZspHCTA9cYYo7GVZ1a7L1Tz
	+D4Iu/ExcViAXGL08fRvpKZ5PBpBA9YQLrQwESbLjz/mhvDg30VCV280sWteX61MabqDodBy+rU
	ICnDFgQbz6Y2NvAi3KgPXoa0TkoG5lA0KzQ9fFZc61HMp110A1y5ei3uevIjGXw==
X-Gm-Gg: ASbGncuBo8puI2PPkZwEHhwnZ63ACowfKgLet5yl1MnodA6bmIo+m1FAofVCFh8rV+D
	Gcx1kYfTKFuIVme5Qil9kuG3MLN4iozrCB6eaqbFdfmH1749UypbXeFgFPeCLqIEk4nfdIl1YdE
	Whxlxq63H3fxVO558uSI8s4/e4Os9326Yybv2APf3N+TpHO10q+tjrKbXyX01lgWVAsH7CjW/q8
	vXH5QpiTqBLtuKs7xJGxMq1sLwkOvG3WyoRdMBsolhR9QhiIwgoqUrtdqKh96qcLpzpQZGJCclF
	dikVlk+GKicz5eB2f0l3gJQL4yVelzFUdw1Rxt9T+FiXeic41I9o1cr22e4KcRtMZDSTC2vgv2B
	/5cqfltev2SISo21pP8wNdw==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2554175e9.24.1755806874309;
        Thu, 21 Aug 2025 13:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8ikhW4DoWVw60oDeAXqMRvn4UERlcVawLCjGel2pacwRc1R1ONhYVQm5EzuW0YIJQT4FDg==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2553905e9.24.1755806873856;
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487a009sm12690403f8f.11.2025.08.21.13.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
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
Subject: [PATCH RFC 17/35] mm/gup: drop nth_page() usage within folio when recording subpages
Date: Thu, 21 Aug 2025 22:06:43 +0200
Message-ID: <20250821200701.1329277-18-david@redhat.com>
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

nth_page() is no longer required when iterating over pages within a
single folio, so let's just drop it when recording subpages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b2a78f0291273..f017ff6d7d61a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -491,9 +491,9 @@ static int record_subpages(struct page *page, unsigned long sz,
 	struct page *start_page;
 	int nr;
 
-	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
+	start_page = page + ((addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(start_page, nr);
+		pages[nr] = start_page + nr;
 
 	return nr;
 }
@@ -1512,7 +1512,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			}
 
 			for (j = 0; j < page_increm; j++) {
-				subpage = nth_page(page, j);
+				subpage = page + j;
 				pages[i + j] = subpage;
 				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
 				flush_dcache_page(subpage);
-- 
2.50.1

