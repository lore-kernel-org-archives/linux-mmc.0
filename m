Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D30369989
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806846; cv=none; b=VQN9Aq10wwB5dBVeR1YKwggipaEFfYfHTaf4JH3NcWQodVnltbU+5zBCiec2DesiQkL5uIpdKLq3SsbOWQM0S9coDg09VzkcDqtCIK0nri62yfTXIPek8c3xPk7QkMpy4Gu7mvDKDsUFEGcBFC4/+P37sDyl1mn1CZKY7e8/O5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806846; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnOgwnkbunMYay6WJIDSjnV5CwZYP3S41iKNpu/4tGS63Sg0u1ekAm5xgz5v4YrN6sd6CTK4HXmE9mfPE/tT+XdNwuoTLAH8hJwSixbKlHw1QspPwgL+q7BUy22N8pzkML8DabUFOBVX1Az0vTNnBTzV70GuRnxya5ZxVYxXxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbucRQ54; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbucRQ54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=hbucRQ54sDPTGZ3BfKd563mrpC1xIJBtBESlBPfW0Mz0enbCpRRcd0bD6P8XYBStaUOvrs
	q5og+I2I2OYzZODlRzYY2Zvf0KsB2UDdwySTZfoYKdxzUV+p0HTYLy4CCvRztjDk5g/fbK
	touBRH3plwzJeqDoxYRw6fB6/tpnsqI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-HP22gemUPP2X99Tqlhuoxw-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: HP22gemUPP2X99Tqlhuoxw-1
X-Mimecast-MFC-AGG-ID: HP22gemUPP2X99Tqlhuoxw_1755806842
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so8650065e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=C3kPgE9NFZr3CulyojmTLWT1Mhd1IoAPzAtcz6f0v31e7G0KTGxKMl+xrewrs9uGm3
         yCyhhUOfKmCC3ZX+2o3bchEPT0HYVF4QqW9NCwJK8LIh3KE2gyXqm8YjKbV/5OTBziRE
         YMb57NFCRBf4gzXvZmG3TAoDfH6WtMJ5MRdRYLISLcrCbz3N+J7crmzx8njJYWKkBsZJ
         YVVBrk3e4l870aUjaj5Z63m2z+RnxPl83GKBN/l3L1oFd+j0HTHJamXIas89zvbahInS
         0c6V6pCVr6Ifx8Q2G9BJIsWS1Q0ybXwenrbkSP7zAO0JmOxPrN4X5Wk7YRm7/Urc2Ddb
         M0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpQTmjOC2l5nIUeePLfZHqik1X+EVumiU3iniNqS2x6ANeOA0i7PatnWHgOzD1xixly+7wl1LlfMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWgIikkcbZ3cOcgLUC3NLF5EP8fkssNtd4B4I0TdRU0kO/G2k
	iuzbZfSbc0ruJfkFsD5+6UzSJNo1fC+cV11Vt69YMjnX95BUFJCUgLe25PJ3B6Eb7tCU3AMGu4x
	i+ZGhpQZ2iSg6u8grVTF9fEfZAbRVy6hljqLGWOSHLigsLAcOPCzdAfbtGvW0Zw==
X-Gm-Gg: ASbGncvYW5pEwX06Ks5yV7P/4pD6YuY3pQnOx4E6+yYVJk/0+rD6RJs/6IzD9TtQMMo
	ioVPMkY8Vg4h0vxs9/p8TO1Sa4fOeR4wB9TU2TZ6ZNX4nxTXq66uqAXb7LdiWnGyrcay5fD9mPf
	rpu142YpaIiqlDKCNoEij+LEGIRxrS5I8CBA1NPjIY+VDn2V93cIv8Djue4cMzYbZL3te1g7nYA
	TPL7jylzqp9RmkOULwIQYJ1XGLwGYIPrI5ffVIuD2vYdKIqu/ZZ6w/ZAQqjCNK51BttNj7OG9Go
	MCE2AopfdRg0k1rgPFl0ARTOGX+IqFGjIiChrWyQyqP3+j44AkdQ423KosnaOBr5MjP+IbSnME5
	dskVd5Ii6qK9HErwOZnYA0g==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412555e9.14.1755806841694;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
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
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
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

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1

