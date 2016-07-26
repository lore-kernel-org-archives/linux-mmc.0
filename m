From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: avoid unused function warnings
Date: Wed, 27 Jul 2016 00:48:23 +0200
Message-ID: <CAPDyKFrQuqCV_7LLm=ueJkj0wa9SCtoaGEJnivoXQ4hfrv-1OA@mail.gmail.com>
References: <20160726123246.879426-1-arnd@arndb.de> <CAPDyKFoZs8DRuj2Hu_rY1iV4wKMrn6VHYeGLKmkYrMW1hfhniA@mail.gmail.com>
 <19008164.GYnbEcydYS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19008164.GYnbEcydYS@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 26 July 2016 at 22:56, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, July 26, 2016 10:18:53 PM CEST Ulf Hansson wrote:
>> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > index 2bb326bbc34a..593e34053c4b 100644
>> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > @@ -1293,13 +1293,12 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>> >         return 0;
>> >  }
>> >
>> > -#ifdef CONFIG_PM
>> > -static int sdhci_esdhc_suspend(struct device *dev)
>> > +static int __maybe_unused sdhci_esdhc_suspend(struct device *dev)
>>
>> Instead of using __maybe_unused, I prefer to change above "#ifdef
>> CONFIG_PMf" to "#ifdef CONFIG_PM_SLEEP".
>> I do realize that the runtime PM callbacks still requires #ifdef
>> CONFIG_PM, so yes that's requires an extra "ifdef".
>>
>> Sure, it's more a matter of taste (and micro optimizations).
>
> I was hoping that we could eventually do a mass-conversion to
> __maybe_unused, as everybody seems to get the #ifdef wrong.
>
> Any specific reason for your preference?

Only that this is how I get used to do it - and that it becomes a bit
more clear what is needed to support the various PM configurations.

If you still insist on the "maybe_unused" option, that's okay as well.

Kind regards
Uffe
