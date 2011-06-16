From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
	support for mx5
Date: Thu, 16 Jun 2011 20:32:33 +0200
Message-ID: <87lix1hbjy.fsf@lebrac.rtp-net.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<20110614064841.GB30295@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110614064841.GB30295@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Tue, 14 Jun 2011 14:48:42 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Shawn Guo <shawn.guo@freescale.com> writes:

Hi,

> On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
>> The card-present polling within sdhci based driver is very expensive
>> in terms of the impact to system performance.  We observe a few
>> system performance issues from Freescale and Linaro on mx5 platforms,
>> which have been proved card polling related.
>> 
>> The patch set extends the current sdhci-esdhc-imx card_detect and
>> write_protect support to cover mx5 platforms, and solves above
>> performance issues.
>> 
>> Shawn Guo (4):
>>       mmc: sdhci: fix interrupt storm from card detection
>>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
>>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
>>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
>> 
> Hi Arnaud,
>
> Any chance to play with it yet?

Finally managed to build a kernel with this version of the
patchset. While I'm not polling anymore, I'm getting a lot of interrupts
if the card is not inserted. Theses interrupts are not happening if the
card is inserted. I can see things like this in the logs :
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000080

[ of course, the bit of the present state register indicating card
presence is equal to 0 ]

I've tested the SIGNAL case only. Don't know if switch to GPIO may help.
Do you have same kind of issue on your side ?

Thanks,
Arnaud
