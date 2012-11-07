From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix SD cards not being detected sometimes.
Date: Wed, 07 Nov 2012 14:43:32 -0500
Message-ID: <87mwyt6vx7.fsf@octavius.laptop.org>
References: <1351612447-18982-1-git-send-email-javier.martin@vista-silicon.com>
	<20121102082550.GE1641@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36098 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab2KGTnh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Nov 2012 14:43:37 -0500
In-Reply-To: <20121102082550.GE1641@pengutronix.de> (Sascha Hauer's message of
	"Fri, 2 Nov 2012 09:25:50 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>, linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com

Hi,

On Fri, Nov 02 2012, Sascha Hauer wrote:
> On Tue, Oct 30, 2012 at 04:54:07PM +0100, Javier Martin wrote:
>> When a SD card is initialized some data transfers of 64 and 8 bytes
>> are issued. It seems the DMA has some problems dealing with these kind
>> of "short" transfers, leading sometimes to the SD card not being detected.
>> 
>> In order to solve this problem, do not use DMA for transfer sizes lower
>> than the sector size.
>> 
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
