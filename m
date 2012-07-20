From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Fri, 20 Jul 2012 17:26:01 +0530
Message-ID: <CAJe_Zhfu-k0V7q527JSqdThn_c7WfNcaHmYOwBBaaRh+A=2hKA@mail.gmail.com>
References: <5006571A.7060103@de.bosch.com>
	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
	<50068696.8070408@de.bosch.com>
	<CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
	<5006C40D.300@de.bosch.com>
	<CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>
	<50094168.2090900@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64349 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab2GTL4D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jul 2012 07:56:03 -0400
Received: by vcbfk26 with SMTP id fk26so2866360vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jul 2012 04:56:02 -0700 (PDT)
In-Reply-To: <50094168.2090900@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Wohlrab Knut (CM-AI/PJ-CA31)" <Knut.Wohlrab@de.bosch.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On 20 July 2012 17:00, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> On 19.07.2012 22:45, Jassi Brar wrote:

>>> This problem can occur on many devices with embedded MMC and removable
>>> SD,
>>> e.g. smart phones. So I think we should find an solution to define MMC
>>> scan
>>> order or device number/name in a device tree.
>>>
>> I assume your issue is that due to async nature of mmc scanning, the
>> eMMC is detected later than external card, despite being the probe for
>> eMMC's slot initiated first ?
>> If so, we can do by simply associating 'N' of 'mmcblkN' with the slot
>> index i.e, mmc_host.index (instead of mmc_blk_data.name_idx). Which is
>> always in the order of probe calling. And we don't need to modify, or
>> expect more of, DT for that.
>
>
> Do you mean something like
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1536,7 +1536,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct
> mmc_card *card,
>          */
>
>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> -                "mmcblk%d%s", md->name_idx, subname ? subname : "");
> +                "mmcblk%d%s", card->host->index, subname ? subname : "");
>
>         blk_queue_logical_block_size(md->queue.queue, 512);
>         set_capacity(md->disk, size);
>
> ?
>
Exactly!
It seems too trivial and default for the author to have missed it, so
I suspect I am overlooking something yet again. I would dig email
archives to know more about that naming convention before dare submit
a patch :)
