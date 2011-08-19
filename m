From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/4] mmc: tmio: Cache interrupt masks
Date: Fri, 19 Aug 2011 13:32:22 +0900
Message-ID: <CANqRtoSRReqERzfLnvTsTaPMuAov0XGCCpgOPtuJRmEXcM8wPg@mail.gmail.com>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
	<1313716221-20136-2-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313716221-20136-2-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> wrote:
> This avoids the need to look up the masks each time an interrupt
> is handled.
>
> As suggested by Guennadi.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Good idea, thanks for this!

/ magnus
