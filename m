From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 09/14] ASoC: pxa: remove the dmaengine
	compat need
Date: Thu, 21 Jun 2018 10:50:03 +0200
Message-ID: <87muvoo75w.fsf@belgarion.home>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180617170217.24177-10-robert.jarzmik@free.fr>
 <1984a4a7-e33b-6349-31f3-6f85ff1582b8@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1984a4a7-e33b-6349-31f3-6f85ff1582b8@zonque.org> (Daniel Mack's
 message of "Sun, 17 Jun 2018 20:17:09 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>, linux-media@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dmaengine@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-mmc@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> Hi Mark,
>
> I prepared a series of patches for 4.18 that conflict with this one. Instead of
> letting other people resolve this down the road, I'd prefer if this one went
> through the ASoC tree, if you don't mind.
>
> I've talked to Robert off-list, and he's fine with this approach.
That's right.

I'll tentativaly queue this patch to my pxa/for-next tree. As soon as I hear
that Mark queued it up in his tree, I'll drop it from mine.

Cheers.

--
Robert
