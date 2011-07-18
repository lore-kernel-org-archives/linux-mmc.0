From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock
 frequency
Date: Tue, 19 Jul 2011 07:27:58 +0800
Message-ID: <20110719072758.20dd400e@jbarnes-e6510>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com>
	<m2sjqa2q93.fsf@bob.laptop.org>
	<alpine.DEB.2.02.1107131031360.3174@lazy>
	<201107131835.25217.arnd@arndb.de>
	<m262n62kgf.fsf@bob.laptop.org>
	<alpine.DEB.2.02.1107131154000.3174@lazy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1107131154000.3174@lazy>
Sender: linux-pci-owner@vger.kernel.org
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 13 Jul 2011 11:54:40 -0500 (CDT)
Manoj Iyer <manoj.iyer@canonical.com> wrote:

> 
> > On Wed, Jul 13 2011, Arnd Bergmann wrote:
> >> Not much. This card only has a 6MB/s write speed, which is well
> >> below what a 50 MHz bus can do. It mgiht be different on a fast
> >> eMMC device or a Sandisk Extreme Pro UHS-1 card.
> >
> > Okay, I see.  I think we're good for now, then -- hopefully anyone
> > using a UHS card on their laptop will see the printk when wondering
> > why their performance isn't great and get in touch with us, and we
> > can investigate more then.
> >
> > I've pushed Manoj's patch to mmc-next for 3.1 now, with the printk
> > changes and a stable@ tag.
> >
> 
> Thanks Chris!

Assuming you can't move the patch into the MMC driver itself, you can
add my acked-by for the PCI quirk addition.

Thanks,
Jesse
