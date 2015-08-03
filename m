From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [SHDCI] Heavy (thousands) DMA leaks
Date: Mon, 3 Aug 2015 11:39:34 +0200
Message-ID: <55BF36D6.4080504@suse.cz>
References: <55B9EF02.7040404@suse.cz>
 <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35142 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbHCJji (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2015 05:39:38 -0400
In-Reply-To: <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>

Hi,

On 08/03/2015, 11:30 AM, Chen Bough wrote:
> I carefully review my patch, all the DMA memory mapped in sdhci_pre_req() is unmapped in sdhci_post_req.

I suspect 'host_cookie' or 'next' handling is bad somewhere. But I don't
know...

> Can you provide the method of your testing DMA leaks?

boot kernel with CONFIG_DMA_API_DEBUG
insert the card
mount it
rsync from the card ~200 MB
umount it
unload the sdhci driver
the leak warning is reported

I am not sure whether suspend-resume is needed after the first step.

> You said over 4000 leaked mappings during one card transfer, if true, 
> We can't map any dma memory after some sd transfer, do you meet this?

Yes, I see:
sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 65536 bytes)
after some time. The driver falls back to non-DMA transfers after that.
It also generates a warning about that:
WARNING: CPU: 0 PID: 0 at drivers/mmc/host/sdhci.c:857
sdhci_prepare_data+0x8ec/0x900 [sdhci]()

thanks,
-- 
js
suse labs
