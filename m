From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Fri, 20 Aug 2010 17:06:50 +0200
Message-ID: <4C6E9A0A.6060205@arndnet.de>
References: <4C4555DA.40203@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:40743 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752692Ab0HTPGw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Aug 2010 11:06:52 -0400
In-Reply-To: <4C4555DA.40203@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi,

Am 20.07.2010 09:52, schrieb Yusuke Goda:
> Adjust the tmio_mmc block size check to accept 2-byte requests in
> 4-bit mode. Tested with the SDHI hardware block included in sh7724.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

Tested on AP4EVB (sh7372) with SDHC and MMC cards - no regression.

Tested-by: Arnd Hannemann <arnd@arndnet.de>
