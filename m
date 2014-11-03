From: Michael Heimpold <mhei@heimpold.de>
Subject: Re: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
Date: Mon, 03 Nov 2014 21:49:31 +0100
Message-ID: <8090335.0rPHov2cpK@kerker>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <5456B7B3.60401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5456B7B3.60401@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kristina =?utf-8?B?TWFydMWhZW5rbw==?= <kristina.martsenko@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Montag, 3. November 2014, 01:01:07 schrieben Sie:
> On 01/11/14 23:40, Stefan Wahren wrote:
> > Hi,
> > 
> > i was testing Linux Kernel 3.18-rc2 with my i.MX28 board (I2SE Duckbill) and ran
> > into the problem that the sd card isn't detected from the Kernel at booting
> > (driver: mxs-mmc.c). That results in a endless wait for the root partition
> > 
> > Here are the relevant messages (bad case):
> > 
> > [...]
> > [    1.501883] mxs-mmc 80010000.ssp: initialized
> > [    1.521203] TCP: cubic registered
> > [    1.530850] NET: Registered protocol family 10
> > [    1.548469] mip6: Mobile IPv6
> > [    1.551698] sit: IPv6 over IPv4 tunneling driver
> > [    1.566016] ip6_gre: GRE over IPv6 tunneling driver
> > [    1.575831] NET: Registered protocol family 17
> > [    1.581640] bridge: automatic filtering via arp/ip/ip6tables has been
> > deprecated. Update your scripts to load br_netfilter if you need this.
> > [    1.595635] Key type dns_resolver registered
> > [    1.604302] registered taskstats version 1
> > [    1.618188] stmp3xxx-rtc 80056000.rtc: setting system clock to 1970-01-01
> > 00:00:03 UTC (3)
> > [    1.675580] Waiting for root device /dev/mmcblk0p3...
> > 
> > In Linux Kernel 3.17 that problem didn't exist (good case):
> > 
> > [...]
> > [    1.546857] mxs-mmc 80010000.ssp: initialized
> > [    1.576363] TCP: cubic registered
> > [    1.588856] NET: Registered protocol family 10
> > [    1.608208] mmc0: host does not support reading read-only switch. assuming
> > write-enable.
> > [    1.616927] mip6: Mobile IPv6
> > [    1.620028] sit: IPv6 over IPv4 tunneling driver
> > [    1.629900] mmc0: new high speed SDHC card at address 0007
> > [    1.642901] ip6_gre: GRE over IPv6 tunneling driver
> > [    1.652047] mmcblk0: mmc0:0007 SD16G 14.6 GiB
> > [    1.662108] NET: Registered protocol family 17
> > [    1.678091]  mmcblk0: p1 p2 p3
> > [...]
> > 
> > I've have bisected the problem to this commit:
> > 
> > commit 89168b48991537bec2573b3b6a8841df74465b12
> > Author: Linus Walleij <linus.walleij@linaro.org>
> > Date:   Thu Oct 2 09:08:46 2014 +0200
> > 
> >     mmc: core: restore detect line inversion semantics
> >    
> >     commit 98e90de99a0c43bd434da814c882c4332441871e
> >     "mmc: host: switch OF parser to use gpio descriptors"
> >     switched the semantic behaviour of card detect and read
> >     only flags such that the inversion capability flag would
> >     only be set if inversion was explicitly specified in the
> >     device tree, in the hopes that no-one was using double
> >     inversion.
> >    
> >     It turns out that the XOR:ing between the explicit
> >     inversion was indeed in use, so we need to restore the
> >     old semantics where both ways of inversion are checked
> >     and the end result XOR:ed.
> >    
> >     Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> >     Tested-by: Javier Martinez Canillas <javier@dowhile0.org>
> >     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > Kernel command line: -e noinitrd console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw
> > rootwait
> > 
> > It looks to me that the patch didn't fix all host controller.
> 
> I ran into this issue as well. Seems that a card-detect flag 
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an 
> uninitialized variable, which can lead to the card being reported as 
> not present. This patch fixes it for me:
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 03c53b72a2d6..f0e187682d3b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	struct device_node *np;
>  	u32 bus_width;
>  	int len, ret;
> -	bool cap_invert, gpio_invert;
> +	bool cap_invert, gpio_invert = false;
>  

sorry, but I don't understand how your patch fixes the problem.

First use of the gpio_invert bool is in line 370/371 within mmc_gpiod_request_cd
(re-wrapped into a single line here for better reading):

-snip-
ret = mmc_gpiod_request_cd(host, "cd", 0, true,  0, &gpio_invert);
-snap-

A pointer to the bool is passed, and inside mmc_gpiod_request_cd (drivers/mmc/core/slot-gpio.c,
line 322), always a value is assigned:

-snip-
if (gpio_invert)
                *gpio_invert = !gpiod_is_active_low(desc);
-snap-

So returning to mmc_of_parse, the bool should always have an initialized value.
Apart from some error handling, the bool is used immediately in the xor expression
and results in setting MMC_CAP2_CD_ACTIVE_HIGH bit, or not.

I also cannot see a code path, where gpio_invert is used without a call to mmc_gpiod_request_cd.

Would be nice, if you could point me to what I'm missing.

>  	if (!host->parent || !host->parent->of_node)
>  		return 0;
> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	else
>  		cap_invert = false;
>  
> +	gpio_invert = false;
>  	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert);

Same here. The functions always assigns a value when a pointer is given.
(And this change is unrelated to the reporters problem, so should be fixed with a
dedicated patch.)


Thanks,
Michael


>  	if (ret) {
>  		if (ret == -EPROBE_DEFER)
> 
> Let me know if this also fixes it for you, and I'll send in a proper 
> patch.
> 
> Thanks,
> Kristina
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
