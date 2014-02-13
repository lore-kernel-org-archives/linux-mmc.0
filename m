From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [RFT][PATCH v3] mmc: change cb710-mmc platform power management to
 use dev_pm_ops
Date: Thu, 13 Feb 2014 06:49:33 -0700
Message-ID: <52FCCD6D.6020704@samsung.com>
References: <1392240089-19489-1-git-send-email-shuah.kh@samsung.com>
 <CAPDyKFoukY2PGNWimUbRqDr36eJ_+eBASJR4uac6nH4-kowmCQ@mail.gmail.com>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <CAPDyKFoukY2PGNWimUbRqDr36eJ_+eBASJR4uac6nH4-kowmCQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, mirq-linux@rere.qmqm.pl, Chris Ball <chris@printf.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Shuah Khan <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 02/13/2014 02:47 AM, Ulf Hansson wrote:
> On 12 February 2014 22:21, Shuah Khan <shuah.kh@samsung.com> wrote:
>> Change cb710-mmc platform driver to register pm ops using dev_pm_ops instead
>> of legacy pm_ops. The existing legacy suspend/resume routines are identical
>> and simply clear IRQ mask in the device in case it got undefined during sleep
>> state. Changed code to collapse suspend and resume into one .pm interface
>> for suspend and resume which gets installed for suspend, freeze, poweroff,
>> thaw, restore, and resume states using SIMPLE_DEV_PM_OPS().
>>
>> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
>> ---
>>
>> patch v3: Addresses review comments on patch v2
>>
>>   drivers/mmc/host/cb710-mmc.c |   40 ++++++++++++++++------------------------
>>   1 file changed, 16 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
>> index 1087b4c..2dc7b2dc 100644
>> --- a/drivers/mmc/host/cb710-mmc.c
>> +++ b/drivers/mmc/host/cb710-mmc.c
>> @@ -662,26 +662,6 @@ static const struct mmc_host_ops cb710_mmc_host = {
>>          .get_cd = cb710_mmc_get_cd,
>>   };
>>
>> -#ifdef CONFIG_PM
>> -
>> -static int cb710_mmc_suspend(struct platform_device *pdev, pm_message_t state)
>> -{
>> -       struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
>> -
>> -       cb710_mmc_enable_irq(slot, 0, ~0);
>> -       return 0;
>> -}
>> -
>> -static int cb710_mmc_resume(struct platform_device *pdev)
>> -{
>> -       struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
>> -
>> -       cb710_mmc_enable_irq(slot, 0, ~0);
>> -       return 0;
>> -}
>> -
>> -#endif /* CONFIG_PM */
>> -
>>   static int cb710_mmc_init(struct platform_device *pdev)
>>   {
>>          struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
>> @@ -762,14 +742,26 @@ static int cb710_mmc_exit(struct platform_device *pdev)
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int cb710_mmc_suspend_resume(struct device *dev)
>> +{
>> +       struct cb710_slot *slot = cb710_pdev_to_slot(to_platform_device(dev));
>> +
>> +       cb710_mmc_enable_irq(slot, 0, ~0);
>> +       return 0;
>> +}
>> +#else
>> +#define cb710_mmc_suspend_resume NULL
>
> You don't need this. The macro will handle this for you.
>

Without this compiles fail when CONFIG_PM_SLEEP is not defined.

-- Shuah


-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
