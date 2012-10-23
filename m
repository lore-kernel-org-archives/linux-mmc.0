From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/3] dmaengine: add dma_get_channel_caps()
Date: Tue, 23 Oct 2012 23:38:41 +0100
Message-ID: <CACxGe6u_oubGQKHJh_GOjty5xe1qxj-i18GnKqmi7ANHa3K_Wg@mail.gmail.com>
References: <1350615088-14562-1-git-send-email-mporter@ti.com> <1350615088-14562-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51483 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274Ab2JWWjD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Oct 2012 18:39:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so768114pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 23 Oct 2012 15:39:01 -0700 (PDT)
In-Reply-To: <1350615088-14562-2-git-send-email-mporter@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Chris Ball <cjb@laptop.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

On Fri, Oct 19, 2012 at 3:51 AM, Matt Porter <mporter@ti.com> wrote:
> Add a dmaengine API to retrieve per channel capabilities.
> Currently, only channel ops and SG segment limitations are
> implemented caps.
>
> The API is optionally implemented by drivers and when
> unimplemented will return a NULL pointer. It is intended
> to be executed after a channel has been requested and, if
> the channel is intended to be used with slave SG transfers,
> then it may only be called after dmaengine_slave_config()
> has executed. The slave driver provides parameters such as
> burst size and address width which may be necessary for
> the dmaengine driver to use in order to properly return SG
> segment limit caps.
>
> Suggested-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Matt Porter <mporter@ti.com>

Looks okay to me. Minor comment below...

> +/**
> + * dma_get_channel_caps - flush pending transactions to HW
> + * @chan: target DMA channel
> + * @dir: direction of transfer
> + *
> + * Get the channel-specific capabilities. If the dmaengine
> + * driver does not implement per channel capbilities then
> + * NULL is returned.
> + */
> +static inline struct dmaengine_chan_caps
> +*dma_get_channel_caps(struct dma_chan *chan, enum dma_transfer_direction dir)

Looks to me like the returned pointer be a const. Ditto for the
callback prototype in the dma_device structure.

> +{
> +       if (chan->device->device_channel_caps)
> +               return chan->device->device_channel_caps(chan, dir);
> +       return NULL;
> +}
> +
>  enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
>  #ifdef CONFIG_DMA_ENGINE
>  enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
