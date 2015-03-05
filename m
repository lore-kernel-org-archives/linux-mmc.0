From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] tmio: mmc: replace sh_mobile_sdhi_info to
 tmio_mmc_data
Date: Thu, 5 Mar 2015 21:55:08 +0530
Message-ID: <20150305162508.GL2613@intel.com>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64483 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754476AbbCEQ2h (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Mar 2015 11:28:37 -0500
Content-Disposition: inline
In-Reply-To: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, Feb 24, 2015 at 11:07:25AM +0900, Kuninori Morimoto wrote:
> 
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
Applied both to topic/sh

Thanks
-- 
~Vinod

