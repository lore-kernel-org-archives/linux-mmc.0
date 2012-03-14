From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: check interrupt flags in ISR again
Date: Wed, 14 Mar 2012 10:13:34 +0200
Message-ID: <4F60532E.4070103@intel.com>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com> <1331659002-13743-2-git-send-email-alexander.stein@systec-electronic.com> <4F604B16.606@intel.com> <1994979.AaWWmIIAYQ@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60778 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758815Ab2CNIN0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 Mar 2012 04:13:26 -0400
In-Reply-To: <1994979.AaWWmIIAYQ@ws-stein>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Chris Ball <cjb@laptop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On 14/03/12 09:53, Alexander Stein wrote:
> Hello,
>=20
> Am Mittwoch, 14. M=E4rz 2012, 09:39:02 schrieb Adrian Hunter:
>> On 13/03/12 19:16, Alexander Stein wrote:
>>> When using MSI it is possible that a new MSI is sent while an earli=
er
>>> MSI is currently handled. In this case SDHCI_INT_STATUS only contai=
ns
>>> SDHCI_INT_RESPONSE and the ISR would not be called again. But at th=
e end
>>> of the ISR SDHCI_INT_DATA_END is now also pending which would be
>>> ignored.
>>>
>>> Fix this by rereading the interrupt flags in the ISR until no inter=
rupt
>>> we care is pending.
>>>
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.c=
om>
>> [...]
>>> @@ -2336,6 +2338,14 @@ static irqreturn_t sdhci_irq(int irq, void
>>> *dev_id)>=20
>>>  		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
>>>  =09
>>>  	}
>>>
>>> +	intmask_unhandled =3D intmask;
>>> +
>>> +	intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
>>> +
>>> +	/* Do interrupt handling again if we got new flags */
>>> +	if (intmask & ~intmask_unhandled)
>>> +		goto again;
>>> +
>>>
>>>  	intmask &=3D ~SDHCI_INT_BUS_POWER;
>>>  =09
>>>  	if (intmask & SDHCI_INT_CARD_INT)
>>
>> Why not just replace mmiowb() i.e.
>>
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 8d66706..da8a101 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2353,7 +2353,9 @@ static irqreturn_t sdhci_irq(int irq, void *de=
v_id)
>>
>>         result =3D IRQ_HANDLED;
>>
>> -       mmiowb();
>> +       intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
>> +       if (intmask)
>> +               goto again;
>>  out:
>>         spin_unlock(&host->lock);
>>
>=20
> Well, I chose this way to only printk the error once. With your sugge=
stion it=20
> might be printed in each loop, dunno how often/fast these IRQ stats a=
re set=20
> again after clearing. This would end in an endless loop if error flag=
s are set=20
> again fast enough, but see below.
> But in general I like this approach.
>=20
>> But maybe it would be safer limiting the number of loops i.e.
>>
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 8d66706..d88247d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2268,7 +2268,7 @@ static irqreturn_t sdhci_irq(int irq, void *de=
v_id)
>>         irqreturn_t result;
>>         struct sdhci_host *host =3D dev_id;
>>         u32 intmask;
>> -       int cardint =3D 0;
>> +       int cardint =3D 0, max_loops =3D 16;
>>
>>         spin_lock(&host->lock);
>>
>> @@ -2353,7 +2353,9 @@ static irqreturn_t sdhci_irq(int irq, void *de=
v_id)
>>
>>         result =3D IRQ_HANDLED;
>>
>> -       mmiowb();
>> +       intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
>> +       if (intmask && --max_loops)
>> +               goto again;
>>  out:
>>         spin_unlock(&host->lock);
>=20
> The actual problem I saw was a CMD6 command with an R1b response wher=
e the IRQ=20
> for the 'not busy' event was sent during ISR for the response. So I t=
hink=20
> normally this should only occur once.
> Regarding error flags I masked the unhandled flags out in order to pr=
int an=20
> error only once, even if they might be set again in the next loop. Wi=
th a=20
> simple check on intmask they might occur up to 16 times in the kernel=
 log.
> IMHO it makes no sense to repeatedly print errors about interrupt fla=
gs we=20
> don't handle.
>=20
> Suggestions to get a more clean way?

I don't know about clean, but there is this:


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..e0909da 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2267,8 +2267,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_i=
d)
 {
        irqreturn_t result;
        struct sdhci_host *host =3D dev_id;
-       u32 intmask;
-       int cardint =3D 0;
+       u32 intmask, unexpected =3D 0;
+       int cardint =3D 0, max_loops =3D 16;

        spin_lock(&host->lock);

@@ -2344,19 +2344,24 @@ static irqreturn_t sdhci_irq(int irq, void *dev=
_id)
        intmask &=3D ~SDHCI_INT_CARD_INT;

        if (intmask) {
-               pr_err("%s: Unexpected interrupt 0x%08x.\n",
-                       mmc_hostname(host->mmc), intmask);
-               sdhci_dumpregs(host);
-
+               unexpected |=3D intmask;
                sdhci_writel(host, intmask, SDHCI_INT_STATUS);
        }

        result =3D IRQ_HANDLED;

-       mmiowb();
+       intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
+       if (intmask && --max_loops)
+               goto again;
 out:
        spin_unlock(&host->lock);

+       if (unexpected) {
+               pr_err("%s: Unexpected interrupt 0x%08x.\n",
+                       mmc_hostname(host->mmc), unexpected);
+               sdhci_dumpregs(host);
+       }
+
        /*
         * We have to delay this as it calls back into the driver.
         */
