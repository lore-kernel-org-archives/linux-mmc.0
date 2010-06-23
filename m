From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] MMC: add support for the Marvell platform SDHCI  controller
Date: Wed, 23 Jun 2010 15:06:40 +0100
Message-ID: <87y6e56dxr.fsf@linux-g6p1.site>
References: <1277215742-25994-1-git-send-email-saeed@marvell.com> <87631a6k60.fsf@linux-g6p1.site> <AANLkTimqyW5Q9YTsZ1YA0nLDXRYKuTuoaKH-C9wiQFqK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:51213 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab0FWOGm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2010 10:06:42 -0400
In-Reply-To: <AANLkTimqyW5Q9YTsZ1YA0nLDXRYKuTuoaKH-C9wiQFqK@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Saeed Bishara <saeed@marvell.com>, linux-mmc@vger.kernel.org

On Wed, 23 Jun 2010 15:11:04 +0300, saeed bishara <saeed.bishara@gmail.com> wrote:
> the point behind the devm_ (device managed) resouce allocation is not
> to do the free explicitly, the kernel does that on behalf of the
> driver.

Oops, sorry I missed that. I must have been hungry, it was near lunchtime.
