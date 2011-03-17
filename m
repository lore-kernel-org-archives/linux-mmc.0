From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/3] dw_mmc: set fixed burst in BMOD register
Date: Thu, 17 Mar 2011 20:28:02 +0000
Message-ID: <AANLkTik--TiJgNrezLb6hcbFAxWXqvSBUfvGOU2JuEpH@mail.gmail.com>
References: <4D670F0D.8020102@samsung.com>
	<m31v25ppvc.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53145 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab1CQU2E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 16:28:04 -0400
Received: by yia27 with SMTP id 27so1287058yia.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2011 13:28:03 -0700 (PDT)
In-Reply-To: <m31v25ppvc.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Mar 17, 2011 at 6:24 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Will,
>
> On Thu, Feb 24 2011, Jaehoon Chung wrote:
>> This patch is applied fixed burst.
>> If use internal DMA controller, i think that need to set this bit.
>>
>> I tested when set this bit or not. I found that increase performance=
 with IDMAC
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 58476c1..46e5a89 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -315,7 +315,7 @@ static void dw_mci_idmac_stop_dma(struct dw_mci =
*host)
>>
>> =A0 =A0 =A0 /* Stop the IDMAC running */
>> =A0 =A0 =A0 temp =3D mci_readl(host, BMOD);
>> - =A0 =A0 temp &=3D ~SDMMC_IDMAC_ENABLE;
>> + =A0 =A0 temp &=3D ~(SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB);
>> =A0 =A0 =A0 mci_writel(host, BMOD, temp);
>> =A0}
>>
>> @@ -384,7 +384,7 @@ static void dw_mci_idmac_start_dma(struct dw_mci=
 *host, unsigned int sg_len)
>>
>> =A0 =A0 =A0 /* Enable the IDMAC */
>> =A0 =A0 =A0 temp =3D mci_readl(host, BMOD);
>> - =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE;
>> + =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
>> =A0 =A0 =A0 mci_writel(host, BMOD, temp);
>>
>> =A0 =A0 =A0 /* Start it running */
>
> Any thoughts on this patch?

=46rom the documentation I have it's not clear what this bit does. I
have very limited access to hardware with internal DMA support, so I
can't really test it either. I'm willing to believe the patch improves
things but I can't really say one way or the other.
