From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] sdhci: add quirk to support shared bus controller
Date: Mon, 25 Apr 2011 23:49:35 +0800
Message-ID: <BANLkTim6V5RNtrUzz+KQiG0USW72B2xjQQ@mail.gmail.com>
References: <BANLkTi=7h_gBQ1CGqYgUUhZabcwVuoRhCw@mail.gmail.com>
 <BANLkTincOuKrTEzP3gv-d2Vk-Cih+BS4hw@mail.gmail.com> <BANLkTikcxk6yt72pa6QC-unawseaOQ7Dfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44483 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab1DYPt4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2011 11:49:56 -0400
Received: by qwk3 with SMTP id 3so995868qwk.19
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2011 08:49:55 -0700 (PDT)
In-Reply-To: <BANLkTikcxk6yt72pa6QC-unawseaOQ7Dfg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, bin.shi@csr.com, Binghua.Duan@csr.com

2011/4/25 Barry Song <21cnbao@gmail.com>:
> 2011/4/21 Andrei Warkentin <andreiw@motorola.com>:
>> Hi,
>>
>> On Thu, Apr 21, 2011 at 3:51 AM, Barry Song <21cnbao@gmail.com> wrot=
e:
>>> From: Bin Shi <bin.shi@csr.com>
>>>
>>> some controllers share data bus or other pins between
>>> multi-controllers and need to switch the functions of shared pins
>>> runtime
>>> this patch requested those shared pins before actual hardware acces=
s
>>> and release them after access
>>>
>>> Signed-off-by: Bin Shi <bin.shi@csr.com>
>>> Cc: Binghua Duan <binghua.duan@csr.com>
>>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>>> ---
>>> =C2=A0drivers/mmc/host/sdhci.c =C2=A0| =C2=A0 13 +++++++++++++
>>> =C2=A0drivers/mmc/host/sdhci.h =C2=A0| =C2=A0 =C2=A02 ++
>>> =C2=A0include/linux/mmc/sdhci.h | =C2=A0 =C2=A02 ++
>>> =C2=A03 files changed, 17 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index f31077d..7b07152 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1379,6 +1379,13 @@ static void sdhci_tasklet_finish(unsigned lo=
ng param)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_reset(=
host, SDHCI_RESET_DATA);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* some controllers share data bus or o=
ther pins between multi-controller
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and need to switch the function of p=
ins runtime
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops->get_s=
hared_pins(host);
>>> +
>>
>> Why in tasklet_finish? Why not in sdhci_request?
>
> that is ok in sdhci_request
>
>> No need to waste a quirk flag. Just invoke if method is not NULL.
>
> i think most hardwares have no shared pins issue, it should be a quir=
k
> but not a generic option for all devices.
>
>>
>> Also, I would assume host->ops->get_shared_pins would need to
>> synchronize with other SDHCI instances
>> it shares the pins with. Since you do it after the host->lock (as yo=
u
>> should), what happens if get_shared_pins needs to wait?
>
> sorry, just due to my cross-eye while porting the patch from old
> kernel to linux-mmc tree. In fact i mean:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * some controllers share data bus or othe=
r pins between
> multi-controller
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and need to switch the function of pins=
 runtime
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->quirks & SDHCI_QUIRK_SHARED_PINS=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->ops->get=
_shared_pins(host);
>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_request_done(host->mmc, mrq);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * release shared pins so that other contr=
ollers can use them
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->quirks & SDHCI_QUIRK_SHARED_PINS=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->ops->get=
_shared_pins(host);
>

In fact we request shared pins in sdhci_request() and release them in
tasklet_finish. Then i'll send patch v2.

>> Can you show the rest (sdhci driver implementing these hooks)?
>
> Yes. sdhci driver implement these hooks, special behavior of getting
> shared pins depends on special hardware, for us, we just request data
> bus mutex and set related hardware registers to switch the role of
> shared pins.
>
>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->mrq =3D NULL;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->cmd =3D NULL;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->data =3D NULL;
>>> @@ -1391,6 +1398,12 @@ static void sdhci_tasklet_finish(unsigned lo=
ng param)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&host->lock, flag=
s);
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_request_done(host->mmc, mrq);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* release shared pins so that other co=
ntrollers can use them
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops->get_s=
hared_pins(host);
>>> =C2=A0}
>>>
>>> =C2=A0static void sdhci_timeout_timer(unsigned long data)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 85750a9..9d918a5 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -229,6 +229,8 @@ struct sdhci_ops {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*platform_send_init_74_clocks)(str=
uct sdhci_host *host,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 u8 power_mode);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0(*get_ro)(stru=
ct sdhci_host *host);
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0(*get_shared_pins)=
(struct sdhci_host *host);
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0(*put_shared_pins)=
(struct sdhci_host *host);
>>> =C2=A0};
>>>
>>> =C2=A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>> index 83bd9f7..32ab422 100644
>>> --- a/include/linux/mmc/sdhci.h
>>> +++ b/include/linux/mmc/sdhci.h
>>> @@ -85,6 +85,8 @@ struct sdhci_host {
>>> =C2=A0#define SDHCI_QUIRK_NO_HISPD_BIT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1<<29)
>>> =C2=A0/* Controller treats ADMA descriptors with length 0000h incor=
rectly */
>>> =C2=A0#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1<<30)
>>> +/* Controller shared data bus or other pins with other controllers=
 */
>>> +#define SDHCI_QUIRK_SHARED_PINS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1<<31)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* Device IRQ */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *ioaddr; =C2=A0 /* Mapped a=
ddress */
>>> --
>>> 1.7.1
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>>
>
