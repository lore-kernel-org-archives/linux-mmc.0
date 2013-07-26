From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 01/12] mmc: mmc_spi: Support CD/RO GPIOs
Date: Fri, 26 Jul 2013 10:23:01 +1000
Message-ID: <51F1C165.6040600@gmail.com>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1374794808-21890-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51F1B896.8020005@gmail.com> <3057612.zXvbbdByqU@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3057612.zXvbbdByqU@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On 26/07/13 10:04, Laurent Pinchart wrote:
> Hi Ryan,
> 
> On Friday 26 July 2013 09:45:26 Ryan Mallon wrote:
>> On 26/07/13 09:26, Laurent Pinchart wrote:
>>> Add support for passing CD/RO GPIO numbers directly to the mmc_spi
>>> driver instead of relying solely on board code callbacks to retrieve the
>>> CD/RO signals values.
>>>
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>>
>>>  drivers/mmc/host/mmc_spi.c    | 32 +++++++++++++++++++++---------
>>>  drivers/mmc/host/of_mmc_spi.c | 46 ++++++++++----------------------------
>>>  include/linux/spi/mmc_spi.h   | 11 +++++++++++
>>>  3 files changed, 46 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
>>> index 74145d1..4e83908 100644
>>> --- a/drivers/mmc/host/mmc_spi.c
>>> +++ b/drivers/mmc/host/mmc_spi.c
>>> @@ -36,6 +36,7 @@
>>>
>>>  #include <linux/mmc/host.h>
>>>  #include <linux/mmc/mmc.h>		/* for R1_SPI_* bit values */
>>> +#include <linux/mmc/slot-gpio.h>
>>>  #include <linux/spi/spi.h>
>>>  #include <linux/spi/mmc_spi.h>
>>>
>>> @@ -1278,11 +1279,8 @@ static int mmc_spi_get_ro(struct mmc_host *mmc)
>>>  	if (host->pdata && host->pdata->get_ro)
>>>  		return !!host->pdata->get_ro(mmc->parent);
>>>
>>> -	/*
>>> -	 * Board doesn't support read only detection; let the mmc core
>>> -	 * decide what to do.
>>> -	 */
>>> -	return -ENOSYS;
>>> +	else
>>> +		return mmc_gpio_get_ro(mmc);
>>
>> Why not just have the board file assign mmc_gpio_get_ro as
>> host->pdata->get_ro? This would eliminate the need for the
>> MMC_SPI_USE_RO_GPIO flag.
> 
> Because the idea is to get rid of board callbacks and rely on proper kernel 
> abstraction layers such as the GPIO subsystem. This will be especially 
> important when adding device tree support to the mmc_spi driver.
> 
>> Also, if host->pdata->get_ro is not set then this will assume
>> mmc_gpio_get_ro is valid, even if MMC_SPI_USE_RO_GPIO is not set. I'm
>> guessing it will end up returning -ENOSYS, but they way the code reads is
>> that if the host doesn't have get_ro function set, then it is must be a
>> gpio.
> 
> mmc_gpio_get_ro() will indeed return -ENOSYS when the MMC_SPI_USE_RO_GPIO flag 
> isn't set, as the mmc_spi driver will not call mmc_gpio_request_ro() in that 
> case.
> 
> This patch hides the -ENOSYS value from the mmc_spi_get_ro() and 
> mmc_spi_get_cd() functions, perhaps making them slightly confusing, but patch 
> 06/12 then gets rid of those functions, so I don't think it's a bit issue.

Ah, I didn't read far enough along in the patch series :-). So all mmc
spi ro/cd controls are now assumed to be gpios?

~Ryan




