From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 08/17] spi: pl022: Fully gate clocks at request inactivity
Date: Mon, 10 Feb 2014 11:36:08 +0100
Message-ID: <CAPDyKFraQUcZ_LjSAwENQA_RVqXokKKgfOZh7WD1vKmJ+5KstQ@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-9-git-send-email-ulf.hansson@linaro.org>
 <20140204170746.GD22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140204170746.GD22609@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-mmc@vger.kernel.org

On 4 February 2014 18:07, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:49PM +0100, Ulf Hansson wrote:
>> Use clk_disable_unprepare and clk_prepare_enable from the runtime PM
>> callbacks, to fully gate|ungate clocks. Potentially this will save more
>> power, depending on the clock tree for the current SOC.
>
> The same patch has already been applied (I noticed and fixed it while
> doing unrelated code review).

Sorry, didn't notice that.

Thanks!

Kind regards
Ulf Hansson

>
>>       pinctrl_pm_select_default_state(dev);
>> -     clk_enable(pl022->clk);
>> +     clk_prepare_enable(pl022->clk);
>
> Someone should really make this check errors though!
