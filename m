Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07237D5AD
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806916; cv=none; b=PWvNbMH94WE0r7eRgp/3A9AHWEvFzkx6KW3171dIMasRyH6E3oevDB/HAIyior/2gweZk4BLRgYFuMbq9VxFnpvaL1hYoeIs9bNKwy0JHph1Mk+Khbx1Gn7CIXDJ3ZJgcs/JJmbN/wNBWGxgsfb+P9O4QZSk0f3GZq68fW6NKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806916; c=relaxed/simple;
	bh=nQnlX0DDaNxbga/DhB7JLie8Amiy5HfSv4XT65Hn/xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZuL//KydoQB6AsTSzQc1l9acQbkByRkTlXPvSUKeYhLeEFamMV7tWG656eAGtzir2CjYvKUIjakzbmQfeXsKrFFlL0BrWCggdYuIp+LWVVeumXxNu2gsbMQ7421ZgXXjY4hNJVtpeZEei06TB6SAUJu7AVZomQyM5WezMQOSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3mQDHt9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3mQDHt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kuJ+10C4pYxyWPcGDJkWqMBAcRGmXje5KFYns7NWu0=;
	b=D3mQDHt9EalJB+vz9IwQS/o1lcVU2wYGtkPZ0zaFKqF/Lr87jzWfarrShSl4UfOX3SE9kw
	sJJLJ87zjQqoRf/qg5HLk1WEnnYi1hv1A8uzKfbFeBhms9Puy0kC81NSD0ZXzxIDbqmYiy
	vteYzbLiRbserCfVDSwcAg1wcf0830I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-lpqhNJWbPmS184t1sdfchA-1; Thu, 21 Aug 2025 16:08:31 -0400
X-MC-Unique: lpqhNJWbPmS184t1sdfchA-1
X-Mimecast-MFC-AGG-ID: lpqhNJWbPmS184t1sdfchA_1755806909
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c380aa19c1so770634f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806909; x=1756411709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kuJ+10C4pYxyWPcGDJkWqMBAcRGmXje5KFYns7NWu0=;
        b=X5I/shq6uyS9go3I/0H2z0NNnKj2Hf1mAiI0d1Z09DlByW6pszKRIOnSKaDHC/Doxg
         32hRVHqKpKF6z9HQgy34mrGMhj7ndZouyfV4Xl2B9YcCCTg4RYifQv1sdEervMEr0vuW
         d/D1J1+MrB6M8kJ2RyZqVoQ+XVxlcJ1VjawkkRQdNKd1a0m6u0hGj7VsN1xRESSLUJZv
         /DwHR4qQ8w4YdNLCt8HcFMNJMRxrLF10LtGHANR9dSH/nG8PSbPKIxLP322QktKSCtXo
         /QykWGR5N7OiLF/8ZAcLyaIFPxpeCawE+uLt74HFUNv53t6AE9WaTvIBgAP8V9y3ubYZ
         6wuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlg74w3a73qGWbSS3qQ40q5fBDtPuv4fm+ZYHp/2b4DOhY8NxY9WceTZcOx+cke67Q1rkLhZjKLr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0ui7CGnfMzOrmgrRIPQElpBRYTCN6/eixauKGVtJsJQCeH1b
	umof2kBSxRosv8t4Yu0Cx+dNMti2KzghmfvFDmJo2VMtN7z+PiUrNBh9RHkOIVFzll9/ju+/r2N
	XRtL/0mFx+5ghVsKs6Kv9Lprj6XsDxJXlERViDqgbwvWXmGsA4+ufRHjVckc4uQ==
X-Gm-Gg: ASbGncvVGRoAFdF5LqHJddRUXte69RyVH/Nj4OihFNYxaqPuDMrxxnqu2GSeju5MtWD
	hZZ72es0t665dLrHg6GUnlTtOQdg+cE9wncuV27mkn2uoVN9nYIKTVHbPi1jh5ZV9pMB+nENwts
	u7oj9qmwIpC1EPuGkCsfGuRLxUQihwgQXsV1bRxdPg8d6Lb0oPXWfpOGrfdXF8BY3NrkpiE43cN
	I3eaCQqVUbya7cdcN8DzIezjZHP8sq3pzKYEYcj/MFovtFVYnewhmaeF8spL+mgiAaOe62tyqmH
	m2X8WhknG2nuMP2S/BlyrO2g8gVDNtnT678KJ2BkpCX48F8aZuOnX0c6kJCS+fF105RLJ3E+5zF
	WY2abMut7yUGcIc2mG+x3Eg==
X-Received: by 2002:a05:6000:18a6:b0:3b9:48f:4967 with SMTP id ffacd0b85a97d-3c5dd6bbb33mr155486f8f.56.1755806909375;
        Thu, 21 Aug 2025 13:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRykwWh31JVJGBkobbD9YNZEskJV981iF0h0FASAg1XfgxaqZA4MQnDyPntA4/emfIOpWurA==
X-Received: by 2002:a05:6000:18a6:b0:3b9:48f:4967 with SMTP id ffacd0b85a97d-3c5dd6bbb33mr155476f8f.56.1755806908930;
        Thu, 21 Aug 2025 13:08:28 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c5317abe83sm2432791f8f.40.2025.08.21.13.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:28 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
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
Subject: [PATCH RFC 29/35] scsi: core: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:55 +0200
Message-ID: <20250821200701.1329277-30-david@redhat.com>
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

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/scsi/scsi_lib.c | 3 +--
 drivers/scsi/sg.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0c65ecfedfbd6..f523f85828b89 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3148,8 +3148,7 @@ void *scsi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
 	/* Offset starting from the beginning of first page in this sg-entry */
 	*offset = *offset - len_complete + sg->offset;
 
-	/* Assumption: contiguous pages can be accessed as "page + i" */
-	page = nth_page(sg_page(sg), (*offset >> PAGE_SHIFT));
+	page = sg_page(sg) + *offset / PAGE_SIZE;
 	*offset &= ~PAGE_MASK;
 
 	/* Bytes in this sg-entry from *offset to the end of the page */
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3c02a5f7b5f39..2c653f2b21133 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1235,8 +1235,7 @@ sg_vma_fault(struct vm_fault *vmf)
 		len = vma->vm_end - sa;
 		len = (len < length) ? len : length;
 		if (offset < len) {
-			struct page *page = nth_page(rsv_schp->pages[k],
-						     offset >> PAGE_SHIFT);
+			struct page *page = rsv_schp->pages[k] + offset / PAGE_SIZE;
 			get_page(page);	/* increment page count */
 			vmf->page = page;
 			return 0; /* success */
-- 
2.50.1

