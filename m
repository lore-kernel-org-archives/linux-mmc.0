From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Tue, 23 Jul 2019 11:34:42 +0200
Message-ID: <20190723093442.GA27239@lst.de>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <mbrugger@suse.com>, Scott Branden <sbranden@broadcom.com>, linux-gpio@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Christoph Hellwig <hch@lst.de>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@baylibre.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 22, 2019 at 08:10:17PM +0200, Stefan Wahren wrote:
> i rebased this series also and got this only on the RPi 4.
> 
> After reverting the following:
> 
> 79a986721de dma-mapping: remove dma_max_pfn
> 7559d612dff0 mmc: core: let the dma map ops handle bouncing
> 
> This crash disappear, but wifi seems to be still broken.
> 
> Would be nice, if you can investigate further.

That means dma addressing on this system doesn't just work for some
memory, and the mmc bounce buffering was papering over that just for
mmc.  Do you have highmem on this system?  

You might want to try this series, which has been submitted upstream:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-swiotlb
