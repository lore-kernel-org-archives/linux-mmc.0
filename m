From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 2/6] arm: davinci: Explicitly set channel
 controllers' default queues
Date: Mon, 25 Jul 2011 22:01:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEA5@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-3-git-send-email-ido@wizery.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE05@dbde02.ent.ti.com>
 <4E2D70B9.7060202@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34721 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1GYQbg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2011 12:31:36 -0400
In-Reply-To: <4E2D70B9.7060202@mvista.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Sergei,

On Mon, Jul 25, 2011 at 19:03:45, Sergei Shtylyov wrote:
> Hello.
> 
> Nori, Sekhar wrote:
> 
> >> Davinci platforms may define a default queue for each channel
> >> controller. If one is not defined, the default queue is set to EVENTQ_1.
> >> However, there's no way to distinguish between an unset default queue to
> >> one that is set to EVENTQ_0, as EVENTQ_0 = 0.
> 
> >> Explicitly specify the default queue for all channel controllers on all
> >> Davinci platforms to EVENTQ_1, and don't overwrite it in the EDMA probe
> >> function.
> 
> >> One exception is the DA850 board, for which EVENTQ_1 is not a valid
> >> option for its second channel controller. Use EVENTQ_0 instead for that
> >> channel controller.
> 
> >> Signed-off-by: Ido Yariv <ido@wizery.com>
> 
> > Looks good to me. Will queue for v3.2/fixes
> 
>     Why wait for 3.2? If this is considered a fix, it should be applied to 3.1, no?

3.2/fixes just indicates it will be queued as a fix/cleanup
for 3.2 so it will have higher priority for merge when compared
to a new feature.

This patch doesn't really fix any existing broken functionality.
It corrects event queue configuration for EDMA CC1 on DA850 for
which there are no current users in mainline.

So, not sending for v3.1.

Thanks,
Sekhar

