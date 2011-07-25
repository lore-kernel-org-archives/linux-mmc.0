From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 3/6] arm: davinci: mmc: Add support for set_power
 callback
Date: Mon, 25 Jul 2011 18:49:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE0A@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
 <1310303679-17936-4-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36459 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab1GYNWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2011 09:22:22 -0400
In-Reply-To: <1310303679-17936-4-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>

On Sun, Jul 10, 2011 at 18:44:36, Ido Yariv wrote:
> Some devices connected to the MMC bus are power controlled by external
> means. For instance, an SDIO device may be powered down/up by an
> external gpio line.
> 
> In order to avoid toggling power from within the MMC host driver, add a
> set_power callback function, which will be called by set_ios upon
> powering down/up.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> ---
>  arch/arm/mach-davinci/include/mach/mmc.h |    3 +++
>  drivers/mmc/host/davinci_mmc.c           |   13 +++++++++++++

>  2 files changed, 16 insertions(+), 0 deletions(-)


This looks good to me, but needs Ack/Sign-off from
MMC maintainer. Please repost keeping him in CC.

Thanks,
Sekhar
