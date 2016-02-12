From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 00/25] MMC/SDHCI fixes
Date: Fri, 12 Feb 2016 15:23:05 +0100
Message-ID: <87ziv6vwhi.fsf@free-electrons.com>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
	<CAPDyKFqEEHudbQ=GiQzrvrTMRynuBzFMNH5K1Yh3ZVU7UsW2mA@mail.gmail.com>
	<56BDAAB0.6010209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44505 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbcBLOXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2016 09:23:08 -0500
In-Reply-To: <56BDAAB0.6010209@intel.com> (Adrian Hunter's message of "Fri, 12
	Feb 2016 11:49:36 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Hi Adrian,
=20
 On ven., f=C3=A9vr. 12 2016, Adrian Hunter <adrian.hunter@intel.com> w=
rote:

> On 04/02/16 12:55, Ulf Hansson wrote:
>> + Adrian
>>=20
>> On 29 January 2016 at 10:43, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Mon, Dec 21, 2015 at 11:39:56AM +0000, Russell King - ARM Linux =
wrote:
>>>> This all started with a report from an iMX6 Hummingboard user that
>>>> they were seeing regular "mmc0: Got data interrupt 0x00000002 even
>>>> though no data operation was in progress." messages with 4.4-rc an=
d
>>>> additional patches to enable UHS support in DT for the platform.
>>>>
>>>> When I tested 4.4-rc on an iMX6 Hummingboard with UHS support enab=
led,
>>>> I found several other issues.  This patch series addresses some of
>>>> the issues.
>>>>
>>>> However, while testing on Armada 388, an issue was found there, an=
d
>>>> a fix is also included in this patch set, however it does not depe=
nd
>>>> on the rest of the patch series.
>>>>
>>>> We all know that the SDHCI driver is in poor state, and Ulf's desi=
re
>>>> to see it turned into a library (which actually comes from myself.=
)
>>>> However, with the driver in such a poor state, it makes sense to f=
ix
>>>> a few of the issues first, especially if they result in the code
>>>> shrinking - which they do.
>>>>
>>>> However, given what I've found below, I have to wonder how many of=
 the
>>>> quirks that we have in this driver are down to the poor code rathe=
r than
>>>> real hardware problems: how many of them are due to poorly investi=
gated
>>>> bugs.
>>>>
>>>> This series starts off by shutting up some kernel messages that sh=
ould
>>>> not be verbose:
>>>> - the voltage-ranges DT property is optional, so we should not pri=
nt
>>>>   a message saying that it's missing from DT.  That suggests it is=
n't
>>>>   optional.  As no ill effect comes from not specifying it, I've
>>>>   dropped this message to debug level.
>>>>
>>>> - reworking the voltage-ranges code so that callers know whether t=
he
>>>>   optional voltage-ranges property was specified.
>>>>
>>>> - "retrying because a re-tune was needed" - a re-tune is something=
 that
>>>>   is part of the higher speed SD specs, and it's required to happe=
n
>>>>   periodically.  So it's expected and normal behaviour.  There's n=
o need
>>>>   to print this to the kernel log.
>>>>
>>>> - When tuning fails, rather than a bland "mmc0: tuning execution f=
ailed"
>>>>   message, print the error code so that we can see what the reason=
 for
>>>>   the failure is.  MMC fails on this point in many places.
>>>>
>>>> - Move the initialisation of the command ->error member.  It looks=
 to
>>>>   me as if this is not required; mmc_start_request() does this alr=
eady,
>>>>   as it seems the rest of the MMC core does too.  Maybe this shoul=
d be
>>>>   removed altogether?
>>>>
>>>> - Testing error bits, then setting the error, then testing the err=
or
>>>>   value, and completing the command is a very lengthy way to deal =
with
>>>>   errors here.  Test the error bits, and then decide what error oc=
curred
>>>>   before completing.  (This code is actually buggy, see the next c=
hange).
>>>>
>>>> - If a command _response_ CRC error occurs, we can't be certain wh=
ether
>>>>   the card received the command successfully, and has started proc=
essing
>>>>   it.  If it has, and it results in data being read from the card,=
 the
>>>>   card will enter data transfer state, and start sending data to t=
he
>>>>   host.  Therefore, it is completely wrong to blindly terminate th=
e
>>>>   command, especially when such termination fails to clean _anythi=
ng_
>>>>   up - eg, it leaves DMA in place so the host can continue DMAing =
to the
>>>>   memory, and it leaves buffers DMA mapped - which eventually anno=
ys the
>>>>   DMA API debugging.  Fix this by assuming that a CRC error is a r=
eceive
>>>>   side error.  If the card did not correctly receive the command, =
it
>>>>   will not initiate a data transfer, and we should time out after =
the
>>>>   card specified timeout.
>>>>
>>>>   With the unmodified mainline code, even if we reset the state ma=
chines
>>>>   when finishing a request in error, the _card_ itself may well st=
ill be
>>>>   in data transfer mode when this happens.  How can we be sure wha=
t state
>>>>   the data side is actually in?  Could this be why (eg) sdhci-esdh=
c-imx.c
>>>>   has this:
>>>>
>>>>         /* FIXME: delay a bit for card to be ready for next tuning=
 due to errors */
>>>>         mdelay(1);
>>>>
>>>>   And how many more such _hacks_ are working around similar proble=
ms?
>>>>
>>>> - The unaligned buffer handling is a total waste of resources in i=
ts
>>>>   current form.  We DMA map, sync, and unmap it on every transfer,
>>>>   whether the buffer is used or not.  For MMC/SD transfers, these =
will
>>>>   be coming from the VFS/MM layers, which operate through the page
>>>>   cache - hence the vast majority of buffers will be page aligned.
>>>>   Performance measurements on iMX6 show that this additional DMA
>>>>   maintanence is responsible for a 10% reduction in read transfer
>>>>   performance.  Switch this to use a DMA coherent mapping instead,=
 which
>>>>   needs no DMA maintanence.
>>>>
>>>> - sdhci_adma_table_post() is badly coded: we walk the scatterlist
>>>>   looking for any buffers which might not be aligned (which can be=
 a
>>>>   rare event, see above) and then we only do something if we find =
an
>>>>   unaligned buffer _and_ it's a read transfer.  So for a write tra=
nsfer,
>>>>   this scatterlist walking is a total waste of CPU cycles.  Testin=
g the
>>>>   transfer direction is much cheaper than walking the scatterlist.
>>>>   Re-organise the code to do the cheap test first.
>>>>
>>>> - There are two paths to identical DMA unmapping code (the code ar=
ound
>>>>   dma_unmap_sg()) in sdhci_finish_data() and its child function
>>>>   sdhci_adma_table_post().  Trivially simplify this duplication.
>>>>
>>>> - Move sdhci_pre_dma_transfer() so we avoid needing to declare it.
>>>>
>>>> - Do the same thing with sdhci_prepare_data() and sdhci_pre_dma_tr=
ansfer()
>>>>   as with sdhci_finish_data() and sdhci_adma_table_post().
>>>>
>>>> - Fix the mess that is the data segment host_cookie handling.  The
>>>>   existing code seems like a candidate for the obfuscated coding p=
rize!
>>>>   Four patches address this, turning it into something much easier=
 to
>>>>   understand, which then allows (finally)...
>>>>
>>>> - The DMA API leak which occurs when we have mapped the DMA buffer=
s in
>>>>   sdhci_prepare_data() and an error occurs early on in the process=
ing
>>>>   of a request.
>>>>
>>>> - A change (mentioned above) which fixes a prior commit for Armada=
 38x
>>>>   using sdhci-pxav3.c, found while trying to get the higher speed =
modes
>>>>   working on these SoCs.  Clearly the existing code is broken, thi=
s at
>>>>   least resolves some of the breakage by allowing the correct high=
-order
>>>>   SDHCI capabilities through.
>>>>
>>>> - Fixing another DMA API leak with the pre/post request handling, =
where
>>>>   a current request can change the state of the SDHCI_REQ_USE_DMA,=
 and
>>>>   thus stop a mapped request being unmapped.
>>>>
>>>> - Fixing the SDHCI timeout calculation code to correctly round tim=
eouts
>>>>   up rather than down, and correctly calculate the time (in micros=
econds)
>>>>   for a certain number of card clocks.
>>>>
>>>> - Consolidating the SDHCI address/size alignment handling so we on=
ly walk
>>>>   the scatterlist once instead of twice.
>>>>
>>>> Further patches are necessary as there are still a number of obser=
vable
>>>> problems when using this driver on iMX6 with UHS cards.  Patches u=
p to
>>>> and including "mmc: sdhci: further fix for DMA unmapping in
>>>> sdhci_post_req()" should be considered for inclusion in the stable
>>>> kernel trees.
>>>>
>>>> I've tested these changes on iMX6 at UHS speeds, and Armada 388 So=
Cs
>>>> at HS speeds so far.  Others should test them.
>>>
>>> One comment from Adrian addressed.
>>>
>>>  drivers/mmc/card/block.c       |   4 +-
>>>  drivers/mmc/core/core.c        |  17 +-
>>>  drivers/mmc/host/sdhci-pxav3.c |   6 +-
>>>  drivers/mmc/host/sdhci.c       | 444 ++++++++++++++++++-----------=
------------
>>>  drivers/mmc/host/sdhci.h       |   4 +-
>>>  5 files changed, 213 insertions(+), 262 deletions(-)
>>>
>>> --
>>> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
>>> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps =
up
>>> according to speedtest.net.
>>=20
>> I have applied patch 1 to 4, for next!
>>=20
>> The rest are sdhci patches, which from now on needs acks from Adrian
>> for me to pick them up.
>
> I have taken the liberty of re-organizing Russell's patches to put th=
e
> bug fixes first with stable cc's.  I also did 2 tweaks which result i=
n
> final code having the diff below to the original:
>
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f857cb2a3d05..03fbb36580f7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2270,7 +2270,7 @@ static void sdhci_cmd_irq(struct sdhci_host *ho=
st, u32 intmask, u32 *mask)
>  		 * will time out.
>  		 */
>  		if (host->cmd->data &&
> -		    intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT) =3D=3D
> +		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) =3D=3D
>  		     SDHCI_INT_CRC) {
>  			host->cmd =3D NULL;
>  			return;
> @@ -2920,7 +2920,8 @@ int sdhci_add_host(struct sdhci_host *host)
>  			pr_warn("%s: Unable to allocate ADMA buffers - falling back to st=
andard DMA\n",
>  				mmc_hostname(mmc));
>  			host->flags &=3D ~SDHCI_USE_ADMA;
> -		} else if (dma & SDHCI_ADMA2_MASK) {
> +		} else if ((dma + host->align_buffer_sz) &
> +			   (SDHCI_ADMA2_DESC_ALIGN - 1)) {
>  			pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
>  				mmc_hostname(mmc));
>  			host->flags &=3D ~SDHCI_USE_ADMA;
>
>
> Where I have made changes, they are indicated in the patch commit.
>
> I did some basic testing of eMMC, SD card and SDIO, for the fixes alo=
ne
> and also the entire patch set.
>
> Russell, please let me know if this is OK, and if so, Ulf please cons=
ider
> pulling:
>
>
> The following changes since commit 7d9e20d2be0d836c4eb7afca901eced342=
74c8dd:
>
>   Merge branch 'fixes' into next (2016-02-08 16:22:56 +0100)
>
> are available in the git repository at:
>
>
>   git://git.infradead.org/users/ahunter/linux-sdhci.git master

