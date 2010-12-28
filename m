From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: Test bus-width for old MMC devices (v2)
Date: Tue, 28 Dec 2010 03:27:37 -0500
Message-ID: <AANLkTinkskR0_3LsZtjy_iA6ti1cKDWCe=Verq8DSkvs@mail.gmail.com>
References: <s5hfwtzbj8v.wl%tiwai@suse.de>
	<20101216234032.GA17239@void.printf.net>
	<50D31EC8-BD9E-4920-8CEB-2AD10DF9C5C5@marvell.com>
	<20101217034342.GA19673@void.printf.net>
	<s5hy67o95to.wl%tiwai@suse.de>
	<AANLkTimSt5a998m1oqdppsWjGCVid0-Ub81pKgsPR36f@mail.gmail.com>
	<E81C83FE-E3AD-49DA-86BE-95631F1B81CD@marvell.com>
	<AANLkTim6pQW0sDtZRNbXbgbvzuXKCdsju7z_ADBxvXPd@mail.gmail.com>
	<s5h62umnpxb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40882 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0L1I1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2010 03:27:39 -0500
In-Reply-To: <s5h62umnpxb.wl%tiwai@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, Aries Lee <arieslee@jmicron.com>, Qiming Wu <wuqm@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 22, 2010 at 3:59 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 21 Dec 2010 22:56:32 -0500,
> zhangfei gao wrote:
>>
>> On Tue, Dec 21, 2010 at 11:36 AM, Philip Rakity <prakity@marvell.com=
> wrote:
>> >
>> >
>> > Can you please try this diff and see if it works for you.
>> >
>> > Will do formal patch after your testing. =A0What card is failing ?
>> >
>> > Please let me know the manufacturing information so can add card t=
o my test suite.
>> >
>> > Philip
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 1d8409f..77072c8 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -558,6 +558,8 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ext_csd_bits[idx][0]);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_=
set_bus_width_ddr(card->host,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width, MMC_SDR_MODE);
>> Test OK,
>> Curious why move here, then mmc_set_bus_width_ddr is called twice in
>> fact when ddr=3D0 && =A0(!(host->caps & MMC_CAP_BUS_WIDTH_TEST)), th=
ough
>> not impact function.
>> mmc_set_bus_width is mmc_set_bus_width_ddr(host, width, MMC_SDR_MODE=
).
>
> Right. =A0How about the patch below? =A0This one just moves the call
> before caps test, so it's simpler (and avoiding double calls).
>
>
> thanks,
>
> Takashi
>
> =3D=3D=3D
> From b66b9704f8d2fefa402741fb17949224b2766b4f Mon Sep 17 00:00:00 200=
1
> From: Takashi Iwai <tiwai@suse.de>
> Date: Wed, 22 Dec 2010 09:54:33 +0100
> Subject: [PATCH] mmc: fix mmc_set_bus_width_ddr() call without bus-wi=
dth-test cap
>
> With the bus-width test patch, mmc_set_bus_width*() isn't called prop=
erly
> when the driver doesn't set MMC_CAP_BUS_WIDTH and no DDR mode.
> This patch fixes the regression by moving the call up before the cap =
test.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1d8409f..c86dd73 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -558,6 +558,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd_bits[idx][0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set=
_bus_width_ddr(card->host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width, MMC_SDR_MODE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If =
controller can't handle bus width test,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * use=
 the highest bus width to maintain
> @@ -565,8 +567,6 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(=
host->caps & MMC_CAP_BUS_WIDTH_TEST))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set=
_bus_width_ddr(card->host,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width, MMC_SDR_MODE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D=
 mmc_bus_test(card, bus_width);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!e=
rr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0break;
> --
> 1.7.3.4

It's also works, solve (ddr=3D0 & (!(host->caps & MMC_CAP_BUS_WIDTH_TES=
T))) issue.
Is it possible to merge to original patch.

Thanks
>
>
>
