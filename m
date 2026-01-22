Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B074279FA
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083749; cv=pass; b=H4Lq+/jwDzUD4uQmhyz5JGz8RfUA0Ty4tvCN805Dr6s/TZXEJ5u+N2wFtpgApda86DIKrFS9z0Ni4K4ayakiy4RJRF6p9lZkGE9KAcF+9JZKwd9SVepH6wiRKvwnfPgvfzSR9Va2BkbjmWlYemZzdScZIpraazhQ3p2342lZAD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083749; c=relaxed/simple;
	bh=ZHhFrvHNtPemaDw3sRn5VfXn7aqVCVTY0i9LFdN2dNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr7jdxU4ouYL9gDSk4xZ9Bud6vsguXrW5e7EqynUCUhvtLfiy3vk58d0iDHlT0X5LzzPNyf0I6DTSEIyHbeTI6M5H/E6sbQibJ+yWeg061iON2ZDZQNNNY82LJ0wEkuJEV8bjB/Uf7NpMTxHex0DH206IO3T0/yK4KUEbTmJ86U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=do6hTI9q; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="do6hTI9q"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b76844f89so809605e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 04:09:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769083743; cv=none;
        d=google.com; s=arc-20240605;
        b=fA5/3SeVOxkf3bvR1RvGXfi2S7fB8cBe6gzPMwzSUjnQirXELi+DFfvjzpCJwjksj2
         JmJYrMtgWJhdEhVVWy5dYk0cQTvc4IVaDQVYPh+GMsLCQ9aSCjmXPB9jIPoiEd5YkB/5
         SqMDs/7ajDoROSZuRGU1Cmc1kn83oV4usI6OLydl+5J+WzTjqC55rPrpDEzCYHZ+uVyE
         6ErClCuvmwLdMowvpSypfIXmMXfTHqa0ZmutRBqjd62UOvzJmFJoPH85Tm/y/GQSt2jd
         E6gmjLfPNSMf/j9Ofh+JPxDCvOmJ0PaciP+hRPRQe8sN+niprbUYN08wX+hpmaGdMiUK
         hM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6dPEI6i2Pbcf5L6RRn/o/v6uVfOVu0UCYbEOntwFjnM=;
        fh=UAr3Iio88/+/uOeam1rbsH+SPH1h1m2u3IVWGD99Xhc=;
        b=H2tJ9Ea0K2SWTmUPaJnOOzHgM1zPUQLjyFdUY6H7SzpPgKlIaismOre58Dzm0o1rKc
         Oej6V7CsufOzukUa333+t2mPv1ihkr+oa35M3sXuZK6/snzLCgKy7TiMCxhZjq6T+/fi
         5QemGrEjKNEl6IyrwZMaYD6jMpdlMQppVL2LWwKNYaiycGufvh0shylPaA6x7GNYgpEb
         kC+iS0KM0HRne7TAQrXW3XEGdFvfPycPUwRmVQwT7OZqBGKDNGinO9qjBGqMtey6pJmj
         VXv+aA9jgHf5dG6h8xKyAKT9b2xRDgPOK6BGo8TqqnDrCXV+YZXj+UCn75OX5s0FaYrb
         o1Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769083743; x=1769688543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6dPEI6i2Pbcf5L6RRn/o/v6uVfOVu0UCYbEOntwFjnM=;
        b=do6hTI9qW0L+Rfr2nUZMRiy3y2bVx77d8ltvGJ9KRhKyA5/NwkjzkENtvKyKJmHPvo
         F2FOkGo4UxzjZC9qblxTK8X3C0lG33mc0i2HAhOc/NSO7XgiP0tS2zchN4VJulxZjo1Y
         DfeugchTP3qLUhI9si4iOoGrQJ8fRxNDzTeR82bDds5RlYXbAzMZYs+mjluyajwYffGx
         M93KyJwuMeLqlzBlcCzKzZvJuuY/ivXG+Uq8VxFkbB5WftHl06PBanoqGcB72WY2em96
         FeFKK/2dTw3EbSv68jFI+BrO/j3tApGpMs7L0/UWAiUNkBI4LbJ2eWZi43DpZFb+DFzl
         1PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083743; x=1769688543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dPEI6i2Pbcf5L6RRn/o/v6uVfOVu0UCYbEOntwFjnM=;
        b=p46Di/S9bhjHeYG0Nbqum+U8KPorIkarrOp5oPLiIO6QjFtHN0nOYnGGZ6mr6VFHLp
         7rFe5xB3GLBXajK69HL2OZ+GE/D2cl6LYJRXoQTPMsaX+x9UaoQvpPPsTnKCLtzCaXI5
         7zKcSue72s5TN1SO9vHaCbmJ8HDfCBTLnw52f9qUk1BHEQ4Bi5sbh/LF69Nxrea+qSwl
         U1q9QAdIxdiWIYEH5N2/WUayA3niNZcoUey0ZwdFXzqMu6BhhA5x4C6hUmTGG5vNtRwN
         t0bn9zBt6qWa7/1CWdWBusTFgS6vOwnbZyNeLev3oPkFkpbnSUutv+1EathQL2mepMbW
         /XCw==
