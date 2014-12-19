From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc: mmci: Use pm_runtime_put_noidle() during ->probe()
Date: Fri, 19 Dec 2014 12:29:55 +0100
Message-ID: <CAPDyKFq21+qScnfZmjE_h5BchTVM-LTe49a+qO+k2-+kdt-jXw@mail.gmail.com>
References: <1418986459-13443-1-git-send-email-ulf.hansson@linaro.org>
	<20141219105922.GF11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:59008 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbaLSL3z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 06:29:55 -0500
Received: by mail-qg0-f48.google.com with SMTP id f51so482377qge.21
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 03:29:55 -0800 (PST)
In-Reply-To: <20141219105922.GF11285@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 19 December 2014 at 11:59, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 19, 2014 at 11:54:19AM +0100, Ulf Hansson wrote:
>> Previously the pm_runtime_put() caused the device to be runtime PM
>> suspended, but then immediately being resumed when we add the host.
>>
>> Prevent this unnecessary runtime PM suspend/resume cycle during
>> ->probe() by using the pm_runtime_put_noidle() variant instead.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Changes in v2:
>>       Move pm_runtime_put_noidle() after mmc_add_host().
>>
>> ---
>>  drivers/mmc/host/mmci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 8232e9a..d2bbd25 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1739,10 +1739,10 @@ static int mmci_probe(struct amba_device *dev,
>>
>>       pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>>       pm_runtime_use_autosuspend(&dev->dev);
>> -     pm_runtime_put(&dev->dev);
>>
>>       mmc_add_host(mmc);
>>
>> +     pm_runtime_put_noidle(&dev->dev);
>
> I think you'd want this to be _put() in this case.

It doesn't matter which variant of _put*(). The driver core will
invoke pm_request_idle() after really_probe() is done.

Kind regards
Uffe
