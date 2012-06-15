From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Fri, 15 Jun 2012 09:47:42 +0900
Message-ID: <CANqRtoS3JqNHFXcOutssQxpD6DNnyV1QawT2hf251z5d05LJWw@mail.gmail.com>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com>
	<1538938.WjgJgiBpYR@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60186 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab2FOAro convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 20:47:44 -0400
In-Reply-To: <1538938.WjgJgiBpYR@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Jun 15, 2012 at 4:12 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Thursday 14 June 2012 20:12:33 Magnus Damm wrote:
>> On Tue, Jun 12, 2012 at 9:57 PM, Laurent Pinchart wrote:
>> > The tmio_mmc_set_ios() function configures the MMC power, clock an=
d bus
>> > width. When the MMC controller gets powered off, runtime PM switch=
es the
>> > MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwa=
rds
>> > fails and prints an error message to the kernel log.
>> >
>> > As configuring the bus width is pointless when the interface gets
>> > powered down, skip the operation when power is off.
>> >
>> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com=
>
>>
>> First of all, thanks for reporting this issue and coming up with a f=
ix!
>
> You're welcome. You can expect more of them ;-)
>
>> Can you please explain a bit more about when this triggers? Is this
>> related to suspend-to-ram perhaps? Which hardware platform? Is
>> CONFIG_PM_RUNTIME=3Dy set?
>
> I've noticed the problem on the Armadillo board with CONFIG_PM_RUNTIM=
E=3Dy. The
> driver spits out "timeout waiting for SD bus idle" error messages mor=
e or less
> continuously.

I see, thanks for explaining.

>> I suspect that this may be a side effect of the current PM code used
>> on the A1 SoC (which is hooked up on the armadillo board).
>>
>> In short, the A1 SoC does not yet make use of PM domains, but AP4 an=
d
>> the mackerel board (sh7372 based) is using PM domains.
>
> Does this mean that runtime PM is a no-op on A1 ? That would surprise=
 me, as
> turning CONFIG_PM_RUNTIME off gets rid of the problem, so runtime PM =
is
> somehow involved. Even if the power domain does not get turned off, c=
an't the
> MSTP clock be turned off ?

The behavior may be different depending on how the pm domains are tied =
in.

>> This difference may result in different state of clocks at suspend-t=
o-ram
>> timing. So the SDHI driver may work just fine on the mackerel board,=
 but not
>> on the armadillo board. If that's the case then perhaps we shouldn't=
 fix the
>> driver, but instead look at the platform level.
>
> I still believe there's a bug in the driver, please see below.
>
>> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c
>> > b/drivers/mmc/host/tmio_mmc_pio.c index 9a7996a..de1226d 100644
>> > --- a/drivers/mmc/host/tmio_mmc_pio.c
>> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> > @@ -816,13 +816,15 @@ static void tmio_mmc_set_ios(struct mmc_host=
 *mmc,
>> > struct mmc_ios *ios) tmio_mmc_clk_stop(host);
>> > =A0 =A0 =A0 =A0}
>> >
>> > - =A0 =A0 =A0 switch (ios->bus_width) {
>> > - =A0 =A0 =A0 case MMC_BUS_WIDTH_1:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_SD_MEM_CAR=
D_OPT, 0x80e0);
>> > - =A0 =A0 =A0 break;
>> > - =A0 =A0 =A0 case MMC_BUS_WIDTH_4:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_SD_MEM_CAR=
D_OPT, 0x00e0);
>> > - =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 if (host->power) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (ios->bus_width) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BUS_WIDTH_1:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host=
, CTL_SD_MEM_CARD_OPT,
>> > 0x80e0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BUS_WIDTH_4:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host=
, CTL_SD_MEM_CARD_OPT,
>> > 0x00e0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0/* Let things settle. delay taken from winCE driver=
 */
>> > --
>> > 1.7.3.4
>>
>> Is it possible that you get here through tmio_mmc_host_suspend() and
>> mmc_suspend_host()?
>>
>> Just guessing. =3D)
>
> I haven't checked the complete call stack, but I don't think it matte=
rs that
> much.

I suppose that depends on what you are trying to fix. =3D)

> What happens here is that the driver tried to write to a 16-bit hardw=
are
> register after calling pm_runtime_put(). At that point runtime PM may=
 have
> turned to power domain and/or the MSTP clock off for the device. Writ=
ing to a
> 16-bit register first polls for the bus idle bit in the CTL_STATUS2 t=
o be set.
> This never happens in this case (probably because the clock has been =
turned
> off), so the write operation fails.
>
> Speaking generally, I think we should avoid writing to the device aft=
er
> calling pm_runtime_put(), it just doesn't make much sense. If we rele=
ase the
> device from a PM point of view, it means we don't need to touch it an=
ymore, so
> we should prevent writes until the next pm_runtime_get_sync() call.

I totally agree with you on that. I'm just surprised that it triggers
at this point.

Guennadi, does this trigger on sh7372 as well? If not, why is that?

Thanks for your help!

/ magnus
