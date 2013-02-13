From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/3 RESEND] mmc: sdhci: check voltage range only on
 regulators aware of voltage value
Date: Wed, 13 Feb 2013 08:33:12 +0100
Message-ID: <511B41B8.3060506@samsung.com>
References: <87bobqrcb4.fsf@octavius.laptop.org>
 <1360656096-1671-1-git-send-email-m.szyprowski@samsung.com>
 <Pine.LNX.4.64.1302122309470.14434@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:23840 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3BMHdV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Feb 2013 02:33:21 -0500
In-reply-to: <Pine.LNX.4.64.1302122309470.14434@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

Hello,

On 2/12/2013 11:10 PM, Guennadi Liakhovetski wrote:
> Hi Marek
>
> On Tue, 12 Feb 2013, Marek Szyprowski wrote:
>
> > Some regulators don't report any voltage values, so checking supported
> > voltage range results in disabling all SDHCI_CAN_VDD_* flags and
> > registration failure. This patch finally provides a correct fix for the
> > registration of SDHCI driver with all possible voltage regulators:
> > dummy, fixed and regulated without using regulator_count_voltages()
> > hacks.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index ba586ae..735526b 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2976,7 +2976,11 @@ int sdhci_add_host(struct sdhci_host *host)
> >  	}
> >
> >  #ifdef CONFIG_REGULATOR
> > -	if (host->vmmc) {
> > +	/*
> > +	 * Voltage range check makes sense only if regulator reports
> > +	 * any voltage value.
> > +	 */
> > +	if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
> >  		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
> >  			3600000);
>
> Wouldn't using mmc_regulator_get_ocrmask() be a better option?

The idea behind this patch it to avoid messing ocr mask and voltage
regulators when voltage regulator is a simple on/off switch, which doesn't
report any value. This solves the serious problems with sdhci driver when
dummy regulator is enabled in kconfig, otherwise the sdhci driver
concludes that no supported voltage is available and fails to initialize.
Using mmc_regulator_get_ocrmask() won't solve this problem.

BTW, mmc_regulator_get_ocrmask() won't work with continuous range 
regulators.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
  