Thanks to your branch I was able to test the series on the Armada 38x
boards.

At the beginning my main motivation was to ensure that now thanks to th=
e
patch "mmc: sdhci-pxav3: fix higher speed mode capabilities", we really
manage to support SDR50 and DDR50 modes. However I realized that I don'=
t
have any 1.8V support on the board I have.

So I can't confirm this, but at least I didn't see any regression while
using the SD cards.

Gregory



>
> for you to fetch changes up to eb6bf3c3513d2e2ab77d86bc6c2f2755073f07=
45:
>
>   mmc: sdhci: further code simplication (2016-02-11 16:24:46 +0200)
>
> ----------------------------------------------------------------
> Russell King (22):
>       mmc: sdhci: move initialisation of command error member
>       mmc: sdhci: clean up command error handling
>       mmc: sdhci: fix command response CRC error handling
>       mmc: sdhci: avoid unnecessary mapping/unmapping of align buffer
>       mmc: sdhci: plug DMA mapping leak on error
>       mmc: sdhci-pxav3: fix higher speed mode capabilities
>       mmc: sdhci: further fix for DMA unmapping in sdhci_post_req()
>       mmc: sdhci: fix data timeout (part 1)
>       mmc: sdhci: fix data timeout (part 2)
>       mmc: sdhci: allocate alignment and DMA descriptor buffer togeth=
er
>       mmc: sdhci: clean up coding style in sdhci_adma_table_pre()
>       mmc: sdhci: avoid walking SG list for writes
>       mmc: sdhci: factor out common DMA cleanup in sdhci_finish_data(=
)
>       mmc: sdhci: move sdhci_pre_dma_transfer()
>       mmc: sdhci: factor out sdhci_pre_dma_transfer() from sdhci_adma=
_table_pre()
>       mmc: sdhci: pass the cookie into sdhci_pre_dma_transfer()
>       mmc: sdhci: always unmap a mapped data transfer in sdhci_post_r=
eq()
>       mmc: sdhci: clean up host cookie handling
>       mmc: sdhci: cleanup DMA un-mapping
>       mmc: sdhci: prepare DMA address/size quirk handling consolidati=
on
>       mmc: sdhci: consolidate the DMA/ADMA size/address quicks
>       mmc: sdhci: further code simplication
>
>  drivers/mmc/host/sdhci-pxav3.c |   6 ++-
>  drivers/mmc/host/sdhci.c       | 444 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++--------------------------------=
-----------------------------------------------------------
>  drivers/mmc/host/sdhci.h       |   4 +-
>  3 files changed, 200 insertions(+), 254 deletions(-)
>
>
> Regards
> Adrian

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
