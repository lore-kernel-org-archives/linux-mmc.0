From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: fix clock frequency printing
Date: Mon, 03 Dec 2012 14:21:48 -0500
Message-ID: <87lidfhrg3.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1211281023310.1710@axis700.grange>
	<20121130090238.GH4501@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20121130090238.GH4501@verge.net.au> (Simon Horman's message of
	"Fri, 30 Nov 2012 18:02:39 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 30 2012, Simon Horman wrote:
> On Wed, Nov 28, 2012 at 10:24:13AM +0100, Guennadi Liakhovetski wrote:
>> During its probing the SDHI driver prints out the clock frequency, but
>> does it wrongly, always reporting 0Hz. Use the MMC host frequency value
>> to fix this issue.
>> 
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
