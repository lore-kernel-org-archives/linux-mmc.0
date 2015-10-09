From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/5] mmc: sdhci-pxav3: enable usage of DAT3 pin as HW
 card detect
Date: Fri, 9 Oct 2015 14:46:19 +0100
Message-ID: <20151009134619.GS32532@n2100.arm.linux.org.uk>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
 <1444352635-21965-3-git-send-email-mw@semihalf.com>
 <20151009201356.78488116@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151009201356.78488116@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Marcin Wojtas <mw@semihalf.com>, thomas.petazzoni@free-electrons.com, andrew@lunn.ch, ulf.hansson@linaro.org, jason@lakedaemon.net, tawfik@marvell.com, jaz@semihalf.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nadavh@marvell.com, alior@marvell.com, gregory.clement@free-electrons.com, linux-arm-kernel@lists.infradead.org, sebastian.hesselbarth@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 09, 2015 at 08:13:56PM +0800, Jisheng Zhang wrote:
> On Fri, 9 Oct 2015 03:03:52 +0200
> Marcin Wojtas <mw@semihalf.com> wrote:
> 
> > Marvell Armada 38x SDHCI controller enable using DAT3 pin as a hardware
> > card detection. According to the SD sdandard this signal can be used for
> > this purpose combined with a pull-up resistor, implying inverted (active
> > low) polarization of a card detect. MMC standard does not support this
> > feature and does not operate with such connectivity of DAT3.
> > 
> > When using DAT3-based detection Armada 38x SDIO IP expects its internal
> > clock to be always on, which had to be ensured twofold:
> 
> What happen if runtime suspend disables its core clk and axi clk? I guess
> dat3-based detection isn't compatible with runtime pm. If so, do we also
> need to disable runtime pm in probe function?
> 
> > - Each time controller is reset by updating appropriate registers. On the
> >   occasion of adding new register @0x104, register @0x100 name is modified
> >   in order to the be aligned with Armada 38x documentation.
> > - Leaving the clock enabled despite power-down. For this purpose a new
> >   quirk had to be added to SDHCI subsystem - SDHCI_QUIRK2_KEEP_INT_CLK_ON.
> 
> As seen from other mails, Ulf calls for no more quirks...

Absolutely.

You have host->ops->set_clock, which you currently have set to
sdhci_set_clock().  If you need to do something different, please replace
that method with your own version - its fine to either wrap sdhci_set_clock()
or replace it entirely.

sdhci_set_clock() may benefit from being factored a little, so that it's
easier to replace parts of it.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
