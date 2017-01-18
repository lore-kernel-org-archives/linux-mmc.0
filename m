From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3] mmc: sdhci-acpi: support deferred probe
Date: Wed, 18 Jan 2017 17:45:21 +0800
Message-ID: <1484732721.2387.22.camel@intel.com>
References: <1484305415.2221.45.camel@intel.com>
         <CAPDyKFq0sVGjaw3E+VQiHckHB6=nCQzGJTOmzhho0byM5AuHrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50817 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbdARJp2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Jan 2017 04:45:28 -0500
In-Reply-To: <CAPDyKFq0sVGjaw3E+VQiHckHB6=nCQzGJTOmzhho0byM5AuHrw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jonas =?ISO-8859-1?Q?=C5berg?= <cja@gmx.net>, darcari@redhat.com, adrain <adrian.hunter@intel.com>

Hi, Uffe,

On Tue, 2017-01-17 at 15:23 +0100, Ulf Hansson wrote:
> On 13 January 2017 at 12:03, Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > From c889f737322b797b743c63eda241d0283696d3f5 Mon Sep 17 00:00:00
> > 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Wed, 7 Dec 2016 13:13:31 +0800
> > Subject: [PATCH v3] mmc: sdhci-acpi: support deferred probe
> > 
> > With commit 67bf5156edc4 ("gpio / ACPI: fix returned error from
> > acpi_dev_gpio_irq_get()"), mmc_gpiod_request_cd() returns
> > -EPROBE_DEFER if
> > GPIO is not ready when sdhci-acpi driver is probed, and sdhci-acpi
> > driver
> > should be probed again later in this case.
> > 
> > This fixes an order issue when both GPIO and sdhci-acpi drivers are
> > built
> > as modules.
> > 
> > CC: stable@vger.kernel.org # v4.9
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177101
> > Tested-by: Jonas Aaberg <cja@gmx.net>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> I strongly encourage you to run checkpatch of all your change before
> submitting patches.
>  Below is the output, it gave me. It prevents me
> from applying the change. Please fix and re-spin!
> 
Sorry for bring the trouble.
In fact, I indeed run checkpatch before sending it out.

> ERROR: Please use git commit description style 'commit <12+ chars of
> sha1> ("<title line>")' - ie: 'commit fatal: bad o
> ("da241d0283696d3f5")'
> #14:
> > 
> > From c889f737322b797b743c63eda241d0283696d3f5 Mon Sep 17 00:00:00
> > 2001
> ERROR: patch seems to be corrupt (line wrapped?)
> #49: FILE: drivers/mmc/host/sdhci-acpi.c:465:
>      if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
> 
> total: 2 errors, 0 warnings, 11 lines checked
> 
I tried to resend the patch to myself, and find out the patch is
corrupted when it's sent via evolution. Although I have not used
evolution to send patch for a long time, but it indeed works for me
before.

Patch resent. Sorry again for the noise.

thanks,
rui

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
> > index 160f695cc09c..5440323894ee 100644
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
