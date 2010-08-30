From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Mon, 30 Aug 2010 15:17:33 +0200
Message-ID: <4C7BAF6D.6090006@arndnet.de>
References: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:49186 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751758Ab0H3NRi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Aug 2010 09:17:38 -0400
In-Reply-To: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ian Molton <ian@mnementh.co.uk>

Hi,

Am 30.08.2010 12:50, schrieb Matt Fleming:
> From: Yusuke Goda <yusuke.goda.sx@renesas.com>
>
> Adjust the tmio_mmc block size check to accept 2-byte requests in
> 4-bit mode if the hardware supports it.
>
> Tested with the SDHI hardware block included in sh7724.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Tested on AP4EVB (sh7372) with SDHC and MMC cards.

Tested-by: Arnd Hannemann <arnd@arndnet.de>

Regards,
Arnd


