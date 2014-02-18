From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 03/17] mmc: mmci: Mask IRQs for all variants during
 runtime suspend
Date: Tue, 18 Feb 2014 18:02:38 +0100
Message-ID: <CAPDyKFrjOyg8K2UfE61NiQLNJy+6RrRf_Y8ogECNAiGDobS1Jg@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-4-git-send-email-ulf.hansson@linaro.org>
	<20140218160542.GH21483@n2100.arm.linux.org.uk>
	<CAPDyKFq3uAoo7p-7hZgBmMJ4jf9A7dC0aUZJYUE0z1Qq5W=0bw@mail.gmail.com>
	<20140218164614.GI21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140218164614.GI21483@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 18 February 2014 17:46, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 18, 2014 at 05:36:52PM +0100, Ulf Hansson wrote:
>> If we add SDIO irq support to mmci in future; parts of that
>> implementation includes a re-route of DAT1 to a GPIO irq when entering
>> runtime suspend state. The mmci HW will in runtime suspend state, not
>> be responsible for handling irqs, which is the same as of today.
>
> Note that the "irq thread" in sdio_irq is scheduled for destruction -
> it's buggy when the system is under high load and a driver claims a
> SDIO irq.  Sched people hate it too...

We kind of realized that too, in the early days for ux500. At that
point we converted it to a use a dedicated work queue, which improved
the behaviour, don't remember the details why, but maybe I should
collect the patches and send them out. :-)

Finally we moved to use a separate GPIO irq as a dedicated SDIO irq
line for our cw1200 wlan chip, mostly due to gain a bit of
performance. That happened to simplified the mmci part as well, which
was welcome.

>
> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
