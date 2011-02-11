From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 07:48:44 +0800
Message-ID: <20110211234843.GD9289@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
	<19794.17994.381937.158944@ipc1.ka-ro>
	<20110211220821.GA9289@S2100-06.ap.freescale.net>
	<19797.19780.128209.60173@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19797.19780.128209.60173@ipc1.ka-ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 11, 2011 at 03:52:52PM +0100, Lothar Wa=DFmann wrote:
> Hi,
> =

> Shawn Guo writes:
> > Hi Lothar,
> > =

> > On Wed, Feb 09, 2011 at 08:46:18AM +0100, Lothar Wa=DFmann wrote:
> > > Hi Shawn,
> > > =

> > > Shawn Guo writes:
> > > > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > > > The driver calls into mxs-dma via generic dmaengine api for both pio
> > > > and data transfer.
> > > > =

> > > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > > ---
> > > >  arch/arm/mach-mxs/include/mach/mmc.h |   15 +
> > > >  drivers/mmc/host/Kconfig             |    9 +
> > > >  drivers/mmc/host/Makefile            |    1 +
> > > >  drivers/mmc/host/mxs-mmc.c           |  884 ++++++++++++++++++++++=
++++++++++++
> > > >  4 files changed, 909 insertions(+), 0 deletions(-)
> > > >  create mode 100644 arch/arm/mach-mxs/include/mach/mmc.h
> > > >  create mode 100644 drivers/mmc/host/mxs-mmc.c
> > > > =

> > > I've run the mmc-test kernel module with this driver on our TX28
> > > module which fails in the following tests:
> > > |mmc0: Test case 15. Correct xfer_size at write (start failure)...
> > > |mmc0: Result: ERROR (-110)
> > > |mmc0: Test case 16. Correct xfer_size at read (start failure)...
> > > |mmc0: Result: ERROR (-110)
> > > |mmc0: Test case 17. Correct xfer_size at write (midway failure)...
> > > |mmc0: Result: ERROR (-110)
> > > |mmc0: Test case 18. Correct xfer_size at read (midway failure)...
> > > |mmc0: Result: ERROR (-110)
> > > =

> > > Could you try the test on your hardware?
> > > =

> > I'm new to this test.  I enabled MMC_TEST but did not see "test"
> > under /sys for mmc.  Can you please elaborate how to launch this
> > test?  Thanks.
> > =

> You need debugfs mounted and the mmc-test module loaded.
> An inserted card will normally be grabbed by the mmc-block driver. You
> can 'unbind' the driver and 'bind' it to the mmc-test driver using the
> corresponding entries in sysfs. The mmc-test driver can be controlled
> via debugfs.
> =

> The following script steals an inserted card from the mmc-block driver
> and performs all mmc-test testcases (TRASHING THE CONTENTS OF THE
> CARD!).
> <--------
> #!/bin/bash
> drv_path=3D/sys/bus/mmc/drivers
> dbg_path=3D/sys/kernel/debug
> testdrv=3Dmmc_test
> =

> shopt -s nullglob
> card=3D""
> =

> cleanup() {
>     if [ -n "$card" -a -n "$driver" -a "$driver" !=3D "$testdrv" ];then
> 	echo "Restoring driver $driver"
> 	echo "$card" > "$drv_path/$testdrv/unbind"
> 	echo "$card" > "$drv_path/$driver/bind"
>     fi
> }
> =

> trap cleanup 0
> set -e
> cd "$drv_path"
> for d in *;do
>     for l in "$d/"*;do
> 	[ -h "$l" ] || continue
> 	card=3D"$(basename "$l")"
> 	driver=3D"$(dirname "$l")"
> 	break
>     done
>     [ -n "$card" ] && break
> done
> if [ -z "$card" ];then
>     echo "No MMC/SD card found"
>     exit 1
> fi
> if [ "$driver" !=3D "$testdrv" ];then
>     echo "Trying to claim card $card from driver $driver"
>     echo "$card" > "$drv_path/$driver/unbind"
>     echo "$card" > "$drv_path/$testdrv/bind"
> fi
> echo "WARNING: Card $card will be overwritten!"
> echo "Hit <ENTER> to continue; <CTRL-C> to abort"
> read
> # perform all testcases (> 0 for individual tests)
> echo 0 > "$dbg_path/${card%:*}/$card/test"
> >--------
> =

Thanks a lot for the test script.  Yes, I'm seeing the same problem
here.  I will try to get it fixed in v2.

Regards,
Shawn
