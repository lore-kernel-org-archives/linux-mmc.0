From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
Date: Wed, 4 Apr 2018 21:56:23 +0200
Message-ID: <20180404215623.2bf07406@bbrezillon>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 <874lkq4urd.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <874lkq4urd.fsf@belgarion.home>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, driverdevel <devel@driverdev.osuosl.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Nicolas Pitre <nico@fluxnic.net>, Greg Kroah-Hartman <gregkh@li>
List-Id: linux-mmc@vger.kernel.org

On Wed, 04 Apr 2018 21:49:26 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:  
> >> Hi,
> >>
> >> This serie is aimed at removing the dmaengine slave compat use, and transfer
> >> knowledge of the DMA requestors into architecture code.
> >> As this looks like a patch bomb, each maintainer expressing for his tree either
> >> an Ack or "I want to take through my tree" will be spared in the next iterations
> >> of this serie.  
> >
> > Perhaps an option is to send this hole series as PR for 3.17 rc1, that
> > would removed some churns and make this faster/easier? Well, if you
> > receive the needed acks of course.  
> For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all

Especially since 3.17-rc1 has been released more than 3 years ago :-),
but I guess you meant 4.17-rc1.

> acks, I'll queue it into my pxa tree. If at least one maintainer withholds his
> ack, the end of the serie (phase 3) won't be applied until it is sorted out.
> 
> Cheers.
> 
> --
> Robert