X-Gm-Message-State: AOJu0YwarLaDKgNFe7SXAD3FtiIrcSZfRXU9LBf842mZ9hb0HYRfmK4T
	2yabCCkFY8qXVFPO92r1IoUnZdekvmvL0EYqlX9lOEDJ5fXlSfKrXMPjNKyJgMIvbee7BJHvqn2
	SHdHf9mMUlSShZB+KECjHo1YNN5CYfB88anuj/PiZBQ==
X-Gm-Gg: AZuq6aJmbOJtq2X2RiJ+kPmXUXWGKUgCbzcVguAC/6A5anzY9kwkPN5kXyGwkqya924
	M6u2K9SnOyj9rZxFZS0H/xesr2NTTJ7WI0r8A0Q4SboAGfzeg8G+0dffbYeByxvjOieL+IdQxMA
	dDsFmwuKAc2IeaduBdqULQKyhxbnJlF7Hkjo8H/yNqL7ZGvq7qYTKsz5BC2gRjO4eRgYL4BCXot
	wLh6/+Rxa6xHP5FXppYwUpkT0LPUSJntMhCx+FiANfrnXNa8bKR8W9e07oNFXtGGxExjpcM
X-Received: by 2002:a05:6512:aca:b0:59b:7d3a:2a26 with SMTP id
 2adb3069b0e04-59baef00dfdmr7488353e87.44.1769083742410; Thu, 22 Jan 2026
 04:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105064607.1554629-1-daniel@thingy.jp>
In-Reply-To: <20260105064607.1554629-1-daniel@thingy.jp>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 13:08:25 +0100
X-Gm-Features: AZwV_QhceT5McIJW1m9u0CCv7nrgY88Wv-GAKRTK1SATv4BVjIAYhx3OnmRbDqQ
Message-ID: <CAPDyKFptzJfxCeqNjAMsu2q4nEOiaKg6xFjNud9RR=QS1HQW-w@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: sdio: Allow sdio code to be build time disabled
To: Daniel Palmer <daniel@thingy.jp>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 07:46, Daniel Palmer <daniel@thingy.jp> wrote:
>
> In some cases the sdio support is not needed but the compiler
> cannot tell this and it ends up in your binary.
>
> This might not matter so much on generic kernels for systems
> with gigabytes of memory but in situations with megabytes
> of memory that just have an SD card attached via bitbanged SPI
> over GPIO this is wasteful.
>
> For amd64 disabling SDIO reduces the size of the kernel by ~26KiB.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>
> RFC because this is probably incomplete, maybe not a good idea,..
> I have only tested that this removes the unneeded SDIO code on my
> machine with 8MB of RAM and its still able to enumerate and access
> a 64GB SD card it has connected over SPI.

Hmm, in principle I don't mind this. Although, I assume there are lots
of other subsystems that can be split up using additional Kconfigs in
the similar manner.

Doing this for MMC/SD/SDIO alone seems silly unless we have a broader
consensus to do things like this. Do we have that?

In regards to the implementation and from a very brief review, I
observed two issues.
1) We don't want "#ifdef"-s sprinkled all over the place in the c-code
(headers are fine), then better to use stub-functions.
2) We need to be careful about Kconfig dependencies. The SDIO func
drivers are implemented across various subsystems (bluetooth, wifi,
etc), those corresponding Kconfigs probably need a "depends on SDIO"
too.

Kind regards
Uffe

