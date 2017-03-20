From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
Date: Mon, 20 Mar 2017 19:02:26 +0100
Message-ID: <CAPDyKFpuAgFnoAFymZeiPiCQcXATkz6KCEm8Wr_j4hD+nrtGuQ@mail.gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
 <c75c3e5c-c4e1-3f2f-267b-1c781052c55e@gmail.com> <CAPDyKFr6_Y3cSv5Q1WRSQBo7_bsyeVVQTYBQ01gykdMpVWNtXw@mail.gmail.com>
 <ac5f62eb-64c6-b66f-24cc-b6ae74a01697@gmail.com> <d029f887-4fd3-1319-fd01-a99ea9ede5c1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34285 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756393AbdCTSCs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 14:02:48 -0400
Received: by mail-vk0-f46.google.com with SMTP id z204so17503455vkd.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2017 11:02:37 -0700 (PDT)
In-Reply-To: <d029f887-4fd3-1319-fd01-a99ea9ede5c1@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

[...]

>>
> Other alternative:
>
> typedef void (*hw_reset_t)(struct mmc_host *host);
>
> hw_reset_t mmc_get_hw_reset(struct mmc_host *host)
> {
>        struct mmc_pwrseq *p = host->pwrseq;
>
>        if (host->ops->hw_reset)
>                return host->ops->hw_reset;
>        else if (p && p->ops->reset)
>                return p->ops->reset;
>        else
>                return NULL;
> }
>
> And then use what mmc_get_hw_reset returns instead of using
> host->ops->hw_reset directly.
>
> How do you like this one?

Well, I would just rather do these checks and call the correct
callback in mmc_reset(). There is no need to invent a function
returning a function pointer when we call it directly instead.

Additionally, I wonder whether it could make sense to allow both
callbacks to co-exist and then call both. This would give the mmc host
some options for doing some internal reset as well, while the pwrseq
could handle the actual GPIO pin.

What do you think?

Kind regards
Uffe

>
>>>>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>>>>
>>>>  #endif /* LINUX_MMC_CORE_H */
>>>> --
>>>> 2.11.0
>>>>
>>>>
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>
