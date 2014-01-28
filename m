From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 28 Jan 2014 01:08:32 +0000
Message-ID: <861tzs29rj.fsf@void.printf.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<1390190215-22700-2-git-send-email-olof@lixom.net>
	<52DEBDA7.7030200@samsung.com> <52E54540.8080304@gmail.com>
	<CAPDyKFqpOLZiUSDvxVtYrBM8DtrZDLE27LKzyoWaf29Ni2vcFQ@mail.gmail.com>
	<52E700F0.7040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43436 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbaA1BIj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jan 2014 20:08:39 -0500
In-Reply-To: <52E700F0.7040708@gmail.com> (Tomasz Figa's message of "Tue, 28
	Jan 2014 01:59:28 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Olof Johansson <olof@lixom.net>, linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, mark.rutland@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>

Hi,

On Tue, Jan 28 2014, Tomasz Figa wrote:
>> I am not sure I understand why this is needed. I think it would be
>> more convenient to use MMC_CAP_NONREMOVABLE instead as stated earlier.
>> But please elaborate, I might have missed something.
>
> See above. I'm not quite convinced that state of MMC interface should
> determine power state of the chip. I can easily imagine a situation
> where the MMC link is powered down (link power management) but the
> WLAN chip keeps operation. Keep in mind that those are usually
> complete SoCs that can keep processing network traffic autonomously
> and wake-up the application processor whenever anything interesting
> happens using extra out of bounds signalling, which might trigger
> re-enabling the MMC link.

For what it's worth, we did this using upstream code (libertas-sd8686
WLAN with sdhci-pxav3) at OLPC.  We set the SDIO device to 1-bit mode
on system suspend, using MMC_CAP_NONREMOVABLE, MMC_PM_KEEP_POWER and
MMC_PM_WAKE_SDIO_IRQ, and tell the PMU to wake on the 1-bit data line.
When it wakes the system, the system sees the SDIO interrupt and
processes the waiting network traffic.

So this use case is already supported using the current interfaces.
If this interface doesn't work for your use case, could you talk a
little more about what you're trying to achieve?

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
