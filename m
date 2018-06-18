From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Date: Mon, 18 Jun 2018 10:41:59 +0200
Message-ID: <20180618104159.24b9fffb@bbrezillon>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180617170217.24177-1-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>, linux-media@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dmaengine@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

Hi Robert,

On Sun, 17 Jun 2018 19:02:03 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> As I gathered almost all the required acks, this is an information only post
> before queuing to the PXA tree.

We'll need an immutable branch/tag containing those changes, just in
case other conflicting changes get submitted to the NAND driver.

Thanks,

Boris
