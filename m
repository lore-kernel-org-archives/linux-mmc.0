Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC101F8AC5
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369113; cv=none; b=RllukhAW5ooT1NFeBzg07Ige1fvFdD4zz8hUjeClyevpmgC8DW7wZY/askAFaCF4jCdUCy2nYnvYnvXi0NBO7tcutc9EygqfDIs7J4Vihy/Azsa/g3zKwBacTb85An/d2fiVqoqvgWRjno2V7oxxWSn/M7FKbKSIz10JwwyiUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369113; c=relaxed/simple;
	bh=DrJKkg6i9D0PoQ1zdwOSdGIFvRSjQgy2FP4D/LXLQRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moejP4BDEeFYb+KXcIw2vZdD72iDoF5bDigX1+qzxBgxhMzgSu+hUWgW0wA7Y4PJI6RCwV8jQ0v5I5U+EsZyK0qp0jv4EdX+zt/j3C1Q4RaQCkOiTTyKxm/P9KkeiI9LwahF2FrqWIRPZuSmC6jTyBT5X3dKyCU160bTiiKJnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXIc2Z+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXIc2Z+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756369110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dQiayb6TF/jkGdLdQdDfmQoC9oGAqREv3FJiJ/1tw1w=;
	b=KXIc2Z+mlXEAx3uXht+v4ZMhpVt+iAz9uLUBzvPg4SiQBRrnGvkVwKJWXMsTc0bPqnp/dl
	a830EYPX+egeDr0lWwcoXcIb39VzHZWnjySWTpQeDize22NwFnWmh+aJVMWmLDrZQ379Qd
	Y7WKz920Dq5WFHSyGbzxTJrfbxzlCPc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-_ReGCnu_O0qoIF0Ru31cqQ-1; Thu, 28 Aug 2025 04:18:28 -0400
X-MC-Unique: _ReGCnu_O0qoIF0Ru31cqQ-1
X-Mimecast-MFC-AGG-ID: _ReGCnu_O0qoIF0Ru31cqQ_1756369107
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0060bfso3505775e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 01:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369107; x=1756973907;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQiayb6TF/jkGdLdQdDfmQoC9oGAqREv3FJiJ/1tw1w=;
        b=ScMpUkDkrL3D9YnTeszdmwvQR0pQuSKPZdJ2+k+1LhCGEgoR/9HVK1C3pvKioc+5kc
         oUudp3W9i/P8A6aBibwioTERN7CN6FhYlwzurNtxL14TP3UK7oG59MkzBygurwpZjEwd
         Q80Xscb1vl9+zQl7m3gWdNria7wddlki7e/ezChNrmkrEV59jf35ZvQPkv4u1ta+EdZt
         zCKu3sRzJrF3HHC2uwBr+IWLC/YJhrMrBE36k1F2XvFzoeS5vtssHAh098X49P7TfstZ
         MvjQqgn8mZDUJ99JBC+EKjAodCGrc0Q1r+Nxe6ceuDYVG2RwS103oHYLypdA+bZuPalI
         tEtg==
X-Forwarded-Encrypted: i=1; AJvYcCWgz6tEs2NDZ6iDkXEyIpLVew+YgtTI9zdooXdXi5Prcc/Pz45W5IUeJOknaQ8wkDd+5M6eod5I+uI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65eu/Q6iq/2sHlh04SIUEwH/DzWW64d5T7nsj7crgtp6HAx2X
	wJZf/fKYa9auTMb1Nx3J8bYmkMM1LhITcpkMFY57c+eDJvNd0RD9/MuY4h3J0G1ub9pSUPDlEyC
	Dw7GeRA5HL1tbkna0NTvfGxFvdyQupVl9mMmRtrwS0EjRninTKZ4s/U3R7QWayQ==
X-Gm-Gg: ASbGncsSwMLH24SKxKrJykUPBKzaQ+Obzqh2Ho7aGYecsgJdr50j1l2jotVz91Aoa4l
	c/i6NFHTIBh8DnH2Hd3p4HWEiCbUAnDbk92hG8VH9AA1bpbtnbakzUEbdarW/R0/8lOd0sxcGUB
	U8sYf5/Xul2TaFxZm4D6UwCB1r5xwP0bleMiMNRozH7pe/44YZBvZB5ABpjAyiAHkOd3dHvLk+r
	dUG/o0Eubr4dE4VMbupwCNknWS0oxuPBSZhH2H8Xzb4nOVxyCuAvUi/b0yqpt5FRh9Ca+rhSiH8
	tDNsQoWEXUlALVItLtWdkWRV8EpFkRdXl2I8gRK/PUrQ80E5g0Qva5xWq6TPWmXUZq8wU+Gvje/
	MsF2hXbQPaBTaus+SiG0itD9qp3k2+KvKMspODMUwDEDHx80kBf6r5UVcyf6Pa+Y88q0=
