From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5] mmc: sdhci-s3c: Add device tree support
Date: Tue, 18 Sep 2012 13:09:05 +0900
Message-ID: <5057F3E1.4040905@samsung.com>
References: <1345741809-18599-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwRz8mBXefLsuM9D47KxS2iqK6x6YWtjaaEwro7dq5C0_A@mail.gmail.com>
 <m3lig8kmzl.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55121 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab2IREJY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 00:09:24 -0400
In-reply-to: <m3lig8kmzl.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, wmb@firmworks.com, patches@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

On 09/18/2012 12:50 PM, Chris Ball wrote:
> Hi,
> 
> On Mon, Sep 17 2012, Thomas Abraham wrote:
>> On 23 August 2012 22:40, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>>> Add device tree based discovery support for Samsung's sdhci controller
>>>
>>> Cc: Ben Dooks <ben-linux@fluff.org>
>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Chris Ball <cjb@laptop.org>
>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>> ---
>>> Changes since v4:
>>> Adapted to new mmc core card detection bindings as specfied in the patch:
>>> [PATCH] mmc: dt: Add card-detection properties to core binding
>>> and extends it "samsung,cd-pinmux-gpio" property as suggested by
>>> Mitch Bradley <wmb@firmworks.com>
>>>
>>> Changes since v3:
>>>
>>> The patch series that adds device tree support for Samsung sdhci controller
>>> had six patches in total, of which, the first five patches have been accepted.
>>> The sixth patch in the series was dropped since it was using custom Samsung
>>> properties for descrbing the bus-width and card-detect gpio, but had otherwise
>>> addressed all the comments.
>>>
>>> This patch reworks the sixth patch in v3 of the sdhci device tree support
>>> patch series. The only change in this patch from the v3 version is the use of
>>> generic mmc bindings for descrbing the bus-width and card-detect gpio.
>>>
>>>  .../devicetree/bindings/mmc/samsung-sdhci.txt      |   53 +++++++
>>>  drivers/mmc/host/sdhci-s3c.c                       |  162 +++++++++++++++++++-
>>>  2 files changed, 209 insertions(+), 6 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>>
>> Hi Chris,
>>
>> This patch adds device tree support for sdhci-s3c driver. All the
>> comments for this patch has been addressed. Can this be queued for
>> v3.7?
> 
> Yes, sounds good.  Jaehoon, perhaps you could give your Reviewed-by
> for me to add to the patch?  I've pushed this to mmc-next for 3.7
> now, after adding Jaehoon's else-if suggestion that wasn't acted on:
Right, I suggested them. thanks Chris. Looks good to me this patch except for them.

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 3d91c7a..0c77b10 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -461,22 +461,18 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
>  	if (gpio_is_valid(gpio)) {
>  		pdata->cd_type = S3C_SDHCI_CD_GPIO;
>  		goto found_cd;
> -	} else {
> -		if (gpio != -ENOENT) {
> -			dev_err(dev, "invalid card detect gpio specified\n");
> -			return -EINVAL;
> -		}
> +	} else if (gpio != -ENOENT) {
> +		dev_err(dev, "invalid card detect gpio specified\n");
> +		return -EINVAL;
>  	}
>  
>  	gpio = of_get_named_gpio(node, "samsung,cd-pinmux-gpio", 0);
>  	if (gpio_is_valid(gpio)) {
>  		pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
>  		goto found_cd;
> -	} else {
> -		if (gpio != -ENOENT) {
> -			dev_err(dev, "invalid card detect gpio specified\n");
> -			return -EINVAL;
> -		}
> +	} else if (gpio != -ENOENT) {
> +		dev_err(dev, "invalid card detect gpio specified\n");
> +		return -EINVAL;
>  	}
>  
>  	dev_info(dev, "assuming no card detect line available\n");
> 
> Thanks,
> 
> - Chris.
> 

