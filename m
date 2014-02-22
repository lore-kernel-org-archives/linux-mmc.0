From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 0/5][RESENT]mmc: sh_mobile_sdhi: DT update for R-Car
Date: Sat, 22 Feb 2014 18:08:32 +0000
Message-ID: <86ios7vx3z.fsf@void.printf.net>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com> (Kuninori
	Morimoto's message of "Thu, 20 Feb 2014 16:54:10 -0800 (PST)")
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Fri, Feb 21 2014, Kuninori Morimoto wrote:
> These are re-sent patches for R-Car, since there were no response.
> Basically, these clarifies chip dependent settings
> inside driver.
> These are based on mmc/mmc-next branch
> (7536d3f83aa42ba1a3b1c6b30c2b6d94a820cbb2)

Thanks, I've pushed all five patches to mmc-next for 3.15, after
making Sergei's suggested changelog edit to 5/5 of "This patch
adds DT support for r8a7791."

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
