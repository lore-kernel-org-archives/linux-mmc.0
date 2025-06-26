Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312222DCC10;
	Thu, 26 Jun 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941056; cv=none; b=hyH1FcjIIYEmrf3hP2ARk+fj6TZWlJD4tOkm9RG3Wlm4CPoJc2ciwCPzXkkMiwbN01XSs8AOmdV4E5QUNJEhY0XiN1H+O/AiAIhH1IWf8fxmAIlCekOUVPhrXP208hSfoc3uwjKrM0Dctv9PdVWOiqKhYSZGasbfDqjnahZOJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941056; c=relaxed/simple;
	bh=Tcuj9liMYKxMkRvp81H+oER4dm3a08kA2i8lcMgGi1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHfNlurfY1CB7/VJBuYXVzidIUzFREnIBZh8zhrQs9KtIvXZorIX/JsbuQIXBSRv/xwrI8H9azQnXmMR7Bb8SMqUbGLHLynNYxHlcradPuaXSuAXNs9EAIOZApxHWCHrEA0kBvpGUlWk30wrsc/gc2k8W8PDn4aYjBoPy8CYyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFdvFmGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFdvFmGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B73C4AF0C;
	Thu, 26 Jun 2025 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750941054;
	bh=Tcuj9liMYKxMkRvp81H+oER4dm3a08kA2i8lcMgGi1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AFdvFmGzLMJjZXxDjZV/m01zQTuxCUKxLXf0Gg84qB9aK2KhYYiKcdc+mUHnLphwh
	 pY1p04inasnEKd5nBA2oVSnGZoOP+WRuTkRVo1dfqk01FfhtM56sUQedMdg3NRVSt0
	 BlzHUtz4HOTNryNTvoWFwB+cIcvzVAiFSiIj8heUxirAbQWxQ8DlIMrokAZtRf76Ql
	 rrscEOcxyO+r2P+8fR6bsb/j6Nvfcvquv6N6t7HPBMFOWrrIZ27KXcA58zCYtOfCWl
	 UcdwBYo13JyBVy9NWin6/ulhdNf+E2T3on7horUyivOGmqSn4IPA9dZUUk5b7tIWRH
	 1LMqAm1Mc3MWQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1908164a12.2;
        Thu, 26 Jun 2025 05:30:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr6+C4mwzfWqg/7LPTsP+qQVGiypLcoQ9GL6pfCFuZR4cRyTmQkPaglcn1AhUIeLnlNeSPPCYGkVaf@vger.kernel.org, AJvYcCVcmGgGxP3WracRdn8W6iyPfwje4gjzNmmQ2op0bRUqr1uPFT+Er/ivS2LVnB+M0x4lQd4L2mPbhZte@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdhr/tR038oKjUCg1oTqAbsWfaxiMGOnp4c804OmV7UKytdAv
	qulc77mtvXUKDIHtAQX+f/o0+EmLtk+R9hV8Bt/2l2J400C+HokjIILGrsz5lWxDsFcL91RNubl
	zXliWD8TlZTd3NUOkRH8rBf6psSxz4R4=
X-Google-Smtp-Source: AGHT+IGB1r0RULOVkDK+7jbmAQV6m/K9tlzxxAPjyOT0QbB5tXfeb9acQUc0hgS9pLNBlMdu72qPEKROtVEjnWhhHgs=
X-Received: by 2002:a05:6402:3513:b0:608:4945:ca47 with SMTP id
 4fb4d7f45d1cf-60c6698f22dmr3238889a12.17.1750941053172; Thu, 26 Jun 2025
 05:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750765495.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1750765495.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Jun 2025 20:30:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6f9CWGkAJVM45Wir1PYTZaL-tDq4m=5=zazvPzqNSa5A@mail.gmail.com>
X-Gm-Features: Ac12FXzVVRuUM40OXySAmf7n49eft0EfQfUP6aqZIGlcvt6H_OodNRlHwWbaJQg
Message-ID: <CAAhV-H6f9CWGkAJVM45Wir1PYTZaL-tDq4m=5=zazvPzqNSa5A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Introduce the Loongson-2K MMC host
 controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Tue, Jun 24, 2025 at 7:58=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
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
In Patch-1 there is still ls2k1000_mmc_regmap_config(), others look good to=
 me.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Huacai

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
> https://lore.kernel.org/linux-mmc/cover.1744273956.git.zhoubinbin@loongso=
n.cn/
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
>  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k05=
00-mmc.yaml
>  create mode 100644 drivers/mmc/host/loongson2-mmc.c
>
>
> base-commit: f5c755ef810009b85350884c483705bd04365370
> --
> 2.47.1
>
