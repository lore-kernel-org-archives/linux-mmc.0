From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Tue, 23 Jul 2019 16:33:36 +0200
Message-ID: <20190723143336.GA32294@lst.de>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
 <20190723093442.GA27239@lst.de>
 <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>, Matthias Brugger <mbrugger@suse.com>, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 23, 2019 at 03:32:11PM +0200, Nicolas Saenz Julienne wrote:
> You state in "arm: use swiotlb for bounce buffer on LPAE configs" that "The DMA
> API requires that 32-bit DMA masks are always supported". If I understand it
> correctly this device breaks that assumption. Which implies we need a bounce
> buffer system in place for any straming DMA user.

Yes, you do.

> It seems we're unable to use dma-direct/swiotlb, so I enabled arm's dmabounce
> on all devices hooked into RPi's limited interconnect, which fixes this issue.
> Any thoughts on this?

There is no reason swiotlb could not handle the case, but at least for
now dmabounce seems like the better option given that it is well
integrated into the arm code.

Your patch looks good to me.
