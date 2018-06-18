From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 06/14] mtd: rawnand: marvell: remove the
	dmaengine compat need
Date: Mon, 18 Jun 2018 21:31:27 +0200
Message-ID: <87h8lzriwg.fsf@belgarion.home>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180617170217.24177-7-robert.jarzmik@free.fr>
 <3a2a8951-f380-af99-bf97-6ff722404410@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3a2a8951-f380-af99-bf97-6ff722404410@zonque.org> (Daniel Mack's
 message of "Sun, 17 Jun 2018 20:12:49 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>, linux-media@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dmaengine@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-mmc@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> On Sunday, June 17, 2018 07:02 PM, Robert Jarzmik wrote:
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>>
>> This patch simplifies the dma resource acquisition, using the more
>> generic function dma_request_slave_channel().
>>
>> Signed-off-by: Signed-off-by: Daniel Mack <daniel@zonque.org>
>
> Something went wrong here, but you can simply fix that when applying the series
> :)
Indeed, fixed before applying to the pxa/for-next tree.

--
Robert
