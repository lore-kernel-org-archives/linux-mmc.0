From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: fix highmem with VIPT cache and DMA
Date: Fri, 26 Mar 2010 13:34:18 +0000
Message-ID: <1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40471 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709Ab0CZNel (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Mar 2010 09:34:41 -0400
In-Reply-To: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Thu, 2010-03-25 at 21:02 +0000, Nicolas Pitre wrote:
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -11,7 +11,11 @@
> 
>  #define kmap_prot              PAGE_KERNEL
> 
> -#define flush_cache_kmaps()    flush_cache_all()
> +#define flush_cache_kmaps() \
> +       do { \
> +               if (cache_is_vivt()) \
> +                       flush_cache_all(); \
> +       } while (0)

Do the aliasing VIPT caches need flushing as well?

> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -79,7 +79,8 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
>         unsigned int idx = type + KM_TYPE_NR * smp_processor_id();
> 
>         if (kvaddr >= (void *)FIXADDR_START) {
> -               __cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
> +               if (cache_is_vivt())
> +                       __cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);

Same here (and probably some other places in this patch, not sure).

-- 
Catalin

