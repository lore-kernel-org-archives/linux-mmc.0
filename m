From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: V3:  Allow CAPS[1] to be set via QUIRK
Date: Tue, 03 Jul 2012 19:05:34 -0400
Message-ID: <87lij078e9.fsf@octavius.laptop.org>
References: <1340858967-2413-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49853 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab2GCXFj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 19:05:39 -0400
In-Reply-To: <1340858967-2413-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Wed, 27 Jun 2012 21:49:27
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Thu, Jun 28 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> currently only the capability_0 register can be set if
> SDHCI_QUIRK_MISSING_CAPS is defined.  This is a problem when
> the capability_1 register also needs changing.  Use the
> SDHCI_QUIRK_MISSING_CAPS to allow both registers to be set.
>
> Redefining caps[1] is useful when the board design does not
> support 1.8v vccq so UHS modes are not available.  The code
> that calls sdhci_add_host can then detect this condition and
> adjust the caps so the UHS mode will not be attempted on UHS
> cards
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
