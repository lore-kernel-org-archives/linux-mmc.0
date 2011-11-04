From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 0/2] mmc: mmci: Improvements for SDIO
Date: Fri, 4 Nov 2011 15:35:18 +0100
Message-ID: <4EB3F826.1030001@stericsson.com>
References: <1319466800-19884-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:42463 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932517Ab1KDOff (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 10:35:35 -0400
In-Reply-To: <1319466800-19884-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>

Is this patchserie considered OK?

-Russell, patches are available in your patchtracker.

Br
Ulf Hansson

Ulf HANSSON wrote:
> For the ux500v2 variant of the PL18x block, non power of two block
> sizes are now supported.
> 
> In addition constraints on buffer alignments is needed since access to the
> PL18x FIFO must be done on a 4-byte aligned manner. Moreover to be able to
> use DMA for buffers with not 32 bytes aligned sg element lengths, DMAREQCTL
> must enabled.
> 
> Per Forlin (1):
>   mmc: mmci: add constraints on alignment for SDIO
> 
> Stefan Nilsson XK (1):
>   mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant
> 
>  drivers/mmc/host/mmci.c |   56 +++++++++++++++++++++++++++++++++++++++++------
>  drivers/mmc/host/mmci.h |    7 ++++++
>  2 files changed, 56 insertions(+), 7 deletions(-)
> 

