From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: pxamci: prepare and unprepare the clocks
Date: Mon, 01 Sep 2014 15:28:18 +0200
Message-ID: <87sikb4gi5.fsf@free.fr>
References: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFr2SXz2yco5jzbkmrRZvCNQNbA7OjjX=WAtmcBJ1vYynw@mail.gmail.com>
	<871trv5y6t.fsf@free.fr>
	<CAPDyKFpaX4UHW-_z=yy7UA1Xuv2LZqQkttJ-tWugZYSXD4VwiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:40819 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbaIAN2V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 09:28:21 -0400
In-Reply-To: <CAPDyKFpaX4UHW-_z=yy7UA1Xuv2LZqQkttJ-tWugZYSXD4VwiQ@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 1 Sep 2014 14:49:03 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> I understand your concern, but I don't see why there should be any
> major difference in clock management code (clk tree wise), due to this
> patch. It worked before, so likely it will work now!?

It will ony work *differently*, it will change the clock management. It won't
break, but again it's *not* the purpose of the patch.  The patch is aimed at
removing a warning.

As for the clock management, it will the change the behaviour :
Let's see the current clock management :
 - pxamci_probe()
   => clock is disabled
   mmc_add_host()
     mmc_start_host()
       mmc_power_up() (as pxamci is unaware of caps2)
       Here the comment of the function is (drivers/mmc/core/core.c:1534):
       "First, we enable power to the card without the clock running"
       => this won't be true if the clock is enabled in pxamci_probe()
       mmc_set_ios(host, host->ios.clock=host->f_init)
         pxamci_set_ios()
           clk_enable()
             => here the clock is enabled, enable_count=1
       mmc_host_clk_release()
         pxamci_set_ios()
             => here the clock is disabled, enable_count=0

Let's see the your proposal clock management :
 - pxamci_probe()
   => clock is enabled
   mmc_add_host()
     mmc_start_host()
       mmc_power_up() (as pxamci is unaware of caps2)
       mmc_set_ios(host, host->ios.clock=host->f_init)
         pxamci_set_ios()
           clk_enable()
             => here the clock is enabled twice, enable_count=2
       mmc_host_clk_release()
         pxamci_set_ios()
             => here the clock *remains enabled*, enable_count=1

- time passes with clock enabled

So I think there is a difference, unless my understand of the MMC core stack is wrong.

Cheers.

-- 
Robert
