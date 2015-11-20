From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: Correct DT properties for Arasan controller
Date: Fri, 20 Nov 2015 14:21:16 +0100
Message-ID: <564F1E4C.4030703@sigmadesigns.com>
References: <564DFAB9.3000001@sigmadesigns.com> <6057509.l0OJuA1sv4@wuerfel>
 <CAOGqxeUVJ_MFcKw3SMHMyg1PSLhhMOi4=HxuEZ7=L_PfFajEYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.197]:60741 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbbKTNVT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2015 08:21:19 -0500
In-Reply-To: <CAOGqxeUVJ_MFcKw3SMHMyg1PSLhhMOi4=HxuEZ7=L_PfFajEYA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, Suman Tripathi <stripathi@apm.com>

On 19/11/2015 22:42, Alan Cooper wrote:

>>>                       cap-sd-highspeed;
>>>                       sd-uhs-sdr12;
>>>                       sd-uhs-sdr25;
>>>                       sd-uhs-sdr50;
>>>                       sd-uhs-ddr50;
>>>                       sd-uhs-sdr104;
> 
> These values normally come from the Host Controllers CAPS registers
> and are only needed if the CAPS register setting are incorrect.

Using a 4 GB microSDHC card + SD adapter, I get read speeds of
17.3 MB/s (4072669184 bytes in 236 seconds).
Is that an expected value? SDR25 should be 25 MB/s.
Perhaps I need to buy a better card.

>>> - cap-mmc-hw-reset: eMMC hardware reset is supported
> 
> This is only set if the driver supplies a hw_reset callback and the
> Arasan driver does not.

OK.

>>> - cap-sdio-irq: enable SDIO IRQ signalling on this interface
> 
> This is only set if the driver supplies a enable_sdio_irq and the
> Arasan driver does not.

Can't it use a generic implementation, such as sdhci_enable_sdio_irq?

Regards.

