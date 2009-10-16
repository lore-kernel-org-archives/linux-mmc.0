From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Fri, 16 Oct 2009 15:26:37 -0600
Message-ID: <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <4AD81DC2.4080607@googlemail.com>
	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>
	 <4AD8C959.1000004@googlemail.com>
	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>
List-Id: linux-mmc@vger.kernel.org

It appears to never get cleared in the status register.

I added some printks to sdio_irq.c to print the pending interrupts in
the SDIO_CCCR_INTx register for the card and there are no pending
interrupts so I don't think it is a card driver or card issue.

It would be funny if the TRM was wrong and the CIRQ bit is really
cleared by writing 1 to it.  I'll try that.

John

On Fri, Oct 16, 2009 at 3:14 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: Dirk Behme [mailto:dirk.behme@googlemail.com]
>> Sent: Friday, October 16, 2009 2:28 PM
>> To: Madhusudhan Chikkature
>> Cc: linux-mmc@vger.kernel.org; John Rigby; linux-omap@vger.kernel.or=
g;
>> Steve Sakoman
>> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>>
>> Madhusudhan Chikkature wrote:
>> > Hi Dirk,
>> >
>> > I am inlining the patch so that it helps review.
>> ...
>> > @@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
>> > =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > =A0 =A0 case MMC_BUS_WIDTH_4:
>> > =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, CON, con & ~D=
W8);
>> > - =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, HCTL,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(host->base, =
HCTL) | FOUR_BIT);
>> > + =A0 =A0 =A0 =A0 =A0 if (mmc_card_sdio(host->mmc->card)) {
>> >
>> > I wish it could be moved to "enable_sdio_irq" so that we can avoid
>> inclusion of
>> > card.h and checking the type of card in the host controller driver=
=2E
>>
>> Yes, this would be the real clean way. But ...
>>
>> > But the
>> > dependancy on 4-bit seems to be a problem here.
>>
>> ... most probably we have to find a workaround until (if ever?) abov=
e
>> clean implementation is available.
>>
>> What we need is after SDIO mode and bus width is known, and before t=
he
>> first interrupt comes, to set IBG.
>>
>> > On the problems being discussed on testing is the interrupt source
>> geting
>> > cleared at the SDIO card level upon genaration of the CIRQ? If not=
 it
>> remains
>> > asserted.
>>
>> Yes, this seems to be exactly the problem John reports in his follow
>> up mail.
>>
>> Any hint how to clear SDIO interrupt?
>>
> On the controller side I guess it is cleared when you pass "disable" =
in the
> enable_sdio_irq" fn. This happens when you call mmc_signal_sdio_irq.
>
> I am not too sure about how it gets disabled from the card side. I se=
e that
> SDIO core has a function "sdio_release_irq" which is used by the sdio=
 uart
> driver. The usage of this could give a clue.
>
> Regards,
> Madhu
>
>> Many thanks
>>
>> Dirk
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base,=
 HCTL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0OMAP_HSMMC_READ(host->base, HCTL)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| IBG | FOUR_BIT);
