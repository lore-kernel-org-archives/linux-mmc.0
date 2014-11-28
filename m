From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ARM: edma: Rename header file for
 dmaengine filter function definition
Date: Fri, 28 Nov 2014 09:16:24 +0200
Message-ID: <54782148.6040108@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <3300340.ou8f7H2hIc@wuerfel> <54777174.4070203@ti.com>
 <4859328.eEV7jzKEaA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4859328.eEV7jzKEaA@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, vinod.koul@intel.com, nsekhar@ti.com, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, chris@printf.net, dmaengine@vger.kernel.org, ulf.hansson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 11/27/2014 11:52 PM, Arnd Bergmann wrote:
> On Thursday 27 November 2014 20:46:12 Peter Ujfalusi wrote:
>>
>> I see. With this series I did not planed to fix all edma related issues,=
 just
>> as a start clean up the related header files. I would rather not add fix=
es to
>> mmc, spi, etc drivers since while you have valid point it is not in the =
scope
>> of this series.
>> Can we do the changes you are suggesting in an incremental manner?
> =

> Sure, but I'd leave the existing filter function declaration alone then
> and not move it, since we wouldn't want to keep it in the long run.

but if you want to reference the filter function (which is in
drivers/dma/edma.c) in arch/arm/mach-davinci/ directory, we will need it.
Don't we?

If I leave the header as it is, then how would we clean up the edma headers=
? I
would not put the API definitions for the arch code into the same file as we
have the filter definition.


> =

> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =



-- =

P=E9ter
