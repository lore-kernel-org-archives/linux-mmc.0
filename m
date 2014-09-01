From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: pxamci: prepare and unprepare the clocks
Date: Mon, 01 Sep 2014 14:20:58 +0200
Message-ID: <871trv5y6t.fsf@free.fr>
References: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFr2SXz2yco5jzbkmrRZvCNQNbA7OjjX=WAtmcBJ1vYynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:38366 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbaIAMVj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 08:21:39 -0400
In-Reply-To: <CAPDyKFr2SXz2yco5jzbkmrRZvCNQNbA7OjjX=WAtmcBJ1vYynw@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 1 Sep 2014 12:31:04 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

>
> I would suggest you to re-place the existing clk_enable() with
> clk_prepare_enable() and clk_disable with clk_disable_unprepare()
> instead of the approach taken in this patch.

I don't think it works in this driver.

Look at pxamci_set_ios(), and all the handling of host->clkrt (CLKRT_OFF,
...). This driver enables the clock only when transfers are required, not all
the time. Therefore I'd rather let it be that way.

Cheers.

-- 
Robert
