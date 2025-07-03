Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F422E9EAB
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545199; cv=none; b=Ei80uvLrlvwehFXJTSqRhfYDj10JpOcnD9YBCkH2W1qr+St2XJpyE1bJaYaQ/eRUmssiSfd6taSGAluxgtCzkjXlzJ+maejHorEai8qJ9LcnW7TLUMrVcFgSHFuRAKxKab+msnmRfubzHHxj0M0UBwG/GDW2BJwTPj+0r751ZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545199; c=relaxed/simple;
	bh=5S8w3uWd7iW/T21owi5/oSoUv/kNdAAViVeh3UNFFxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJkPUtB3TRW8CsGAEN3qlFR4ex/rr1za2HrSSA8XH4S9mS24t4E2f7JIiekIWmy8tcldZ+xQIkOoV2Iurar9VYasI+YrqOyx2qfKzHKGqu2Ll1KoANjqHRgwWYHOF7HQzXb14iTa1YdHHSmI4xF3ke8iN+XWKEkyhbSIlnpUHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VpVkPmzz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpVkPmzz"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-710bbd7a9e2so57174537b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545196; x=1752149996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9gmRYC6wJsE1ILyc/ieq+nLLcH85wKL/31GtAmZJ+yo=;
        b=VpVkPmzztuVKGEGS0t80nT3shIsezXrXHtVB25BJEqrqPlzrYlIH0X4mF8Hl3qWRRL
         kbGi5wFlt8acA5aROXLGZhLpuHKrCR//iLzzeKFBJAdYgU3oSZX+pQ/vQiyIbeqMsRxh
         Am+ix5z2KGsOzUO42mpe/1eaogcBcX55KAVLqNVXPBHn4to/t7s0hZawF9wxs9JeBhDK
         /sdqk1b/+WC9dEakYNrFaZWB/dJsKSaZBAiB9Se08VxnVOnbc+0ovlprist20ocbWla7
         5xBJ++FoBI+J0FLKtjPV49m92146logp+Z8kuQQmHONyD/Go1ebPevcSYRzgyRsgoYN1
         qRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545196; x=1752149996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gmRYC6wJsE1ILyc/ieq+nLLcH85wKL/31GtAmZJ+yo=;
        b=Ea74miqvp694KkWWOh2kfBHmd+Y9gjECnbHnit9s3mcSVpFwfBKJUqKfGAl1ldfBem
         0FASOMj+YPJb/yjzaA0+mYWY6V6tGPnZTz9HKrDna7UZdc2crvArji8hGEQoiM1krKV0
         B4nWq46gVl7DuxFDyfHHxjFvUuVNX/T7gBJ2KQ9NBh8Gd8EUfnYK+noXEgFoAF5iNMAP
         1d76Q9DeWuIDu3GN52FGux+icb7elq9Sz/ZtWdjm6VkL1sJKSaAWhIqIIHsPBKH2Ik7O
         kQYLxeZiex7nxXx2MHR6fXFYT7BXrDedgRGHqWvv5ipBFECoP6WcCCqCsPFQ65Jppw8e
         cQDg==
X-Forwarded-Encrypted: i=1; AJvYcCUpAWiyX367iI+MJIbHzO0B8EBgSbOCzBUGX0FWwSxgoELYWB4G7J+uiwD/+75EuGAmOXBhFTe0kAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSV+KHFHts6gHD80PiWDs7kEk2nfFzTJhCAfuzccxyrN8cx0Nx
	GszOG6e9XW+s1y2OfMpUdiB1EjyrbJyNy7p5UFF8qeFX76SXxPZsaZq/XlClh/a/96Zea+5K9Kw
	pdf4qKd2WRRqv1BRM84FJux3MQywTY8E2ym/wzheUDQ==
X-Gm-Gg: ASbGncvdD5LJ3r31hzttDm6iuqeJTEoNtuR5sh0rjMATVfZ4k/odq8aRhTX+lQT4RtO
	wsOiqxhrB36gscKNY0CZ9iCEdQW4QazE4p7mIaBnbAZkBbQI13uxdLHL/++w0kN9Pj+t+Jibs3S
	tFrQwtYCUAbMJ7jmEipJXbz13ivCxS/IoCDjfzL/g5TrX6
