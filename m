From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Mon, 22 Feb 2010 16:55:14 +0200
Message-ID: <94a0d4531002220655p675f7648rdfd302ea6aeb1b58@mail.gmail.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f177.google.com ([209.85.223.177]:51821 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0BVOzP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2010 09:55:15 -0500
In-Reply-To: <cover.1266847842.git.david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

On Mon, Feb 22, 2010 at 4:24 PM, David Vrabel <david.vrabel@csr.com> wrote:
> These patches add support for SDIO cards to the omap_hsmmc driver.
> Power management changes to prevent SDIO cards from being turned off
> and losing all state, and card interrupts.
>
> I've been unable to test these exact patches as I only have an N900 for
> testing and the N900 support in mainline is incomplete.

Can't you get the source code with 'apt-get source' in Maemo SDK? It's
a tarball but at least it's something.

-- 
Felipe Contreras
