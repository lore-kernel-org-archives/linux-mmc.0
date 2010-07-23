From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Fri, 23 Jul 2010 20:05:50 +0900
Message-ID: <AANLkTikVm-GWq6vun-AjqLJ1L7Y+s28CdDJqmCEX4+2R@mail.gmail.com>
References: <4C4555DA.40203@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45079 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0GWLFw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jul 2010 07:05:52 -0400
In-Reply-To: <4C4555DA.40203@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

2010/7/20 Yusuke Goda <yusuke.goda.sx@renesas.com>:
> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit mode.
> Tested with the SDHI hardware block included in sh7724.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

With this patch applied I can use SDIO cards in polling mode with the
tmio-mmc driver. Tested with the SDHI hardware block on sh7372 using
the b43 driver and BCM4318 hardware and the unfortunately out-of-tree
AR6002 "android" driver.

Acked-by: Magnus Damm <damm@opensource.se>
