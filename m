From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: Re: [PATCH] mmc: mmc: Fix HS switch failure in mmc_select_hs400()
Date: Fri, 27 May 2016 10:41:17 +0800
Message-ID: <5747B3CD.9080102@rock-chips.com>
References: <1464241832-10322-1-git-send-email-xzy.xu@rock-chips.com> <5746BC9D.9050501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:51359 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbcE0Cli (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 22:41:38 -0400
In-Reply-To: <5746BC9D.9050501@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, dianders@chromium.org, linux-mmc@vger.kernel.org, xzy.xu@rock-chips.com, linux-rockchip@lists.infradead.org



On 2016=E5=B9=B405=E6=9C=8826=E6=97=A5 17:06, Adrian Hunter wrote:
> On 26/05/16 08:50, Ziyuan Xu wrote:
>> To slove the issue which was found on gru board for hs400.
>>
>> [    4.616946] sdhci: Secure Digital Host Controller Interface drive=
r
>> [    4.623135] sdhci: Copyright(c) Pierre Ossman
>> [    4.722575] sdhci-pltfm: SDHCI platform and OF driver helper
>> [    4.730962] sdhci-arasan fe330000.sdhci: No vmmc regulator found
>> [    4.737444] sdhci-arasan fe330000.sdhci: No vqmmc regulator found
>> [    4.774930] mmc0: SDHCI controller on fe330000.sdhci [fe330000.sd=
hci] using ADMA
>> [    4.980295] mmc0: switch to high-speed from hs200 failed, err:-84
>> [    4.986487] mmc0: error -84 whilst initialising MMC card
>>
>> We should change HS400 mode selection timing to meet JEDEC
>> specification. The JEDEC 5.1 said that change the frequency to <=3D =
52MHZ
>> after HS_TIMING switch. Refer to section 6.6.2.3 "HS400" timing mode
>> selection:
>> Set the "Timing Interface" parameter in the HS_TIMING[185] field of =
the
>> Extended CSD register to 0x1 to switch to High Speed mode and then s=
et
>> the clock frequency to a value not greater than 52MHZ.
> Do you need a fix also for re-tuning? i.e. does re-tuning work with t=
his
> patch? Or do you not need re-tuning?

Do you mean that revise the similar timing in mmc_hs400_to_hs200()as=20
shown below?

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8e4d059..4232a42 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1161,10 +1161,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
         if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
                 send_status =3D false;

-       /* Reduce frequency to HS */
-       max_dtr =3D card->ext_csd.hs_max_dtr;
-       mmc_set_clock(host, max_dtr);
-
         /* Switch HS400 to HS DDR */
         val =3D EXT_CSD_TIMING_HS;
         err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_=
TIMING,
@@ -1175,6 +1171,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)

         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);

+       /* Reduce frequency to HS */
+       max_dtr =3D card->ext_csd.hs_max_dtr;
+       mmc_set_clock(host, max_dtr);
+
         if (!send_status) {
                 err =3D mmc_switch_status(card);
                 if (err)

The spec doesn't require mode selection from hs400 to hs200, moreover I=
=20
have not yet hit any failure in mmc_hs400_to_hs200.
Thus I don't know whether a fix is needed for re-tuning.
By the way, what's your opinion for this patch?   I know, you did it on=
=20
purpose that I found some message from git log.

>> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>> ---
>>   drivers/mmc/core/mmc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index b81b08f..8e4d059 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1078,10 +1078,6 @@ static int mmc_select_hs400(struct mmc_card *=
card)
>>   	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
>>   		send_status =3D false;
>>  =20
>> -	/* Reduce frequency to HS frequency */
>> -	max_dtr =3D card->ext_csd.hs_max_dtr;
>> -	mmc_set_clock(host, max_dtr);
>> -
>>   	/* Switch card to HS mode */
>>   	val =3D EXT_CSD_TIMING_HS;
>>   	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> @@ -1097,6 +1093,10 @@ static int mmc_select_hs400(struct mmc_card *=
card)
>>   	/* Set host controller to HS timing */
>>   	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>>  =20
>> +	/* Reduce frequency to HS frequency */
>> +	max_dtr =3D card->ext_csd.hs_max_dtr;
>> +	mmc_set_clock(host, max_dtr);
>> +
>>   	if (!send_status) {
>>   		err =3D mmc_switch_status(card);
>>   		if (err)
>>
>
>
>


