From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 02/12] mmc: sd: add support for signal voltage switch procedure
Date: Wed, 16 Mar 2011 06:44:20 -0400
Message-ID: <AANLkTimLHgGTfDdLjM7PqGpNyuXMS4s_tNHZYO_XjPzq@mail.gmail.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
	<1299238369-1768-3-git-send-email-arindam.nath@amd.com>
	<001a01cbe2fa$55a10b30$00e32190$@org>
	<6C03668EAF45B747AF947A1603D1B300E3C33656@SAUSEXMBP01.amd.com>
	<002001cbe302$c0ae76d0$420b6470$@org>
	<6C03668EAF45B747AF947A1603D1B300E3C3368B@SAUSEXMBP01.amd.com>
	<002c01cbe308$40afd5e0$c20f81a0$@org>
	<AANLkTimF=uqA+N4Jskhqyd+OqBYQ+aQgHAKZaPOAGu7i@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300E3D223A3@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39987 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab1CPKoW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2011 06:44:22 -0400
Received: by vws1 with SMTP id 1so1467161vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2011 03:44:21 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300E3D223A3@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, "cjb@laptop.org" <cjb@laptop.org>, "prakity@marvell.com" <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Wed, Mar 16, 2011 at 2:30 AM, Nath, Arindam <Arindam.Nath@amd.com> w=
rote:
> Hi Zhangfei,
>
>
>> -----Original Message-----
>> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
>> Sent: Wednesday, March 16, 2011 8:33 AM
>> To: Subhash Jadavani; Nath, Arindam
>> Cc: cjb@laptop.org; prakity@marvell.com; linux-mmc@vger.kernel.org; =
Su,
>> Henry; Lu, Aaron; anath.amd@gmail.com
>> Subject: Re: [PATCH v2 02/12] mmc: sd: add support for signal voltag=
e
>> switch procedure
>>
>> On Tue, Mar 15, 2011 at 7:58 AM, Subhash Jadavani
>> <subhashj@codeaurora.org> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Nath, Arindam [mailto:Arindam.Nath@amd.com]
>> >> Sent: Tuesday, March 15, 2011 4:59 PM
>> >> To: Subhash Jadavani; cjb@laptop.org
>> >> Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
>> >> mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
>> >> Subject: RE: [PATCH v2 02/12] mmc: sd: add support for signal
>> voltage
>> >> switch procedure
>> >>
>> >> Hi Subhash,
>> >>
>> >>
>> >> > -----Original Message-----
>> >> > From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
>> >> > Sent: Tuesday, March 15, 2011 4:49 PM
>> >> > To: Nath, Arindam; cjb@laptop.org
>> >> > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
>> >> > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
>> >> > Subject: RE: [PATCH v2 02/12] mmc: sd: add support for signal
>> voltage
>> >> > switch procedure
>> >> >
>> >> >
>> >> >
>> >> > > -----Original Message-----
>> >> > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> >> > > owner@vger.kernel.org] On Behalf Of Nath, Arindam
>> >> > > Sent: Tuesday, March 15, 2011 4:03 PM
>> >> > > To: Subhash Jadavani; cjb@laptop.org
>> >> > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
>> >> > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.co=
m
>> >> > > Subject: RE: [PATCH v2 02/12] mmc: sd: add support for signal
>> >> voltage
>> >> > > switch procedure
>> >> > >
>> >> > > Hi Subhash,
>> >> > >
>> >> > >
>> >> > > > -----Original Message-----
>> >> > > > From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
>> >> > > > Sent: Tuesday, March 15, 2011 3:48 PM
>> >> > > > To: Nath, Arindam; cjb@laptop.org
>> >> > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
>> >> > > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.=
com
>> >> > > > Subject: RE: [PATCH v2 02/12] mmc: sd: add support for sign=
al
>> >> > voltage
>> >> > > > switch procedure
>> >> > > >
>> >> > > > Arindam,
>> >> > > >
>> >> > > > During voltage switch, voltage level for CLK, DATA and CMD
>> >> > pads/pins
>> >> > > > should
>> >> > > > be changed from 3.3v to 1.8v. for this SD controller has to
>> >> modify
>> >> > > few
>> >> > > > bits
>> >> > > > in their controller registers and also have to set the volt=
age
>> >> > level
>> >> > > of
>> >> > > > a
>> >> > > > regulator which is powering those pad/pins.
>> >> > > >
>> >> > > > Now with you current patch, you are calling
>> >> > > start_signal_voltage_switch
>> >> > > > mmc_ops when you want to switch from 3.3v to 1.8v and each
>> >> > controller
>> >> > > > driver
>> >> > > > would then perform above operation in their handler (modify=
ing
>> >> > > relevant
>> >> > > > controller register and setting the voltage level) along wi=
th
>> >> SD3.0
>> >> > > > spec
>> >> > > > requirements.
>> >> > > >
>> >> > > > Now let's say after all above initialization and some data
>> >> transfer
>> >> > > > with
>> >> > > > UHS-I card, card is removed from the slot. Now if I insert =
the
>> >> > > > SDHC/SDSC
>> >> > > > card (with SDv2.0 support) then how will controller undone =
the
>> >> > above
>> >> > > > voltage
>> >> > > > switch operations (means changing pad/ping voltage level ba=
ck
>> >> from
>> >> > > 1.8v
>> >> > > > to
>> >> > > > 3.3v)?
>> >> > > >
>> >> > > > To avoid above issue, we can have one new entry in mmc_ios
>> which
>> >> > > > specifies
>> >> > > > the voltage level required for CLK, DATA, CMD pins (0 =3D 3=
=2E3v,
>> 1 =3D
>> >> > > > 1.8v).
>> >> > > > This entry would be set once start_signal_voltage_switch op=
s
>> >> > returns
>> >> > > > success. So now when card is removed and new card is insert=
ed,
>> at
>> >> > the
>> >> > > > start
>> >> > > > of initialization we should make sure that set_ios() gets
>> called
>> >> > with
>> >> > > > this
>> >> > > > entry reset (0) which would make sure that CLK, DATA and CM=
D
>> >> > > pads/pins
>> >> > > > voltage level back to 3.3v.
>> >> > >
>> >> > > Rather than following the procedure mentioned above, can we
>> simply
>> >> > not
>> >> > > reset 1.8V signaling enable in the Host Control2 register whe=
n a
>> >> card
>> >> > > is removed? Will that serve the purpose?
>> >> >
>> >> > How will the host controller driver comes to know that card is
>> >> removed
>> >> > (assuming that there is no hardware based card detection
>> available)?
>> >>
>> >> Correct me if wrong, but I think bit 7 of Normal Interrupt Status
>> >> Register can inform regarding the card removal event.
>> >
>> > Sorry. But again I have to make this point clear. It's not necessa=
ry
>> that
>> > all host controller implementation would be same as your host
>> controller
>> > implementation. In our host controller we don't have any such stat=
us
>> bit for
>> > card removal event.
>> >
>> >>
>> >> > And I
>> >> > don't think host controller driver itself should take decision =
to
>> >> > revert
>> >> > back from 1.8v to 3.3v until core layer tells it do so.
>> >> >
>> >> > Regarding clearing the bit in Host Control2 register, it's
>> specific
>> >> to
>> >> > your
>> >> > controller. Not all controllers/platform will have same bits
>> >>
>> >> As part of signal voltage switch procedure, we set 1.8V signaling
>> >> enable in the Host Control2 register. So the same bit can be rese=
t
>> to
>> >> set the signaling voltage back to 3.3V.
>> >
>> > Same as my above comment.
>> >
>> >
>> >>
>> >> =A0and also
>> >> > some
>> >> > controller might have to do something extra than setting few bi=
ts
>> in
>> >> > controller registers. In our case for switching from 3.3v to 1.=
8v,
>> >> > other
>> >> > than setting one of the controller register bit, we also need t=
o
>> set
>> >> > the
>> >> > voltage level of a regulator which is powering these interface
>> pins
>> >> > CMD,
>> >> > DATA, CLK.
>> >>
>> >> In that case I will modify the code to add an entry into mmc_ios =
as
>> per
>> >> your suggestion.
>> >
>> > What about removing start_signal_voltage_switch ops itself and jus=
t
>> adding
>> > one entry in ios for voltage_switch? Whenever you want to switch t=
he
>> voltage
>> > level from 1.8v to 2.7v call set_ios() with this new entry set and
>> when you
>> > want to go back from 1.8v to 2.7v call set_ios() with this new ent=
ry
>> reset.
>>
>> Not sure set_ios is a good place to change voltage, which need some
>> time to wait for voltage to be stable, no matter voltage provided by
>> controller or external pmic, while set_ios is protected by spin_lock=
=2E
>> Besides, find start_signal_voltage_switch is not protected by
>> spin_lock when accessing register, it would be not safe.
>
> I agree with you. Moreover, as Nicolas mentioned in one of the discus=
sions before, during signal voltage switching, there should not be any =
concurrent access, so we don't need locking anyways. That's why the cur=
rent implementation has done away with locking. I am planning to implem=
ent using a variable inside mmc_ios and not part of set_ios(). This sho=
uld be able to cater to the needs of all host controllers.

