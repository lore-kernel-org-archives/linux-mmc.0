From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
Date: Thu, 20 Jul 2017 21:43:34 +1000
Message-ID: <87mv7zgwpl.fsf@concordia.ellerman.id.au>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170720062850.2195-1-matthew.brown.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Brown <matthew.brown.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Matt,

Thanks for tackling this mess.

Matt Brown <matthew.brown.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> The cacheflush prototypes currently use start and stop values and each
> call requires typecasting the address to an unsigned long.
> This patch changes the cacheflush prototypes to follow the x86 style of
> using a base and size values, with base being a void pointer.
>
> All callers of the cacheflush functions, including drivers, have been
> modified to conform to the new prototypes.
>
> The 64 bit cacheflush functions which were implemented in assembly code
> (flush_dcache_range, flush_inval_dcache_range) have been translated into
> C for readability and coherence.
>
> Signed-off-by: Matt Brown <matthew.brown.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/powerpc/include/asm/cacheflush.h        | 47 +++++++++++++++++--------
>  arch/powerpc/kernel/misc_64.S                | 52 ----------------------------
>  arch/powerpc/mm/dma-noncoherent.c            | 15 ++++----
>  arch/powerpc/platforms/512x/mpc512x_shared.c | 10 +++---
>  arch/powerpc/platforms/85xx/smp.c            |  6 ++--
>  arch/powerpc/sysdev/dart_iommu.c             |  5 +--
>  drivers/ata/pata_bf54x.c                     |  3 +-
>  drivers/char/agp/uninorth-agp.c              |  6 ++--
>  drivers/gpu/drm/drm_cache.c                  |  3 +-
>  drivers/macintosh/smu.c                      | 15 ++++----
>  drivers/mmc/host/bfin_sdh.c                  |  3 +-
>  drivers/mtd/nand/bf5xx_nand.c                |  6 ++--
>  drivers/soc/fsl/qbman/dpaa_sys.h             |  2 +-
>  drivers/soc/fsl/qbman/qman_ccsr.c            |  3 +-
>  drivers/spi/spi-bfin5xx.c                    | 10 +++---
>  drivers/tty/serial/mpsc.c                    | 46 ++++++++----------------
>  drivers/usb/musb/blackfin.c                  |  6 ++--

I think you want to trim that to powerpc only drivers for now at least.

> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index 11843e3..b8f04c3 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -51,13 +51,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
>   * Write any modified data cache blocks out to memory and invalidate them.
>   * Does not invalidate the corresponding instruction cache blocks.
>   */
> -static inline void flush_dcache_range(unsigned long start, unsigned long stop)
> +static inline void flush_dcache_range(void *start, unsigned long size)
>  {
> -	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
> -	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
> +	void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));

unsigned long would be nicer than u32.

And ALIGN_DOWN() should work here I think.

> +	unsigned long len = size + (L1_CACHE_BYTES - 1);

And ALIGN?

> @@ -83,22 +83,39 @@ static inline void clean_dcache_range(unsigned long start, unsigned long stop)
>   * to invalidate the cache so the PPC core doesn't get stale data
>   * from the CPM (no cache snooping here :-).
>   */
> -static inline void invalidate_dcache_range(unsigned long start,
> -					   unsigned long stop)
> +static inline void invalidate_dcache_range(void *start, unsigned long size)
>  {
> -	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
> -	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
> +	void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
> +	unsigned long len = size + (L1_CACHE_SHIFT - 1);
>  	unsigned long i;
>  
> -	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
> +	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
>  		dcbi(addr);
>  	mb();	/* sync */
>  }
>  
>  #endif /* CONFIG_PPC32 */
>  #ifdef CONFIG_PPC64
> -extern void flush_dcache_range(unsigned long start, unsigned long stop);
> -extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
> +static inline void flush_dcache_range(void *start, unsigned long size)
> +{
> +	void *addr = (void *)((u64)start & ~(L1_CACHE_BYTES - 1));
> +	unsigned long len = size + (L1_CACHE_BYTES - 1);
> +	unsigned long i;
> +
> +	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
> +		dcbf(addr);
> +	mb();	/* sync */
> +}

I'd probably prefer a precursor patch to do the asm -> C conversion, but
I guess that's a pain because then you have to implement both the old
and new logic in C.

Also L1_CACHE_SHIFT is not necessarily == DCACHEL1BLOCKSIZE.

Finally it would be good to see what code the compiler generates out of
this, and see how it compares to the asm version. Not because it's
particularly performance critical (hopefully) but just so we know.

> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
> index 6b4f4cb..0f3a7d9 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -254,8 +254,8 @@ static void __init mpc512x_init_diu(void)
>  	}
>  	memcpy(&diu_shared_fb.ad0, vaddr, sizeof(struct diu_ad));
>  	/* flush fb area descriptor */
> -	dst = (unsigned long)&diu_shared_fb.ad0;
> -	flush_dcache_range(dst, dst + sizeof(struct diu_ad) - 1);
> +	dst = &diu_shared_fb.ad0;

Do you even need dst anymore?

> +	flush_dcache_range(dst, sizeof(struct diu_ad) - 1);
                                                        ^
                  You shouldn't be subtracting 1 any more.


cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
