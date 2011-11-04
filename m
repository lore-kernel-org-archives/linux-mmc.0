From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 0/2] mmc: mmci: Bugfixes for SDIO
Date: Fri, 4 Nov 2011 15:34:15 +0100
Message-ID: <4EB3F7E7.1070901@stericsson.com>
References: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:41996 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932550Ab1KDOec (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 10:34:32 -0400
In-Reply-To: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>

Is this patch and it's patchserie considered OK?

-Russell, patches are available in your patchtracker.

Br
Ulf Hansson

Ulf HANSSON wrote:
> This patchserie fixes some SDIO related issues for the mmci host driver.
> 
> Previously these patches were included in the patch serie called
> "mmc: mmci: Improvements and bugfixes for SDIO", which now has been
> split up.
> 
> Stefan Nilsson XK (1):
>   mmc: mmci: Fix incorrect handling of HW flow control for SDIO
> 
> Ulf Hansson (1):
>   mmc: mmci: Prepare for SDIO before setting up DMA job
> 
>  drivers/mmc/host/mmci.c |   50 ++++++++++++++++++++++++++--------------------
>  1 files changed, 28 insertions(+), 22 deletions(-)
> 