How about add spin_lock/unlock outside of sleep and protect the
register accessing?
>
> Thanks,
> Arindam
>
>>
>> >
>> >>
>> >> Thanks,
>> >> Arindam
>> >>
>> >> >
>> >> >
>> >> >
>> >> > >
>> >> > > Thanks,
>> >> > > Arindam
>> >> > >
>> >> > > >
>> >> > > > Regards,
>> >> > > > Subhash
>> >> > > >
>> >> > > >
>> >> > > > > -----Original Message-----
>> >> > > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> >> > > > > owner@vger.kernel.org] On Behalf Of Arindam Nath
>> >> > > > > Sent: Friday, March 04, 2011 5:03 PM
>> >> > > > > To: cjb@laptop.org
>> >> > > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
>> >> > > > > subhashj@codeaurora.org; linux-mmc@vger.kernel.org;
>> >> > > henry.su@amd.com;
>> >> > > > > aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
>> >> > > > > Subject: [PATCH v2 02/12] mmc: sd: add support for signal
>> >> voltage
>> >> > > > > switch procedure
>> >> > > > >
>> >> > > > > Host Controller v3.00 adds another Capabilities register.
>> Apart
>> >> > > > > from other things, this new register indicates whether th=
e
>> Host
>> >> > > > > Controller supports SDR50, SDR104, and DDR50 UHS-I modes.
>> The
>> >> > spec
>> >> > > > > doesn't mention about explicit support for SDR12 and SDR2=
5
>> UHS-
>> >> I
>> >> > > > > modes, so the Host Controller v3.00 should support them b=
y
>> >> > default.
>> >> > > > > Also if the controller support SDR104 mode, it will also
>> >> support
>> >> > > > > SDR50 mode as well. So depending on the host support, we =
set
>> >> the
>> >> > > > > corresponding MMC_CAP_* flags. One more new register. Hos=
t
>> >> > Control2
>> >> > > > > is added in v3.00, which is used during Signal Voltage
>> Switch
>> >> > > > > procedure described below.
>> >> > > > >
>> >> > > > > Since as per v3.00 spec, UHS-I supported hosts should set
>> S18R
>> >> > > > > to 1, we set S18R (bit 24) of OCR before sending ACMD41. =
We
>> >> also
>> >> > > > > need to set XPC (bit 28) of OCR in case the host can supp=
ly
>> >> > >150mA.
>> >> > > > > This support is indicated by the Maximum Current
>> Capabilities
>> >> > > > > register of the Host Controller.
>> >> > > > >
>> >> > > > > If the response of ACMD41 has both CCS and S18A set, we
>> start
>> >> the
>> >> > > > > signal voltage switch procedure, which if successfull, wi=
ll
>> >> > switch
>> >> > > > > the card from 3.3V signalling to 1.8V signalling. Signal
>> >> voltage
>> >> > > > > switch procedure adds support for a new command CMD11 in =
the
>> >> > > > > Physical Layer Spec v3.01. As part of this procedure, we
>> need
>> >> to
>> >> > > > > set 1.8V Signalling Enable (bit 3) of Host Control2
>> register,
>> >> > which
>> >> > > > > if remains set after 5ms, means the switch to 1.8V
>> signalling
>> >> is
>> >> > > > > successfull. Otherwise, we clear bit 24 of OCR and retry =
the
>> >> > > > > initialization sequence.
>> >> > > > >
>> >> > > > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
>> >> > > > > ---
>> >> > > > > =A0drivers/mmc/core/sd.c =A0 =A0 | =A0 37 ++++++++++-
>> >> > > > > =A0drivers/mmc/core/sd_ops.c | =A0 32 ++++++++++
>> >> > > > > =A0drivers/mmc/core/sd_ops.h | =A0 =A01 +
>> >> > > > > =A0drivers/mmc/host/sdhci.c =A0| =A0148
>> >> > > > > +++++++++++++++++++++++++++++++++++++++++----
>> >> > > > > =A0drivers/mmc/host/sdhci.h =A0| =A0 18 +++++-
>> >> > > > > =A0include/linux/mmc/host.h =A0| =A0 10 +++
>> >> > > > > =A0include/linux/mmc/sd.h =A0 =A0| =A0 =A01 +
>> >> > > > > =A07 files changed, 229 insertions(+), 18 deletions(-)
>> >> > > > >
>> >> > > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.=
c
>> >> > > > > index b3f8a3c..3e82599 100644
>> >> > > > > --- a/drivers/mmc/core/sd.c
>> >> > > > > +++ b/drivers/mmc/core/sd.c
>> >> > > > > @@ -408,6 +408,7 @@ struct device_type sd_type =3D {
>> >> > > > > =A0int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32
>> *cid)
>> >> > > > > =A0{
>> >> > > > > =A0 =A0 int err;
>> >> > > > > + =A0 u32 rocr;
>> >> > > > >
>> >> > > > > =A0 =A0 /*
>> >> > > > > =A0 =A0 =A0* Since we're changing the OCR value, we seem =
to
>> >> > > > > @@ -427,10 +428,25 @@ int mmc_sd_get_cid(struct mmc_host
>> *host,
>> >> > u32
>> >> > > > > ocr, u32 *cid)
>> >> > > > > =A0 =A0 if (!err)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 ocr |=3D 1 << 30;
>> >> > > > >
>> >> > > > > - =A0 err =3D mmc_send_app_op_cond(host, ocr, NULL);
>> >> > > > > + =A0 /* If the host can supply more than 150mA, XPC shou=
ld be
>> >> set
>> >> > to
>> >> > > > > 1. */
>> >> > > > > + =A0 if (host->caps & (MMC_CAP_SET_XPC_330 |
>> MMC_CAP_SET_XPC_300
>> >> |
>> >> > > > > + =A0 =A0 =A0 MMC_CAP_SET_XPC_180))
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 ocr |=3D 1 << 28;
>> >> > > > > +
>> >> > > > > + =A0 err =3D mmc_send_app_op_cond(host, ocr, &rocr);
>> >> > > > > =A0 =A0 if (err)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> >> > > > >
>> >> > > > > + =A0 /*
>> >> > > > > + =A0 =A0* In case CCS and S18A in the response is set, s=
tart
>> >> Signal
>> >> > > > > Voltage
>> >> > > > > + =A0 =A0* Switch procedure. SPI mode doesn't support CMD=
11.
>> >> > > > > + =A0 =A0*/
>> >> > > > > + =A0 if (!mmc_host_is_spi(host) && (rocr & 0x41000000)) =
{
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 err =3D mmc_start_voltage_switch(ho=
st);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 if (err)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> >> > > > > + =A0 }
>> >> > > > > +
>> >> > > > > =A0 =A0 if (mmc_host_is_spi(host))
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_cid(host, cid);
>> >> > > > > =A0 =A0 else
>> >> > > > > @@ -827,11 +843,26 @@ int mmc_attach_sd(struct mmc_host
>> *host)
>> >> > > > > =A0 =A0 }
>> >> > > > >
>> >> > > > > =A0 =A0 /*
>> >> > > > > + =A0 =A0* If the host supports one of UHS-I modes, reque=
st the
>> >> card
>> >> > > > > + =A0 =A0* to switch to 1.8V signaling level.
>> >> > > > > + =A0 =A0*/
>> >> > > > > + =A0 if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_S=
DR25
>> |
>> >> > > > > + =A0 =A0 =A0 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
>> >> > > MMC_CAP_UHS_DDR50))
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 host->ocr |=3D (1 << 24);
>> >> > > > > +
>> >> > > > > + =A0 /*
>> >> > > > > =A0 =A0 =A0* Detect and init the card.
>> >> > > > > =A0 =A0 =A0*/
>> >> > > > > =A0 =A0 err =3D mmc_sd_init_card(host, host->ocr, NULL);
>> >> > > > > - =A0 if (err)
>> >> > > > > - =A0 =A0 =A0 =A0 =A0 goto err;
>> >> > > > > + =A0 if (err =3D=3D -EAGAIN) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 /*
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0* Retry initialization with S18R=
 set to 0.
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 host->ocr &=3D ~(1 << 24);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_init_card(host, host=
->ocr, NULL);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 if (err)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> >> > > > > + =A0 }
>> >> > > > >
>> >> > > > > =A0 =A0 mmc_release_host(host);
>> >> > > > > =A0 =A0 err =3D mmc_add_card(host->card);
>> >> > > > > diff --git a/drivers/mmc/core/sd_ops.c
>> >> > b/drivers/mmc/core/sd_ops.c
>> >> > > > > index 797cdb5..8a23e2e 100644
>> >> > > > > --- a/drivers/mmc/core/sd_ops.c
>> >> > > > > +++ b/drivers/mmc/core/sd_ops.c
>> >> > > > > @@ -146,6 +146,38 @@ int mmc_app_set_bus_width(struct
>> mmc_card
>> >> > > *card,
>> >> > > > > int width)
>> >> > > > > =A0 =A0 return 0;
>> >> > > > > =A0}
>> >> > > > >
>> >> > > > > +int mmc_start_voltage_switch(struct mmc_host *host)
>> >> > > > > +{
>> >> > > > > + =A0 struct mmc_command cmd;
>> >> > > > > + =A0 int err;
>> >> > > > > +
>> >> > > > > + =A0 BUG_ON(!host);
>> >> > > > > +
>> >> > > > > + =A0 /*
>> >> > > > > + =A0 =A0* If the host does not provide signal voltage sw=
itch
>> >> > > procedure,
>> >> > > > > we
>> >> > > > > + =A0 =A0* set S18R to 0, and then retry initialization
>> sequence.
>> >> > > > > + =A0 =A0*/
>> >> > > > > + =A0 if (!host->ops->start_signal_voltage_switch)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> >> > > > > +
>> >> > > > > + =A0 memset(&cmd, 0, sizeof(struct mmc_command));
>> >> > > > > +
>> >> > > > > + =A0 cmd.opcode =3D SD_SWITCH_VOLTAGE;
>> >> > > > > + =A0 cmd.arg =3D 0;
>> >> > > > > + =A0 cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>> >> > > > > +
>> >> > > > > + =A0 err =3D mmc_wait_for_cmd(host, &cmd, 0);
>> >> > > > > + =A0 if (err)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 return err;
>> >> > > > > +
>> >> > > > > + =A0 if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERR=
OR))
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 return -EIO;
>> >> > > > > +
>> >> > > > > + =A0 err =3D host->ops->start_signal_voltage_switch(host=
);
>> >> > > > > +
>> >> > > > > + =A0 return err;
>> >> > > > > +}
>> >> > > > > +
>> >> > > > > =A0int mmc_send_app_op_cond(struct mmc_host *host, u32 oc=
r,
>> u32
>> >> > > *rocr)
>> >> > > > > =A0{
>> >> > > > > =A0 =A0 struct mmc_command cmd;
>> >> > > > > diff --git a/drivers/mmc/core/sd_ops.h
>> >> > b/drivers/mmc/core/sd_ops.h
>> >> > > > > index ffc2305..3cfba59 100644
>> >> > > > > --- a/drivers/mmc/core/sd_ops.h
>> >> > > > > +++ b/drivers/mmc/core/sd_ops.h
>> >> > > > > @@ -20,6 +20,7 @@ int mmc_app_send_scr(struct mmc_card
>> *card,
>> >> u32
>> >> > > > > *scr);
>> >> > > > > =A0int mmc_sd_switch(struct mmc_card *card, int mode, int
>> group,
>> >> > > > > =A0 =A0 u8 value, u8 *resp);
>> >> > > > > =A0int mmc_app_sd_status(struct mmc_card *card, void *ssr=
);
>> >> > > > > +int mmc_start_voltage_switch(struct mmc_host *host);
>> >> > > > >
>> >> > > > > =A0#endif
>> >> > > > >
>> >> > > > > diff --git a/drivers/mmc/host/sdhci.c
>> >> b/drivers/mmc/host/sdhci.c
>> >> > > > > index 8914a25..5487a0b 100644
>> >> > > > > --- a/drivers/mmc/host/sdhci.c
>> >> > > > > +++ b/drivers/mmc/host/sdhci.c
>> >> > > > > @@ -85,6 +85,8 @@ static void sdhci_dumpregs(struct
>> sdhci_host
>> >> > > *host)
>> >> > > > > =A0 =A0 printk(KERN_DEBUG DRIVER_NAME ": Cmd: =A0 =A0 =A0=
0x%08x | Max
>> >> curr:
>> >> > > > > 0x%08x\n",
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readw(host, SDHCI_COMMAND),
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_MAX_CURRE=
NT));
>> >> > > > > + =A0 printk(KERN_DEBUG DRIVER_NAME ": Host ctl2: 0x%08x\=
n",
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 sdhci_readw(host, SDHCI_HOST_CONTRO=
L2));
>> >> > > > >
>> >> > > > > =A0 =A0 if (host->flags & SDHCI_USE_ADMA)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG DRIVER_NAME ": =
ADMA Err:
>> 0x%08x |
>> >> > > ADMA
>> >> > > > > Ptr: 0x%08x\n",
>> >> > > > > @@ -1337,11 +1339,70 @@ out:
>> >> > > > > =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
>> >> > > > > =A0}
>> >> > > > >
>> >> > > > > +static int sdhci_start_signal_voltage_switch(struct
>> mmc_host
>> >> > *mmc)
>> >> > > > > +{
>> >> > > > > + =A0 struct sdhci_host *host;
>> >> > > > > + =A0 u8 pwr;
>> >> > > > > + =A0 u16 clk, ctrl;
>> >> > > > > + =A0 u32 present_state;
>> >> > > > > +
>> >> > > > > + =A0 host =3D mmc_priv(mmc);
>> >> > > > > +
>> >> > > > > + =A0 /* Stop SDCLK */
>> >> > > > > + =A0 host =3D mmc_priv(mmc);
>> >> > > > > + =A0 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> >> > > > > + =A0 clk &=3D ~SDHCI_CLOCK_CARD_EN;
>> >> > > > > + =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> >> > > > > +
>> >> > > > > + =A0 /* Check whether DAT[3:0] is 0000 */
>> >> > > > > + =A0 present_state =3D sdhci_readl(host, SDHCI_PRESENT_S=
TATE);
>> >> > > > > + =A0 if (!((present_state & SDHCI_DATA_LVL_MASK) >>
>> >> > > > > SDHCI_DATA_LVL_SHIFT)) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 /* Enable 1.8V Signal Enable in the=
 Host
>> Control2
>> >> > > register
>> >> > > > > */
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HO=
ST_CONTROL2);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_VDD_180;
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl, SDHCI_HOST=
_CONTROL2);
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 /* Wait for 5ms */
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 usleep_range(5000, 5500);
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HO=
ST_CONTROL2);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 if (ctrl & SDHCI_CTRL_VDD_180) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Provide SDCLK ag=
ain and wait for
>> 1ms*/
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D sdhci_readw=
(host,
>> >> SDHCI_CLOCK_CONTROL);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk |=3D SDHCI_CLOC=
K_CARD_EN;
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, =
clk,
>> >> SDHCI_CLOCK_CONTROL);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(1000, =
1500);
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If DAT[3:0] le=
vel is 1111b, then the
>> >> card
>> >> > > was
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* successfully s=
witched to 1.8V
>> signaling.
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 present_state =3D s=
dhci_readl(host,
>> >> > > > > SDHCI_PRESENT_STATE);
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((present_state =
&
>> SDHCI_DATA_LVL_MASK)
>> >> =3D=3D
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_DA=
TA_LVL_MASK) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret=
urn 0;
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 }
>> >> > > > > + =A0 }
>> >> > > > > +
>> >> > > > > + =A0 /*
>> >> > > > > + =A0 =A0* If we are here, that means the switch to 1.8V
>> signaling
>> >> > > > > failed. Stop
>> >> > > > > + =A0 =A0* power to the card, and retry initialization se=
quence
>> by
>> >> > > > > setting S18R
>> >> > > > > + =A0 =A0* to 0.
>> >> > > > > + =A0 =A0*/
>> >> > > > > + =A0 pwr =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
>> >> > > > > + =A0 pwr &=3D ~SDHCI_POWER_ON;
>> >> > > > > + =A0 sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>> >> > > > > +
>> >> > > > > + =A0 return -EAGAIN;
>> >> > > > > +}
>> >> > > > > +
>> >> > > > > =A0static const struct mmc_host_ops sdhci_ops =3D {
>> >> > > > > =A0 =A0 .request =A0 =A0 =A0 =A0=3D sdhci_request,
>> >> > > > > =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D sdhci_set_ios,
>> >> > > > > =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D sdhci_get_ro,
>> >> > > > > =A0 =A0 .enable_sdio_irq =3D sdhci_enable_sdio_irq,
>> >> > > > > + =A0 .start_signal_voltage_switch =A0 =A0=3D
>> >> > > > > sdhci_start_signal_voltage_switch,
>> >> > > > > =A0};
>> >> > > > >
>> >> > > > >
>> >> > > > >
>> >> > > >
>> >> > >
>> >> >
>> >>
>> /*******************************************************************=
***
>> >> > > > > *******\
>> >> > > > > @@ -1799,7 +1860,9 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host)=
;
>> >> > > > > =A0int sdhci_add_host(struct sdhci_host *host)
>> >> > > > > =A0{
>> >> > > > > =A0 =A0 struct mmc_host *mmc;
>> >> > > > > - =A0 unsigned int caps, ocr_avail;
>> >> > > > > + =A0 u32 caps[2];
>> >> > > > > + =A0 u32 max_current_caps;
>> >> > > > > + =A0 unsigned int ocr_avail;
>> >> > > > > =A0 =A0 int ret;
>> >> > > > >
>> >> > > > > =A0 =A0 WARN_ON(host =3D=3D NULL);
>> >> > > > > @@ -1822,12 +1885,15 @@ int sdhci_add_host(struct sdhci_h=
ost
>> >> > *host)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->version);
>> >> > > > > =A0 =A0 }
>> >> > > > >
>> >> > > > > - =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) =
? host-
>> >> >caps
>> >> > :
>> >> > > > > + =A0 caps[0] =3D (host->quirks & SDHCI_QUIRK_MISSING_CAP=
S) ?
>> host-
>> >> > > >caps
>> >> > > > > :
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILIT=
IES);
>> >> > > > >
>> >> > > > > + =A0 if (host->version >=3D SDHCI_SPEC_300)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 caps[1] =3D sdhci_readl(host,
>> SDHCI_CAPABILITIES_1);
>> >> > > > > +
>> >> > > > > =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_SDMA;
>> >> > > > > - =A0 else if (!(caps & SDHCI_CAN_DO_SDMA))
>> >> > > > > + =A0 else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 DBG("Controller doesn't have SDMA
>> capability\n");
>> >> > > > > =A0 =A0 else
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_SDMA;
>> >> > > > > @@ -1838,7 +1904,8 @@ int sdhci_add_host(struct sdhci_hos=
t
>> >> *host)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI_USE_SDMA;
>> >> > > > > =A0 =A0 }
>> >> > > > >
>> >> > > > > - =A0 if ((host->version >=3D SDHCI_SPEC_200) && (caps &
>> >> > > > > SDHCI_CAN_DO_ADMA2))
>> >> > > > > + =A0 if ((host->version >=3D SDHCI_SPEC_200) &&
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 (caps[0] & SDHCI_CAN_DO_ADMA2))
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_ADMA;
>> >> > > > >
>> >> > > > > =A0 =A0 if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
>> >> > > > > @@ -1892,10 +1959,10 @@ int sdhci_add_host(struct sdhci_h=
ost
>> >> > *host)
>> >> > > > > =A0 =A0 }
>> >> > > > >
>> >> > > > > =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
>> >> > > > > - =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps &
>> SDHCI_CLOCK_V3_BASE_MASK)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps[0] &
>> >> SDHCI_CLOCK_V3_BASE_MASK)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> SDHCI_CLOCK_BA=
SE_SHIFT;
>> >> > > > > =A0 =A0 else
>> >> > > > > - =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps & SDHCI_CLO=
CK_BASE_MASK)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps[0] &
>> SDHCI_CLOCK_BASE_MASK)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> SDHCI_CLOCK_BA=
SE_SHIFT;
>> >> > > > >
>> >> > > > > =A0 =A0 host->max_clk *=3D 1000000;
>> >> > > > > @@ -1911,7 +1978,7 @@ int sdhci_add_host(struct sdhci_hos=
t
>> >> *host)
>> >> > > > > =A0 =A0 }
>> >> > > > >
>> >> > > > > =A0 =A0 host->timeout_clk =3D
>> >> > > > > - =A0 =A0 =A0 =A0 =A0 (caps & SDHCI_TIMEOUT_CLK_MASK) >>
>> >> > > SDHCI_TIMEOUT_CLK_SHIFT;
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 (caps[0] & SDHCI_TIMEOUT_CLK_MASK) =
>>
>> >> > > > > SDHCI_TIMEOUT_CLK_SHIFT;
>> >> > > > > =A0 =A0 if (host->timeout_clk =3D=3D 0) {
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->get_timeout_clock)=
 {
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk=
 =3D host->ops-
>> >> > > > > >get_timeout_clock(host);
>> >> > > > > @@ -1923,7 +1990,7 @@ int sdhci_add_host(struct sdhci_hos=
t
>> >> *host)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> > > > > =A0 =A0 }
>> >> > > > > - =A0 if (caps & SDHCI_TIMEOUT_CLK_UNIT)
>> >> > > > > + =A0 if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk *=3D 1000;
>> >> > > > >
>> >> > > > > =A0 =A0 /*
>> >> > > > > @@ -1950,21 +2017,76 @@ int sdhci_add_host(struct sdhci_h=
ost
>> >> > *host)
>> >> > > > > =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA=
))
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA=
;
>> >> > > > >
>> >> > > > > - =A0 if (caps & SDHCI_CAN_DO_HISPD)
>> >> > > > > + =A0 if (caps[0] & SDHCI_CAN_DO_HISPD)
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPE=
ED |
>> >> > > MMC_CAP_MMC_HIGHSPEED;
>> >> > > > >
>> >> > > > > =A0 =A0 if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETEC=
TION)
>> &&
>> >> > > > > =A0 =A0 =A0 =A0 mmc_card_is_removable(mmc))
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEEDS_POLL=
;
>> >> > > > >
>> >> > > > > + =A0 /* UHS-I mode(s) supported by the host controller. =
*/
>> >> > > > > + =A0 if (host->version >=3D SDHCI_SPEC_300)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR12 |
>> MMC_CAP_UHS_SDR25;
>> >> > > > > +
>> >> > > > > + =A0 /* SDR104 supports also implies SDR50 support */
>> >> > > > > + =A0 if (caps[1] & SDHCI_SUPPORT_SDR104)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR104 |
>> >> MMC_CAP_UHS_SDR50;
>> >> > > > > + =A0 else if (caps[1] & SDHCI_SUPPORT_SDR50)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR50;
>> >> > > > > +
>> >> > > > > + =A0 if (caps[1] & SDHCI_SUPPORT_DDR50)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_DDR50;
>> >> > > > > +
>> >> > > > > =A0 =A0 ocr_avail =3D 0;
>> >> > > > > - =A0 if (caps & SDHCI_CAN_VDD_330)
>> >> > > > > + =A0 /*
>> >> > > > > + =A0 =A0* According to SD Host Controller spec v3.00, if=
 the
>> Host
>> >> > > System
>> >> > > > > + =A0 =A0* can afford more than 150mA, Host Driver should=
 set
>> XPC
>> >> to
>> >> > 1.
>> >> > > > > Also
>> >> > > > > + =A0 =A0* the value is meaningful only if Voltage Suppor=
t in
>> the
>> >> > > > > Capabilities
>> >> > > > > + =A0 =A0* register is set. The actual current value is 4=
 times
>> the
>> >> > > > > register
>> >> > > > > + =A0 =A0* value.
>> >> > > > > + =A0 =A0*/
>> >> > > > > + =A0 max_current_caps =3D sdhci_readl(host, SDHCI_MAX_CU=
RRENT);
>> >> > > > > +
>> >> > > > > + =A0 if (caps[0] & SDHCI_CAN_VDD_330) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 int max_current_330;
>> >> > > > > +
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail |=3D MMC_VDD_32_33 | MM=
C_VDD_33_34;
>> >> > > > > - =A0 if (caps & SDHCI_CAN_VDD_300)
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 max_current_330 =3D ((max_current_c=
aps &
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_330_MASK)
>> >>
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_330_SHIFT)
>> *
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_MULTIPLIER;
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 if (max_current_330 > 150)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_=
CAP_SET_XPC_330;
>> >> > > > > + =A0 }
>> >> > > > > + =A0 if (caps[0] & SDHCI_CAN_VDD_300) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 int max_current_300;
>> >> > > > > +
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail |=3D MMC_VDD_29_30 | MM=
C_VDD_30_31;
>> >> > > > > - =A0 if (caps & SDHCI_CAN_VDD_180)
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 max_current_300 =3D ((max_current_c=
aps &
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_300_MASK)
>> >>
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_300_SHIFT)
>> *
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_MULTIPLIER;
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 if (max_current_300 > 150)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_=
CAP_SET_XPC_300;
>> >> > > > > + =A0 }
>> >> > > > > + =A0 if (caps[0] & SDHCI_CAN_VDD_180) {
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 int max_current_180;
>> >> > > > > +
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail |=3D MMC_VDD_165_195;
>> >> > > > >
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 max_current_180 =3D ((max_current_c=
aps &
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_180_MASK)
>> >>
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_180_SHIFT)
>> *
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_MAX_CURRENT_MULTIPLIER;
>> >> > > > > +
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 if (max_current_180 > 150)
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_=
CAP_SET_XPC_180;
>> >> > > > > + =A0 }
>> >> > > > > +
>> >> > > > > =A0 =A0 mmc->ocr_avail =3D ocr_avail;
>> >> > > > > =A0 =A0 mmc->ocr_avail_sdio =3D ocr_avail;
>> >> > > > > =A0 =A0 if (host->ocr_avail_sdio)
>> >> > > > > @@ -2024,7 +2146,7 @@ int sdhci_add_host(struct sdhci_hos=
t
>> >> *host)
>> >> > > > > =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048)=
 {
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D 2;
>> >> > > > > =A0 =A0 } else {
>> >> > > > > - =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D (caps &
>> SDHCI_MAX_BLOCK_MASK)
>> >> >>
>> >> > > > > + =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D (caps[0] &
>> >> SDHCI_MAX_BLOCK_MASK)
>> >> > >>
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
DHCI_MAX_BLOCK_SHIFT;
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->max_blk_size >=3D 3) {
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNI=
NG "%s: Invalid maximum
>> >> > block
>> >> > > size,
>> >> > > > > "
>> >> > > > > diff --git a/drivers/mmc/host/sdhci.h
>> >> b/drivers/mmc/host/sdhci.h
>> >> > > > > index 223762c..95d70e6 100644
>> >> > > > > --- a/drivers/mmc/host/sdhci.h
>> >> > > > > +++ b/drivers/mmc/host/sdhci.h
>> >> > > > > @@ -69,6 +69,8 @@
>> >> > > > > =A0#define =A0SDHCI_DATA_AVAILABLE =A0 =A0 =A00x00000800
>> >> > > > > =A0#define =A0SDHCI_CARD_PRESENT =A0 =A0 =A0 =A00x0001000=
0
>> >> > > > > =A0#define =A0SDHCI_WRITE_PROTECT =A0 =A0 =A0 0x00080000
>> >> > > > > +#define =A0SDHCI_DATA_LVL_MASK =A0 =A0 =A0 0x00F00000
>> >> > > > > +#define =A0 SDHCI_DATA_LVL_SHIFT =A0 =A0 20
>> >> > > > >
>> >> > > > > =A0#define SDHCI_HOST_CONTROL =A0 =A0 =A0 =A0 0x28
>> >> > > > > =A0#define =A0SDHCI_CTRL_LED =A0 =A0 =A0 =A0 =A0 =A00x01
>> >> > > > > @@ -147,7 +149,8 @@
>> >> > > > >
>> >> > > > > =A0#define SDHCI_ACMD12_ERR =A0 0x3C
>> >> > > > >
>> >> > > > > -/* 3E-3F reserved */
>> >> > > > > +#define SDHCI_HOST_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x3E
>> >> > > > > +#define =A0SDHCI_CTRL_VDD_180 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x0008
>> >> > > > >
>> >> > > > > =A0#define SDHCI_CAPABILITIES 0x40
>> >> > > > > =A0#define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A00x0000003F
>> >> > > > > @@ -168,9 +171,20 @@
>> >> > > > > =A0#define =A0SDHCI_CAN_VDD_180 0x04000000
>> >> > > > > =A0#define =A0SDHCI_CAN_64BIT =A0 0x10000000
>> >> > > > >
>> >> > > > > +#define =A0SDHCI_SUPPORT_SDR50 =A0 =A0 =A0 0x00000001
>> >> > > > > +#define =A0SDHCI_SUPPORT_SDR104 =A0 =A0 =A00x00000002
>> >> > > > > +#define =A0SDHCI_SUPPORT_DDR50 =A0 =A0 =A0 0x00000004
>> >> > > > > +
>> >> > > > > =A0#define SDHCI_CAPABILITIES_1 =A0 =A0 =A0 0x44
>> >> > > > >
>> >> > > > > -#define SDHCI_MAX_CURRENT =A00x48
>> >> > > > > +#define SDHCI_MAX_CURRENT =A0 =A0 =A0 =A0 =A00x48
>> >> > > > > +#define =A0SDHCI_MAX_CURRENT_330_MASK =A0 =A0 =A0 =A00x0=
000FF
>> >> > > > > +#define =A0SDHCI_MAX_CURRENT_330_SHIFT =A0 =A0 =A0 0
>> >> > > > > +#define =A0SDHCI_MAX_CURRENT_300_MASK =A0 =A0 =A0 =A00x0=
0FF00
>> >> > > > > +#define =A0SDHCI_MAX_CURRENT_300_SHIFT =A0 =A0 =A0 8
>> >> > > > > +#define =A0SDHCI_MAX_CURRENT_180_MASK =A0 =A0 =A0 =A00xF=
=460000
>> >> > > > > +#define =A0SDHCI_MAX_CURRENT_180_SHIFT =A0 =A0 =A0 16
>> >> > > > > +#define =A0 SDHCI_MAX_CURRENT_MULTIPLIER =A0 =A0 4
>> >> > > > >
>> >> > > > > =A0/* 4C-4F reserved for more max current */
>> >> > > > >
>> >> > > > > diff --git a/include/linux/mmc/host.h
>> >> b/include/linux/mmc/host.h
>> >> > > > > index bcb793e..ad7daa3 100644
>> >> > > > > --- a/include/linux/mmc/host.h
>> >> > > > > +++ b/include/linux/mmc/host.h
>> >> > > > > @@ -117,6 +117,8 @@ struct mmc_host_ops {
>> >> > > > >
>> >> > > > > =A0 =A0 /* optional callback for HC quirks */
>> >> > > > > =A0 =A0 void =A0 =A0(*init_card)(struct mmc_host *host, s=
truct
>> mmc_card
>> >> > > *card);
>> >> > > > > +
>> >> > > > > + =A0 int =A0 =A0 (*start_signal_voltage_switch)(struct m=
mc_host
>> >> > *host);
>> >> > > > > =A0};
>> >> > > > >
>> >> > > > > =A0struct mmc_card;
>> >> > > > > @@ -173,6 +175,14 @@ struct mmc_host {
>> >> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DDR mode at
>> 1.2V
>> >> > */
>> >> > > > > =A0#define MMC_CAP_POWER_OFF_CARD =A0 =A0 (1 << 13) =A0 =A0=
 =A0 /* Can
>> >> power
>> >> > > off
>> >> > > > after
>> >> > > > > boot */
>> >> > > > > =A0#define MMC_CAP_BUS_WIDTH_TEST =A0 =A0 (1 << 14) =A0 =A0=
 =A0 /*
>> >> > CMD14/CMD19
>> >> > > bus
>> >> > > > > width ok */
>> >> > > > > +#define MMC_CAP_UHS_SDR12 =A0(1 << 15) =A0 =A0 =A0 /* Ho=
st supports
>> >> UHS
>> >> > > SDR12
>> >> > > > > mode */
>> >> > > > > +#define MMC_CAP_UHS_SDR25 =A0(1 << 16) =A0 =A0 =A0 /* Ho=
st supports
>> >> UHS
>> >> > > SDR25
>> >> > > > > mode */
>> >> > > > > +#define MMC_CAP_UHS_SDR50 =A0(1 << 17) =A0 =A0 =A0 /* Ho=
st supports
>> >> UHS
>> >> > > SDR50
>> >> > > > > mode */
>> >> > > > > +#define MMC_CAP_UHS_SDR104 (1 << 18) =A0 =A0 =A0 /* Host=
 supports
>> >> UHS
>> >> > > SDR104
>> >> > > > > mode */
>> >> > > > > +#define MMC_CAP_UHS_DDR50 =A0(1 << 19) =A0 =A0 =A0 /* Ho=
st supports
>> >> UHS
>> >> > > DDR50
>> >> > > > > mode */
>> >> > > > > +#define MMC_CAP_SET_XPC_330 =A0 =A0 =A0 =A0(1 << 20) =A0=
 =A0 =A0 /* Host
>> >> > > supports >150mA
>> >> > > > > current at 3.3V */
>> >> > > > > +#define MMC_CAP_SET_XPC_300 =A0 =A0 =A0 =A0(1 << 21) =A0=
 =A0 =A0 /* Host
>> >> > > supports >150mA
>> >> > > > > current at 3.0V */
>> >> > > > > +#define MMC_CAP_SET_XPC_180 =A0 =A0 =A0 =A0(1 << 22) =A0=
 =A0 =A0 /* Host
>> >> > > supports >150mA
>> >> > > > > current at 1.8V */
>> >> > > > >
>> >> > > > > =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0=
 =A0 =A0/* supported pm
>> >> > > features */
>> >> > > > >
>> >> > > > > diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/s=
d.h
>> >> > > > > index 178363b..3ba5aa6 100644
>> >> > > > > --- a/include/linux/mmc/sd.h
>> >> > > > > +++ b/include/linux/mmc/sd.h
>> >> > > > > @@ -17,6 +17,7 @@
>> >> > > > > =A0/* This is basically the same command as for MMC with =
some
>> >> > quirks.
>> >> > > > */
>> >> > > > > =A0#define SD_SEND_RELATIVE_ADDR =A0 =A0 3 =A0 /* bcr
>> >> > > R6
>> >> > > > > */
>> >> > > > > =A0#define SD_SEND_IF_COND =A0 =A0 =A0 =A0 =A0 8 =A0 /* b=
cr =A0[11:0] See
>> below
>> >> > > R7
>> >> > > > > */
>> >> > > > > +#define SD_SWITCH_VOLTAGE =A0 =A0 =A0 =A0 11 =A0/* ac
>> >> > > R1
>> >> > > > > */
>> >> > > > >
>> >> > > > > =A0 =A0/* class 10 */
>> >> > > > > =A0#define SD_SWITCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6 =A0=
 /* adtc [31:0] See
>> below
>> >> > > R1
>> >> > > > > */
>> >> > > > > --
>> >> > > > > 1.7.1
>> >> > > > >
>> >> > > > > --
>> >> > > > > To unsubscribe from this list: send the line "unsubscribe
>> >> linux-
>> >> > > mmc"
>> >> > > > in
>> >> > > > > the body of a message to majordomo@vger.kernel.org
>> >> > > > > More majordomo info at =A0http://vger.kernel.org/majordom=
o-
>> >> > info.html
>> >> > > >
>> >> > >
>> >> > >
>> >> > > --
>> >> > > To unsubscribe from this list: send the line "unsubscribe lin=
ux-
>> >> mmc"
>> >> > in
>> >> > > the body of a message to majordomo@vger.kernel.org
>> >> > > More majordomo info at =A0http://vger.kernel.org/majordomo-
>> info.html
>> >> >
>> >>
>> >
>> >
>> >
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
