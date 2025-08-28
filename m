Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF62EBBAB
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370636; cv=none; b=gqcHOD0l6HPIYL2MqdDturruApFiaKKQ8CrpQzr/TJy3pMwJnFNRrxj5cpoQBy0frbfUpFKB2ir2dI0DCe9bb+UJx9zRg0SvCAAftrdXMQDslpj3xTPzmy3sOzeVtGVBg5FCDBs1OkAm+Wq4jl482VKYMW1UztSOw0ZfvW6Itwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370636; c=relaxed/simple;
	bh=dtF3GY0txqUlnrqvH6O65DtDqS/OwB3kNXWzpcWqR1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD4RRZvDqRu/Hvyg8OrdIdPFOz1IOxRRDPrRqgwHkHjpf4aTnvGhabEpahvWLUTJdzm4tK7neIUjZw5CDH7i8O6+8bW09sfxspLv2zPHU/PqAGYAldqodyHzNElp9B3w2X+bk59SyL16bH7TsQa7q7r1mVAgpyooak26avXjwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p29dZu8R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p29dZu8R"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248a61a27acso5575335ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756370633; x=1756975433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jLT2osl3N94HJBBJWKPAk2avCo16Lo88yw1WJjz/wsM=;
        b=p29dZu8RbOb7kdgd3ZtBE+clhKPFI9QwXvom3vRpu7v7a1BNfOf04PU5L6eIb+0FBr
         ZJ7mWZfZ2mcXw1UHzo0Vs9d33gwzevLkpSu0YJr2E2fKiWCrzULRqrXnPXb5kSTJ3ER1
         lekjoGVJMRclMo/7IcBNF97sqSiEiVAty0uAbdjvDiroutPRgdOc+q//92w7WV45D9pi
         e1UtjxHBW+qEvW8peS4A2hkdOiciAuwA9wtJGZwCluOTwVwjbKgf5e+TmJfJSwogxt8I
         /2BnHGYkw7OpFqwTxwo1VxGML77arPgfw3R+ucnsXcN4AJBKvuEX402Rpp+gQpculFrr
         AiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370633; x=1756975433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLT2osl3N94HJBBJWKPAk2avCo16Lo88yw1WJjz/wsM=;
        b=tXEcV6dq0flpP3M+BLlKZVHpxuQB53lBCa3op+IiX1vVL3SkyNmIWUhk/W7P8hbH7j
         5QRds4AHNMQcXOoK7V5PIFwS/4Jkd+VqSQF8xs49/Kv9Hsoi/kI3IdB+iytWAxf0i6ac
         7e+j/l//oNEyG6SxFg3+Fk80yuAV9iyb1wXaIkKaAxelgEdJs2eLDlO8/gj8Fg5KrDHS
         BWIyWOGVE1zCS/s1DnwedFxFq7WAgCLkFNe2lSbqTLI2bZXY2pOTlcma2XQkc239qLJ8
         NlN2GjexKiQezJZlxB2qinauTYFETKV1vKnHVapBqBiTaNonrVi7XTXmO4MgOV9fEyJD
         ojWw==
X-Forwarded-Encrypted: i=1; AJvYcCXoMZPIz6qXmPHJ6Bdg7Ub8f3zagDozlgIx2VJRVV/Y+ysXwcRXIaXCIRro9N5i/sheXNQA5M7KVTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshjuAtOp1j0IadL/yrI0IsmOhZ9qlo0W6TSYKPNeutbQbIS7o
	fWn4650gRMeZ1uPOE2l9ifMAi7SACru533DZHEgv3AM71EaO+AwBwMCz0XwOXk16KhtI/8T0wHe
	KIhca9oWXvLMbkv1hKpJRHFqaYMzRVTdSJALRrBZ5
