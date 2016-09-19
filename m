From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] tmio: add support for eMMC with 8 bit bus width
Date: Mon, 19 Sep 2016 12:00:04 +0200
Message-ID: <CAPDyKFr3-BAAg9HYVY93rmjOfrBxpVTH4RLJeKotTVER6Padsg@mail.gmail.com>
References: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdX7GygtuA43=+HFFOyMGt=x1b2UTQBUojqedSfcRmSxjQ@mail.gmail.com> <20160919080045.GA1409@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36195 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756496AbcISKAG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2016 06:00:06 -0400
Received: by mail-wm0-f50.google.com with SMTP id w84so67101300wmg.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2016 03:00:06 -0700 (PDT)
In-Reply-To: <20160919080045.GA1409@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>

On 19 September 2016 at 10:00, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Sep 15, 2016 at 01:52:26PM +0200, Geert Uytterhoeven wrote:
>> Hi Wolfram,
>>
>> On Wed, Sep 14, 2016 at 7:05 PM, Wolfram Sang
>> <wsa+renesas@sang-engineering.com> wrote:
>> > The DTS changes for R-Car Gen3 will come via a seperate series. Note that
>> > 'non-removable' is not supported yet because of Runtime PM issues. It seems we
>> > need to overhaul Runtime PM handling for other reasons as well, so I suggest
>> > the basic support goes in like this and DTS do not use 'non-removable' for now.
>>
>> DT describes the hardware, not current limitations of the software.
>> Hence IMHO you should add the "non-removable" property to the DTS, and
>> work around its non-functioning in software.
>
> @Ulf: Would you accept such a workaround for a while?

With some comments about why, yes!

Br
Uffe

>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index f21c92ec7121cc..5ab8af294f7c40 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1154,6 +1154,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>                                   !mmc_card_is_removable(mmc) ||
>                                   mmc->slot.cd_irq >= 0);
>
> +       /* Workaround for NONREMOVABLE until we fix RuntimePM handling */
> +       if (pdata->flags & TMIO_MMC_MIN_RCAR2)
> +               _host->native_hotplug = true;
> +
>         if (tmio_mmc_clk_enable(_host) < 0) {
>                 mmc->f_max = pdata->hclk;
>                 mmc->f_min = mmc->f_max / 512;
>
