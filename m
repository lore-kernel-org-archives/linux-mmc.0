From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 4/7] mmc: tmio: Add UHS-I mode support
Date: Wed, 16 Mar 2016 09:58:38 +0100
Message-ID: <CAPDyKFp_d=GKxKvNt7nyGoWLFSUYTycbS6jb-khPC1cBvJENog@mail.gmail.com>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
	<1455913003-6140-5-git-send-email-wsa@the-dreams.de>
	<CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
	<20160309161735.GB9443@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33541 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbcCPI6o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 04:58:44 -0400
Received: by mail-wm0-f47.google.com with SMTP id l68so179616778wml.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 01:58:44 -0700 (PDT)
In-Reply-To: <20160309161735.GB9443@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

On 9 March 2016 at 17:17, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > +
>> > +       int (*start_signal_voltage_switch)(struct tmio_mmc_host *host,
>> > +                                          unsigned char signal_voltage);
>>
>> Do you really need to add a new tmio specific callback for this?
>>
>> Why can't you instead have the tmio variant driver assign the
>> ->start_signal_voltage_switch() callback into the struct mmc_host_ops
>> instead?
>
> Just to see how it looks, I tried your suggestion. However, mmc_ops is
> consted all the way into the core (rightfully, I'd say), so this makes
> this approach quite clumsy. I kept the above callback now, just changed
> the second paramater to pass the whole ios so I can use it with
> mmc_regulator_set_vqmmc().

Okay, let me elaborate a bit more on what I really meant.

In tmio_mmc_of_parse(), the mmc->ops gets assigned to the
&tmio_mmc_ops. Before doing that, you can conditionally assign
->start_signal_voltage_switch() callback within the &tmio_mmc_ops,
right!?

Why am I suggesting this? I want to avoid us evolving the code in the
wrong direction, similar what has happened to SDHCI. *One* way to
address this, is to minimize unnecessary variant specific callbacks.

>
>> > +static int tmio_mmc_card_busy(struct mmc_host *mmc)
>> > +{
>> > +       struct tmio_mmc_host *host = mmc_priv(mmc);
>> > +       u32 status;
>> > +
>> > +       pm_runtime_get_sync(mmc_dev(mmc));
>>
>> This isn't needed as the mmc core already deal with runtime PM of the
>> host device via mmc_claim|release_host().
>
> sdhci.c does it, too - missing cleanup?

We quite recently added this into the mmc core, before it was the
controller driver itself who dealt with pm_runtime_get|put().
So, yes several drivers can be cleaned up.

Kind regards
Uffe
