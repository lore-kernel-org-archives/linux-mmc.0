From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH V2] mmc: omap_hsmmc: Fix sleep too long in ISR context.
Date: Wed, 21 Aug 2013 22:44:06 +0530
Message-ID: <5214F55E.6020408@ti.com>
References: <201308071805022428282@gmail.com> <5213BAD0.8030406@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <5213BAD0.8030406@yahoo.es>
Sender: linux-omap-owner@vger.kernel.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: cjb <cjb@laptop.org>, Felipe Balbi <balbi@ti.com>, majianpeng <majianpeng@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, mayuzheng <mayuzheng@kedacom.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 21 August 2013 12:22 AM, Hein Tibosch wrote:
> Hi,
>
> [ added some people from TI ]
>
> On 8/7/2013 6:05 PM, majianpeng wrote:
>> V2:
>> 	clean up code.
>> V1:
>> 	www.mail-archive.com/linux-omap@vger.../msg93239.html=E2=80=8E
>>
>>
>> We found a problem when we removed a working sd card that the irqact=
ion
>> of omap_hsmmc can sleep to 3.6s. This cause our watchdog to work.
>> In func omap_hsmmc_reset_controller_fsm, it should watch a 0->1
>> transition.But avoiding endless waiting, it used loops_per_jiffy as =
the timer.
>
> Tried on a OMAP4460:
> This can easily be replicated: just withdraw an SD-card and the kerne=
l
> will get blocked during more than 3 seconds.
> Calling OMAP_HSMMC_READ() in this loop makes it last so long.
>
> The function waits for a 0=3D>1, followed by a 1=3D>0 transition.
> The value of 1 always comes, but in most cases the code is just too
> slow to detect it. The first loop will only stop when (i =3D=3D limit=
)
>
>> The code is:
>>> while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>>>                 && (i++ < limit))
>>>                         cpu_relax();
>> But generanly loops_per_jiffy as a timer,it should like:
>>>   while(i++ < limit)
>>> cpu_relax();
>> I found for the long time case, the while-opeation stoped because 'i=
 =3D=3D limit'.
>> Because added some code, so the duration became too longer than
>> MMC_TIMEOU_US(20ms).
>>
>> The software can't monitor the transition of hardware for thi case.
>>
>> Becasue those codes in ISR context, it can't use timer_before/after.
>> I divived the time into 1ms and used udelay(1) to instead.
>> It will cause do additional udelay(1).But from my test,it looks good=
=2E
>>
>> Reported-by: Yuzheng Ma <mayuzheng@kedacom.com>
>> Tested-by: Yuzheng Ma <mayuzheng@kedacom.com>
>> Reviewed-by: Hein Tibosch <hein_tibosch@yahoo.es>
>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c | 25 +++++++++++--------------
>>   1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 1865321..bbda5ed 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -973,9 +973,8 @@ static inline void omap_hsmmc_dbg_report_irq(str=
uct omap_hsmmc_host *host,
>>   static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsm=
mc_host *host,
>>   						   unsigned long bit)
>>   {
>> -	unsigned long i =3D 0;
>> -	unsigned long limit =3D (loops_per_jiffy *
>> -				msecs_to_jiffies(MMC_TIMEOUT_MS));
>> +	/*change to 1ms,so we can use udelay(1)*/
>> +	unsigned long limit =3D MMC_TIMEOUT_MS * 1000;
>>
>>   	OMAP_HSMMC_WRITE(host->base, SYSCTL,
>>   			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
>
> Checked here: the SRC-bit indeed becomes high.
> After the test 'features & HSMMC_HAS_UPDATED_RESET', the bit has
> become low again already.
> Changing to order of statements worked for me, but for Jianpeng Ma
> this didn't work (timings are 'on the edge').

I think 1->0 transition is missed sometimes and waiting until timeout,
Jianpeng Ma, which SoC are you testing ?

>
> This reset function is also called while mounting a card and then 'SR=
C'
> will be high long enough (more than 100 loops). It is after withdrawi=
ng
> the card that the reset is performed extremely fast.
>
>> @@ -984,17 +983,15 @@ static inline void omap_hsmmc_reset_controller=
_fsm(struct omap_hsmmc_host *host,
>>   	 * OMAP4 ES2 and greater has an updated reset logic.
>>   	 * Monitor a 0->1 transition first
>>   	 */
>> -	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
>> -		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>> -					&& (i++ < limit))
>> -			cpu_relax();
>> -	}
>> -	i =3D 0;
>> -
>> -	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
>> -		(i++ < limit))
>> -		cpu_relax();
>> -
>> +	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET)
>> +		while (!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
>> +			&& limit--)
>> +			udelay(1);
>
> In this way, the loop will only last about 'MMC_TIMEOUT_MS' ms
> and my WDT doesn't get triggered :-)
>
>> +	limit =3D MMC_TIMEOUT_MS * 1000;
>> +	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) && limit--)
>> +		udelay(1);
>> +
>>   	if (OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
>>   		dev_err(mmc_dev(host->mmc),
>>   			"Timeout waiting on controller reset in %s\n",
>
> Anybody an opinion on this?
>
> Thanks, Hein
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
