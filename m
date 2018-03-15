From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix falling from idmac to PIO mode when
 dw_mci_reset occurs
Date: Thu, 15 Mar 2018 14:39:35 +0100
Message-ID: <CAPDyKFp--bHg8PH7om7TTY15m0CRw3i4eO1=StRnVofxnf50OQ@mail.gmail.com>
References: <20180314193051.16791-1-Evgeniy.Didin@synopsys.com>
 <CAPDyKFrgBm8-G1CsnqS9G62xFA2qA0XkuGBfA5v6grZnjRLteA@mail.gmail.com>
 <1521119909.10304.1.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1521119909.10304.1.camel@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On 15 March 2018 at 14:18, Evgeniy Didin <Evgeniy.Didin@synopsys.com> wrote:
> Hello Ulf,
>
> On Thu, 2018-03-15 at 10:57 +0100, Ulf Hansson wrote:
>> On 14 March 2018 at 20:30, Evgeniy Didin <Evgeniy.Didin@synopsys.com> wrote:
>> > It was found that in IDMAC mode after soft-reset driver switches
>> > to PIO mode.
>> >
>> > That's what happens in case of DTO timeout overflow calculation failure:
>> > 1. soft-reset is called
>> > 2. driver restarts dma
>> > 3. descriptors states are checked, one of descriptor is owned by the IDMAC.
>> > 4. driver can't use DMA and then switches to PIO mode.
>> >
>> > Failure was already fixed in:
>> > https://urldefense.proofpoint.com/v2/url?u=https-3A__www.spinics.net_lists_linux-2Dmmc_msg48125.html&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=vQk-RIbjwN0zvlwiMSpq3LYUTNf7Gqc4ujhosYI
>> > TtAw&m=6rPWpKUYQD3kY-2OEikJUWyEJvwKJljWHFC8rd2TCak&s=JjX0Dx8-eSyW2cATMsnG1eAzrKgoDkS1bcS5XYrVtlE&e=.
>>
>> Evgeniy,
>>
>> It seems like I should squash this fix into the above commit? Makes sense?
> IMHO it is not a good idea, because this fix is orthogonal to the above commit.
> Debugging drto overflow issue we found this strange behavior.

Okay! Thanks for clarifying.

> This might be general issue of soft-reset. So I think this should be separate patch.
> Also if these patches are independent, it will be easier to backport them.

Should I add a stable tag then?

[...]

Kind regards
Uffe
