From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] SDHCI: Don't assign mmc->caps at SDHCI directly
Date: Mon, 28 Jun 2010 12:35:31 -0700
Message-ID: <AANLkTino3O_ALJIPE5bOzwfwFIN2KRdkq3OlN7gMVaLq@mail.gmail.com>
References: <20100612054450.GA25682@july> <20100628113415.a36c1348.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46258 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab0F1Tfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2010 15:35:52 -0400
Received: by iwn7 with SMTP id 7so316671iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2010 12:35:51 -0700 (PDT)
In-Reply-To: <20100628113415.a36c1348.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>

On Mon, Jun 28, 2010 at 11:34 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Jun 2010 14:44:50 +0900
> Kyungmin Park <kyungmin.park@samsung.com> wrote:
>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Some host controller can set mmc->caps before sdhci_add_host.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 4321e0c..142419c 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1791,7 +1791,7 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / 256;
>> =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
>> - =A0 =A0 mmc->caps =3D MMC_CAP_SDIO_IRQ;
>> + =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>>
>> =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> A great shower of MMC patches have magically turned up in linux-next,
> apparently via some tree of Grant's. =A0Those patches changed the abo=
ve
> code to look like:
>
> =A0 =A0 =A0 =A0if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>
> So it appears that this bug is fixed in that code as well. =A0So I'll
> drop your patch. =A0If the above changes end up not getting merged in=
to
> mainline then your fix will be lost.
>
> That fix was unchangelogged. =A0In fact the patch was completely
> unchangelogged and I haven't looked at it at all and as far as I can
> tell none of it has been sent to the mmc list.

I messed it up by pushing the wrong branch.  I'm pulling it out now
and it won't be in the next linux-next.

g.
