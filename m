From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 2/6] arm: davinci: Explicitly set channel
 controllers'	default queues
Date: Mon, 25 Jul 2011 18:45:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE05@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
 <1310303679-17936-3-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36171 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab1GYNRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2011 09:17:34 -0400
In-Reply-To: <1310303679-17936-3-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>

On Sun, Jul 10, 2011 at 18:44:35, Ido Yariv wrote:
> Davinci platforms may define a default queue for each channel
> controller. If one is not defined, the default queue is set to EVENTQ_1.
> However, there's no way to distinguish between an unset default queue to
> one that is set to EVENTQ_0, as EVENTQ_0 = 0.
> 
> Explicitly specify the default queue for all channel controllers on all
> Davinci platforms to EVENTQ_1, and don't overwrite it in the EDMA probe
> function.
> 
> One exception is the DA850 board, for which EVENTQ_1 is not a valid
> option for its second channel controller. Use EVENTQ_0 instead for that
> channel controller.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>

Looks good to me. Will queue for v3.2/fixes

BTW, Arnd has indicated a preference for "ARM: davinci: "
prefix so I will make that change while applying.

Thanks,
Sekhar

