From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Remove platform data
Date: Sat, 17 Nov 2012 15:32:44 -0500
Message-ID: <8762549dhv.fsf@octavius.laptop.org>
References: <1351682578-12922-1-git-send-email-festevam@gmail.com>
	<20121031154458.GB8358@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48103 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab2KQUct (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 15:32:49 -0500
In-Reply-To: <20121031154458.GB8358@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Wed, 31 Oct 2012 23:45:00 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, marex@denx.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi,

On Wed, Oct 31 2012, Shawn Guo wrote:
> On Wed, Oct 31, 2012 at 09:22:58AM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>> 
>> All MXS users have been converted to device tree and the board files have been
>> removed.
>> 
>> No need to keep platform data in the driver.
>> 
>> Also move bus_width declaration in the beggining of mxs_mmc_probe() to avoid:
>> 'warning: ISO C90 forbids mixed declarations and code'.
>>   
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, pushed to mmc-next for 3.8 with ACKs from Marek and Shawn.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