>
>  drivers/mmc/core/Kconfig    | 12 +++++++++++-
>  drivers/mmc/core/Makefile   |  6 +++---
>  drivers/mmc/core/core.h     |  7 +++++++
>  drivers/mmc/core/host.c     |  2 ++
>  drivers/mmc/core/sdio_bus.h |  5 +++++
>  drivers/mmc/core/sdio_cis.h |  4 ++++
>  drivers/mmc/core/sdio_ops.h | 14 ++++++++++++++
>  7 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 14d2ecbb04d3..4112242a6c98 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -64,9 +64,19 @@ config MMC_BLOCK_MINORS
>
>           If unsure, say 8 here.
>
> +config MMC_SDIO
> +       bool "Support SDIO in MMC core" if EXPERT
> +       default y
> +       help
> +         Enable SDIO support in the MMC core. If you will never use
> +         SDIO because your hardware can't support it or your usecase
> +         will never need it i.e. you have one SD host and it has fixed
> +         eMMC attached to it you can set this to N and remove some
> +         unneeded code.
> +
>  config SDIO_UART
>         tristate "SDIO UART/GPS class support"
> -       depends on TTY
> +       depends on MMC_SDIO && TTY
>         help
>           SDIO function driver for SDIO cards that implements the UART
>           class, as well as the GPS class which appears like a UART.
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 15b067e8b0d1..efc354150e8a 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -6,9 +6,9 @@
>  obj-$(CONFIG_MMC)              += mmc_core.o
>  mmc_core-y                     := core.o bus.o host.o \
>                                    mmc.o mmc_ops.o sd.o sd_ops.o \
> -                                  sdio.o sdio_ops.o sdio_bus.o \
> -                                  sdio_cis.o sdio_io.o sdio_irq.o sd_uhs2.o\
> -                                  slot-gpio.o regulator.o
> +                                  sd_uhs2.o slot-gpio.o regulator.o
> +mmc_core-$(CONFIG_MMC_SDIO)    += sdio.o sdio_ops.o sdio_bus.o \
> +                                  sdio_cis.o sdio_io.o sdio_irq.o
>  mmc_core-$(CONFIG_OF)          += pwrseq.o
>  obj-$(CONFIG_PWRSEQ_SIMPLE)    += pwrseq_simple.o
>  obj-$(CONFIG_PWRSEQ_SD8787)    += pwrseq_sd8787.o
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index a028b48be164..8e2a1abc5523 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -85,7 +85,14 @@ int mmc_detect_card_removed(struct mmc_host *host);
>
>  int mmc_attach_mmc(struct mmc_host *host);
>  int mmc_attach_sd(struct mmc_host *host);
> +#ifdef CONFIG_MMC_SDIO
>  int mmc_attach_sdio(struct mmc_host *host);
> +#else
> +static inline int mmc_attach_sdio(struct mmc_host *host)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
>  int mmc_attach_sd_uhs2(struct mmc_host *host);
>
>  /* Module parameters */
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 88c95dbfd9cf..0216953b8906 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -563,7 +563,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         spin_lock_init(&host->lock);
>         init_waitqueue_head(&host->wq);
>         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> +#ifdef CONFIG_MMC_SDIO
>         INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
> +#endif
>         timer_setup(&host->retune_timer, mmc_retune_timer, 0);
>
>         INIT_WORK(&host->supply.uv_work, mmc_undervoltage_workfn);
> diff --git a/drivers/mmc/core/sdio_bus.h b/drivers/mmc/core/sdio_bus.h
> index 27b8069a72ab..ad14784b37d1 100644
> --- a/drivers/mmc/core/sdio_bus.h
> +++ b/drivers/mmc/core/sdio_bus.h
> @@ -14,8 +14,13 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card);
>  int sdio_add_func(struct sdio_func *func);
>  void sdio_remove_func(struct sdio_func *func);
>
> +#ifdef CONFIG_MMC_SDIO
>  int sdio_register_bus(void);
>  void sdio_unregister_bus(void);
> +#else
> +#define sdio_register_bus() 0
> +#define sdio_unregister_bus()
> +#endif
>
>  #endif
>
> diff --git a/drivers/mmc/core/sdio_cis.h b/drivers/mmc/core/sdio_cis.h
> index 6d76f6fa608c..486eeb802162 100644
> --- a/drivers/mmc/core/sdio_cis.h
> +++ b/drivers/mmc/core/sdio_cis.h
> @@ -13,10 +13,14 @@
>  struct mmc_card;
>  struct sdio_func;
>
> +#ifdef CONFIG_MMC_SDIO
>  int sdio_read_common_cis(struct mmc_card *card);
>  void sdio_free_common_cis(struct mmc_card *card);
>
>  int sdio_read_func_cis(struct sdio_func *func);
>  void sdio_free_func_cis(struct sdio_func *func);
> +#else
> +#define sdio_free_common_cis(card)
> +#endif
>
>  #endif
> diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
> index 37f79732a206..dc16e80aa361 100644
> --- a/drivers/mmc/core/sdio_ops.h
> +++ b/drivers/mmc/core/sdio_ops.h
> @@ -12,6 +12,7 @@
>  #include <linux/mmc/sdio.h>
>
>  struct mmc_host;
> +#ifdef CONFIG_MMC_SDIO
>  struct mmc_card;
>  struct work_struct;
>
> @@ -33,6 +34,19 @@ static inline bool sdio_is_io_busy(u32 opcode, u32 arg)
>                 (opcode == SD_IO_RW_DIRECT &&
>                 !(addr == SDIO_CCCR_ABORT || addr == SDIO_CCCR_SUSPEND)));
>  }
> +#else
> +/* These are referenced in code outside of the sdio files so define dummy versions */
> +static inline int sdio_reset(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static inline bool sdio_is_io_busy(u32 opcode, u32 arg)
> +{
> +       return false;
> +}
> +#endif
> +
>
>  #endif
>
> --
> 2.51.0
>
