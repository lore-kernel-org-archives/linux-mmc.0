From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] ARM: dove: DT support for sdhci-dove
Date: Tue, 07 Aug 2012 23:53:08 -0400
Message-ID: <87boimvy3f.fsf@octavius.laptop.org>
References: <1343666134-21205-1-git-send-email-sebastian.hesselbarth@googlemail.com>
	<1343722379-32699-1-git-send-email-sebastian.hesselbarth@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34342 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab2HHDxT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:53:19 -0400
In-Reply-To: <1343722379-32699-1-git-send-email-sebastian.hesselbarth@googlemail.com>
	(Sebastian Hesselbarth's message of "Tue, 31 Jul 2012 10:12:59 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Anton Vorontsov <cbouatmailru@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>, David Brown <davidb@codeaurora.org>, Andrew Lunn <andrew@lunn.ch>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Sebastian,

On Tue, Jul 31 2012, Sebastian Hesselbarth wrote:
> This patch adds device tree support and binding documentiation for
> sdhci-dove.
>
> v2: extended documentation and removed second interrupt as it is marked 
>     'reserved' in dove datasheet.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
>
> ---

Looks good, pushed to mmc-next for 3.7.  In future, please use the area
just below the "---" to describe your patch changelog v1->v2; that way
it won't go into the commit message in git.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