X-Google-Smtp-Source: AGHT+IHaoKPJi6Fqow0vU1i5ZdMl3X5b+ttkE6pWwhs9E/k6RPBMt6GLClH4Z/mfJsmhDNTidyIoSsJcZcEgNd/ru1Q=
X-Received: by 2002:a05:690c:3582:b0:70c:b534:868f with SMTP id
 00721157ae682-7164d40a01emr96268507b3.20.1751545196417; Thu, 03 Jul 2025
 05:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750765495.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1750765495.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:20 +0200
X-Gm-Features: Ac12FXzBMo2xArYqhItw2PxBrY1sUyu9ZVNxnwNFP-mg-pD_fwp1o-Cr5nqL5Fw
Message-ID: <CAPDyKFrYYdhrctvwJ=VdTRHYSLSO_MjGKfasP53muVbe1+=0ag@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Introduce the Loongson-2K MMC host
 controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 13:58, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> This patchset introduce the MMC host controller on Loongson-2K series
> CPUs.
>
> They are similar, except for the interface characteristics and the use of
> DMA engine, specifically, the Loongson-2K0500/Loongson-2K1000 use an
> externally shared APBDMA engine, while the Loongson-2K2000 uses an
> internally exclusive DMA.
>
> Based on this, I'm splitting the driver into two patches.
>
> List of the patchset:
> Patch1: bindings for Loongson-2K0500/Loongson-2K1000;
> Patch2: driver for MMC controller using externally shared APBDMA engine;
> Patch3: bindings for Loongson-2K2000;
> Patch4: driver for MMC controller using internally exclusive DMA.
>
> Thanks.
>
> -------
> V4:
> patch(2/4):
>  - Code formatting;
>  - Fix lkp error
>     https://lore.kernel.org/all/202506202031.TNchn822-lkp@intel.com/
> patch(4/4):
>  - Rename function names:
>         ls2k1000_mmc_regmap_config -> ls2k0500_mmc_regmap_config
>         loongson2_mmc_reorder_cmd_data -> ls2k0500_mmc_reorder_cmd_data
>         loongson2_mmc_set_internal_dma -> ls2k2000_mmc_set_internal_dma
>  - Use macro definitions for magic numbers.
>
> Link to V3:
> https://lore.kernel.org/all/cover.1750216134.git.zhoubinbin@loongson.cn/
>
> V3:
> patch(1/4):
>  - Rename dt-binding file as loongson,ls2k0500-mmc.yaml.
> patch(2/4):
>  - Fix lkp error;
>     https://lore.kernel.org/all/202505130918.uanOGxju-lkp@intel.com/
>  - Add regulators support for ios ops;
>  - Add ack_sdio_irq() callback;
>  - Add MMC_CAP2_SDIO_IRQ_NOTHREAD flag;
> patch(3/4):
>  - Add Ack-by tag.
> patch(4/4):
>  - Update commit for fix_data_timeout().
>
> Link to V2:
> https://lore.kernel.org/all/cover.1746581751.git.zhoubinbin@loongson.cn/
>
> V2:
> patch(1/4):
>  - Add reg define for each reg entry.
>
> patch(2/4):
>  - Put all code in the c-file;
>  - Use mmc_from_priv() instead of host->mmc;
>  - Use sdio_signal_irq() instead of mmc_signal_sdio_irq();
>  - Use devm_mmc_alloc_host() instead of mmc_alloc_host();
>  - Use mmc_regulator_get_supply();
>
> patch(4/4):
>  - Add fix_cmd_interrupt function which is needed by Loongson-2K2000.
>
> Link to V1:
> https://lore.kernel.org/linux-mmc/cover.1744273956.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (4):
>   dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
>   mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
>   dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for
>     Loongson-2K2000
>   mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver
>
>  .../bindings/mmc/loongson,ls2k0500-mmc.yaml   |  112 ++
>  MAINTAINERS                                   |    7 +
>  drivers/mmc/host/Kconfig                      |   13 +
>  drivers/mmc/host/Makefile                     |    1 +
>  drivers/mmc/host/loongson2-mmc.c              | 1029 +++++++++++++++++
>  5 files changed, 1162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
>  create mode 100644 drivers/mmc/host/loongson2-mmc.c
>
>
> base-commit: f5c755ef810009b85350884c483705bd04365370
> --
> 2.47.1
>
>

The series applied for next, thanks!

Note, I am leaving you to address/discuss Huacai's comment on patch1
as a new patch on top.

Kind regards
Uffe
