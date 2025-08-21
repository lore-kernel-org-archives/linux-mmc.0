Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510812C0273
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807109; cv=none; b=lJZOQHXNrdyy2+HeSPAMcgZZRVJqH8kNEsAeLijj3HI+1FM6nvKUt3cpwxAw4LjQ2VKtE6vDaNRzP7nsTuxH4QGHi0Ui3gnenP/t8v17PNA2EtoJ74/Vz+V/7buHy5ivSda1xjDeRFlepEDS35YWQKiak7thdLLog8hSj5Z3bj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807109; c=relaxed/simple;
	bh=izYuZWtM9expuJ4aw1W3JEFW5k9djBINp3Pti4HydYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmnO62EiMEuaQGz6DZljFi2Sj6RFqVTJYwi28tKfewHosVNRzeZ9A9WPtDjW3J2Gh9KpQnmiUHUwY9QfL0gmXDRM+SsDyPo7nHAQWjMDqGII0MXQduA+ydkMqKrDKTZXbS4aTJZJNhlfOpOW5+JC337Ieyj8jvDvmvaNScV2ISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GByKPNnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GByKPNnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755807106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
	b=GByKPNnBT0XZXx8sOsXUC2kflZ8RAxIAn0Kfe7uoQjEgpciVZZITMZnRgFPDaD33ZMK6CE
	R1VBMvj7gR2Lod9Kc92RZ9ZSireoIZoSxDC4j/x5vlIewNFGtUiNvQEnBJEk6tO+nxh2SZ
	cksIUTJR3bL4NQDc6vMo+1fDRxDzdDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-2AlZ6r-BPXqEEcbSmcCUyA-1; Thu, 21 Aug 2025 16:08:44 -0400
X-MC-Unique: 2AlZ6r-BPXqEEcbSmcCUyA-1
X-Mimecast-MFC-AGG-ID: 2AlZ6r-BPXqEEcbSmcCUyA_1755806923
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9edf2d82dso666857f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806923; x=1756411723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
        b=p8Co1wJPotS4u9gXEtU7b2fn5A+OgjqDE5s8X6CwZzFDU5upcSHhKCrmY2EqVuau22
         lgu9tgNVsLeOtfQotv7VsEapPy4f/44kxZO2WL+v0hSm7Kf2Ki3IMIC+JTJJ3ac/nXcQ
         Qrui9s6Fsk9yC8IrrRSD/MexSH2DqfWjA2izUtU6Qw+oYhkFQTWM5Rb7JL7n/V/Zp2u2
         k7kSeOc9Jnuf6mU1RF1TruxMjnqW/GODz602Ys9578SkvTWsG8XLfBs/5i2Ua4L15Wgd
         tW/3Y/0FRsVyi31XoSw8yHHg6k1nVpieDyWIc9FAKka2uO0JItQcMHas/ep87XFef/R4
         qViQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSRhiKOuM0oS8Ge/cW+hWro3jJ4D/vqouPzk7qsTEfVNU1E4+xP0BVHUAHkMqGQWfQQewo5fB2KNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDa35gLrveIUCSgLjqbS9QuQGQKZ/W+RvWx2DzqkRGN7exrh3L
	pxUOtX0LeFOXzj5D2VfHOlaZab0G6f420iezTs4+2w+X0Ikb9vNmAmd9GMQ/oKc0dt/319uYMmN
	/daIS/ySJoIVlqjFEF3fNL8zKEZDcjvglo7dWrVotUU3PEG057nXMPqPwmEf/nQ==
X-Gm-Gg: ASbGncvGhKB5KGzPp8MS7ItWs7fES2K8nRYXjhsYFo+Moahfp8sTtXssA5Y22XdD17W
	4rWiT3DnwJL1UO2LOmw2GOthdkNJsRZTN68iH8mg0BFr6YRZxzkOk04USbx/qXqe7UdHk5YBsKq
	8ftcmrj1EtAv/tuZFGk7eU5UAzvs8KlGKMh486L01qgbdhCW6Q5YevBkYLqQKXQuF2z2TXMt78/
	Pr+sq5zHDe0WVoK5JqK4HtOsPiXol8VJD3Da5fcpijucqkQhncMpZ0t0DBdgbh1V8nzk/7gNxE5
	UuFScd7+wncoyHavSfCx0MqM8jpaHQj/te7EDt4uEzJwDdHCbP9zRm1ADoL1ZbF4nj3Rv2DUsnv
	mrXvo30iPN0+aOQsAfknxuQ==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204683f8f.33.1755806922954;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHzRKC08dohUKQD/XdldMc6IWYVddiLtTh8Yidep5vx+5++gzVG23SiimMwYZ+HldR36Zkg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204645f8f.33.1755806922505;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a587sm10028205e9.18.2025.08.21.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
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
Subject: [PATCH RFC 34/35] block: update comment of "struct bio_vec" regarding nth_page()
Date: Thu, 21 Aug 2025 22:07:00 +0200
Message-ID: <20250821200701.1329277-35-david@redhat.com>
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

Ever since commit 858c708d9efb ("block: move the bi_size update out of
__bio_try_merge_page"), page_is_mergeable() no longer exists, and the
logic in bvec_try_merge_page() is now a simple page pointer
comparison.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bvec.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 0a80e1f9aa201..3fc0efa0825b1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,11 +22,8 @@ struct page;
  * @bv_len:    Number of bytes in the address range.
  * @bv_offset: Start of the address range relative to the start of @bv_page.
  *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
+ * All pages within a bio_vec starting from @bv_page are contiguous and
+ * can simply be iterated (see bvec_advance()).
  */
 struct bio_vec {
 	struct page	*bv_page;
-- 
2.50.1

