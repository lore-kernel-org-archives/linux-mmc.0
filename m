From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Wed, 11 May 2011 15:08:53 +0200
Message-ID: <20110511130852.GB12469@opensource.wolfsonmicro.com>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
	<1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1305110379-17218-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 11, 2011 at 12:39:39PM +0200, Antonio Ospite wrote:
> Add support for powering up SD cards driven by regulators.
> This makes the mmc_spi driver work also with the Motorola A910 phone.
> 
> Signed-off-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>

Reviwed-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

but

> +	switch (power_mode) {
> +	case MMC_POWER_OFF:
> +		if (host->vcc) {
> +			int ret = mmc_regulator_set_ocr(host->mmc,
> +							host->vcc, 0);
> +			if (ret)
> +				return ret;
> +		} else {
> +			host->pdata->setpower(&host->spi->dev, vdd);
> +		}
> +		break;
> +
> +	case MMC_POWER_UP:
> +		if (host->vcc) {
> +			int ret = mmc_regulator_set_ocr(host->mmc,
> +							host->vcc, vdd);
> +			if (ret)
> +				return ret;
> +		} else {
>  			host->pdata->setpower(&host->spi->dev, vdd);
> -			if (power_mode == MMC_POWER_UP)
> -				msleep(host->powerup_msecs);
>  		}
> +		msleep(host->powerup_msecs);
> +		break;

This stuff all looks like it should be factored out.

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
