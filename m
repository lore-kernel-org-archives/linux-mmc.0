From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Thu, 26 Aug 2010 02:50:09 +0100
Message-ID: <AANLkTiko3vN5APNcKbFegOn_XEySyDgBnAoGzyOKSsiZ@mail.gmail.com>
References: <4C33DFF0.3040804@renesas.com> <20100708144647.1e77364b.akpm@linux-foundation.org>
 <4C3BD041.3020705@renesas.com> <20100825225208.02a906f7@linux-g6p1.site> <20100825150502.33649ff0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38652 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0HZBu3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2010 21:50:29 -0400
Received: by iwn5 with SMTP id 5so1112789iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2010 18:50:29 -0700 (PDT)
In-Reply-To: <20100825150502.33649ff0.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Fleming <matt@console-pimps.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Probably dropped because I complained about two things,

1) The patch doesnt check what the hardware is underneath before
arbitrarily changing the parameters relied on by some hardware

2) Removing a comment I put there for a good reason without explaining =
why.

"It works on my hardware" is not a good enough excuse.

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 25 August 2010 23:05, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
> On Wed, 25 Aug 2010 22:52:08 +0100
> Matt Fleming <matt@console-pimps.org> wrote:
>
>> On Tue, 13 Jul 2010 11:32:33 +0900
>> Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
>>
>> > Hi Andrew
>> >
>> > Andrew Morton wrote:
>> > > On Wed, 07 Jul 2010 11:01:20 +0900
>> > > Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
>> > >
>> > >> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>> > >> ---
>> > >> =A0drivers/mmc/host/tmio_mmc.c | =A0 =A02 +-
>> > >> =A01 files changed, 1 insertions(+), 1 deletions(-)
>> > >>
>> > >> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmi=
o_mmc.c
>> > >> index ee7d0a5..cac1c97 100644
>> > >> --- a/drivers/mmc/host/tmio_mmc.c
>> > >> +++ b/drivers/mmc/host/tmio_mmc.c
>> > >> @@ -661,7 +661,7 @@ static int tmio_mmc_start_data(struct tmio_=
mmc_host *host,
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->blksz, data->blocks);
>> > >>
>> > >> =A0 =A0 =A0 =A0 =A0/* Hardware cannot perform 1 and 2 byte requ=
ests in 4 bit mode */
>> > >> - =A0 =A0 =A0 =A0if (data->blksz < 4 && host->mmc->ios.bus_widt=
h =3D=3D MMC_BUS_WIDTH_4) {
>> > >> + =A0 =A0 =A0 =A0if (data->blksz < 2 && host->mmc->ios.bus_widt=
h =3D=3D MMC_BUS_WIDTH_4) {
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: %d byte block un=
supported in 4 bit mode\n",
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(ho=
st->mmc), data->blksz);
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> > >
>> > > Again, please provide a suitable description for this change.
>> > I think the data size is not limited by MMC_BUS_WIDTH_x.
>> > I confirmed that data transmission of 2Byte was performed without =
a problem.
>>
>> This patch hasn't been picked up. I'm assuming that's because Andrew=
 is
>> still unhappy with the changelog.
>
> Actually I don't know what happened with this. =A0I merged it on July=
 8
> and appear to have dropped it on July 27, but I can't find its
> removed-from-mm email so I don't know why I dropped it. =A0Weird.
>
> Oh well, I merged it again. =A0Is 2.6.37 an appropriate merge schedul=
e?
>
> Also, I tend not to handle tmio_mmc patches - usually Paul patches th=
at
> driver.
>
>> Andrew, how about something like,
>>
>> "When running in 4-bit bus width mode, it is entirely possible to
>> transfer data in block sizes of 2 bytes and larger. Relax the
>> conditional check to allow 2-byte data block transfers which were
>> previously disallowed."
>
> thanks.
>
>> Yusuke, have I interpreted your changelog correctly? Also note that
>> your patch should remove the comment above the conditional that says=
,
>> "Hardware cannot perform 1 and 2 byte requests in 4 bit mode".
>
> this?
>
> --- a/drivers/mmc/host/tmio_mmc.c~tmio_mmc-revise-a-limit-of-the-data=
-size-fix
> +++ a/drivers/mmc/host/tmio_mmc.c
> @@ -660,7 +660,6 @@ static int tmio_mmc_start_data(struct tm
> =A0 =A0 =A0 =A0pr_debug("setup data transfer: blocksize %08x =A0nr_bl=
ocks %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->blksz, data->blocks);
>
> - =A0 =A0 =A0 /* Hardware cannot perform 1 and 2 byte requests in 4 b=
it mode */
> =A0 =A0 =A0 =A0if (data->blksz < 2 && host->mmc->ios.bus_width =3D=3D=
 MMC_BUS_WIDTH_4) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: %d byte block unsupported =
in 4 bit mode\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc), =
data->blksz);
> _
>
>
