From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 05/13] power: pwrseq: Remove mmc prefix from mmc_pwrseq
Date: Fri, 06 May 2016 08:20:15 +0200
Message-ID: <572C379F.6030504@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-6-git-send-email-k.kozlowski@samsung.com>
 <48539995-2966-0df0-51db-e0c549a92880@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:22912 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcEFGUV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2016 02:20:21 -0400
In-reply-to: <48539995-2966-0df0-51db-e0c549a92880@osg.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 05/05/2016 09:09 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> The "mmc" prefix is no longer needed after moving the pwrseq core code
>> from mmc/ to power/.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [snip]
> 
>> diff --git a/drivers/power/pwrseq/pwrseq_emmc.c b/drivers/power/pwrseq/pwrseq_emmc.c
>> index a0583ed46d7f..a68ac9a68e04 100644
>> --- a/drivers/power/pwrseq/pwrseq_emmc.c
>> +++ b/drivers/power/pwrseq/pwrseq_emmc.c
>> @@ -22,7 +22,7 @@
>>  #include <linux/mmc/host.h>
>>
> 
> I don't think this header inclusion is needed. At least I didn't see anything
> defined there that's used in this driver. This also applies to pwrseq_simple.
> 
> I think you could remove those in another preparatory patches before the move.
>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Good catch, thanks.

BR,
Krzysztof


