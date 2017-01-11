From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] sdhci-acpi: support deferred probe
Date: Wed, 11 Jan 2017 08:58:56 +0800
Message-ID: <1484096336.2253.4.camel@intel.com>
References: <1482719296-4783-1-git-send-email-rui.zhang@intel.com>
         <CAPDyKFo5jcv+YathFEG86fAPt=nH42Z35LjztDV0ozFNY8d48Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755619AbdAKA7E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Jan 2017 19:59:04 -0500
In-Reply-To: <CAPDyKFo5jcv+YathFEG86fAPt=nH42Z35LjztDV0ozFNY8d48Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, cja@gmx.net, darcari@redhat.com

On Tue, 2017-01-10 at 16:38 +0100, Ulf Hansson wrote:
> On 26 December 2016 at 03:28, Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > With commit
> > 67bf5156edc4 (gpio / ACPI: fix returned error from
> > acpi_dev_gpio_irq_get()),
> > mmc_gpiod_request_cd() returns -EPROBE_DEFER if GPIO is not ready
> > when sdhci-acpi driver is probed, and sdhci-acpi driver should be
> > probed
> > again later in this case.
> > 
> > This fixes an order issue when both GPIO and sdhci-acpi drivers are
> > built as
> > modules.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177101
> > Tested-by: Jonas Aaberg <cja@gmx.net>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Seems like both a fixes tag and a stable tag would we useful.
> 
The order issue always exists.
And commit 67bf5156edc4 just makes it possible to fix it in this way.
I can cc stable 4.9 as it depends on 67bf5156edc4, but I don't think
this needs a fixes tag.

thanks,
rui
> Please re-spin and make also the changes that Adrian proposed to the
> change log.
> 
> Kind regards
> Uffe
> 
> > 
> > ---
> >  drivers/mmc/host/sdhci-acpi.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-acpi.c
> > b/drivers/mmc/host/sdhci-acpi.c
> > index 160f695..5440323 100644
> > --- a/drivers/mmc/host/sdhci-acpi.c
> > +++ b/drivers/mmc/host/sdhci-acpi.c
> > @@ -466,7 +466,10 @@ static int sdhci_acpi_probe(struct
> > platform_device *pdev)
> >         if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
> >                 bool v = sdhci_acpi_flag(c,
> > SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
> > 
> > -               if (mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0,
> > NULL)) {
> > +               err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v,
> > 0, NULL);
> > +               if (err) {
> > +                       if (err == -EPROBE_DEFER)
> > +                               goto err_free;
> >                         dev_warn(dev, "failed to setup card detect
> > gpio\n");
> >                         c->use_runtime_pm = false;
> >                 }
> > --
> > 2.7.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
