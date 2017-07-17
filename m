From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] mmc: mxcmmc: fix error return code in mxcmci_probe()
Date: Sun, 16 Jul 2017 23:53:22 -0500
Message-ID: <58cd3a01-d2a4-936f-d19e-120f4824e798@embeddedor.com>
References: <20170707055928.GA11041@embeddedgus>
 <CAPDyKFpBf+ryXUTW8xscUvudqvLVgwK4LpURLEhA5ue-UkkSEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpBf+ryXUTW8xscUvudqvLVgwK4LpURLEhA5ue-UkkSEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 07/11/2017 09:43 AM, Ulf Hansson wrote:
> On 7 July 2017 at 07:59, Gustavo A. R. Silva <garsilva@embeddedor.com> wrote:
>> platform_get_irq() returns an error code, but the mxcmmc driver
>> ignores it and always returns -EINVAL. This is not correct,
>> and prevents -EPROBE_DEFER from being propagated properly.
>>
>> Print error message and propagate the return value of
>> platform_get_irq on failure.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Thanks, applied for next!
>

Thank you!

> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/mxcmmc.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>> index fb3ca82..f3c2832 100644
>> --- a/drivers/mmc/host/mxcmmc.c
>> +++ b/drivers/mmc/host/mxcmmc.c
>> @@ -1014,8 +1014,10 @@ static int mxcmci_probe(struct platform_device *pdev)
>>
>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>         irq = platform_get_irq(pdev, 0);
>> -       if (irq < 0)
>> -               return -EINVAL;
>> +       if (irq < 0) {
>> +               dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
>> +               return irq;
>> +       }
>>
>>         mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
>>         if (!mmc)
>> --
>> 2.5.0
>>

-- 
Gustavo A. R. Silva
