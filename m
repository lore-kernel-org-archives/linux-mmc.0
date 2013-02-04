From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] mmc: s3cmci: moved mach/regs-sdi.h into s3cmci device
 driver
Date: Sun, 03 Feb 2013 17:16:50 -0800
Message-ID: <0e9801ce0275$50c8f720$f25ae560$@samsung.com>
References: <1359765917-11219-1-git-send-email-kgene.kim@samsung.com>
 <510EB2F1.4010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41641 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3BDBRE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Feb 2013 20:17:04 -0500
In-reply-to: <510EB2F1.4010603@gmail.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>

Sylwester Nawrocki wrote:
> 
> Hi,
> 
Hi,

> On 02/02/2013 01:45 AM, Kukjin Kim wrote:
> > Since mach/regs-sdi.h is used only for s3cmci.c, so this moves the
> > header file into the driver file, drivers/mmc/host/s3cmci.c file.
> >
> > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> 
> FIW, I have tested this patch on mini2440 board:
> 
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Sylwester, thanks for your test :-)

Chris, if you're ok on this, please take this in your tree. Or if you want,
let me pick this up in Samsung tree.

Thanks.

- Kukjin

