From: <ext-denis.2.karpov@nokia.com>
Subject: RE: [PATCH RFC] mmc : omap_hsmmc : Save and restore the sysc across
 reset
Date: Mon, 16 Jan 2012 14:53:01 +0000
Message-ID: <5E7C2FE2AE03DF4CA6AC500032BF8F77C176F7@008-AM1MPN1-072.mgdnok.nokia.com>
References: <1326713587-26463-1-git-send-email-shubhrajyoti@ti.com>
 <5E7C2FE2AE03DF4CA6AC500032BF8F77C1762A@008-AM1MPN1-072.mgdnok.nokia.com>
 <4F143296.8090802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:21380 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab2APOxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 09:53:09 -0500
In-Reply-To: <4F143296.8090802@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shubhrajyoti@ti.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

ext Shubhrajyoti wrote on=A02012-01-16:
> On Monday 16 January 2012 06:41 PM, ext-denis.2.karpov@nokia.com wrot=
e:
>> ext Shubhrajyoti D wrote on 2012-01-16:
>>> The commit 11dd62:[omap_hsmmc: context save/restore support]
>>>=20
>>> does a reset and restores AUTOIDLE settings.
>>> This patch saves the register does a reset and restores
>>> the same configuration.
>> ...
>>>  	if (pdata->get_context_loss_count) {
>>> @@ -700,6 +700,7 @@ static int omap_hsmmc_context_restore(struct
>>> omap_hsmmc_host *host)
>>>  		&& time_before(jiffies, timeout)) 		; +	sysc =3D
>>>  OMAP_HSMMC_READ(host->base, SYSCONFIG); 	/* Do software reset */
>>>  	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET); 	timeout =3D
>>>  jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>>> @@ -707,8 +708,7 @@ static int omap_hsmmc_context_restore(struct
>>> omap_hsmmc_host *host)
>>>  		&& time_before(jiffies, timeout))
>>>  		;
>>> -	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
>>> -			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
>>> +	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, sysc);
>> The meaning of the code is to restore the register context after it =
was lost
> during transition into low power consumption state. SW reset is neede=
d to bring
> all the registers in a consistent state before reconfiguring some of =
them.
> Agreed thanks.
>> Saving and restoring the SYSCONFIG register across SW reset is not n=
eeded.
>>=20
>> Also re-configuring AUTOIDLE feature is not necessary since SYSCONFI=
G reset
> value has is 1 already, according to TRM. I guess it was done to make=
 things
> more explicit.
> However in addition to autoidle there are other bits in the register
> like the sidle mode , enable wakeup which will get not get overwritte=
n now.
>=20
> Do you agree?

No, there's no need to do that - after SW reset the registers have pred=
efined reset values; the reset value is correct in case of SYSCONFIG re=
gister for most of omap3|4 boards based, doesn't need any update after =
SW reset.

If in case of your board the reset value of SYSCONFIG register is not w=
hat you want - you still cannot rely on the contents of the SYSCONFIG r=
egister once the context was lost, i.e. saving its value before SW rese=
t doesn't help.=20
You would need to initialize it to the proper value after the SW reset =
manually, probably the same value that you used during initialization.

Denis
