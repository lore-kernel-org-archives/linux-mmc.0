From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [PATCH] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Fri, 27 Aug 2010 19:55:44 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A58275D@shsmsx501.ccr.corp.intel.com>
References: <4C775C8E.7040903@samsung.com>
	<20100827070955.GA2418@console-pimps.org>
 <AANLkTikLq_04+KQzyKmOh2K7U4wME=bXTzfq0M1KH8V3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44460 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699Ab0H0Lzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 07:55:49 -0400
In-Reply-To: <AANLkTikLq_04+KQzyKmOh2K7U4wME=bXTzfq0M1KH8V3@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>

>-----Original Message-----
>From: linux-mmc-owner@vger.kernel.org
>[mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Kyungmin Park
>Sent: Friday, August 27, 2010 3:15 PM
>To: Matt Fleming
>Cc: Jaehoon Chung; linux-mmc@vger.kernel.org; Marek Szyprowski; Andrew=
 Morton;
>Ben Dooks
>Subject: Re: [PATCH] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable=
 case
>
>On Fri, Aug 27, 2010 at 4:09 PM, Matt Fleming <matt@console-pimps.org>=
 wrote:
>> On Fri, Aug 27, 2010 at 03:34:54PM +0900, Jaehoon Chung wrote:
>>> If controller use SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk,
>>> controller need always polling detect
>>>
>>> In this case, always generated interrupt.Because controller checked=
 card
>status.
>>> I think that is not efficiently.
>>>
>>> But if card is nonremovable, we need not always polling.
>>> So i added the check-point which is nonremovable or not
>>>
>>> =A0Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>> =A0drivers/mmc/host/sdhci.c | =A0 =A05 +++--
>>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 401527d..4bc5d3c 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1826,8 +1826,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
>>>
>>> - =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>>> + =A0 =A0 if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 !(host->mmc->caps & MMC_CAP_NONREMOVABLE)=
)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NE=
EDS_POLL;

Since module parameter 'mmc_assume_removable' (defined in core.c) also =
controls the nonremovable attribute of the mmc/eMMC device, will it be =
better to also check value of 'mmc_assume_removable' here? Thanks.

Regards,
Yunpeng Gao

