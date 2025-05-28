Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E781E0DBA;
	Wed, 28 May 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423217; cv=none; b=tcnDOcFDvZU5pLL/1bPmfkmiEvBqS8yeMs/YntvMJx1Ihl4gC8IBvRsnkz9xu2vB5qdGTLXyMwGy/jEZTzdAmLjwt+kIsda+vb8qOTt9WWr3zDva5vHpYL8e3m73kFMeYve69WQp2E85eTb1+adEsLpZkMKvwjgy/Um73e8TI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423217; c=relaxed/simple;
	bh=WIrinfMiUyAK0J7pL1G1KsvX4q1r3p0Fe9ePl0u9gtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqTj1UL+PpIlSHuva9rg3DE3hwR3yRi2WfUoF7uO23Ykr5lnzLqfDD6pPHLmbLcoX4o0G7xtaVwyEQXg/Y+oB/FjPy7TfxXNwybU2k5xoJC5ackR62gGDsucjzRiNiNdbE0XXxgOkYGqpu10IcUbehMUlmq7JNDsOMA5IP3mAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52d9a275c27so2654725e0c.0;
        Wed, 28 May 2025 02:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423212; x=1749028012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYU8Mi90KLdCAAJJaGYDubPex399S/3mu0JP984ggbk=;
        b=DQc8cR5ylyBmphwLY4m7WQHcYPxnADSQkmwgmZgdwhGYxn/21dZPfTRF+2KxHhfoOw
         5RYvX1m4Q0lS7k0pq2RvS4FWr9PD36Dkljtl3ltlyQ5/U0XRIdKlOEEMhQzGzdzeNR7o
         HGZ5x1uq2tNkKLlFSbWbYPlCMyRDWRB0oup7jAtZV+GFP3weErwzXdnkLDB3mDr3dtc7
         tRy6gKF7jiBQzf2Su2CnFd+mf4IJRSSXpUiSRkIDON4AakqkQNPdhCNqTMBuRgrUewbN
         lnDjOeliiZHZbAIbsYRLh4O3/02URfWjCfkc6m6EM51ikCb84JXvYJCIoz3y14sMJafQ
         jvig==
X-Forwarded-Encrypted: i=1; AJvYcCVWYl73hqtST3XhRU9D5Z57YKpw5mlSK0eKxn2fdo4AgQ/JfiCcHqtjCTp/RI0ACJG779tqmRW4XLSD@vger.kernel.org, AJvYcCW5cGCWXYRusuVd4skgYQEMzjTnTS0Ju/hZZik1JAN5YVskuVUhJAx+wrlVgyNeYcwSui+3WWwbbzkuZGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFgXyD0W1325ymVzwJN01g7g6SpvraHedpXo0rgXlgF+3vaLx
	1Y6BcNqmha1Ue5eRsfSOEgepjg3kjzS6lMFqojh0lyaVP51ZR3ttmz1sPeYsbkUL
X-Gm-Gg: ASbGncsE90nfoYut1nLYEITbwgBF3iMrMKCp1og/9Mz+QLqq/5CYp5o+dX504dn1oyh
	xB+4Mt2ppfL20dncKAgUYNMcI68wZcBZbYIHUia+VgAkvIet12cMAc3wc/tj2S5P6ko1yEmSYjH
	siBpQC37zEXNyvvlzYr+oBXJwji4xOZiV9/hf0tdSKhKGbp+TS+ROQzciN+kDO7zD55IZb2Y+if
	DyBAAnQibKDwtM+yiL2Cuscy3KcuqmkQ1vaEBFguynKbUOF+1QuHKU1vdTtbCzB8bn3Fk2pENcV
	r2f/m/T/Km/s2/YCQ8u+DcidBIPZfE2x5EtkbVtLRZPrh/t4+CT8MMg7cVEGM4GgAZUOiiKyOzI
	MJRU8kwi/0HV7Bg==
X-Google-Smtp-Source: AGHT+IHfNVkNJvyzuGOXvU2/5E8q4hXCG5ePgdD3cthNXeuQMw3gnVLwTDUf0eI/hRQz3uPM3fzEOw==
X-Received: by 2002:a05:6122:3d0d:b0:52f:204d:4752 with SMTP id 71dfb90a1353d-52f2c5ca414mr13253504e0c.11.1748423212554;
        Wed, 28 May 2025 02:06:52 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53066972cb4sm592394e0c.39.2025.05.28.02.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:06:52 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-87e049bb3e4so1401443241.0;
        Wed, 28 May 2025 02:06:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3kqi49IImI4GnQDl7JIHcnHyjwjaITAhYfP4IX2mnZgfUQsv57YoYnww0X/14DZHDCCwZzKQQ/ahjczw=@vger.kernel.org, AJvYcCX2lFC5FU0TQ7qawEiEd1sc0vRLneZvNWlfzwvcpHz86spzlCWvDc7IUcK7z4K1MDQshU8wtbZfFKUz@vger.kernel.org
X-Received: by 2002:a05:6102:8006:b0:4e5:8d09:7b14 with SMTP id
 ada2fe7eead31-4e58d097d83mr5192536137.0.1748423212075; Wed, 28 May 2025
 02:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528085453.481320-1-yangzh0906@thundersoft.com>
