From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
Date: Tue, 3 Apr 2018 09:15:03 +0200
Message-ID: <CAK8P3a20etAsuj_-b2UbtPcTdB0ry7CZbh660omTk=c_eY8N6w@mail.gmail.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, IDE-ML <linux-ide@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Samuel Ortiz <samuel@sortiz.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Nicolas Pitre <nico@fluxnic.net>, Greg
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi,
>
> This serie is aimed at removing the dmaengine slave compat use, and transfer
> knowledge of the DMA requestors into architecture code.
>
> This was discussed/advised by Arnd a couple of years back, it's almost time.
>
> The serie is divided in 3 phasees :
>  - phase 1 : patch 1/15 and patch 2/15
>    => this is the preparation work
>  - phase 2 : patches 3/15 .. 10/15
>    => this is the switch of all the drivers
>    => this one will require either an Ack of the maintainers or be taken by them
>       once phase 1 is merged
>  - phase 3 : patches 11/15
>    => this is the last part, cleanup and removal of export of the DMA filter
>       function
>
> As this looks like a patch bomb, each maintainer expressing for his tree either
> an Ack or "I want to take through my tree" will be spared in the next iterations
> of this serie.
>
> Several of these changes have been tested on actual hardware, including :
>  - pxamci
>  - pxa_camera
>  - smc*
>  - ASoC and SSP
>
> Happy review.

This looks really great overall, thanks for cleaning this up!

The SSP part is still a bit weird, as I commented, but I'm sure we can
figure something out there.

    Arnd