>> > + =A0 =A0 =A0 =A0 =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base,=
 HCTL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0OMAP_HSMMC_READ(host->base, HCTL)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| FOUR_BIT);
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > =A0 =A0 case MMC_BUS_WIDTH_1:
>> > =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, CON, con & ~D=
W8);
>> > @@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
>> > =A0 =A0 return 0;
>> > =A0}
>> >
>> > +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>> enable)
>> > +{
>> > + =A0 struct omap_hsmmc_host *host =3D mmc_priv(mmc);
>> > + =A0 u32 ie, ise;
>> > +
>> > + =A0 ise =3D OMAP_HSMMC_READ(host->base, ISE);
>> > + =A0 ie =A0=3D OMAP_HSMMC_READ(host->base, IE);
>> > +
>> > + =A0 if (enable) {
>> > + =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, ise | CIRQ=
_ENABLE);
>> > + =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, =A0ie =A0| =
CIRQ_ENABLE);
>> > + =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, ise & ~CIR=
Q_ENABLE);
>> > + =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, =A0ie =A0& =
~CIRQ_ENABLE);
>> > + =A0 }
>> > +
>> > +}
>> > +
>> > =A0static const struct mmc_host_ops omap_hsmmc_ops =3D {
>> > =A0 =A0 .enable =3D omap_hsmmc_enable_fclk,
>> > =A0 =A0 .disable =3D omap_hsmmc_disable_fclk,
>> > @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
>> > =A0 =A0 .set_ios =3D omap_hsmmc_set_ios,
>> > =A0 =A0 .get_cd =3D omap_hsmmc_get_cd,
>> > =A0 =A0 .get_ro =3D omap_hsmmc_get_ro,
>> > - =A0 /* NYET -- enable_sdio_irq */
>> > + =A0 .enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
>> > =A0};
>> >
>> > =A0static const struct mmc_host_ops omap_hsmmc_ps_ops =3D {
>> > @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
>> > =A0 =A0 .set_ios =3D omap_hsmmc_set_ios,
>> > =A0 =A0 .get_cd =3D omap_hsmmc_get_cd,
>> > =A0 =A0 .get_ro =3D omap_hsmmc_get_ro,
>> > - =A0 /* NYET -- enable_sdio_irq */
>> > + =A0 .enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
>> > =A0};
>> >
>> > =A0#ifdef CONFIG_DEBUG_FS
>> > @@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
>> > =A0 =A0 mmc->max_seg_size =3D mmc->max_req_size;
>> >
>> > =A0 =A0 mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEE=
D |
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP=
_SDIO_IRQ;
>> >
>> > =A0 =A0 if (mmc_slot(host).wires >=3D 8)
>> > =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>> >
>> >
>> >
>> >
>> >
>> >> John Rigby wrote:
>> >>> I have seen several discussions about lack of sdio irq support i=
n the
>> >>> hsmmc driver but no patches. =A0Has anyone on this list implemen=
ted this
>> >>> and/or can anyone point me to patches?
>> >> What a coincidence ;)
>> >>
>> >> I'm currently working on this. See attachment what I currently ha=
ve.
>> >> It is compile tested only against recent omap linux head. I don't=
 have
>> >> a board using SDIO at the moment, so no real testing possible :(
>> >>
>> >> Some background, maybe it helps people to step in:
>> >>
>> >> Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi=
 by
>> >> MMC port 2 in 4 bit configuration [1]. The wifi performance is qu=
ite
>> >> bad (~100kB/s). There is some rumor that this might be SDIO irq
>> >> related [2]. There was an attempt to fix this [3] already, but th=
is
>> >> doesn't work [4]. Having this, I started to look into it.
>> >>
>> >> I used [3], the TI Davinci driver [5] (supporting SDIO irq), the =
SDIO
>> >> Simplified Specification [6] and the OMAP35x TRM [7] as starting
>> points.
>> >>
>> >> Unfortunately, the Davinci MMC registers and irqs are different
>> >> (Davinci has a dedicated SDIO irq). But combining [3] and [5] hel=
ps to
>> >> get an idea what has to be done.
>> >>
>> >> I think the main issues of [3] were that it doesn't enable IBG fo=
r 4
>> >> bit mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't rese=
t the
>> >> irq bits.
>> >>
>> >> Topics I still open:
>> >>
>> >> - Is it always necessary to deal with IE _and_ ISE register? I'm =
not
>> >> totally clear what the difference between these two registers are=
 ;)
>> >> And in which order they have to be set.
>> >>
>> >> - Davinci driver [5] in line 1115 checks for data line to call
>> >> mmc_signal_sdio_irq() for irq enable.
>> >>
>> >> - Davinci driver deals with SDIO in xfer_done() (line 873)
>> >>
>> >> - Davinci driver sets block size to 64 if SDIO in line 701
>> >>
>> >> It would be quite nice if anybody likes to comment on attachment =
and
>> >> help testing.
>> >>
>> >> Many thanks and best regards
>> >>
>> >> Dirk
>> >>
>> >> [1] http://gumstix.net/wiki/index.php?title=3DOvero_Wifi
>> >>
>> >> [2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb=
56
>> >>
>> >> [3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673=
be
>> >>
>> >> [4] http://groups.google.com/group/beagleboard/msg/5cdfe2a3195319=
37
>> >>
>> >> [5]
>> >> http://arago-project.org/git/projects/?p=3Dlinux-
>> davinci.git;a=3Dblob;f=3Ddrivers/mmc/host/davinci_mmc.c;h=3D1bf05872=
50614c6d8abf
>> e02028b96e0e47148ac8;hb=3DHEAD
>> >>
>> >> [6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/
>> >>
>> >> [7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf
>> >>
>> >>
>> >
>> >
>> >
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
