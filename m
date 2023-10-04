Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC1E7C4EC
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Oct 2023 18:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjJDSuG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjJDSuF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2023 14:50:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6598
        for <linux-mmc@vger.kernel.org>; Wed,  4 Oct 2023 11:50:00 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65d5a6230fcso593866d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2023 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696445399; x=1697050199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLxg9fH8T1y0yGnPhHcUGUL8dVs76BY9tqGI34u50Bs=;
        b=QsbIpSBUs1v250EisypmrLo1xZypuMbM2kchknnKaBXNugEvZGKHS6ZnC5LkKIA5HI
         RkNexXThTo4uZDmP+CH6Ji+frDRYT03SSYNxeH8cmgKaFZgLuaZqX/HbgNhxWazpTJIg
         SF6OygLNnaOuJHMh42k3lP8vRcYQajUk/goQhWKFF+i0ZBHt33ijTvL+/epwkIPGC3N5
         kfE8oiE8pqHarj89/dSVZjC4/XDcGT1Z7eXDvbMyPRhbMVFgerGtkdGOX/5XxhygmSrM
         VB7mvIWAeLmnsgDnLlICZA725CgpfasFEMSovzPw2eifNm5Hi1e31G4HvHW9gAp1cXq9
         ++/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445399; x=1697050199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLxg9fH8T1y0yGnPhHcUGUL8dVs76BY9tqGI34u50Bs=;
        b=CYo70jRkngigznaWxx59jVobxRwX+kXNDcIb2uQUIHhWr+JpyncS2Lm52ZSAXVMjmN
         kBBYJponXuc59YiJC7DoPIPYoqP8pbVaCb0va1XuzDiT0f14QW6oClPTeu8uTzYDG0Ms
         lo1cJvVegESpGamWVD8x7KXMEIsvYV8IE47A60+EAfAZ3EVLbOUEpt1ifZWcjuTUfflJ
         iJTi2VbjLxAL03f0x45LfXD2UwE9V9SDud/gcxafOHIXN1/7+bajStzG5CqtqfqcgEjJ
         Sv3oo3iqJVTBQ6qGxAN/vju8UaeR9pdNnAbYzlTuopXI4mwzAefHXGWhBr2Fkni6iEzn
         zcEQ==
X-Gm-Message-State: AOJu0YxYTEC22V0K0B96euwYe7SliAhsptaeua0zVNndMfzRb+YWQtI3
        ZHQsk/206LaHnBAHLrolND9w2w==
X-Google-Smtp-Source: AGHT+IENGPIAeevR+++9VNUaDLPyKIYbr+kdZo6T203e5mzPMqSIxUqcJDFLq+tp33c+F3IchycJlQ==
X-Received: by 2002:a0c:e54f:0:b0:64a:92e9:10e4 with SMTP id n15-20020a0ce54f000000b0064a92e910e4mr2602325qvm.63.1696445399373;
        Wed, 04 Oct 2023 11:49:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:1d3e:176c:909c:5aed? ([2600:1700:2000:b002:1d3e:176c:909c:5aed])
        by smtp.gmail.com with ESMTPSA id x1-20020a0ce241000000b0065d89f4d537sm1516928qvl.45.2023.10.04.11.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 11:49:58 -0700 (PDT)
Message-ID: <20075b03-e3b0-4f29-9ba1-98eed361a44f@sifive.com>
Date:   Wed, 4 Oct 2023 13:49:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Guo Ren <guoren@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Han Gao <gaohan@iscas.ac.cn>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xi Ruoyao <xry111@xry111.site>, Fu Wei <wefu@redhat.com>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker>
 <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
 <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com>
 <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
 <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com>
 <CA+V-a8s1S4yTH19PVNSznAgUFoHRNoye9CfwjW6iy6PbQ9thew@mail.gmail.com>
 <CA+V-a8vbWW6=HTfR+FCPOB0bAa8M3Bbm_k=7+XbjOc3ybo6VNQ@mail.gmail.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CA+V-a8vbWW6=HTfR+FCPOB0bAa8M3Bbm_k=7+XbjOc3ybo6VNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2023-10-04 12:16 PM, Lad, Prabhakar wrote:
> On Wed, Oct 4, 2023 at 5:03 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
>>
>> On Wed, Oct 4, 2023 at 3:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 04/10/2023 3:02 pm, Icenowy Zheng wrote:
>>> [...]
>>>>>>> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
>>>>>>> required configs for RZ/Five SoC") can cause regression on all
>>>>>>> non-dma-coherent riscv platforms with generic defconfig. This is
>>>>>>> a common issue. The logic here is: generic riscv defconfig
>>>>>>> selects
>>>>>>> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
>>>>>>> non-dma-coherent riscv platforms have a dma global pool, this
>>>>>>> assumption
>>>>>>> seems not correct. And I believe DMA_GLOBAL_POOL should not be
>>>>>>> selected by ARCH_SOCFAMILIY, instead, only ARCH under some
>>>>>>> specific
>>>>>>> conditions can select it globaly, for example NOMMU ARM and so
>>>>>>> on.
>>>>>>>
>>>>>>> Since this is a regression, what's proper fix? any suggestion is
>>>>>>> appreciated.
>>>>>
>>>>> I think the answer is to not select DMA_GLOBAL_POOL, since that is
>>>>> only
>>>>
>>>> Well I think for RISC-V, it's not NOMMU only but applicable for every
>>>> core that does not support Svpbmt or vendor-specific alternatives,
>>>> because the original RISC-V priv spec does not define memory attributes
>>>> in page table entries.
>>>>
>>>> For the Renesas/Andes case I think a pool is set by OpenSBI with
>>>> vendor-specific M-mode facility and then passed in DT, and the S-mode
>>>> (which MMU is enabled in) just sees fixed memory attributes, in this
>>>> case I think DMA_GLOBAL_POOL is needed.
>>>
>>> Oh wow, is that really a thing? In that case, either you just can't
>>> support this platform in a multi-platform kernel, or someone needs to do
>>> some fiddly work in dma-direct to a) introduce the notion of an optional
>>> global pool,
>> Looking at the code [0] we do have compile time check for
>> CONFIG_DMA_GLOBAL_POOL irrespective of this being present in DT or
>> not, instead if we make it compile time and runtime check ie either
>> check for DT node or see if pool is available and only then proceed
>> for allocation form this pool.
>>
>> What are your thoughts on this?
>>
> Something like the below:
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index f2fc203fb8a1..7bf41a4634a4 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -198,6 +198,7 @@ int dma_release_from_global_coherent(int order,
> void *vaddr);
>  int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
>                 size_t size, int *ret);
>  int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
> +bool dma_global_pool_available(void);
>  #else
>  static inline void *dma_alloc_from_global_coherent(struct device *dev,
>                 ssize_t size, dma_addr_t *dma_handle)
> @@ -213,6 +214,10 @@ static inline int
> dma_mmap_from_global_coherent(struct vm_area_struct *vma,
>  {
>         return 0;
>  }
> +static inline bool dma_global_pool_available(void)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_DMA_GLOBAL_POOL */
> 
>  /*
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index c21abc77c53e..605f243b8262 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -277,6 +277,14 @@ int dma_mmap_from_dev_coherent(struct device
> *dev, struct vm_area_struct *vma,
>  #ifdef CONFIG_DMA_GLOBAL_POOL
>  static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
> 
> +bool dma_global_pool_available(void)
> +{
> +       if (!dma_coherent_default_memory)
> +               return false;
> +
> +       return true;
> +}
> +
>  void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
>                                      dma_addr_t *dma_handle)
>  {
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 9596ae1aa0da..a599bb731ceb 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -235,7 +235,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>                  * If there is a global pool, always allocate from it for
>                  * non-coherent devices.
>                  */
> -               if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
> +               if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> dma_global_pool_available())
>                         return dma_alloc_from_global_coherent(dev, size,
>                                         dma_handle);

dma_alloc_from_global_coherent() already checks dma_coherent_default_memory, so
the solution could be even simpler:

--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -232,12 +232,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 					      attrs);

 		/*
-		 * If there is a global pool, always allocate from it for
+		 * If there is a global pool, always try to allocate from it for
 		 * non-coherent devices.
 		 */
-		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
-			return dma_alloc_from_global_coherent(dev, size,
-					dma_handle);
+		ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
+		if (ret)
+			return ret;

 		/*
 		 * Otherwise remap if the architecture is asking for it.  But

Regards,
Samuel

