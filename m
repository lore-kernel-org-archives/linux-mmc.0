From: Matt Fleming <matt@console-pimps.org>
Subject: Re: +
 mmc-add-support-for-the-marvell-platform-sdhci-controller.patch added to
 -mm tree
Date: Thu, 26 Aug 2010 07:55:07 +0100
Message-ID: <20100826075507.0d9f0eae@linux-g6p1.site>
References: <201008252316.o7PNGPhl021552@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:33556 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750874Ab0HZGzJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 02:55:09 -0400
In-Reply-To: <201008252316.o7PNGPhl021552@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, saeed@marvell.com, linux-mmc@vger.kernel.org

On Wed, 25 Aug 2010 16:16:25 -0700
akpm@linux-foundation.org wrote:

> 
> The patch titled
>      mmx: add support for the Marvell platform SDHCI controller
> has been added to the -mm tree.  Its filename is
>      mmc-add-support-for-the-marvell-platform-sdhci-controller.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: mmx: add support for the Marvell platform SDHCI controller
> From: Saeed Bishara <saeed@marvell.com>
> 
> Implement a driver for the platfrom SDHCI controllers that is found on
> some of Marvell's SoC's.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/host/Kconfig    |   12 +
>  drivers/mmc/host/Makefile   |    1 
>  drivers/mmc/host/sdhci-mv.c |  243 ++++++++++++++++++++++++++++++++++
>  3 files changed, 256 insertions(+)
> 

Reviewed-by: Matt Fleming <matt@console-pimps.org>
