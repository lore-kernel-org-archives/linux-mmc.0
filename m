From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Thu, 21 Apr 2016 09:53:42 +0200
Message-ID: <4129305.Ka9B8YpEaI@wuerfel>
References: <cover.1461163234.git.larper@axis.com> <92b72ede5f8ddf2b2f74cdb7422bc8ef5458b23c.1461163234.git.larper@axis.com> <57187D74.8090601@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:64768 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbcDUHx7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 03:53:59 -0400
In-Reply-To: <57187D74.8090601@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: Lars Persson <larper@axis.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

On Thursday 21 April 2016 09:12:52 Lars Persson wrote:
> On 04/20/2016 04:53 PM, Lars Persson wrote:
> > Add a start_signal_voltage_switch() operation to support enabling of
> > UHS modes.
> >
> > Signed-off-by: Lars Persson <larper@axis.com>
> > ---
> >   drivers/mmc/host/usdhi6rol0.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> > index 807c06e..2585ea4 100644
> > --- a/drivers/mmc/host/usdhi6rol0.c
> > +++ b/drivers/mmc/host/usdhi6rol0.c
> > @@ -1147,12 +1147,25 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
> >       }
> >   }
> >
> > +static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     int ret;
> > +
> 
> To support boards without regulator we need to put a 
> IS_ERR_OR_NULL(mmc->supply.vqmmc) check here and bail out with return 0. 
> Missing vqmmc is OK according to our binding document, but treated as an 
> error by mmc_regulator_set_vqmmc().

mmc_regulator_set_vqmmc() should already take care of handling
all the those cases. In general, it's almost always a bug to use
IS_ERR_OR_NULL(): if you ever feel the need to use it, you should
either fix the code that made the pointer ambiguous or you have
misunderstood the interface.

	Arnd
