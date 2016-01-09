From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] mmc: atmel: get rid of struct mci_dma_data
Date: Sat, 9 Jan 2016 14:10:27 +0200
Message-ID: <CAHp75Vdq83QRUw_ZxxVWcC6Xut5y-sJfYwLA+cOtGMhjB7Rm3w@mail.gmail.com>
References: <1452302551-24199-1-git-send-email-mans@mansr.com>
	<1452302551-24199-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452302551-24199-2-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Jan 9, 2016 at 3:22 AM, Mans Rullgard <mans@mansr.com> wrote:
> As struct mci_dma_data is now only used by AVR32, it is nothing but
> pointless indirection.  Replace it with struct dw_dma_slave in the
> AVR32 platform code and with a void pointer elsewhere.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

> @@ -1376,15 +1375,15 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>                                 ARRAY_SIZE(atmel_mci0_resource)))
>                 goto fail;
>
> -       slave = kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
> +       slave = kzalloc(sizeof(*slave), GFP_KERNEL);
>         if (!slave)
>                 goto fail;
>
> -       slave->sdata.dma_dev = &dw_dmac0_device.dev;
> -       slave->sdata.src_id = 0;
> -       slave->sdata.dst_id = 1;
> -       slave->sdata.m_master = 1;
> -       slave->sdata.p_master = 0;

Seems you based this on top of our non-submitted yet patches.

> +       slave->dma_dev = &dw_dmac0_device.dev;
> +       slave->src_id = 0;
> +       slave->dst_id = 1;
> +       slave->m_master = 1;
> +       slave->p_master = 0;


-- 
With Best Regards,
Andy Shevchenko
