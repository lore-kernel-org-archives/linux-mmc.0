From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v2] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Thu, 11 Jun 2015 18:55:22 +0200
Message-ID: <CAL9uMOEuHmVXXu5DqPzdD2C=wk1o6k3cjjvCbHx0wMSEYmTw2Q@mail.gmail.com>
References: <1433926397-31376-1-git-send-email-carlo@caione.org>
	<CAD8Lp45_Bj3L3+AUgs+WYmS1jkoHhnjR+0wVpMQ1r5oToEPBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35418 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbbFKQzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jun 2015 12:55:23 -0400
Received: by igbzc4 with SMTP id zc4so59335582igb.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2015 09:55:22 -0700 (PDT)
In-Reply-To: <CAD8Lp45_Bj3L3+AUgs+WYmS1jkoHhnjR+0wVpMQ1r5oToEPBrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, "Jasper St. Pierre" <jasper@endlessm.com>, Jerry Cao <jerry.cao@amlogic.com>, victor.wan@amlogic.com, Ulf Hansson <ulf.hansson@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, linux-meson@googlegroups.com

On Wed, Jun 10, 2015 at 3:44 PM, Daniel Drake <drake@endlessm.com> wrote:
> On Wed, Jun 10, 2015 at 2:53 AM, Carlo Caione <carlo@caione.org> wrote:
>> +static int meson_mmc_map_dma(struct meson_mmc_host *host,
>> +                            struct mmc_data *data,
>> +                            unsigned int flags)
>> +{      u32 i, dma_len;
>> +       struct scatterlist *sg;
>> +
>> +       dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>> +                            ((data->flags & MMC_DATA_READ) ?
>> +                            DMA_FROM_DEVICE : DMA_TO_DEVICE));
>> +       if (dma_len == 0) {
>> +               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       for_each_sg(data->sg, sg, data->sg_len, i) {
>> +               if (sg->offset & 3 || sg->length & 3) {
>> +                       dev_err(mmc_dev(host->mmc),
>> +                               "unaligned scatterlist: os %x length %d\n",
>> +                               sg->offset, sg->length);
>> +                       return -EINVAL;
>> +               }
>> +       }
>
> If the offset/length check fails here, do you leak the DMA mapping?
> If so, can you do the offset/length check first to avoid that?

Good idea. Fix in v3.

> There should only ever be 1 entry in the scatterlist, right? In that
> case you can do a simple check there, and then instead of looping,
> just check the first entry in the scatterlist.

Right.

I'm going to wait a couple of days for more comments before submitting v3.

Thanks,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
