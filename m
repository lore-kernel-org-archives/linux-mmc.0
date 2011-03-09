From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 13:01:30 -0800
Message-ID: <AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:44039 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1CIVBh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 16:01:37 -0500
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p29L1WZd014476
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 13:01:32 -0800
Received: from gyg8 (gyg8.prod.google.com [10.243.50.136])
	by hpaq3.eem.corp.google.com with ESMTP id p29L0t16023813
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 13:01:30 -0800
Received: by gyg8 with SMTP id 8so391543gyg.9
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 13:01:30 -0800 (PST)
In-Reply-To: <AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

On Wed, Mar 9, 2011 at 12:24 PM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> On Tue, Mar 8, 2011 at 3:39 PM, Grant Grundler <grundler@google.com> =
wrote:
>>
>> Save and restore SDHCI interrupt mask during suspend/resume.
>> Enables ARM Tegra2 board to suspend/resume.
>>
>> Signed-off-by: Venkat Rao <vrao@broadcom.com>
>> Reviewed-by: Olof Johansson <olofj@chromium.org>
>> Reviewed-by: Grant Grundler <grundler@chromium.org>
>> ---
>> =C2=A0drivers/mmc/host/sdhci.c =C2=A0| =C2=A0 =C2=A05 +++++
>> =C2=A0include/linux/mmc/sdhci.h | =C2=A0 =C2=A02 ++
>> =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 3c6358f..68d2e36 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *host=
, pm_message_t state)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmc->card && (mmc->card->type !=3D MM=
C_TYPE_SDIO))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mmc_s=
uspend_host(host->mmc);
>>
>> + =C2=A0 =C2=A0 =C2=A0 /* Save the original intmask to restore later=
 */
>> + =C2=A0 =C2=A0 =C2=A0 host->save_intmask =3D sdhci_readl(host, SDHC=
I_INT_ENABLE);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK)=
;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->vmmc)
>> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_enable_card_detection(host);
>>
>> + =C2=A0 =C2=A0 =C2=A0 /* Restore the original intmask */
>> + =C2=A0 =C2=A0 =C2=A0 sdhci_unmask_irqs(host, host->save_intmask);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>> =C2=A0}
>>
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index dfb2106..5b9f6db 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -141,6 +141,8 @@ struct sdhci_host {
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int caps; =C2=A0 =C2=A0 =C2=A0/*=
 Alternative capabilities */
>>
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int save_intmask; =C2=A0 =C2=A0/* St=
ore original intmask */
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long private[0] ____cacheline_al=
igned;
>> =C2=A0};
>> =C2=A0#endif /* __SDHCI_H */
>> --
>> 1.7.2.3
>>
>> --
>
> Hi Grant,
>
> Why is this necessary?

Hi Andrei,
Sorry - I didn't CC the original author of the patch...(now CC'd) and
hopefully he or Sandeep can explain.

> If I understand correctly, the sdhci resume
> sequence sets some base needed bits inside SDHCI_INT_ENABLE inside
> sdhci_clear_set_irqs. Only if you have some outstanding DMA, but
> surely all DMA must be completed prior to your suspending
> (mmc_queue_suspend ensures nothing is outstanding)?

That's a good question. Given this is a WIFI device, my initial
assumption is we could receive packets or state/event changes any
time. But the device might in fact be quiesced during the suspend
operation. I have to check what the brcm80211/brcmfmac driver is doing
in this case.

> I'm asking since we're on Tegra 2 and have suspend/resume working fin=
e
> with eMMC.

We do too - but only if the brcmfmac driver isn't loaded.

I'll look up if there are any side effects of writing SDHCI_INT_ENABLE
as well. It's possible this is unique to having BRCM4329 connected to
the eMMC controller instead of a flash device.

thanks,
grant
