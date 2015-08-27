From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] pwrseq: bind pinctrl pins before using the gpios
Date: Thu, 27 Aug 2015 10:48:58 +0200
Message-ID: <CAPDyKFpZaeBbfN05HoHGafbkEJ1k6ZCNn+o5w6HKUzJ7Q0irPg@mail.gmail.com>
References: <1439812687-18259-1-git-send-email-srinivas.kandagatla@linaro.org>
	<CAPDyKFqMOr5DwDcOjDTUV4Eaqp4VK1Q-Dt2_KcG-GtsNOr8JkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqMOr5DwDcOjDTUV4Eaqp4VK1Q-Dt2_KcG-GtsNOr8JkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-mmc@vger.kernel.org

+ Stephen Rothwell

On 25 August 2015 at 14:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 17 August 2015 at 13:58, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Some of the pin-controllers like the Qualcomms "qcom,pm8921", which
>> require a pinconf to be setup to use pins as gpios. Using the pins
>> directly without pinconf setup would result in incorrect output voltage
>> or load settings. On the other hand pwrseq code does not configure the
>> pinctrl by default as it does not go thru the driver core.
>>
>> This patch adds a call to pinctrl_bind_pins() to bind pins which
>> are going to be used as gpios.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Thanks, applied for next! I add the "mmc:" to the prefix of the commit
> message header.

This went in too quickly, my bad!

The kbuild test robot reports an error when building i386 with
allmodconfig, so I will drop this patch from my next branch.
https://lists.01.org/pipermail/kbuild-all/2015-August/011806.html

Moreover I have some more comment around the patch, see below.

>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/core/pwrseq.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
>> index 4c1d175..6e5d8b3 100644
>> --- a/drivers/mmc/core/pwrseq.c
>> +++ b/drivers/mmc/core/pwrseq.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/err.h>
>>  #include <linux/of.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/pinctrl/devinfo.h>
>>
>>  #include <linux/mmc/host.h>
>>
>> @@ -65,6 +66,10 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>>                 goto err;
>>         }
>>
>> +       ret = pinctrl_bind_pins(&pdev->dev);

pinctrl_bind_bins() uses devm_* functions and that's not going to work
as the used device here isn't being probed/released.

Instead you need to use the *non* devm_pinctrl_*() APIs, such as
pinctrl_get|put() etc.

>> +       if (ret)
>> +               goto err;
>> +
>>         match = mmc_pwrseq_find(np);
>>         if (IS_ERR(match)) {
>>                 ret = PTR_ERR(match);
>> --
>> 1.9.1
>>

Kind regards
Uffe
