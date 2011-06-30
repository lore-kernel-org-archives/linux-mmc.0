From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Thu, 30 Jun 2011 21:36:53 +0200
Message-ID: <4E0CD055.30902@ti.com>
References: <1309460700-25898-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab1F3ThA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2011 15:37:00 -0400
In-Reply-To: <1309460700-25898-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

Hi Balaji,

On 6/30/2011 9:04 PM, Krishnamoorthy, Balaji T wrote:
> Removing the custom state machine - lazy disable framework in omap_hsmmc
> to make way for runtime pm to handle host controller
> power states.
> This allows mmc_host_enable/mmc_host_disable to be replaced by
> runtime get_sync and put_sync at host controller driver.
>
> Enable runtime PM in omap_hsmmc
>
> Rebased to 3.0-rc5
> Tested on OMAP4430SDP, OMAP3430SDP, OMAP2430SDP
>
> MMC runtime patch has dependency on
> [PATCH 0/6] OMAP2+: hwmod framework fixes [1]
> for MMC1/MMC2 clock to get ungated after idle in OMAP4.
>
> Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.

Mmm, that's weird, which one exactly is fixing the issue?
BTW, what is the issue exactly?

Benoit

>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457.html
>
> Balaji T K (3):
>    MMC: OMAP: HSMMC: Remove lazy_disable
>    MMC: OMAP: HSMMC: add runtime pm support
>    MMC: OMAP: HSMMC: Remove unused iclk
>
>   drivers/mmc/host/omap_hsmmc.c |  365 +++++++----------------------------------
>   1 files changed, 57 insertions(+), 308 deletions(-)
>

