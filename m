From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
Date: Tue, 12 Jun 2018 16:42:34 +0800
Message-ID: <20180612084234.gjzq66xsqblryrkm@shbuild888>
References: <20180608095154.22413-1-feng.tang@intel.com>
 <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

Thanks for the review.

On Tue, Jun 12, 2018 at 08:25:44AM +0200, Ulf Hansson wrote:
> On 8 June 2018 at 11:51, Feng Tang <feng.tang@intel.com> wrote:
> > When doing some boot time optimization for an eMMC rootfs NUCs,
> > we found the rootfs may spend around 100 microseconds waiting
> > for eMMC card to be initialized, then the rootfs could be
> > mounted.
> >         [    1.216561] Waiting for root device /dev/mmcblk1p1...
> >         [    1.289262] mmc1: new HS400 MMC card at address 0001
> >         [    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
> >         [    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
> >         [    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
> >         [    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
> >         [    1.292798]  mmcblk1: p1 p2 p3
> >         [    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
> >         [    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
> >
> > And this is a common problem for smartphones, tablets, embedded
> > devices and automotive products. This patch will make the eMMC/SD
> > card  start initializing earlier, by changing its order in drivers/Makefile.
> >
> > On our platform, the waiting for eMMC card is almost eliminated with the patch,
> > which is critical to boot time.
> 
> I am wondering what kernel version you are running here. There have
> been some changes to the mmc initialization path, which perhaps can
> help.
These logs in commit msg are based on kernel 4.14, and the patch is generated
against kernel 4.17.

> 
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  drivers/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 24cd47014657..c473afd3c688 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)               += regulator/
> >  # reset controllers early, since gpu drivers might rely on them to initialize
> >  obj-$(CONFIG_RESET_CONTROLLER) += reset/
> >
> > +# put mmc early as many morden devices use emm/sd card as rootfs storage
> > +obj-y                          += mmc/
> > +
> 
> Your suggested approach isn't really a solution, as it may work for
> your particular case but not for everybody else.

Do you mean the patch may break some platforms? Yes, I only tested on
some IA based NUCs, and I did think about other architectures, things
that may affect MMC are gpio/clk/pinctrl, and those are still earlier
than mmc after change.

Thanks,
Feng
