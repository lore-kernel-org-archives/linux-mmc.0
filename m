From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/3] mmc: sdhci_pltfm: Constify sdhci_pltfm_data
Date: Fri, 22 Mar 2013 13:01:43 -0400
Message-ID: <87a9pvmkqw.fsf@octavius.laptop.org>
References: <1363199165-16211-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43767 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998Ab3CVRBt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:01:49 -0400
In-Reply-To: <1363199165-16211-1-git-send-email-lars@metafoo.de> (Lars-Peter
	Clausen's message of "Wed, 13 Mar 2013 19:26:03 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Anton Vorontsov <cbou@mail.ru>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mike Rapoport <mike@compulab.co.il>, Shawn Guo <shawn.guo@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 13 2013, Lars-Peter Clausen wrote:
> The sdhci_pltfm_data struct is never modified within the sdhci_pltfm module. So
> make the pdata parameter to sdhci_pltfm_init and sdhci_pltfm_register const.
> This allows drivers to declare their sdhci_pltfm_data struct as const.
>
> This patch also makes the sdhci_pltfm_data declarations const where possible.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, all three patches pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
