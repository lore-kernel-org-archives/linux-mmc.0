From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 08/15] ASoC: pxa: remove the dmaengine compat need
Date: Thu, 12 Apr 2018 18:55:28 +0200
Message-ID: <87a7u82wlb.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-9-robert.jarzmik@free.fr>
 <20180412152632.GG9929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180412152632.GG9929@sirena.org.uk> (Mark Brown's message of
 "Thu, 12 Apr 2018 16:26:32 +0100")
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, linu@osuosl.org, Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Samuel Ortiz <samuel@sortiz.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood>
List-Id: linux-mmc@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Apr 02, 2018 at 04:26:49PM +0200, Robert Jarzmik wrote:
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> If there's no dependency I'm happy to take this for 4.18.
Thanks for the ack.

The patches 1 and 2 are the dependency here, so I'd rather push it through my
tree once the review is complete.

Cheers.

-- 
Robert
