From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: pxamci: fix the device-tree probe deferral path
Date: Thu, 04 Feb 2016 21:28:59 +0100
Message-ID: <87h9ho5ies.fsf@belgarion.home>
References: <1454537992-15839-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFqD+X+2Dt3RT3uhsoXVknOySmjfn-tT9xX4C9QZiXqcrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqD+X+2Dt3RT3uhsoXVknOySmjfn-tT9xX4C9QZiXqcrw@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 4 Feb 2016 12:11:37 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 3 February 2016 at 23:19, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> When the gpio driver is probed after the mmc one, the read/write gpio
>> and card detection one return -EPROBE_DEFER. Unfortunately, the memory
>> region remains requested, and upon the next probe, the probe will fail
>> anyway with -EBUSY.
>>
>> Fix this by releasing the memory resource upon probe failure.
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  drivers/mmc/host/pxamci.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
>> index 28a057fae0a1..405ec339a1b8 100644
>> --- a/drivers/mmc/host/pxamci.c
>> +++ b/drivers/mmc/host/pxamci.c
>> @@ -657,7 +657,7 @@ static int pxamci_probe(struct platform_device *pdev)
>>         if (!r || irq < 0)
>>                 return -ENXIO;
>>
>> -       r = request_mem_region(r->start, SZ_4K, DRIVER_NAME);
>> +       r = devm_request_mem_region(&pdev->dev, r->start, SZ_4K, DRIVER_NAME);
>
> I suggest you replace also the ioremap call, thus using
> devm_ioremap_resource() is convenient.
Yes, of course, for v2.

>> @@ -840,7 +840,6 @@ out:
>>         }
>>         if (mmc)
>>                 mmc_free_host(mmc);
>> -       release_resource(r);
>
> This looks wrong.
Hum. Why so ?

> Perhaps it's just easier to convert the probe function to use all
> devm_* functions, as for example irqs isn't freed either.
You're very right.
Actually the first patch I had was with devm_irq_request(), and then I reverted
that chunk, thinking I was overdoing it, and that this didn't belong to this
commit.
Silly me, hein ?

> In that way, you will solve all problems of also leaking memory in one go.
Sure.

Cheers.

-- 
Robert
