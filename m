From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH v2 2/2] mmc, sdhci, bcm-kona, LLVMLinux: Remove use of
 __initconst
Date: Wed, 24 Sep 2014 11:21:16 -0700
Message-ID: <54230B9C.9090703@converseincode.com>
References: <20140923212922.GG12270@beef> <1411512908-19237-1-git-send-email-behanw@converseincode.com> <1411512908-19237-2-git-send-email-behanw@converseincode.com> <5774775.2EcFmuR4sV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5774775.2EcFmuR4sV@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: bcm@fixthebug.org, chris@printf.net, gnurou@gmail.com, linus.walleij@linaro.org, mporter@linaro.org, ulf.hansson@linaro.org, bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rjui@broadcom.comlinus.walleij@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 09/24/14 02:22, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 15:55:08 behanw@converseincode.com wrote:
>> --- a/drivers/mmc/host/sdhci-bcm-kona.c
>> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
>> @@ -225,7 +225,7 @@ static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
>>                  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>   };
>>   
>> -static struct __initconst of_device_id sdhci_bcm_kona_of_match[] = {
>> +static struct of_device_id const sdhci_bcm_kona_of_match[] = {
>>          { .compatible = "brcm,kona-sdhci"},
>>          { .compatible = "bcm,kona-sdhci"}, /* deprecated name */
>>          {}
>>
> Sorry for giving you trouble over such a simple patch (especially
> one that I have acked already), but I just noticed that this is
> not following the common style we use in the kernel.
It's all good. It's not like you haven't saved me a tonne of time 
already! :)

> Almost everywhere in Linux, we use
>
> static const struct of_device_id sdhci_bcm_kona_of_match[] = {
>
> not
>
> static struct of_device_id const sdhci_bcm_kona_of_match[] = {
True enough. I put the const where I did to be in keeping with the 
intent of __initconst, making the array const instead of the contained type.

> AFAICT they behave in identical ways,
Indeed. For C in both cases the resulting array of struct of_device_id 
ends up in .rodata, so functionally equivalent.

>   but the first one seems
> easier to read for someone familiar with kernel code.
No worries. Happy to post a v3.

Linus Walleij: Would you like me to respin the "gpio, bcm-kona, 
LLVMLinux: Remove use of __initconst" patch as well?

Behan

-- 
Behan Webster
behanw@converseincode.com
