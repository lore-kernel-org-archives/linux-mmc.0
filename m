From: Chen-Yu Tsai <wens@kernel.org>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Wed, 24 Jul 2019 10:53:32 +0800
Message-ID: <CAGb2v66-o23CW5iH9Bn1aELymPSiKrA43eJd2q6EZ7iubcogaw@mail.gmail.com>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
 <20190723093442.GA27239@lst.de>
 <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
 <b15509d6-bc2e-3d06-0eea-943e6e456d62@gmx.net>
 <5f9b11f54c66fd0487837f7e58af3adf7f86635f.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5f9b11f54c66fd0487837f7e58af3adf7f86635f.camel@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>, Matthias Brugger <mbrugger@suse.com>, "open list:BROADCOM BCM281XX..." <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, Michael Turquette <mturquette@baylibre.com>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "moderated list:BROADCOM BCM2835..." <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 24, 2019 at 1:33 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2019-07-23 at 18:26 +0200, Stefan Wahren wrote:
> > Hi Nicolas,
> >
> > thanks for your work, but i'm a little bit sceptical about these
> > changes. So here some thoughts.
> >
> > Am 23.07.19 um 15:32 schrieb Nicolas Saenz Julienne:
> > > On Tue, 2019-07-23 at 11:34 +0200, Christoph Hellwig wrote:
> > > > On Mon, Jul 22, 2019 at 08:10:17PM +0200, Stefan Wahren wrote:
> > > > > i rebased this series also and got this only on the RPi 4.
> > > > >
> > > > > After reverting the following:
> > > > >
> > > > > 79a986721de dma-mapping: remove dma_max_pfn
> > > > > 7559d612dff0 mmc: core: let the dma map ops handle bouncing
> > > > >
> > > > > This crash disappear, but wifi seems to be still broken.
> > > > >
> > > > > Would be nice, if you can investigate further.
> > > > That means dma addressing on this system doesn't just work for some
> > > > memory, and the mmc bounce buffering was papering over that just for
> > > > mmc.  Do you have highmem on this system?
> > > >
> > > > You might want to try this series, which has been submitted upstream:
> > > >
> > > >
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-swiotlb
> > > Hi Christoph,
> > > I tried your series on top of Stefan's, it has no effect. I guess it's no
> > > surprise as with mult_v7_defconfig, you get SWIOTLB=n & LPAE=n.
> > >
> > > FYI DMA addressing constraints for RPi4 are the following: devices can only
> > > access the first GB of ram even though the board might have up to 4GB of
> > > ram.
> > > The DMA addresses are aliased with a 0xc0000000 offset. So 0x00000000 phys
> > > is
> > > aliased to 0xc0000000 in DMA. This is the same as for an RFC you commented
> > > last
> > > week trying to fix similar issues for arm64.
> > >
> > > You state in "arm: use swiotlb for bounce buffer on LPAE configs" that "The
> > > DMA
> > > API requires that 32-bit DMA masks are always supported". If I understand it
> > > correctly this device breaks that assumption. Which implies we need a bounce
> > > buffer system in place for any straming DMA user.
> > >
> > > It seems we're unable to use dma-direct/swiotlb, so I enabled arm's
> > > dmabounce
> > > on all devices hooked into RPi's limited interconnect, which fixes this
> > > issue.
> > Does it fix the wifi issue too?
>
> Well it works as long as I revert this: 901bb98918 ("nl80211: require and
> validate vendor command policy"). Which has nothing to do with DMA anyways.
>
> Was this the issue you where seeing?
>
> [    4.969679] WARNING: CPU: 2 PID: 21 at net/wireless/core.c:868 wiphy_register+0x8e8/0xbdc [cfg80211]
> [...]
> [    4.969974] ieee80211 phy0: brcmf_cfg80211_attach: Could not register wiphy device (-22)

We're seeing this on different platforms (allwinner / rockchip / amlogic)
with Broadcom WiFi chips. So it's unlikely to be related with anything in
this series.

I believe a fix for this has already been queued up:

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=91046d6364afde646734c7ead1f649d253c386e9

ChenYu
