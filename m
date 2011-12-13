From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 0/5] mmc: mmci: Improvements and bugfixes for SDIO
Date: Tue, 13 Dec 2011 17:24:17 +0100
Message-ID: <4EE77C31.4030205@stericsson.com>
References: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:34948 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753929Ab1LMQYl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 11:24:41 -0500
In-Reply-To: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, elinwal <linus.walleij@stericsson.com>

Hi Russell,

I would just like to inform you that I just uploaded these patches into 
your patchtracker tool. I will ask Linus to help out testing this on 
RealView PB1176 board as well, since I unfortunately don't own such a 
board myself.

These patches is also based on Linux 3.2-rc4 and on top of the other 
mmci patch serie.

Br
Ulf Hansson

Ulf HANSSON wrote:
> This patchserie is based upon the below stated patchserie:
> mmc: mmci: Improved PM support, cleanup and bugfixes
> 
> These patches are all related to the SDIO support. Some patches will
> anyway effect the code execution path for non-SDIO and more important
> also the "hotpath" for all PIO read transfers. The intent is to try
> to affect as little as possible.
> 
> Per Forlin (1):
>   mmc: mmci: Add constraints on alignment for SDIO
> 
> Stefan Nilsson XK (1):
>   mmc: mmci: Fix PIO read for small SDIO packets
> 
> Ulf Hansson (3):
>   mmc: mmci: Prepare for SDIO before setting up DMA job
>   mmc: mmci: Fix incorrect handling of HW flow control for SDIO
>   mmc: mmci: Support any block sizes for ux500v2 variant
> 
>  drivers/mmc/host/mmci.c |  120 +++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/mmci.h |    7 +++
>  2 files changed, 98 insertions(+), 29 deletions(-)
> 

