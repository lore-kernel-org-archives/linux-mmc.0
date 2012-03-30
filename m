From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: bus: print bus speed mode of UHS-I card
Date: Fri, 30 Mar 2012 17:58:39 +0900
Message-ID: <CAKYAXd84EBFbP-AZAfEjNE2R0Rj4Ci1Brd0Y9qihcUiM1oN7BQ@mail.gmail.com>
References: <1333089618-20627-1-git-send-email-subhashj@codeaurora.org>
	<20120330085135.GA13563@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37248 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759539Ab2C3I6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 04:58:39 -0400
In-Reply-To: <20120330085135.GA13563@ladygaga>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, arindam.nath@amd.com, Aaron Lu <aaron.lu@amd.com>

2012/3/30 Aaron Lu <aaron.lu@amd.com>:
> Hi,
>
> On Fri, Mar 30, 2012 at 12:10:18PM +0530, Subhash Jadavani wrote:
>> When UHS-I card is detected also print the bus speed mode
>> in which UHS-I card will be running.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>
> Acked-by: Aaron Lu <aaron.lu@amd.com>
>
> -Aaron
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Thanks.
>
>> ---
>> =C2=A0drivers/mmc/core/bus.c | =C2=A0 17 +++++++++++++++--
>> =C2=A01 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 5d011a3..3f60606 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -267,6 +267,15 @@ int mmc_add_card(struct mmc_card *card)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>> =C2=A0 =C2=A0 =C2=A0 const char *type;
>> + =C2=A0 =C2=A0 const char *uhs_bus_speed_mode =3D "";
>> + =C2=A0 =C2=A0 static const char *const uhs_speeds[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [UHS_SDR12_BUS_SPEED] =3D=
 "SDR12 ",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [UHS_SDR25_BUS_SPEED] =3D=
 "SDR25 ",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [UHS_SDR50_BUS_SPEED] =3D=
 "SDR50 ",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [UHS_SDR104_BUS_SPEED] =3D=
 "SDR104 ",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [UHS_DDR50_BUS_SPEED] =3D=
 "DDR50 ",
>> + =C2=A0 =C2=A0 };
>> +
>>
>> =C2=A0 =C2=A0 =C2=A0 dev_set_name(&card->dev, "%s:%04x", mmc_hostnam=
e(card->host), card->rca);
>>
>> @@ -296,6 +305,10 @@ int mmc_add_card(struct mmc_card *card)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (mmc_sd_card_uhs(card) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (card->sd_bus_speed < AR=
RAY_SIZE(uhs_speeds)))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uhs_bus_speed_mode =3D u=
hs_speeds[card->sd_bus_speed];
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (mmc_host_is_spi(card->host)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("%s: new %s=
%s%s card on SPI\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_hostname(card->host),
>> @@ -303,13 +316,13 @@ int mmc_add_card(struct mmc_card *card)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_card_ddr_mode(card) ? "DDR " : "",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 type);
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("%s: new %s%s%s%=
s card at address %04x\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("%s: new %s%s%s%=
s%s card at address %04x\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_hostname(card->host),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_card_uhs(card) ? "ultra high speed " :
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (mmc_card_highspeed(card) ? "high speed " : ""),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (mmc_card_hs200(card) ? "HS200 " : ""),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_card_ddr_mode(card) ? "DDR " : "",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 type, card->rca);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uhs_bus_speed_mode, type, card->rca);
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0#ifdef CONFIG_DEBUG_FS
>> --
>> 1.7.1.1
>>
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora =
=46orum.
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
