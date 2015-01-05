From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: Possible regression with commit 52221610d
Date: Mon, 5 Jan 2015 11:52:25 -0800
Message-ID: <CAJAp7Oi0AyLxy1KFpZ-Cz1-ts9Lh2UaxP3+e6n3EyQjVaEfoXg@mail.gmail.com>
References: <54584260.8030602@nvidia.com>
	<CAD7vxxKb668Y0hpYRhwMjQnNrDCQMzn=XGtLEU+ZAtY=OFjHLg@mail.gmail.com>
	<545895B2.2000101@nvidia.com>
	<CAD7vxxLmLsRpxrYqc30nV0m6atO7jyNgv1Wh4R8GCAy3+y-1dw@mail.gmail.com>
	<CAJAp7OgmrEX1XQcwvwf4jzW3eK9TUgde2MQQOp7fOJzvmO=tCQ@mail.gmail.com>
	<CAD7vxxJaCdKiG9h_32OUSUkQMQk6AAwi6d0v01KEnSVTF8cN1w@mail.gmail.com>
	<CAJAp7Oh+ziadeEDWsus_k_2w33vPJxGGcGZyMNQkpLemf7SAhg@mail.gmail.com>
	<CAJAp7OhWKoAoZfq+zWspLnqUkoJb3izMD41Vyfn0AW4Jni8HAQ@mail.gmail.com>
	<CAD7vxxLe5COSrsnVZ2G_uhtUXfjFnDA45HSG2dNT1LrxcyFcQw@mail.gmail.com>
	<CAJAp7OhAP-rDM2zyo0Yr0-7erUp4ewKJ+tC=vyU-YMP_MzXJbA@mail.gmail.com>
	<CAD7vxxJy2sE1os+ipJZV7_GvEyhu8cE-0QLBS5SVHUqfjkYBwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:65038 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbbAETw1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jan 2015 14:52:27 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so18918265lab.13
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jan 2015 11:52:25 -0800 (PST)
In-Reply-To: <CAD7vxxJy2sE1os+ipJZV7_GvEyhu8cE-0QLBS5SVHUqfjkYBwQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Sachin Kamat <spk.linux@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Sun, Dec 21, 2014 at 7:01 PM, Tim Kryger <tim.kryger@gmail.com> wrote:
> On Wed, Dec 17, 2014 at 11:57 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
[..]
>> Non-the-less, feel free to propose a patch and I will give it a test.
>
> Lets start with the simplest change first.  Please give this a try and
> let me know what you think.
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ada1a3e..59a328a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1239,6 +1239,12 @@ static void sdhci_set_power(struct sdhci_host
> *host, unsigned char mode,
>                 spin_unlock_irq(&host->lock);
>                 mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>                 spin_lock_irq(&host->lock);
> +
> +               if (mode != MMC_POWER_OFF)
> +                       sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> +               else
> +                       sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
>                 return;
>         }
>
>
> Thanks again for your help in getting to the bottom of this.

Sorry for the delay, but

Tested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
