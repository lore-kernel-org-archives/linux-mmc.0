From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/12] treewide: Fix GENMASK misuses
Date: Wed, 10 Jul 2019 09:01:25 -0700
Message-ID: <c94a0a50c41c7530354b4a662ee945212424c8c7.camel@perches.com>
References: <cover.1562734889.git.joe@perches.com>
 <5fa1fa6998332642c49e2d5209193ffe2713f333.camel@sipsolutions.net>
 <20190710094337.wf2lftxzfjq2etro@shell.armlinux.org.uk>
 <b9c3b83c9be50286062ae8cefd5d38e2baa0fb22.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <b9c3b83c9be50286062ae8cefd5d38e2baa0fb22.camel@perches.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Johannes Berg <johannes@sipsolutions.net>
Cc: devel@driverdev.osuosl.org, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, Benjamin Fair <benjaminfair@google.com>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, Patrick Venture <venture@google.com>, openbmc@lists.ozlabs.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Nancy Yuen <yuenn@google.com>, linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-amlogic@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2019-07-10 at 08:45 -0700, Joe Perches wrote:
> On Wed, 2019-07-10 at 10:43 +0100, Russell King - ARM Linux admin wrote:
> > On Wed, Jul 10, 2019 at 11:17:31AM +0200, Johannes Berg wrote:
> > > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > > These GENMASK uses are inverted argument order and the
> > > > actual masks produced are incorrect.  Fix them.
> > > > 
> > > > Add checkpatch tests to help avoid more misuses too.
> > > > 
> > > > Joe Perches (12):
> > > >   checkpatch: Add GENMASK tests
> > > 
> > > IMHO this doesn't make a lot of sense as a checkpatch test - just throw
> > > in a BUILD_BUG_ON()?
> 
> I tried that.
> 
> It'd can't be done as it's used in declarations
> and included in asm files and it uses the UL()
> macro.
> 
> I also tried just making it do the right thing
> whatever the argument order.

I forgot.

I also made all those arguments when it was
introduced in 2013.

https://lore.kernel.org/patchwork/patch/414248/

> Oh well.

yeah.
