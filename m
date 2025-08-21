Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F38369981
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806846; cv=none; b=jtdNfL04vDcqE028tWzO2SzEc8mU81FaRntI4aRSZCnGjmGEGONhDLlJxSN/WRvpTfMZznHSjBmS0L3iKmzcrg0vrx/LRrRLTt4sUOcl71QpvN1eV5aZyNpFxYfrtDnyWAHASh8NnoICu9wEWMmoXQQabhu74TWe2PQBZ0KChfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806846; c=relaxed/simple;
	bh=Cw7Tggvlta2Xmlg9ZVygUv1C92bk8NKTD0n9SH6aeIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwCD0tdDOlvzbtSMZL6JNoXfupK5mA1WQztvYCZ8zp3aMX5ksIaPP1XutLq5D7PNNJWBqVKudURkt9PnzHRBVkLUXHYzJ0CIRwnHWi/7SbQmT5QZ3m5red5ahLkiF2hYzsDeXFMtvcZxxLUzUcGCa+IubZPRdynhMAmwAm073AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcRzGZMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcRzGZMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
	b=HcRzGZMaIoKCEpdPLqCKQSjSZsgrjorL1+79aEHeGCSZr7jm+XOHlfY2MFF3t+7nvwkgv5
	hNVa522yDE6g9uv3X9+6h1cDoUL1tj9P/ET3Yy/IHyvHmwm40IbUDFA+82OvC+5nOOJL6E
	Aaony1+7kyGUiA9XEWWWu1XXbqDhPcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-9uuePHgkNC2IXvOv3M7NnA-1; Thu, 21 Aug 2025 16:07:21 -0400
X-MC-Unique: 9uuePHgkNC2IXvOv3M7NnA-1
X-Mimecast-MFC-AGG-ID: 9uuePHgkNC2IXvOv3M7NnA_1755806839
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10734055e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806839; x=1756411639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
        b=jud/A+JQlNNYndLRYppxRCzrPiiiRF52CuElYO8tnpIRIisCJL+xtuTk1b5NeQ4cI7
         cnol8zNmVT3A51GQKDDCrLWi7wbYrrEM2riyVxynVIsXCCnmwuhli6fS9iB2710Hkgt8
         /8vL4k6Vo+uU6Q56hyo5sIQ9FXdZqV6sZZl/sbgJ2m0J0JFPU83T8jsvEcbDKDMmGXOX
         rNoEHP80QtBu4kJkh8IVHPFdSoHxhorkPOViXbmpbigu1Zy5Xk2YAG8OMO26Q7NAH6cz
         g9scLn0pHUk//HG5ielbZtjBn74qalSP6J4p80t8UzrSV36CIk/YJhfjHoid1gkG1UX2
         8FqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQy9ypMrsbrZ+FikBxAIjU21TuuJ0OOXC5L6TH8A7IPtBnu25kMm08AX7TQCMFS4RQY5BaKDeh0UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0xaNcC+57IBg4BU6ohSpajjvQg91hp1qUbm7JeZ9ZOjpCvn6
	lqU3RFi18WnfnAE2jS3Usa0Ju7vlO1S41GzOFgFxW2HDkqkCY7xTV9NU/2vUnhh76jhcQnOA+Nr
	ppXXvIFNWDIFcb1DWc1OtrLuDJWMCjCEIzsDkNNvMz3CQalECL0+vpDTVDo3sZA==
X-Gm-Gg: ASbGncs/7/IsRZ2HVSlTGF/LRmYMlpyzhySZb80t5q0X6ln9UuXJzuXJ1rQfcFbmiY0
	i7HSoiws2F0CTD3S91j71nwTIIJlvvPDspuq8+71HfxgS01VFuQqF7hhE7Y7pT7q7HIbCat94J0
	FHRfrAQ0WVh6r+UhhTVYJPfF9YRG0QIvJpcP/GmXryjB+ep6lXqkSjVXbdn4hdz62JyuLLVsiCj
	ohl5jS3p1RIXKo9gg4pStog7i7VUzXo53g+2NzXljzT7OAUO8TVb6W6aVdiCPu5tez9DdDqgEEB
	fnDYWcuuio6Ezpuq4PgRRubKCJKgyNQK2ennVi/Lz7BvLtlpWYnTtyuQkgtCujOZugpOkJ/bfhm
	d1CPA6zbVgwqQeIYLA9lqkA==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845365e9.7.1755806838948;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhnqxttMNkrL8PAxIX9Mfq64uKkvY2MjzJ39LtAH2Yg7PxwVl8kOZ6CXLaaMF5rYTxrWwyA==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845125e9.7.1755806838506;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dea2b9sm8988005e9.15.2025.08.21.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: [PATCH RFC 04/35] x86/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:30 +0200
Message-ID: <20250821200701.1329277-5-david@redhat.com>
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

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100e..e431d1c06fecd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1552,7 +1552,6 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
-	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
-- 
2.50.1

