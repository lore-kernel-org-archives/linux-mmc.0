From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Wed, 12 Dec 2012 07:53:37 +0100
Message-ID: <CACRpkdbZSFQ1HvXZ3Op093CediAm9rPHwHX38h_sxwE9ARSe5A@mail.gmail.com>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
 <20121211145243.GQ14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121211145243.GQ14363@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 11, 2012 at 3:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> The amba bus is already performing same actions but for the apb_pclk.
>> So here we just make sure the clock to card is gated as well to save
>> more power. At runtime resume we will thus restore the clock again.
>
> And how exactly do you ensure the requirement that a certain number of
> clocks is supplied to the card after the last command before you cut
> the clock?

Oh, that's gonna be a problem.

So I can see a quite straight-forward way to do this actually:

1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
which means that the ios will be called with f=0 whenever
the card is unused, taking into account the required number
of clocks to the card.

2) Implement handling of f=0 from the ios in the ios callback.
Then clk_disable(host->clk). I did a hack at this some months
back but never got around to finish it, sorry for not doing
that even though this clock gating was invented for the MMCI
in the first place :-(

3) In the suspend() callback, sleep until the clock indicates
that the card is declocked with something like:
while (clk_is_enabled(host->clk)) { sleep(1) }
However the clk framework does not have clk_is_enabled()
so you'd either have to add that or use a local atomic
variable host_clk_enabled set in (2).

Should work, I think?

Yours,
Linus Walleij
