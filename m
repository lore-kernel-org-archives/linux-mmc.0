From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Mon, 28 Mar 2011 20:38:08 -0700
Message-ID: <BANLkTi=CBaqzHM97batDSET7FX1WkyXOOg@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<m339m6hdjp.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:23118 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab1C2DiM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2011 23:38:12 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p2T3cA10012372
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 20:38:10 -0700
Received: from gxk19 (gxk19.prod.google.com [10.202.11.19])
	by wpaz24.hot.corp.google.com with ESMTP id p2T3c8dj004472
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 20:38:09 -0700
Received: by gxk19 with SMTP id 19so1638031gxk.31
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 20:38:08 -0700 (PDT)
In-Reply-To: <m339m6hdjp.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>

On Mon, Mar 28, 2011 at 7:21 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Grant,
>
> On Tue, Mar 08 2011, Grant Grundler wrote:
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
>> =C2=A0 =C2=A0 =C2=A0 if (mmc->card && (mmc->card->type !=3D MMC_TYPE=
_SDIO))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_suspend=
_host(host->mmc);
>>
>> + =C2=A0 =C2=A0 /* Save the original intmask to restore later */
>> + =C2=A0 =C2=A0 host->save_intmask =3D sdhci_readl(host, SDHCI_INT_E=
NABLE);
>> =C2=A0 =C2=A0 =C2=A0 sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (host->vmmc)
>> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host)
>>
>> =C2=A0 =C2=A0 =C2=A0 sdhci_enable_card_detection(host);
>>
>> + =C2=A0 =C2=A0 /* Restore the original intmask */
>> + =C2=A0 =C2=A0 sdhci_unmask_irqs(host, host->save_intmask);
>> +
>> =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>
> I'm okay with the patch in principle, but it doesn't apply to any mai=
nline
> kernel as far as I can see -- we've never called sdhci_mask_irqs() in=
 the
> suspend path, which is context in this patch. =C2=A0Maybe I'm missing=
 something?

Yes. Sorry. /o\

I didn't know this happened. Olof just helped me track down this
change from Android tree which was pulled into the chromium.org
"kernel-next" tree to support ARM tegra2:

http://android.git.kernel.org/?p=3Dkernel/tegra.git;a=3Dcommit;h=3Dda2d=
1c69d66f8a4028b5f93fc972652b79bbb648

Author: Dmitry Shmidt <dimitrysh@google.com>
Date:   Thu Aug 12 18:08:40 2010 -0700

    mmc: sdhci: Skip mmc suspend/resume ops for SDIO device,

    enable/disable sdc irq instead of request/free,
    mask all sdc interrupts on suspend

[And given the "subject" of the commit log, neither google nor yahoo
could find the link. We had to manually find the commit by traversing
android.git.kernel.org. ]


> If not, it would be good to know whether the patch is needed on a mai=
nline
> kernel, as well as posting a rebased version.

After the conversation with Olof and Andrei Warkentin, I'm pretty sure
the proposed patch IS needed.

I will provide a rebased version. But I first need to talk to Dmitry
(cc'd) tomorrow (8pm PST here already) and see if other Adroid changes
to drivers/mmc need to be upstreamed or if this one could/should go in
alone.

my apologies for making this messy,
grant
