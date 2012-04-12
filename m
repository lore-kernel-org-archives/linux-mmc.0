From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: core: skip card initialization if power class
 selection fails
Date: Thu, 12 Apr 2012 09:58:23 +0530
Message-ID: <CAGxe1ZEtDPP5aDMJgz8Pib=4F0UDboKVQW0G34h8dt38-iNspA@mail.gmail.com>
References: <1334144122-20647-1-git-send-email-subhashj@codeaurora.org>
	<CAKYAXd9YVKjiwfOOYJ8_FYiCLQOoU-8stewPiNJBoyb_OxBW7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKYAXd9YVKjiwfOOYJ8_FYiCLQOoU-8stewPiNJBoyb_OxBW7g@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11 April 2012 19:24, Namjae Jeon <linkinjeon@gmail.com> wrote:
> Hi. Subhash.
> Have you considered return -EINVAL in switch ?
That is case which should never enter.
> And looks complex more.. how about getting bus_width and ddr value
> from argument ?
bus_width is already a argument of mmc_select_powerclass.
>
> Thanks.
> 2012/4/11 Subhash Jadavani <subhashj@codeaurora.org>:
>> With current implementation of power class selection,
>> mmc_select_powerclass() should never fail. So treat any error
>> returned by this function as serious enough to skip the card
>> initialization.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> ---
>> =A0drivers/mmc/core/mmc.c | =A0 26 +++++++++++++++-----------
>> =A01 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f34afbd..5f9d98e 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -722,6 +722,18 @@ static int mmc_select_powerclass(struct mmc_car=
d *card,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card=
->ext_csd.generic_cmd6_time);
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int width =3D 4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ddr =3D (bus_width <=3D EXT_CSD_BU=
S_WIDTH_8) ? 0 : 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((bus_width =3D=3D EXT_CSD_BUS_WIDT=
H_8) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (bus_width =3D=3D EXT_CSD_DDR_=
BUS_WIDTH_8))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 width =3D 8;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power class selection to b=
us width %d ddr %d"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" failed\n", mmc_hostna=
me(card->host), width, ddr);
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> @@ -1115,9 +1127,7 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_powerclass(card, e=
xt_csd_bits, ext_csd);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: power =
class selection to bus width %d"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
" failed\n", mmc_hostname(card->host),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
1 << bus_width);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/*
>> @@ -1149,10 +1159,7 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_po=
werclass(card, ext_csd_bits[idx][0],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_war=
ning("%s: power class selection to "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d failed\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto e=
rr;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(ca=
rd, EXT_CSD_CMD_SET_NORMAL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 EXT_CSD_BUS_WIDTH,
>> @@ -1180,10 +1187,7 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_po=
werclass(card, ext_csd_bits[idx][1],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_war=
ning("%s: power class selection to "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d ddr %d failed\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width, ddr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto e=
rr;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(ca=
rd, EXT_CSD_CMD_SET_NORMAL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 EXT_CSD_BUS_WIDTH,
>> --
>> 1.7.1.1
>>
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora =
=46orum.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
