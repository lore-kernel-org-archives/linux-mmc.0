Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AB37E8FB
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806925; cv=none; b=N/34iFfxADWEaMFjNMkcIrRgGXFRzhCVFsascm5WnYBb1ZFu9sFjqV9c+qGhAnjG2hcVqfKMIrqXTzgch4Ztr4DTh2orcseCkqX1nSokphXWul59NODHRLN+c9TFXnxeZ1Yv80Ej+9dkI0MVwxQ2uemmy9fLtTDuGVEuPpj/hog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806925; c=relaxed/simple;
	bh=E88hXeAEs+yXdxHqIfTWo/GvQIeDr+kkFObDidynu1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEOnCFwcj+tBS02WPmaqXR/vGgIcaZ3SPwa8bSEtQUoeJPe5BhmQNqqbh40b/Cupjeb7pPYRTqLBZ2EE8Ma6fW6TxzgqzdrLIGu/M/mgxJvA5tAO4fhLyK7hV/LxwQ5NQRLrHbiKCjnr5RzV2kog59MAG2JoaIQJY/8gS+o6BXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eo1W+7Of; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo1W+7Of"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
	b=Eo1W+7OfCKPR3TmueUDrWMcqFW522sNOhlP53J7uQxeeuO90he1AZHGNf85VJguWAIS9en
	jb75jmZMBK/IzK4SN7kQs3ah3M4328zJ2p2n5rgZzF1I8C5NONciGN8p6Uc9wgzm6LRVea
	B7HYQ3xIciDm6x/srNv6XTq22NROlbc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qIIEOMCrMZGTDFkLBaKkRQ-1; Thu, 21 Aug 2025 16:08:06 -0400
X-MC-Unique: qIIEOMCrMZGTDFkLBaKkRQ-1
X-Mimecast-MFC-AGG-ID: qIIEOMCrMZGTDFkLBaKkRQ_1755806880
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so14273695e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806880; x=1756411680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
        b=PTZHK7V3pitaIgcT2Op3JQPYFa45zshYjjV/00c3w1zKwhkbcFxZVF5ysKuhqNVgCu
         HL08B4pOIVUNj/CMaq7iCOQZwUGxEyCiDgbP7wqRQImZA6Qxjh1fpxLHdcJd/cbEr6xm
         UVXT/UcNBQ5V02p7bY6+ZbOeStW7fvBViYmYraep4Nn6GeQv5YAuKF2a6fSSyksZCDAM
         KRDeGh/vPfYeHrIg87KuDAvpvJ01JjMOsfZeMtH5l/kp0gJ9JToPnTqENUGr7YN2QitX
         qRzbuSmMMrrqkSy1ZF4MZ5pCUn4RdsGLvd2b4/7Ev/c+1m8X/r3C2MKIcEIAV0MhYmTs
         btJw==
X-Forwarded-Encrypted: i=1; AJvYcCUAFK0nPsc2O3EYee4mXxSKqF9zl/6n9oW6SHabw2npfsVWIYZmWRm7qC6OZnIlBxVu8Y4tOYlMqQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yUVipP/CeIVj+AhDvKakhNmurjq/knDYW+ZCnYAdHX92PfdB
	wF6gaH+5IJ4oDlFsDJkoVw05RGH1OSlpqVTnx3oScltRPwvvrNZemmLbsrJ9FqSVJxSMcag28yR
	okIwpGGWw8x36S+7QaaZP7clid6GItBJVw0PCeqwWrLlAsLZusrK6MsMrBFU61w==
X-Gm-Gg: ASbGncthP4KAXsodAcyUNVpkpuxHKRomJvSqE4ww1wOP2OjxV+yWqY8FEHeWQ8apCYt
	n4d5RCsuPtHyzyDBScvqG+BUwX4p6wyv2FGuc6bwM9Fb4N5gOGNEYY0NAabm/bJAkgVEAVsTwMF
	2iJn0ej8tAu+G/UHdetLFW4FbdUDO6CYi6gYozLVX6gbnQIeIlb1CUugbJ5lcOmA35lp8Z5Z7aV
	auDBCBL9IiBii0u3JBGiLuN7y3p7Iq7Cx8CjGYStZsOfcnZHH9fQOWA2P3bLL9I1j3jLGqzpGSi
	36a/8cDI51TuqbP3uH/ueBt/OWNxa4dWmY3I1niadWqWzbBALTTWeDGsmIUuaF5Gkyd1cYxbbtc
	4OAH6AIrh/uyc6l8IxmcBaA==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328725e9.11.1755806880049;
        Thu, 21 Aug 2025 13:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ciI0WdoI3CxhUtu7m/cESVsdReJmvmXFWCMaWsO+hhXySreox2GeOL2sJ8kVyLPwCYhbEA==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328365e9.11.1755806879543;
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07778939bsm12219075f8f.46.2025.08.21.13.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH RFC 19/35] io_uring/zcrx: remove nth_page() usage within folio
Date: Thu, 21 Aug 2025 22:06:45 +0200
Message-ID: <20250821200701.1329277-20-david@redhat.com>
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

Within a folio/compound page, nth_page() is no longer required.
Given that we call folio_test_partial_kmap()+kmap_local_page(), the code
would already be problematic if the src_pages would span multiple folios.

So let's just assume that all src pages belong to a single
folio/compound page and can be iterated ordinarily.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f29b2a4867516..107b2a1b31c1c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -966,7 +966,7 @@ static ssize_t io_copy_page(struct page *dst_page, struct page *src_page,
 		size_t n = len;
 
 		if (folio_test_partial_kmap(page_folio(src_page))) {
-			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
+			src_page += src_offset / PAGE_SIZE;
 			src_offset = offset_in_page(src_offset);
 			n = min(PAGE_SIZE - src_offset, PAGE_SIZE - dst_offset);
 			n = min(n, len);
-- 
2.50.1

