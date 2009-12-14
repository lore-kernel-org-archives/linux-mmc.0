From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH 1/2] sdhci-of: reorganize driver to support
 additional hardware
Date: Mon, 14 Dec 2009 23:27:07 +0300
Message-ID: <20091214202707.GA5300@oksana.dev.rtsoft.ru>
References: <1260819206-30074-1-git-send-email-albert_herranz@yahoo.es>
 <1260819206-30074-2-git-send-email-albert_herranz@yahoo.es>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:4233 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751404AbZLNU1J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 15:27:09 -0500
Content-Disposition: inline
In-Reply-To: <1260819206-30074-2-git-send-email-albert_herranz@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

On Mon, Dec 14, 2009 at 08:33:25PM +0100, Albert Herranz wrote:
> This patch breaks down sdhci-of into a core portion and a eSDHC portion,
> clearing the path to easily support additional hardware using the same
> OF driver.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Looks really good, thanks a lot for your work!

Few minor nits down below.

[...]
> +++ b/drivers/mmc/host/sdhci-of-core.c

Not sure if adding -core prefix makes things better (it
actually makes the patch harder to review).

Can we leave the core in sdhci-of.c, and just factor out
esdhc stuff from it?

[...]
> +#include <linux/mmc/host.h>
> +#include <asm/machdep.h>
> +#include "sdhci-of.h"
> +

You still need to include sdhci.h. Files need to include all
the headers they need. I.e., here you should not rely on the
fact that sdhci-of.h includes sdhci.h.

[...]
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of.h
> @@ -0,0 +1,42 @@
[...]
> +extern struct sdhci_of_data sdhci_esdhc;
> +
> +#endif /* __SDHCI_OF_H */
> +
> -- 
> 1.6.3.3

Unneeded empty line at the end of sdhci-of.h.


If you'll manage to resend the patches before Linus roll the -rc1
out, I'd be glad to beg Andrew to send this for v2.6.33. Because
it will be a pity if it has to wait for 2.6.34.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
