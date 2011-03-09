From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 14:00:00 -0800
Message-ID: <AANLkTi==6jPPBJQou8KAGZCKtmmN44Q85PR5x2_KOR2J@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
	<AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
	<AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:3093 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1CIWAF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 17:00:05 -0500
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id p29M03sn018182
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 14:00:03 -0800
Received: from gxk19 (gxk19.prod.google.com [10.202.11.19])
	by kpbe11.cbf.corp.google.com with ESMTP id p29M01kw011950
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 14:00:01 -0800
Received: by gxk19 with SMTP id 19so476682gxk.39
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 14:00:01 -0800 (PST)
In-Reply-To: <AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

On Wed, Mar 9, 2011 at 1:10 PM, Andrei Warkentin <andreiw@motorola.com>=
 wrote:
> On Wed, Mar 9, 2011 at 3:01 PM, Grant Grundler <grundler@google.com> =
wrote:
>> On Wed, Mar 9, 2011 at 12:24 PM, Andrei Warkentin <andreiw@motorola.=
com> wrote:
>>> On Tue, Mar 8, 2011 at 3:39 PM, Grant Grundler <grundler@google.com=
> wrote:
>>>>
>>>> Save and restore SDHCI interrupt mask during suspend/resume.
>>>> Enables ARM Tegra2 board to suspend/resume.
>>>>
>>>> Signed-off-by: Venkat Rao <vrao@broadcom.com>
>>>> Reviewed-by: Olof Johansson <olofj@chromium.org>
>>>> Reviewed-by: Grant Grundler <grundler@chromium.org>
>>>> ---
>>>> =C2=A0drivers/mmc/host/sdhci.c =C2=A0| =C2=A0 =C2=A05 +++++
>>>> =C2=A0include/linux/mmc/sdhci.h | =C2=A0 =C2=A02 ++
>>>> =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 3c6358f..68d2e36 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *ho=
st, pm_message_t state)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmc->card && (mmc->card->type !=3D =
MMC_TYPE_SDIO))
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mmc=
_suspend_host(host->mmc);
>>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 /* Save the original intmask to restore lat=
er */
>>>> + =C2=A0 =C2=A0 =C2=A0 host->save_intmask =3D sdhci_readl(host, SD=
HCI_INT_ENABLE);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_mask_irqs(host, SDHCI_INT_ALL_MAS=
K);
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->vmmc)
>>>> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *hos=
t)
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_enable_card_detection(host);
>>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 /* Restore the original intmask */
>>>> + =C2=A0 =C2=A0 =C2=A0 sdhci_unmask_irqs(host, host->save_intmask)=
;
>>>> +
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>>>> =C2=A0}
>>>>
>>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>>> index dfb2106..5b9f6db 100644
>>>> --- a/include/linux/mmc/sdhci.h
>>>> +++ b/include/linux/mmc/sdhci.h
>>>> @@ -141,6 +141,8 @@ struct sdhci_host {
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int caps; =C2=A0 =C2=A0 =C2=A0=
/* Alternative capabilities */
>>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int save_intmask; =C2=A0 =C2=A0/* =
Store original intmask */
>>>> +
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long private[0] ____cacheline_=
aligned;
>>>> =C2=A0};
>>>> =C2=A0#endif /* __SDHCI_H */
>>>> --
>>>> 1.7.2.3
>>>>
>>>> --
>>>
>>> Hi Grant,
>>>
>>> Why is this necessary?
>>
>> Hi Andrei,
>> Sorry - I didn't CC the original author of the patch...(now CC'd) an=
d
>> hopefully he or Sandeep can explain.
>>
>>> If I understand correctly, the sdhci resume
>>> sequence sets some base needed bits inside SDHCI_INT_ENABLE inside
>>> sdhci_clear_set_irqs. Only if you have some outstanding DMA, but
>>> surely all DMA must be completed prior to your suspending
>>> (mmc_queue_suspend ensures nothing is outstanding)?
>>
>> That's a good question. Given this is a WIFI device, my initial
>> assumption is we could receive packets or state/event changes any
>> time. But the device might in fact be quiesced during the suspend
>> operation. I have to check what the brcm80211/brcmfmac driver is doi=
ng
>> in this case.
>>
>>> I'm asking since we're on Tegra 2 and have suspend/resume working f=
ine
>>> with eMMC.
>>
>> We do too - but only if the brcmfmac driver isn't loaded.
>>
>> I'll look up if there are any side effects of writing SDHCI_INT_ENAB=
LE
>> as well. It's possible this is unique to having BRCM4329 connected t=
o
>> the eMMC controller instead of a flash device.
>>
>> thanks,
>> grant
>>
>
> +Dmitry Shmidt
>
> Ah, interesting. So this is an SDIO device. We also have a BRCM4329
> :-).

Yes. :)

> Different driver, though, although I'm sure it's the same
> Broadcom DHD stuff...

It might be. I've been pulling brcm80211 from gregkh's
staging-2.6:drivers/staging tree and that's been evolving.  I expect
the driver used by Android is functionally equivalent modulo any
"sleep lock" (or whatever it's called now) changes.


> I took a look (yay web archives,
> http://groups.google.com/a/chromium.org/group/chromium-os-reviews/bro=
wse_thread/thread/bfe4ece948222f96?pli=3D1),
> and it seems you have SDHCI_QUIRK_NO_SDIO_IRQ disabled in your
> sdhci-tegra.

Indeed - this patch was proposed shortly after Olof submitted the
change to remove SDHCI_QUIRK_NO_SDIO_IRQ.  My role here is to get
patches we were handed over a month ago upstream.

> I see why above patch is necessary now.

I don't understand the relationship between the two. Can you
elaborate? Or point at docs?
I'd be happy to add comments to the code.

In a followup you wrote
The dependency bothers me since it suggests that if
SDHCI_QUIRK_NO_SDIO_IRQ flag is set, we should not be touching this
register. Is that correct?


> This is bit OT, but are the LP2 idle gains significant here?

I don't know if CPU pwer is reduced or if that was intentional or just
a side effect. Venkat or Sandeep (Broadcom) might be able to answer
that.


In a follow up, you also wrote:
> As an additional comment, I think the way this patch is made it hides
> the reason for why this is necessary.

TBH, even after this conversation, it's still not clear to me why.

The dependency bothers me since it suggests that if
SDHCI_QUIRK_NO_SDIO_IRQ flag is set, we should not be touching this
register. Is that correct?

> The patch should explicitly record if SDHCI_INT_CARD_INT is
> enabled on suspend and set it back again on resume.

Would this be better?
     host->save_intmask =3D sdhci_readl(host, SDHCI_INT_ENABLE) &
SDHCI_INT_CARD_INT;

Does kernel.org still need something to deal with state of
SDHCI_QUIRK_NO_SDIO_IRQ quirk bit?

thanks,
grant
