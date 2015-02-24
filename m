From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] tmio: mmc: replace sh_mobile_sdhi_info to tmio_mmc_data
Date: Tue, 24 Feb 2015 09:17:26 +0100
Message-ID: <6625730.KGa6x2BHnT@wuerfel>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53096 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbBXISK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Feb 2015 03:18:10 -0500
In-Reply-To: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tuesday 24 February 2015 11:07:25 Kuninori Morimoto wrote:
> Hi Ulf, Vinod, Simon
> 
> DMAEngine cleanup patches are accepted in v4.0-rc1
> 
> As I mentioned in
> http://thread.gmane.org/gmane.linux.ports.sh.devel/42669
> these are last of sh_mobile_sdhi DMA patches.
> 
> These patches uses tmio_mmc_data on platform,
> and remove sh_mobile_sdhi
> 
> These are based on
>  - linus's v4.0-rc1
>  - Vinod's dma/next (git://git.infradead.org/users/vkoul/slave-dma.git :: next)
> 

Both patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