X-Gm-Gg: ASbGnctiyrJEHHPRvbN/lIidcawJI0BBwwT7f4GAyL93Dvnwd7Pw5P1SnDN36u2eqyT
	khVdYwRBKW/tHMG2ByCy9s7D15GipPTCfkM4A5ReUXjAdStVOPEqKes9Q2MSBrQtqrurKvUiMYt
	iZfcFgUOQr68bEgdYJ6GDS1OqGL8+W73gPPll2hq3btHTxKr3RQp9MBDj6I6GWXujfQtmFhb5Oc
	o4XMah4Z1aZgfkpi0LEWwpQD04=
X-Google-Smtp-Source: AGHT+IGJmjz+YHPyNxr90AMhiQNNDQu9deq8PWwNfyq+zFWi/YcgUyPYkmS3VX3aACMgtkUmoKeOvBcyBRDmMb3NDeE=
X-Received: by 2002:a17:903:3d06:b0:248:8063:a8b4 with SMTP id
 d9443c01a7336-2488063abcbmr89508125ad.22.1756370632768; Thu, 28 Aug 2025
 01:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827220141.262669-1-david@redhat.com> <20250827220141.262669-35-david@redhat.com>
In-Reply-To: <20250827220141.262669-35-david@redhat.com>
From: Marco Elver <elver@google.com>
Date: Thu, 28 Aug 2025 10:43:16 +0200
X-Gm-Features: Ac12FXwMzUnIHp_v7uH0kV3Hu6ram9vqgPmCMZ3TyuNNAlhDfe6K8rTgx1FpO8k
Message-ID: <CANpmjNP8-dM-cizCfsVOUNDS2jBaY6d=0Wx8OGen5RbXgaqcfQ@mail.gmail.com>
Subject: Re: [PATCH v1 34/36] kfence: drop nth_page() usage
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 00:11, 'David Hildenbrand' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> We want to get rid of nth_page(), and kfence init code is the last user.
>
> Unfortunately, we might actually walk a PFN range where the pages are
> not contiguous, because we might be allocating an area from memblock
> that could span memory sections in problematic kernel configs (SPARSEMEM
> without SPARSEMEM_VMEMMAP).
>
> We could check whether the page range is contiguous
> using page_range_contiguous() and failing kfence init, or making kfence
> incompatible these problemtic kernel configs.
>
> Let's keep it simple and simply use pfn_to_page() by iterating PFNs.
>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks.

> ---
>  mm/kfence/core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 0ed3be100963a..727c20c94ac59 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -594,15 +594,14 @@ static void rcu_guarded_free(struct rcu_head *h)
>   */
>  static unsigned long kfence_init_pool(void)
>  {
> -       unsigned long addr;
> -       struct page *pages;
> +       unsigned long addr, start_pfn;
>         int i;
>
>         if (!arch_kfence_init_pool())
>                 return (unsigned long)__kfence_pool;
>
>         addr = (unsigned long)__kfence_pool;
> -       pages = virt_to_page(__kfence_pool);
> +       start_pfn = PHYS_PFN(virt_to_phys(__kfence_pool));
>
>         /*
>          * Set up object pages: they must have PGTY_slab set to avoid freeing
> @@ -613,11 +612,12 @@ static unsigned long kfence_init_pool(void)
>          * enters __slab_free() slow-path.
>          */
>         for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -               struct slab *slab = page_slab(nth_page(pages, i));
> +               struct slab *slab;
>
>                 if (!i || (i % 2))
>                         continue;
>
> +               slab = page_slab(pfn_to_page(start_pfn + i));
>                 __folio_set_slab(slab_folio(slab));
>  #ifdef CONFIG_MEMCG
>                 slab->obj_exts = (unsigned long)&kfence_metadata_init[i / 2 - 1].obj_exts |
> @@ -665,10 +665,12 @@ static unsigned long kfence_init_pool(void)
>
>  reset_slab:
>         for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -               struct slab *slab = page_slab(nth_page(pages, i));
> +               struct slab *slab;
>
>                 if (!i || (i % 2))
>                         continue;
> +
> +               slab = page_slab(pfn_to_page(start_pfn + i));
>  #ifdef CONFIG_MEMCG
>                 slab->obj_exts = 0;
>  #endif
> --
> 2.50.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250827220141.262669-35-david%40redhat.com.
