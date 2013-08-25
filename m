From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: mxs-mmc: Use devm_clk_get()
Date: Sat, 24 Aug 2013 22:07:34 -0400
Message-ID: <87r4ditteh.fsf@octavius.laptop.org>
References: <1372881758-23502-1-git-send-email-festevam@gmail.com>
	<20130704012750.GA14617@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51982 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab3HYCHi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 22:07:38 -0400
In-Reply-To: <20130704012750.GA14617@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Thu, 4 Jul 2013 09:27:52 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de, linux-mmc@vger.kernel.org

Hi Fabio,

On Wed, Jul 03 2013, Shawn Guo wrote:
> On Wed, Jul 03, 2013 at 05:02:37PM -0300, Fabio Estevam wrote:
>> Using devm_clk_get() allows us to remove the clk_put() calls, so let's use it
>> to simplify the code.
>> 
>> Rename the 'out_clk_put' label to 'out_clk_disable' now that clk_put
>> is removed.
>> 
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
>
> Both,
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, both pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
