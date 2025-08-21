Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C92F39C5
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808253; cv=none; b=peElLCBiOOo0g8ZKYbzolo0m9DG2jKy0Ox6eQz/ukIAEEpg5xxw9f+JBuQXi6LxzlgbkKQxs+gZZEei3q68EdGSZ2o8YVuuKA3Ah/sstfOZpTe+DGPhSejSs6mluC/XsTFWxe/ARku4YQ/mYuHA6IMQWE23dy8AjxKLUAojcTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808253; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+IqR9S4jgmIMWmZxdrCkh0zC2LmIrTCMCS8luq7livUpfDmhcm7lmkFVvONho/VGLi9UrLbAFsrI6d+w59DXwfJ/OgE9MgkOdMpdyqykA90NzXvOUy1eMDH+bk2Pq9wdUWc3E0ft9PJXRMz2qrICg1ANY3r5qqKL2v5y5X1kqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hw13mY/O; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hw13mY/O"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70a88ddc0aeso12367226d6.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808250; x=1756413050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=Hw13mY/Oe9gj7OnUwOEIiYi0KBTvDn/B16oZX29hzbvkJhawbpzoRqQJ5a1kyQ1VTs
         O5W2tovsc0IHeAeL3CR2aI1oMeKA/PiPQYNnaXyiN99zPMsgt48GZlchfpw3jG8pVAhW
         JhndpaGHV5pYHSeZLc8TLfk5XzNjUjoZ3bAGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808250; x=1756413050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=eKUnGaoITjBHAMF3xW0dnqD5QwGCk450IPC1bW2IGyBoVgWXMR9wRGOrkxMyAxqDib
         KO2o8eB9b9zizd0hmScpM8Z17zusTPBlql3yVkEQxuYxkA9HfPxWo7FCr5swJ2PPH+hS
         2OzBSB5Py6Wmo8v6sheoYIn7Fton+zlFXiSjuvn9a2RQH5QrbLfhxAqjRNaeweQxpeAf
         ibJeM5L0KIJ42tjndaoEQzNcuFNyigNpEVeLXPS2icM2KxfZl/3a+u3F9T9xEDrLZZXE
         Kq3mVR/XpwUq3xKBQfq1133LfCLlYeR5ua2wWo190+xyhLT/u4jmuCosn11l8dnYvm3l
         PM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6DZv62C2W98cVHp4GW6bxTxQw1oNHHICJjcwBxyS7Ge6VY3l2Ga83WYxG3Zqo8kXHZr3h2jNSg0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqhM7dWWdZ5Gh6zAAlApoF2M8BBip5jFe0Nl4XQRCh9F530x4
	3NRXgjhcKIYccDC7bLPTTePc33/QccDORaPUPMR/JMjEe6FoaDRMsD2wS+nIbqW9gEzS9eBtErb
	63N/eHCxgcQ==
X-Gm-Gg: ASbGncvphF3F8sdew+NOIU15J3HJAdGBgmmVfkcOO044lssflWNSahYCKoUCqcRcSR1
	AEe4pABq0k9n9O2AmdAvt/V3a20m627oNplXi+sg5c69AcL9iXPEXuez7iFffn5MZJ22EzWIRG1
	1cojy4viwtMEcB59d60sCGlMUpR7jFVQuwf8Yg323xkcE19pJodp2+nOLulZW/PbaaOp4ULiY71
	kGpZ4BRGXeODTVA110NxN6H0V9osDVUi7jtOwB7ke58Y/oZcT+aFB+mmCgFTwJGy70VGmGl2+2K
	jtBKwBgXDbI4eL37H8ipU3+wG0JKQoCA2stR58TxCaLIhrC4UXxIJmZtrvuRLyL4FyNYWMbZbdp
	l82Bia5Gnt4GQeMsP4P7bJrxSZOpybEu+lIKQfwSSYggGYCKDMe03CCdI1gbEwmvuB3haK5V0U3
	eu
X-Google-Smtp-Source: AGHT+IE/xKTgVYOFW//jJgeWdx9HuOqdloWjG6IpHQmDeBJpxrvXHzuSY/fpHAb4TXs01+OrWU2Khg==
X-Received: by 2002:a05:6214:d07:b0:70d:7cdf:7700 with SMTP id 6a1803df08f44-70d972514e8mr10631806d6.16.1755808249534;
        Thu, 21 Aug 2025 13:30:49 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9086433sm110950276d6.24.2025.08.21.13.30.49
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:30:49 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109919a09so17877721cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:30:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCCBiMtJkKuVgN1onprkwUAn+tUyx6cpDfaxuHtJct1VD1bxSwEs6gHFW0hFpnTEw/BdC4SKUVvsQ=@vger.kernel.org
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus
