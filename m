From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/3] tmio: add a platform flag to disable card
	write-protection detection
Date: Tue, 11 May 2010 21:17:57 +0900
Message-ID: <AANLkTilDX0gAIbHVaUt7JPZyLvUBLEd_UA1RaMYnvCZY@mail.gmail.com>
References: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
	 <Pine.LNX.4.64.1005111150500.6810@axis700.grange>
	 <AANLkTikkOqraPO8CoGSxyVZSDObII42CdJcIj-GG6lz_@mail.gmail.com>
	 <Pine.LNX.4.64.1005111414200.6810@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:53318 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0EKMSA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2010 08:18:00 -0400
In-Reply-To: <Pine.LNX.4.64.1005111414200.6810@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org

On Tue, May 11, 2010 at 9:15 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Tue, 11 May 2010, Magnus Damm wrote:
>
>> Hi Guennadi,
>>
>> Many thanks for your work on this!
>>
>> On Tue, May 11, 2010 at 6:52 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Write-protection status is not always available, e.g., micro-SD ca=
rds do not
>> > have a write-protection switch at all. This patch adds a flag to l=
et platforms
>> > force tmio_mmc to consider the card writable.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>> > =A0drivers/mmc/host/tmio_mmc.c | =A0 =A05 ++++-
>> > =A0include/linux/mfd/tmio.h =A0 =A0| =A0 =A04 ++++
>> > =A02 files changed, 8 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_m=
mc.c
>> > index 7e79ba4..11c19b0 100644
>> > --- a/drivers/mmc/host/tmio_mmc.c
>> > +++ b/drivers/mmc/host/tmio_mmc.c
>> > @@ -640,8 +640,11 @@ static void tmio_mmc_set_ios(struct mmc_host =
*mmc, struct mmc_ios *ios)
>> > =A0static int tmio_mmc_get_ro(struct mmc_host *mmc)
>> > =A0{
>> > =A0 =A0 =A0 =A0struct tmio_mmc_host *host =3D mmc_priv(mmc);
>> > + =A0 =A0 =A0 struct mfd_cell *cell =3D host->pdev->dev.platform_d=
ata;
>> > + =A0 =A0 =A0 struct tmio_mmc_data *pdata =3D cell->driver_data;
>> >
>> > - =A0 =A0 =A0 return (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT=
_WRPROTECT) ? 0 : 1;
>> > + =A0 =A0 =A0 return ((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) =
||
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sd_ctrl_read32(host, CTL_STATUS) & =
TMIO_STAT_WRPROTECT)) ? 0 : 1;
>> > =A0}
>>
>> It's a bit late so perhaps I'm thinking backwards, but isn't this
>> logic inverted?
>>
>> Fact: The WP signal is missing from the micro-sd slot on the kfr2r09
>> board, and the card incorrectly comes up write protected.
>>
>> Solution: TMIO_MMC_WRPROTECT_DISABLE is set to make sure the card is
>> _not_ write protected by mistake.
>>
>> But: The code using the ->reg_ro() callback assumes that the card is
>> read-only if 1 is returned according to drivers/mmc/core/sd.c. The
>> code above returns 1 if TMIO_MMC_WRPROTECT_DISABLE is set. So the ca=
rd
>> will be forced read-only on kfr2r09 unless i'm mistaken, and this do=
es
>> not help so much. =3D)
>
> I think above is right, please, look again. If TMIO_MMC_WRPROTECT_DIS=
ABLE
> is set, the function returns 0.

Err, yeah, you are correct. I overlooked the "?" part... Looking good!

Thanks,

/ magnus
