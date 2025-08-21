Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4F34F49A
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806839; cv=none; b=FbqxyTR2dGcgNIxgPlzSou08rBZYUM0cYWtpVh+Ku8jJ7yHh4SkU2pFVYrpaN/I8V7dK+wnOFhUHzTAOJOglO5ayFhshh3lTr0PW1nwFvIIF/3j3gSHe+9bqkUJg11xCWiwuEJsXp2eGeKFD3DPG2N/oGWGkdsBdIi43XHmufgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806839; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDovI+cz69sAhD4EauL4umU5F36yrXnt9CfFhyrh4aF6htvg+JQEAegJ8HZmi1mugCcM3GCXXLZkOc6qKQ9qVNJFaJKxif3nHVw2N1WoBaIF7nr7eGcl06ZRC+LTDG93au9HMDuC4NAeIQWAPPniM0R97F1MSPnY1ly46KSB9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbguPC8t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbguPC8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=HbguPC8tqBkg7t9/QOVKN35ZpT6p3DwwnNWto2lsLSPmzEFAH/NWIL/1ftGjfqy6oJgfIm
	vFfgtL3Abduu/oa56uS15OTjsdnVjAj0CciRfKz5zBxWHb5uXFtpZ4foA1Ur45VsAHtVSt
	nkvO04oL4Iu1BYlT+IGC12IVe5fuu8I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-diV02aHWPxWLefhkwam5qA-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: diV02aHWPxWLefhkwam5qA-1
X-Mimecast-MFC-AGG-ID: diV02aHWPxWLefhkwam5qA_1755806833
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b46bbso6492605e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=soE/9q1gq352ZQdXpByyLofegqSTi6htODedmaJrDOciYX3TAgcJ1wzmSOXcxFK1mJ
         fPNL8E1Sqxn++50CvrOZSIRrkbuTaA/OQVYKvbiTpwr8SsE9NP6xzg2mL3gzdK8O3TNy
         nswf/eNaQIapbAklOifzd+sZEbe0iilNtmgxGXjP71xzV3HmTtvHboInba5BtFNw/Zww
         XhOsVYVsslUx+qN3QCNc/CZaUIaLSE3sFtHmSL7C0fc7jtqSOOy4eLGDBISHJA59uJUR
         tEp6FMi7GXDaKSmnNF3z3geZeCOSAYkKoKZ9yt6THD+m87KBv2bzkPRfnzzZmNzrYsGU
         WE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2GaNfequ+twRySb2IKhh6Pt18+dm21ik6cay3du/2/7kjkGch5dyNpCp9AApUZ6yhJYKuStY1mnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+HAsIPNs7fEddxzedNoMjNBcARiCXU1j73geGtvNI9ZiSQfr
	f1n9E4aw/fA/gcKFz46ehIfOYMhUirEaDpTU+bOji1CK0ZKfP0XobQ0o+qp2ZajYSlbSfsNW5U1
	uyqgEcpxShIWXZlpDMV4JBnsuvWSNQhBaYAHiPdEpViJ8WnF+fEaMq656hde6FA==
X-Gm-Gg: ASbGncvJOWofLxMY13uAswRWvmcXScru+bsYL1MBoWRq8zyG1CiqAO5Qusno4djLikb
	N8LbWBXdissY+Gi6epJ+WZab34srWnfQNJ5GDKBPZ3QPJLR13GcjYtAjev66pDwwDbGEOJhZaFy
	e/myWR0Y4T1fO55kTuagTlaRCb20Lz3RzjNcR2zkjYR+biJD7ajvupeV0xAdk5MpxvipdgmRf0l
	h+nHlgoSsPhju7S6gWFxx5ltXe5IvYFMjH2SWworh4nUpbJFAr6D3KXucmZHI7sju/AYrTNuFZV
	Fl4SsNlhk30bR7DPOgHWCEnwUvXRND5ejBdGMLoem+WxqF6X6hUmE/V1ER3ng9X0VnJdpsy7E7/
	0+8uA9RfEch705p72+p3VCA==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598495e9.14.1755806833364;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1

