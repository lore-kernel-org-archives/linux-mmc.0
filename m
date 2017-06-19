From: Tomas Winkler <tomasw@gmail.com>
Subject: Re: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
Date: Tue, 20 Jun 2017 00:25:15 +0300
Message-ID: <CA+i0qc4ERgD=C_rNC5OPiwrJ2Qd0TqSK78BJOwrm743rgf3U5Q@mail.gmail.com>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-5-linus.walleij@linaro.org> <20170616074543.GA9125@lst.de>
 <CAPDyKFoWHKNsAnqrnmS-_e6OeTAMx5nGxY5W8ittWGPjriANLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35281 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdFSVZQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2017 17:25:16 -0400
In-Reply-To: <CAPDyKFoWHKNsAnqrnmS-_e6OeTAMx5nGxY5W8ittWGPjriANLg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Tomas Winkler <tomas.winkler@intel.com>

>>> Currently the RPMB partition spawns a separate block device
>>> named /dev/mmcblkNrpmb for each device with an RPMB partition,
>>> including the creation of a block queue with its own kernel
>>> thread and all overhead associated with this. On the Ux500
>>> HREFv60 platform, for example, the two eMMCs means that two
>>> block queues with separate threads are created for no use
>>> whatsoever.
>>
>> Yikes!  What an amazingly stupid design decision.
>
> Unfortunate, there is more. :-)
>
> We are actually registering at least three more block devices per eMMC
> card (two boot partitions, and one general purpose partition). Except
> for the main partition of course.

Little correction, there are 4 general purpose partition, not one.

>
> The difference compared to rpmb from the above, is that those are
> actually general read/write partitions.
>
> So all these partitions are on the same eMMC card, but being I/O
> scheduled separately because there are separate block devices. Yeah,
> starvation, latency, etc - all bad things comes with it. :-)

Actually the worst issue is that emmc is single headed and all the security
devices and VMs has to go via host for their data.
>
> My point is, this is only the first step in re-working and fixing this
> - and we really appreciate your review!
