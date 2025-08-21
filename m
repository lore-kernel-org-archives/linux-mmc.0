Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53302FC039
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806866; cv=none; b=SJZYdQxg/GFrla5hX5MQAf+QO7d5GO9Mc/pnK9DPriQDC4oWVNq6rqufoy9+RIlkFnZEZOI151BDvFBLaAEAHplHHajnBtWMsab3OqJovqRKhMqW2Wp8VdGHd8y0X0dmxBoqFVdCPby6lEXsKR+GUUDOheMw//ljxXfRhIyHh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806866; c=relaxed/simple;
	bh=XmsSbVhT3dGsaRmtyroJ024d7WMqPWbEWQJfIPHhOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKQdY4vfuf0wuAoOIzHyJaNoFuKJw+C3Rwj3eacVL0XDT1ywE6cbiwrfFWc4n28qQ7cuVjWiiM0RHPh5ZId5UDfFS7Whyz1+5qunCfrcbiJyY68lLbmWX+HSxsJrvtCK6vKz95QZ1u4nuq7NjmV3T9R2TupZwDYiobpBdPx6u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CisXHL6v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CisXHL6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
	b=CisXHL6v2QjuKeGotkAeKPWZ642xrEezOTevm2KNI/3nhnfLHXqBA83VHdJ6Fe+qb/cNRM
	bUyNtbGENJMvEPLIYu95zj+GmGOkuXGVrxrZ7TH1TmSFqb8BY1RMJWwdMNmCm4jb1PA1Uj
	nBRxwbqHOCNfK8qbY1uV8DPV15sMK2s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-XUJymV3vNn6t-OjxG48sOQ-1; Thu, 21 Aug 2025 16:07:39 -0400
X-MC-Unique: XUJymV3vNn6t-OjxG48sOQ-1
X-Mimecast-MFC-AGG-ID: XUJymV3vNn6t-OjxG48sOQ_1755806858
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so8301565e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806858; x=1756411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
        b=ruPsWvzrXC7jZK0AjypI2l/v0lUGCM13CN4jN0SiRUloE1VVYbJN46tVmOk6WQQb1G
         91dlshQYAfDj0KoDQ50fwVjeoAALsEayjJPIkddLhPTeqeDxx07GC13MvY39m2+lJRpR
         dFUDwxHxLbov89jti2k2PQZemYDGfqoUIzOckZuCGtVGpoOFXLJEUVc07pm9rgjeWhSS
         tYmEbcks3U+OpXsUXv1+2vEcHCaO4ZWIm7z89GddK3x0ihipDjlRuTUadX0EBGZnU4Op
         CiVXRhlwn3zYk1PVIlSOonWveR4BhF8a0n5pFbGRbReqcYrRc2WocxWawryRNRA+1sKh
         WhKw==
X-Forwarded-Encrypted: i=1; AJvYcCUIf7YIpP1aiw1StBkBlB6n0galVnv8bcQTm5EitTF4Ldebb21ORy61anwHmWnHUYHNE2lQr+y7/K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IF/p9oHm/0zsQWY4HYi1r6yXGtr4oK7PUGtD/BGvGegbrXPT
	YY2jFKrrd2ISar0B2rJsbZDkiAkzrNERWrKuygNw9KgA/M5mhy3C5y32NEYr/dy0Gz1sAAmxxwV
	7eOOTeckJTlV/FEV2V+Vfof7eU6GmmfRVr0wGb1Gi9JHRlLCqmn/r/yYU18wefA==
X-Gm-Gg: ASbGncvjSXpgflY889gJfUrzTtFDZl9KNanHT4Joj10yZ07OowYSC6vkfaXzix400KE
	NW1CxPhlUqdi+RmU8CYC3gCHx5cOwCW9KvwwxRJbl0N/wQJGQP8G8CsXbs7zMGmJzZj764yScte
	W6ZgwadCFmgq5YZu329zv6nN/PyNLOVWn95R6hPd0U3yUQ2Na88zo6ZoRmpXULdsWmpschKZHXx
	zh5fr/i/eeMBJcLjRKpzyEqooYQXXMRBo9LVVRcifDxI3lnESo5mFSwVJDWEzRzZvl9KU3LAqDJ
	yI25hij7LuYCtAi9U4WZT0of8i4LFWoofogIkvJAaSraUaE9uqJpXZufBahUIYkbU0AZapfbGeL
	1eONycWp1caBhh+DidpKgFg==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646845e9.18.1755806857909;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSU80KqPPviGOLp6CI40u/NjPujjG4FLCG6NoakJIlvY80lRDOTTm20w50mEKFuk0YjVSLQ==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646245e9.18.1755806857378;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e87858asm18672185e9.3.2025.08.21.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
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
Subject: [PATCH RFC 11/35] mm: sanity-check maximum folio size in folio_set_order()
Date: Thu, 21 Aug 2025 22:06:37 +0200
Message-ID: <20250821200701.1329277-12-david@redhat.com>
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

Let's sanity-check in folio_set_order() whether we would be trying to
create a folio with an order that would make it exceed MAX_FOLIO_ORDER.

This will enable the check whenever a folio/compound page is initialized
through prepare_compound_head() / prepare_compound_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..946ce97036d67 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
+	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
-- 
2.50.1

