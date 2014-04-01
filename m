From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 3/3] memstick: Add realtek USB memstick host driver
Date: Tue, 1 Apr 2014 15:06:54 -0700
Message-ID: <20140401150654.fe27636428a62fdf9e0d2dc1@linux-foundation.org>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
	<1395744293-24398-4-git-send-email-rogerable@realtek.com>
	<533A3080.2020008@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38949 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaDAWG5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 18:06:57 -0400
In-Reply-To: <533A3080.2020008@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger <rogerable@realtek.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

On Tue, 1 Apr 2014 11:20:32 +0800 Roger <rogerable@realtek.com> wrote:

> On 03/25/2014 06:44 PM, rogerable@realtek.com wrote:
> > From: Roger Tseng <rogerable@realtek.com>
> >
> > Realtek USB memstick host driver provides memstick host support based on the
> > Realtek USB card reader MFD driver.
> >
> > Signed-off-by: Roger Tseng <rogerable@realtek.com>
> > ---
> >   drivers/memstick/host/Kconfig       |  10 +
> >   drivers/memstick/host/Makefile      |   1 +
> >   drivers/memstick/host/rtsx_usb_ms.c | 839 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 850 insertions(+)
> >   create mode 100644 drivers/memstick/host/rtsx_usb_ms.c
> Hi Andrew,
> 
> Since I'll have to send next revision(v6, to modify patch 1/3) and 
> you've commented v4, would you also comment or Ack the 3/3 of this one? 
> This should save one revision for me to make any necessary change.

It looks OK to my inexpert eye.  It would be better if Maxim and/or Alex
could review the code.  If that doesn't happen then I guess the best we
can do is to go ahead and merge it.  Have you worked out via which tree
the patches will be merged?

