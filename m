From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: core: fix power class selection
Date: Tue, 3 Apr 2012 21:47:58 +0530
Message-ID: <CAKLKtzeYhQtfPLTvO--5cOg6h90t6OpiRmgPKu3cP7AfKBNnMQ@mail.gmail.com>
References: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
	<CAKLKtzew2g7bXR3Xdz448cs8O_jQHp0ybG1r1VBUTXcoh2BDwA@mail.gmail.com>
	<000501cd11b1$75766770$60633650$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <000501cd11b1$75766770$60633650$@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, girish.shivananjappa@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 3 April 2012 21:20, Subhash Jadavani <subhashj@codeaurora.org> wrote=
:
>
>
>> -----Original Message-----
>> From: Saugata Das [mailto:saugata.das@linaro.org]
>> Sent: Tuesday, April 03, 2012 8:55 PM
>> To: Subhash Jadavani
>> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org;
>> girish.shivananjappa@linaro.org
>> Subject: Re: [PATCH v1 1/1] mmc: core: fix power class selection
>>
>> On 3 April 2012 12:25, Subhash Jadavani <subhashj@codeaurora.org> wr=
ote:
>> > mmc_select_powerclass() function returns error if eMMC VDD level
>> > supported by host is between 2.7v to 3.2v.
>> >
>> > According to eMMC specification, valid voltage for high voltage ca=
rds
>> > is 2.7v to 3.6v. This patch ensures that 2.7v to 3.6v VDD range is
>> > treated as valid range.
>> >
>> > Also, failure to set the power class shouldn't be treated as fatal
>> > error because even if setting the power class fails, card can stil=
l
>> > work in default power class.
>> > If mmc_select_powerclass() returns error, just print the warning
>> > message and go ahead with rest of the card initialization.
>> >
>>
>> Have you checked why mmc_select_powerclass returned error ? Today, i=
n
>> the mmc_select_powerclass, it is just setting the value of power cla=
ss,
> which
>> the eMMC expects. So, it should not fail.
>>
>> Another point is that, today mmc_select_powerclass is assuming that =
host
>> can support the maximum possible power classes and it does not check=
 host
>> controllers capability in driving higher current (mA). But I think i=
n
> future we
>> need to add this check for host controller ability and return error =
from
>> mmc_select_powerclass so that mmc_init_card can choose the next spee=
d
>
> Agreed with this point.
>
>> mode. From that perspective, the approach to ignore the error return=
 from
>> mmc_select_powerclass looks wrong.
>
> My patch was just intended to fix the issue existing power class
> implementation. As commit text says:
> =A0 =A0 =A0 =A0- don't consider 2.7v to 3.2v as invalid range
> =A0 =A0 =A0 =A0- We are already ignoring the error returned by
> mmc_set_power_class() function for DS/HS/DDR cards. So this patch has
> extended that to HS200 cards.
>
> So as far as this patch is concerned, I don't see anything wrong here=
=2E
>
> As you have mentioned, currently we are not taking the host controlle=
r
> capability into account (as it doesn't exist as of now) so we should =
not see
> mmc_select_powerclass() fail any time.

This is actually the main concern. The fail of mmc_select_powerclass
is something to be checked and not ignored since it should not fail
under the current implementation.


> But yes, next thing should be to take into account the host current s=
ourcing
> capability before deciding which bus speed mode to choose. But that m=
ay be a
> big change and should be as separate patch. Girish had already posted=
 one
> patch for this which needs to be extended to achieve this.
>
> Regards,
> Subhash
>
>>
>>
>> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> > ---
>> > =A0drivers/mmc/core/mmc.c | =A0 30 +++++++++++++++++-------------
>> > =A01 files changed, 17 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
>> > 02914d6..54df5ad 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -695,6 +695,11 @@ static int mmc_select_powerclass(struct mmc_c=
ard
>> > *card,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (host->ios.clock <=3D 20000=
0000)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0index =3D EXT_CSD_P=
WR_CL_200_195;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> > + =A0 =A0 =A0 case MMC_VDD_27_28:
>> > + =A0 =A0 =A0 case MMC_VDD_28_29:
>> > + =A0 =A0 =A0 case MMC_VDD_29_30:
>> > + =A0 =A0 =A0 case MMC_VDD_30_31:
>> > + =A0 =A0 =A0 case MMC_VDD_31_32:
>> > =A0 =A0 =A0 =A0case MMC_VDD_32_33:
>> > =A0 =A0 =A0 =A0case MMC_VDD_33_34:
>> > =A0 =A0 =A0 =A0case MMC_VDD_34_35:
>> > @@ -1111,11 +1116,10 @@ static int mmc_init_card(struct mmc_host
>> > *host, u32 ocr,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd_bits =3D (bus_width =3D=3D =
MMC_BUS_WIDTH_8) ?
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_BUS_WIDTH_8 :
>> > EXT_CSD_BUS_WIDTH_4;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_powerclass(card,=
 ext_csd_bits,
>> > ext_csd);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power cl=
ass selection to bus width
>> > %d failed\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_=
hostname(card->host), 1 <<
>> > bus_width);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: powe=
r class selection to bus
> width %d"
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0" failed\n",
>> > + mmc_hostname(card->host),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A01 << bus_width);
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0/*
>> > @@ -1147,10 +1151,10 @@ static int mmc_init_card(struct mmc_host
>> > *host, u32 ocr,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_=
powerclass(card,
>> > ext_csd_bits[idx][0],
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_e=
rr("%s: power class selection to "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0"bus width %d failed\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0mmc_hostname(card->host),
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A01 << bus_width);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_w=
arning("%s: power class selection to
> "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0"bus width %d failed\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0mmc_hostname(card->host),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A01 << bus_width);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(=
card, EXT_CSD_CMD_SET_NORMAL,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH, @@ -1178,10
>> > +1182,10 @@ static int mmc_init_card(struct mmc_host *host, u32 oc=
r,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_=
powerclass(card,
>> > ext_csd_bits[idx][1],
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_e=
rr("%s: power class selection to "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0"bus width %d ddr %d failed\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0mmc_hostname(card->host),
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A01 << bus_width, ddr);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_w=
arning("%s: power class selection to
> "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0"bus width %d ddr %d
>> > + failed\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0mmc_hostname(card->host),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A01 << bus_width, ddr);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(=
card, EXT_CSD_CMD_SET_NORMAL,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH,
>> > --
>> > 1.7.1.1
>> >
>> > --
>> > Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> > The Qualcomm Innovation Center, Inc. is a member of the Code Auror=
a
>> Forum.
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c"
>> > in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> > info at =A0http://vger.kernel.org/majordomo-info.html
>
