From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/5 RFC] mmc: sdhci-iproc: Actually enable the clock
Date: Wed, 27 Jan 2016 22:11:40 +0100
Message-ID: <CAPDyKFq_=8nKiEse5KAW3FVZBut6mL6Qk6jvFYim9ihxZt5GEA@mail.gmail.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
	<1453042744-16196-3-git-send-email-stefan.wahren@i2se.com>
	<CAPDyKFrCV_GCqCjymsKuOov9GT8gbmb9rBQoJfzmMbMtBnoqWQ@mail.gmail.com>
	<885101040.21976.ad433530-d9a2-4a98-b048-302cf8550d48.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33376 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968011AbcA0VLl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 16:11:41 -0500
Received: by mail-yk0-f173.google.com with SMTP id k129so7380722yke.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 13:11:41 -0800 (PST)
In-Reply-To: <885101040.21976.ad433530-d9a2-4a98-b048-302cf8550d48.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lee Jones <lee@kernel.org>, Ray Jui <rjui@broadcom.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-rpi-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Jon Mason <jonmason@broadcom.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 27 January 2016 at 20:11, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi,
>
>> Ulf Hansson <ulf.hansson@linaro.org> hat am 27. Januar 2016 um 15:16
>> geschrieben:
>>
>>
>> On 17 January 2016 at 15:59, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> > The RPi firmware-based clocks driver can actually disable
>> > unused clocks, so when switching to use it we ended up losing
>> > our MMC clock once all devices were probed.
>> >
>> > This patch adopts the changes from 1e5a0a9a58e2 ("mmc: sdhci-bcm2835:
>> > Actually enable the clock") to sdhci-iproc.
>> >
>> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> > ---
>> > drivers/mmc/host/sdhci-iproc.c | 9 ++++++++-
>> > 1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>> > index e22060a..55bc348 100644
>> > --- a/drivers/mmc/host/sdhci-iproc.c
>> > +++ b/drivers/mmc/host/sdhci-iproc.c
>> > @@ -207,6 +207,11 @@ static int sdhci_iproc_probe(struct platform_device
>> > *pdev)
>> > ret = PTR_ERR(pltfm_host->clk);
>> > goto err;
>> > }
>> > + ret = clk_prepare_enable(pltfm_host->clk);
>> > + if (ret) {
>> > + dev_err(&pdev->dev, "failed to enable host clk\n");
>> > + goto err;
>> > + }
>> >
>> > if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>> > host->caps = iproc_host->data->caps;
>> > @@ -215,10 +220,12 @@ static int sdhci_iproc_probe(struct platform_device
>> > *pdev)
>> >
>> > ret = sdhci_add_host(host);
>> > if (ret)
>> > - goto err;
>> > + goto err_clk;
>> >
>> > return 0;
>> >
>> > +err_clk:
>> > + clk_disable_unprepare(pltfm_host->clk);
>> > err:
>> > sdhci_pltfm_free(pdev);
>> > return ret;
>> > --
>> > 1.7.9.5
>> >
>>
>> There's a missing clk_disable_unprepare() from the ->remove()
>> callback. Otherwise this looks good.
>
> this shouldn't be necessary, because clk_disable_unprepare() is already called
> by sdhci_pltfm_unregister().

Huh. That's yet another strange behaviour of the sdhci core.

So there's no clk enabling done via the registering API, but disabling
is done at unregistering. It's fragile.

That also means there is a clk disable unbalance issue at ->remove()
for sdhci-iproc, right!?

Anyway, the patch is of course correct. Applied for next!

Thanks and kind regards
Uffe
