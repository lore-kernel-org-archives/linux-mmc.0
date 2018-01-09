From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Tue, 9 Jan 2018 09:07:28 +0100
Message-ID: <CAPDyKFo+r39NAW1qGaXxq3_9kr9dVU8DBEuhQBtg-n4r4JFzAA@mail.gmail.com>
References: <20180105162936.18612-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:43187 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757637AbeAIIH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jan 2018 03:07:29 -0500
Received: by mail-io0-f180.google.com with SMTP id w188so17592969iod.10
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jan 2018 00:07:29 -0800 (PST)
In-Reply-To: <20180105162936.18612-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, "# 4.0+" <stable@vger.kernel.org>

[...]

> @@ -3713,6 +3751,43 @@ int sdhci_setup_host(struct sdhci_host *host)
>          */
>         mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
>
> +       if (mmc->max_segs == 1) {
> +               unsigned int max_blocks;
> +               unsigned int max_seg_size;
> +
> +               max_seg_size = mmc->max_req_size;
> +               max_blocks = max_seg_size / 512;
> +               dev_info(mmc->parent, "host only supports SDMA, activate bounce buffer\n");
> +
> +               /*
> +                * When we just support one segment, we can get significant speedups
> +                * by the help of a bounce buffer to group scattered reads/writes
> +                * together.
> +                *
> +                * TODO: is this too big? Stealing too much memory? The old bounce
> +                * buffer is max 64K. This should be the 512K that SDMA can handle
> +                * if I read the code above right. Anyways let's try this.
> +                * FIXME: use devm_*
> +                */
> +               host->bounce_buffer = dma_alloc_coherent(mmc->parent, max_seg_size,
> +                                                        &host->bounce_addr, GFP_KERNEL);

Why do you need dma_alloc_coherent() - allocated bounce buffer? Isn't
a regular kmalloc-ed buffer fine as a bounce buffer?

I am worried, also according to your above comment, that it's not
always going to work to request a large buffer like this, especially
with dma_alloc_coherent().

> +               if (!host->bounce_buffer) {
> +                       dev_err(mmc->parent,
> +                               "failed to allocate %u bytes for bounce buffer\n",
> +                               max_seg_size);
> +                       return -ENOMEM;

Why not fall back to use the max_segs = 1 here. It may be slow, as
reported, but it works.

> +               }
> +               host->bounce_buffer_size = max_seg_size;
> +
> +               /* Lie about this since we're bouncing */
> +               mmc->max_segs = max_blocks;
> +               mmc->max_seg_size = max_seg_size;
> +
> +               dev_info(mmc->parent,
> +                        "bounce buffer: bounce up to %u segments into one, max segment size %u bytes\n",
> +                        max_blocks, max_seg_size);
> +       }
> +
>         return 0;
>

[...]

Kind regards
Uffe
