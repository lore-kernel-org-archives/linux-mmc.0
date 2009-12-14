From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH 1/2] sdhci-of: reorganize driver to support additional
 hardware
Date: Mon, 14 Dec 2009 22:14:02 +0100
Message-ID: <4B26AA9A.70607@yahoo.es>
References: <1260819206-30074-1-git-send-email-albert_herranz@yahoo.es> <1260819206-30074-2-git-send-email-albert_herranz@yahoo.es> <20091214202707.GA5300@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp106.mail.ukl.yahoo.com ([77.238.184.38]:43023 "HELO
	smtp106.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932643AbZLNVOL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 16:14:11 -0500
In-Reply-To: <20091214202707.GA5300@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

Anton Vorontsov wrote:
> On Mon, Dec 14, 2009 at 08:33:25PM +0100, Albert Herranz wrote:
>> This patch breaks down sdhci-of into a core portion and a eSDHC portion,
>> clearing the path to easily support additional hardware using the same
>> OF driver.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> 
> Looks really good, thanks a lot for your work!
> 
> Few minor nits down below.
> 
> [...]
>> +++ b/drivers/mmc/host/sdhci-of-core.c
> 
> Not sure if adding -core prefix makes things better (it
> actually makes the patch harder to review).
> 
> Can we leave the core in sdhci-of.c, and just factor out
> esdhc stuff from it?
> 

I wanted to preserve the module name (sdhci-of). I basically renamed sdhci-of.c to sdhci-of-core.c to avoid a recursive rule in the Makefile.
Is there an easy way to make the module build as sdhci-of from sdhci-of.c + sdhci-of-esdhc.c + whatever ?

> [...]
>> +#include <linux/mmc/host.h>
>> +#include <asm/machdep.h>
>> +#include "sdhci-of.h"
>> +
> 
> You still need to include sdhci.h. Files need to include all
> the headers they need. I.e., here you should not rely on the
> fact that sdhci-of.h includes sdhci.h.
> 

Including sdhci.h more than once currently results in duplicate definition errors because that header file is not protected with #ifdef'ery.
I can fix sdhci.h and then explicitly include it again.

> [...]
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-of.h
>> @@ -0,0 +1,42 @@
> [...]
>> +extern struct sdhci_of_data sdhci_esdhc;
>> +
>> +#endif /* __SDHCI_OF_H */
>> +
>> -- 
>> 1.6.3.3
> 
> Unneeded empty line at the end of sdhci-of.h.
> 

Thanks.

> If you'll manage to resend the patches before Linus roll the -rc1
> out, I'd be glad to beg Andrew to send this for v2.6.33. Because
> it will be a pity if it has to wait for 2.6.34.
> 

I'll try, as long as we solve nit #1 quickly enough :)

Cheers,
Albert