X-Received: by 2002:a05:600c:190b:b0:45b:6743:2240 with SMTP id 5b1f17b1804b1-45b68aa25cbmr59785085e9.27.1756369107174;
        Thu, 28 Aug 2025 01:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUJsaR2J7iF3R+ldMkn3aeuQzBBUKQPNZcZ93/+SZsto/QZ9LRuZpML8ujkA6ncDdKY9np+A==
X-Received: by 2002:a05:600c:190b:b0:45b:6743:2240 with SMTP id 5b1f17b1804b1-45b68aa25cbmr59784365e9.27.1756369106625;
        Thu, 28 Aug 2025 01:18:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b732671b7sm21138515e9.3.2025.08.28.01.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 01:18:26 -0700 (PDT)
Message-ID: <6880f125-803d-4eea-88ac-b67fdcc5995d@redhat.com>
Date: Thu, 28 Aug 2025 10:18:23 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/36] mm/hugetlb: cleanup
 hugetlb_folio_init_tail_vmemmap()
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-14-david@redhat.com> <aLADXP89cp6hAq0q@kernel.org>
 <377449bd-3c06-4a09-8647-e41354e64b30@redhat.com>
 <aLAN7xS4WQsN6Hpm@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLAN7xS4WQsN6Hpm@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 10:06, Mike Rapoport wrote:
> On Thu, Aug 28, 2025 at 09:44:27AM +0200, David Hildenbrand wrote:
>> On 28.08.25 09:21, Mike Rapoport wrote:
>>> On Thu, Aug 28, 2025 at 12:01:17AM +0200, David Hildenbrand wrote:
>>>> We can now safely iterate over all pages in a folio, so no need for the
>>>> pfn_to_page().
>>>>
>>>> Also, as we already force the refcount in __init_single_page() to 1,
>>>> we can just set the refcount to 0 and avoid page_ref_freeze() +
>>>> VM_BUG_ON. Likely, in the future, we would just want to tell
>>>> __init_single_page() to which value to initialize the refcount.
>>>>
>>>> Further, adjust the comments to highlight that we are dealing with an
>>>> open-coded prep_compound_page() variant, and add another comment explaining
>>>> why we really need the __init_single_page() only on the tail pages.
>>>>
>>>> Note that the current code was likely problematic, but we never ran into
>>>> it: prep_compound_tail() would have been called with an offset that might
>>>> exceed a memory section, and prep_compound_tail() would have simply
>>>> added that offset to the page pointer -- which would not have done the
>>>> right thing on sparsemem without vmemmap.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    mm/hugetlb.c | 20 ++++++++++++--------
>>>>    1 file changed, 12 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 4a97e4f14c0dc..1f42186a85ea4 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -3237,17 +3237,18 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
>>>>    {
>>>>    	enum zone_type zone = zone_idx(folio_zone(folio));
>>>>    	int nid = folio_nid(folio);
>>>> +	struct page *page = folio_page(folio, start_page_number);
>>>>    	unsigned long head_pfn = folio_pfn(folio);
>>>>    	unsigned long pfn, end_pfn = head_pfn + end_page_number;
>>>> -	int ret;
>>>> -
>>>> -	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
>>>> -		struct page *page = pfn_to_page(pfn);
>>>> +	/*
>>>> +	 * We mark all tail pages with memblock_reserved_mark_noinit(),
>>>> +	 * so these pages are completely uninitialized.
>>>
>>>                                ^ not? ;-)
>>
>> Can you elaborate?
> 
> Oh, sorry, I misread "uninitialized".
> Still, I'd phrase it as
> 
> 	/*
> 	 * We marked all tail pages with memblock_reserved_mark_noinit(),
> 	 * so we must initialize them here.
> 	 */

I prefer what I currently have, but thanks for the review.

-- 
Cheers

David / dhildenb

