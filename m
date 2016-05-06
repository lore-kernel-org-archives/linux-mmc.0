From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 09/13] power: pwrseq: Add support for USB hubs with
 external power
Date: Fri, 06 May 2016 08:26:28 +0200
Message-ID: <572C3914.4040708@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-10-git-send-email-k.kozlowski@samsung.com>
 <3bdf7888-5ed1-2a55-6607-ee8be70e25e7@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <3bdf7888-5ed1-2a55-6607-ee8be70e25e7@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 05/05/2016 09:52 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> Some USB devices on embedded boards have external power supply which has
>> to be reset in certain conditions. Add pwrseq interface for this.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/power/pwrseq/pwrseq.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pwrseq.h        |  8 ++++++++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
>> index 495a19d3c30b..306265f55a10 100644
>> --- a/drivers/power/pwrseq/pwrseq.c
>> +++ b/drivers/power/pwrseq/pwrseq.c
>> @@ -52,6 +52,43 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>>  }
>>  EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
>>  
>> +struct pwrseq *pwrseq_alloc(struct device *dev)
>> +{
> 
> This function is USB specific so better to call it usb_pwrseq_alloc() instead.

Indeed it is parsing USB specific bindings so such prefix is needed.

> Although, this function has a lot of duplicated code from mmc_pwrseq_alloc()
> so I think is better to keep the name generic and factorize the common code.
> 
> I expect other devices are also needing some kind of power seq in the future
> so having a single alloc function instead of each for device type makes sense.

Yes, this can be cleaned up and unified.

> 
>> +	struct device_node *np;
>> +	struct pwrseq *p, *ret = NULL;
>> +
>> +	np = of_parse_phandle(dev->of_node, "usb-pwrseq", 0);
> 
> I know this is just an RFC but you should really add DT bindings for this.

Yep, next step.

Best regards,
Krzysztof

