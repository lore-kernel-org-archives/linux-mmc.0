From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MMC: add support for the Marvell platform SDHCI
 controller
Date: Wed, 25 Aug 2010 16:16:18 -0700
Message-ID: <20100825161618.07d63707.akpm@linux-foundation.org>
References: <1277215742-25994-1-git-send-email-saeed@marvell.com>
	<20100825233958.10de8e87@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40299 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968Ab0HYXQX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2010 19:16:23 -0400
In-Reply-To: <20100825233958.10de8e87@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, saeed.bishara@gmail.com, Saeed Bishara <saeed@marvell.com>

On Wed, 25 Aug 2010 23:39:58 +0100
Matt Fleming <matt@console-pimps.org> wrote:

> On Tue, 22 Jun 2010 17:09:02 +0300
> Saeed Bishara <saeed@marvell.com> wrote:
> 
> > This patch implements the driver for the platfrom SDHCI controllers that found on some of Marvell's SoC's.
> > 
> > Signed-off-by: Saeed Bishara <saeed@marvell.com>
> > ---
> >  drivers/mmc/host/Kconfig    |   12 ++
> >  drivers/mmc/host/Makefile   |    1 +
> >  drivers/mmc/host/sdhci-mv.c |  243 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 256 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/mmc/host/sdhci-mv.c
> 
> Andrew, any reason this hasn't been picked up?

I must have been hungry, it was near lunchtime. :)

> (I noticed you weren't on the CC).

That too.
