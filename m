From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: questions about runtime pm
Date: Tue, 22 Dec 2015 14:24:53 +0100
Message-ID: <20151222132453.GB2789@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:16942 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbLVNZh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 08:25:37 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi guys,

I have recently added PM support for my driver but I don't have the
behavior I was expecting. I am wondering if I didn't do something wrong.

I have implemented runtime_suspend in a very simple way, I call
sdhci_runtime_suspend_host() and I disable the clocks. It works pretty
well with the eMMC which is non removable but with a SD card... If I
have my SD card present on boot time, it is detected but
insertion/removal is not detected.

Having a look to sdhci_runtime_suspend_host() internal, all the
interruptions are disabled expecting the card interrupt if it has been
set earlier.

>From my understanding, it means that if there is no activity on sdhci,
we will go to suspend and then we could wake up only on a software event
(or a sdio interrupt). How to manage card insertion/removal in this
case? My problem is so huge, I have probably missed something...

Moreover, to avoid system PM, I have used pm_runtime_force_suspend but I
could not wake up on card insertion/removal too. Do I have to use system
PM if I want to manage this case?

Thanks for your advices.

Regards

Ludovic