In-Reply-To: <20250528085453.481320-1-yangzh0906@thundersoft.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 May 2025 11:06:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjR0Ki_vLYtvv1HYpZVdLqUtacG=zs4_ooC0yLnK_CvA@mail.gmail.com>
X-Gm-Features: AX0GCFv2umrJq54Eu_Z7Pa0M5hU7WaTzckrO6UyfF8NfUyYwIvRhoe3M_guovBM
Message-ID: <CAMuHMdVjR0Ki_vLYtvv1HYpZVdLqUtacG=zs4_ooC0yLnK_CvA@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] mmc: sdhci: add Black Sesame Technologies BST
 C1200 controller driver
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ge Gordon <gordon.ge@bst.ai>, BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Shan-Chun Hung <shanchun1218@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Peter Robinson <pbrobinson@gmail.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

Hi Albert,

On Wed, 28 May 2025 at 10:55, Albert Yang <yangzh0906@thundersoft.com> wrote:
> Add a driver for the DesignWare Mobile Storage Host Controller (DWCMSHC)
> SDHCI controller found in Black Sesame Technologies C1200 SoCs.
>
> The driver provides specialized clock configuration, tuning, voltage
> switching, and power management for the BST DWCMSHC controller. It also
> includes support for eMMC boot and memory-mapped I/O for CRM registers.
>
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>

Thanks for your patch!

> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1112,3 +1112,14 @@ config MMC_LITEX
>           module will be called litex_mmc.
>
>           If unsure, say N.
> +
> +config MMC_SDHCI_BST
> +       tristate "SDHCI OF support for the BST DWC MSHC"

depends on ARCH_BST || COMPILE_TEST

> +       depends on MMC_SDHCI_PLTFM
> +       depends on OF
> +       depends on COMMON_CLK
> +       help
> +         This selects Synopsys DesignWare Cores Mobile Storage Controller
> +         support.
> +         If you have a controller with this interface, say Y or M here.
> +         If unsure, say N.

> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-bst-c1200.c

> +#define SDEMMC_CRM_BCLK_DIV_CTRL       0x08
> +#define SDEMMC_CRM_RX_CLK_CTRL         0x14
> +#define SDEMMC_CRM_TIMER_DIV_CTRL      0x0C
> +#define SDEMMC_CRM_VOL_CTRL            0x1C
> +#define DRIVER_NAME                    "sdhci_bst"
> +#define BST_VOL_STABLE_ON              (0x1 << 7)
> +#define SDHCI_DUMP_BST(f, x...)                \
> +       pr_info("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ##x)
> +#define SD_3_3V                                0
> +#define SD_1_8V                                1
> +#define default_max_freq               200000ul
> +
> +void sdhci_bst_print_vendor(struct sdhci_host *host)
> +{
> +       SDHCI_DUMP_BST("============ SDHCI VENDOR REGISTER DUMP ===========\n");
> +
> +       SDHCI_DUMP_BST("VER_ID:  0x%08x | VER_TPYE:  0x%08x\n",
> +                      sdhci_readl(host, SDHC_MHSC_VER_ID_R),
> +                      sdhci_readl(host, SDHC_MHSC_VER_TPYE_R));
> +       SDHCI_DUMP_BST("MHSC_CTRL:  0x%08x | MBIU_CTRL:  0x%08x\n",
> +                      sdhci_readw(host, SDHC_MHSC_CTRL_R),
> +                      sdhci_readw(host, SDHC_MBIU_CTRL_R));
> +       SDHCI_DUMP_BST("EMMC_CTRL:  0x%08x | BOOT_CTRL: 0x%08x\n",
> +                      sdhci_readl(host, SDHC_EMMC_CTRL_R),
> +                      sdhci_readw(host, SDHC_BOOT_CTRL_R));
> +       SDHCI_DUMP_BST("GP_IN:   0x%08x | GP_OUT: 0x%08x\n",
> +                      sdhci_readl(host, SDHC_GP_IN_R),
> +                      sdhci_readb(host, SDHC_GP_OUT_R));
> +       SDHCI_DUMP_BST("AT_CTRL:     0x%08x | AT_STAT:  0x%08x\n",
> +                      sdhci_readb(host, SDHC_AT_CTRL_R),
> +                      sdhci_readb(host, SDHC_AT_STAT_R));
> +}
> +EXPORT_SYMBOL_GPL(sdhci_bst_print_vendor);

Why do you need this?

> +
> +static u32 bst_read_phys_bst(u32 phys_addr)
> +{
> +       u32 phys_addr_page = phys_addr & 0xFFFFE000;
> +       u32 phys_offset = phys_addr & 0x00001FFF;
> +       u32 map_size = phys_offset + sizeof(u32);
> +       u32 ret = 0xDEADBEEF;
> +       void *mem_mapped = ioremap(phys_addr_page, map_size);
> +
> +       if (mem_mapped) {
> +               ret = (u32)ioread32(((u8 *)mem_mapped) + phys_offset);
> +               iounmap(mem_mapped);
> +       }

Please do not ioremap()/iounmap() for each register read...

> +
> +       return ret;
> +}
> +
> +static void bst_write_phys_bst(u32 phys_addr, u32 value)
> +{
> +       u32 phys_addr_page = phys_addr & 0xFFFFE000;
> +       u32 phys_offset = phys_addr & 0x00001FFF;
> +       u32 map_size = phys_offset + sizeof(u32);
> +       void *mem_mapped = ioremap(phys_addr_page, map_size);
> +
> +       if (mem_mapped) {
> +               iowrite32(value, ((u8 *)mem_mapped) + phys_offset);
> +               iounmap(mem_mapped);
> +       }

or write...

> +}

Aborting review.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
