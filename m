From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v2 2/7] mmc: sdhci-pxav3: binding: Add pxa1928 compatible
 support
Date: Wed, 9 Sep 2015 16:34:59 +0530
Message-ID: <55F0125B.6040500@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-3-git-send-email-vaibhav.hiremath@linaro.org>
 <55EF740A.1020204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55EF740A.1020204-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On Wednesday 09 September 2015 05:19 AM, Rob Herring wrote:
> On 09/07/2015 06:18 AM, Vaibhav Hiremath wrote:
>> With support for pxa1928 family of devices , this patch
>> updates the binding document with compatible property
>> of "marvell,pxav3-1928-sdhci".
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-pxa.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
>> index 3d1b449..29edcf5 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
>> @@ -5,7 +5,7 @@ and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
>>
>>   Required properties:
>>   - compatible: Should be "mrvl,pxav2-mmc", "mrvl,pxav3-mmc" or
>> -  "marvell,armada-380-sdhci".
>> +  "marvell,armada-380-sdhci" or "marvell,pxav3-1928-sdhci".
>
> v3 is implied by pxa1928. So I'd just do "marvell,pxa1928-sdhci" to
> better match the chip name.
>

Ok, No issues.

I followed the existing "armada-380-sdhci" naming style.
Will correct it in next version.


Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
