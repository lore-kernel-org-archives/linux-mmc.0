From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 15:10:45 -0600
Message-ID: <AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
	<AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:54584 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1CIVKr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 16:10:47 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p29L9RxK000264
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 16:09:27 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p29L8gA4029828
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 16:09:27 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so1156721vws.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 13:10:45 -0800 (PST)
In-Reply-To: <AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>, Dmitry Shmidt <dimitrysh@google.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

On Wed, Mar 9, 2011 at 3:01 PM, Grant Grundler <grundler@google.com> wr=
ote:
> On Wed, Mar 9, 2011 at 12:24 PM, Andrei Warkentin <andreiw@motorola.c=
om> wrote:
>> On Tue, Mar 8, 2011 at 3:39 PM, Grant Grundler <grundler@google.com>=
 wrote:
>>>
>>> Save and restore SDHCI interrupt mask during suspend/resume.
>>> Enables ARM Tegra2 board to suspend/resume.
>>>
>>> Signed-off-by: Venkat Rao <vrao@broadcom.com>
>>> Reviewed-by: Olof Johansson <olofj@chromium.org>
>>> Reviewed-by: Grant Grundler <grundler@chromium.org>
>>> ---
>>> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A05 +++++
>>> =A0include/linux/mmc/sdhci.h | =A0 =A02 ++
>>> =A02 files changed, 7 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 3c6358f..68d2e36 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *hos=
t, pm_message_t state)
>>> =A0 =A0 =A0 =A0if (mmc->card && (mmc->card->type !=3D MMC_TYPE_SDIO=
))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc);
>>>
>>> + =A0 =A0 =A0 /* Save the original intmask to restore later */
>>> + =A0 =A0 =A0 host->save_intmask =3D sdhci_readl(host, SDHCI_INT_EN=
ABLE);
>>> =A0 =A0 =A0 =A0sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>>>
>>> =A0 =A0 =A0 =A0if (host->vmmc)
>>> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host=
)
>>>
>>> =A0 =A0 =A0 =A0sdhci_enable_card_detection(host);
>>>
>>> + =A0 =A0 =A0 /* Restore the original intmask */
>>> + =A0 =A0 =A0 sdhci_unmask_irqs(host, host->save_intmask);
>>> +
>>> =A0 =A0 =A0 =A0return ret;
>>> =A0}
>>>
>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>> index dfb2106..5b9f6db 100644
>>> --- a/include/linux/mmc/sdhci.h
>>> +++ b/include/linux/mmc/sdhci.h
>>> @@ -141,6 +141,8 @@ struct sdhci_host {
>>>
>>> =A0 =A0 =A0 =A0unsigned int caps; =A0 =A0 =A0/* Alternative capabil=
ities */
>>>
>>> + =A0 =A0 =A0 unsigned int save_intmask; =A0 =A0/* Store original i=
ntmask */
>>> +
>>> =A0 =A0 =A0 =A0unsigned long private[0] ____cacheline_aligned;
>>> =A0};
>>> =A0#endif /* __SDHCI_H */
>>> --
>>> 1.7.2.3
>>>
>>> --
>>
>> Hi Grant,
>>
>> Why is this necessary?
>
> Hi Andrei,
> Sorry - I didn't CC the original author of the patch...(now CC'd) and
> hopefully he or Sandeep can explain.
>
>> If I understand correctly, the sdhci resume
>> sequence sets some base needed bits inside SDHCI_INT_ENABLE inside
>> sdhci_clear_set_irqs. Only if you have some outstanding DMA, but
>> surely all DMA must be completed prior to your suspending
>> (mmc_queue_suspend ensures nothing is outstanding)?
>
> That's a good question. Given this is a WIFI device, my initial
> assumption is we could receive packets or state/event changes any
> time. But the device might in fact be quiesced during the suspend
> operation. I have to check what the brcm80211/brcmfmac driver is doin=
g
> in this case.
>
>> I'm asking since we're on Tegra 2 and have suspend/resume working fi=
ne
>> with eMMC.
>
> We do too - but only if the brcmfmac driver isn't loaded.
>
> I'll look up if there are any side effects of writing SDHCI_INT_ENABL=
E
> as well. It's possible this is unique to having BRCM4329 connected to
> the eMMC controller instead of a flash device.
>
> thanks,
> grant
>

+Dmitry Shmidt

Ah, interesting. So this is an SDIO device. We also have a BRCM4329
:-). Different driver, though, although I'm sure it's the same
Broadcom DHD stuff...

I took a look (yay web archives,
http://groups.google.com/a/chromium.org/group/chromium-os-reviews/brows=
e_thread/thread/bfe4ece948222f96?pli=3D1),
and it seems you have SDHCI_QUIRK_NO_SDIO_IRQ disabled in your
sdhci-tegra. I see why above patch is necessary now.

This is bit OT, but are the LP2 idle gains significant here?

Thanks,
A
