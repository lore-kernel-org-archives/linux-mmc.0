From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: Correct DT properties for Arasan controller
Date: Thu, 19 Nov 2015 16:42:30 -0500
Message-ID: <CAOGqxeUVJ_MFcKw3SMHMyg1PSLhhMOi4=HxuEZ7=L_PfFajEYA@mail.gmail.com>
References: <564DFAB9.3000001@sigmadesigns.com>
	<6057509.l0OJuA1sv4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:35112 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbKSVmb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 16:42:31 -0500
Received: by qgea14 with SMTP id a14so6230046qge.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2015 13:42:30 -0800 (PST)
In-Reply-To: <6057509.l0OJuA1sv4@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, Suman Tripathi <stripathi@apm.com>

On Thu, Nov 19, 2015 at 3:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>                       cap-sd-highspeed;
>>                       sd-uhs-sdr12;
>>                       sd-uhs-sdr25;
>>                       sd-uhs-sdr50;
>>                       sd-uhs-ddr50;
>>                       sd-uhs-sdr104;

These values normally come from the Host Controllers CAPS registers
and are only needed if the CAPS register setting are incorrect.

>> - cap-mmc-hw-reset: eMMC hardware reset is supported

This is only set if the driver supplies a hw_reset callback and the
Arasan driver does not.

>> - cap-sdio-irq: enable SDIO IRQ signalling on this interface

This is only set if the driver supplies a enable_sdio_irq and the
Arasan driver does not.



Al
