From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ARM: edma: Rename header file for
 dmaengine filter function definition
Date: Thu, 27 Nov 2014 20:46:12 +0200
Message-ID: <54777174.4070203@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <8235185.7qUDHu9jso@wuerfel> <547733E3.3020408@ti.com>
 <3300340.ou8f7H2hIc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3300340.ou8f7H2hIc@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, vinod.koul@intel.com, nsekhar@ti.com, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, chris@printf.net, dmaengine@vger.kernel.org, ulf.hansson@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/27/2014 04:50 PM, Arnd Bergmann wrote:
> On Thursday 27 November 2014 16:23:31 Peter Ujfalusi wrote:
>> This will only work in case of legacy boot. When booting with DT we do n=
ot
>> have pdata and after this patch in dt boot we are not going to be able t=
o get
>> the DMA resources either.
> =

> No, when booting with DT, the filter_fn and data are not used at all,
> we get the dma channel by parsing the DT instead.

Correct.

>> I think if we want to do something like this, it has to be done within t=
he
>> dmaengine framework. The dma controller's of_dma_filter_info already have
>> .filter_fn which could be used by the framework.
> =

> No, of_dma_filter_info/of_dma_simple_xlate was a mistake, we should never
> have even introduced that. All drivers that rely on this can simply
> provide their own xlate function that calls of_dma_get_slave_channel()
> or one of the related functions.
> =

> edma is particularly trivial, it can just use of_dma_xlate_by_chan_id()
> instead of of_dma_simple_xlate, as it looks up the channel by its number.

I see. With this series I did not planed to fix all edma related issues, ju=
st
as a start clean up the related header files. I would rather not add fixes =
to
mmc, spi, etc drivers since while you have valid point it is not in the sco=
pe
of this series.
Can we do the changes you are suggesting in an incremental manner?

-- =

P=E9ter
