From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Wed, 12 Dec 2012 12:02:03 +0100
Message-ID: <CAPDyKFqxvTi9caXC=XwVTmwMS0-48movLeATnxMmXCsHVoDbUw@mail.gmail.com>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
 <20121211145243.GQ14363@n2100.arm.linux.org.uk>
 <CACRpkdbZSFQ1HvXZ3Op093CediAm9rPHwHX38h_sxwE9ARSe5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdbZSFQ1HvXZ3Op093CediAm9rPHwHX38h_sxwE9ARSe5A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 12 December 2012 07:53, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 11, 2012 at 3:52 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> The amba bus is already performing same actions but for the apb_pclk.
>>> So here we just make sure the clock to card is gated as well to save
>>> more power. At runtime resume we will thus restore the clock again.
>>
>> And how exactly do you ensure the requirement that a certain number of
>> clocks is supplied to the card after the last command before you cut
>> the clock?

So, I agree that this needs to be taken care of, but I think it
already is, see more comments below.

>
> Oh, that's gonna be a problem.
>
> So I can see a quite straight-forward way to do this actually:
>
> 1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
> which means that the ios will be called with f=0 whenever
> the card is unused, taking into account the required number
> of clocks to the card.

I think MMC_CLKGATE was a good initiative in the past. But that was
before runtime pm was there to use. Runtime pm suits much better for
handling clock gating and other runtime power save actions that could
be possible for a host driver to do.

I would even suggest the MMC_CLKGATE should be removed from the
protocol layer, once we see that all host drivers that used it has
switch to runtime pm.

>
> 2) Implement handling of f=0 from the ios in the ios callback.
> Then clk_disable(host->clk). I did a hack at this some months
> back but never got around to finish it, sorry for not doing
> that even though this clock gating was invented for the MMCI
> in the first place :-(
>
> 3) In the suspend() callback, sleep until the clock indicates
> that the card is declocked with something like:
> while (clk_is_enabled(host->clk)) { sleep(1) }
> However the clk framework does not have clk_is_enabled()
> so you'd either have to add that or use a local atomic
> variable host_clk_enabled set in (2).
>
> Should work, I think?

I think the solution is much easier. Please consider the below:

1.
Some host drivers which implements runtime pm and corresponding
runtime callbacks, primarily rely on the the autosuspend timeout.
In mmci case, this timeout is set to 50ms, which will be more than
enough for any slow frequency to accomplish the 8 clock cycles.

I believe sdhci_s3c driver and omap_hsmmc.c does this as well.

2.
If we think 1) is not enough for all mmc/sd/sdio operations you could
implement ".enable|disable" host function pointers. In those you can
do pm_runtime_get|put. Thus the responsibility will be moved to the
protocol layer of handling the mmc_claim|release_host properly. It
must then keep the host claimed if by some reason the host must be
prevented from entering "runtime power save mode". Although, I have
not yet found any mmc/sd/sdio operations that seems to require this to
be done, you will have to convince me about what circumstances this is
need, except for the 8 clock cycles of course.

omap_hsmmc.c, does this, I doubt it is needed.

>
> Yours,
> Linus Walleij


Kind regards
Ulf Hansson
