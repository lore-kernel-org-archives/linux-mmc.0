From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
Date: Thu, 14 Jan 2016 18:09:10 +0530
Message-ID: <569796EE.7030506@ti.com>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41336 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcANMkC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2016 07:40:02 -0500
In-Reply-To: <20160114120706.GA12774@earth>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pali.rohar@gmail.com, pavel@ucw.cz, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, nsekhar@ti.com

Hi,

On Thursday 14 January 2016 05:37 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 14, 2016 at 02:45:20PM +0530, Kishon Vijay Abraham I wrote:
>> Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
>> have PBIAS regulator) in order for MMC1 to work.
>>
>> Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
>> using a olddefconfig or a custom .config.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 7fb0753..7086bd6 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>  	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
>>  	if (IS_ERR(host->pbias)) {
>>  		ret = PTR_ERR(host->pbias);
>> -		if ((ret != -ENODEV) && host->dev->of_node)
>> +		if ((ret != -ENODEV) && host->dev->of_node) {
>> +			dev_err(host->dev,
>> +			"SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
>>  			return ret;
>> +		}
>>  		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
>>  			PTR_ERR(host->pbias));
>>  		host->pbias = NULL;
> 
> 
> Is there a good reason against adding "depends on REGULATOR_PBIAS"
> to MMC_OMAP_HS? I guess it's required for most systems and the regulator
> driver is just 250 loc. I am aware, that this will disable the
> hsmmc driver for 'make oldconfig', but I guess that will be noticed
> in a similar way your warning is noticed.

hmm.. only MMC1 requires PBIAS so I'm not sure if it's okay to add depends on
REGULATOR_PBIAS for the HSMMC driver as such. And as you said it'll also
disable the hsmmc driver if oldconfig is used. But do we get a warning?

Thanks
Kishon
