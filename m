From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC v02 01/15] dmaengine: core: Allow NULL mask pointer in __dma_device_satisfies_mask()
Date: Tue, 1 Dec 2015 14:58:35 +0200
Message-ID: <CAHp75Vfk_GAANRYdbHNxtCy-Ni18FppsKhPPX1X84v1Zu6JXvw@mail.gmail.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
	<1448891145-10766-2-git-send-email-peter.ujfalusi@ti.com>
	<CAHp75VfY=NU4MG7q1w=oYdTiTr0dqtNTQU3UkEaL=tXPJADH5Q@mail.gmail.com>
	<565D6CB1.8030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36725 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbbLAM6g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 07:58:36 -0500
In-Reply-To: <565D6CB1.8030808@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>

On Tue, Dec 1, 2015 at 11:47 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 11/30/2015 04:35 PM, Andy Shevchenko wrote:
>> On Mon, Nov 30, 2015 at 3:45 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>> Treat as true condition the case when the mask is NULL.
>>
>> What do you think about setting some default (all "on") mask when mask
>> is not supplied?
>
> Probably rephrasing the commit message to say that when the mask is NULL it
> means that the caller does not care about the capabilities of the dma device
> thus return with true in such a case.
>
> We could also drop this patch and in private_candidate() :
>
> -       if (!__dma_device_satisfies_mask(dev, mask)) {
> +       if (mask && !__dma_device_satisfies_mask(dev, mask)) {
>                 pr_debug("%s: wrong capabilities\n", __func__);
>                 return NULL;
>         }

Between patch and above proposal I would choose the latter one.

>> I don't know for sure but there might be cases when you don't want
>> literally *any* channel to satisfy.
>
> Or set DMA_SLAVE only in dma_request_chan()? What happens if we have cases
> when we are able to request channel for memcpy via dma_request_chan()
> (dedicated memcpy channel/DMA engine?) in that case we will have the SLAVE
> set, but not MEMCPY, or any other variation we do not know yet?

Frankly, have no idea.

-- 
With Best Regards,
Andy Shevchenko
