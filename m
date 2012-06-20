From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/7 v4] mmc: tmio: clock and PM updates
Date: Wed, 20 Jun 2012 13:54:41 -0400
Message-ID: <87pq8t3m3i.fsf@octavius.laptop.org>
References: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de> (Guennadi
	Liakhovetski's message of "Wed, 20 Jun 2012 19:10:29 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Jun 20 2012, Guennadi Liakhovetski wrote:
> This patch series is a respin of the sub-series 3/6 from 
> http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus=14633
> of which the first patch has been superseded by "mmc: tmio: Don't access 
> hardware registers after stopping clocks"
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg14696.html
> This series also requires "mmc: add a function to get a regulator, 
> supplying card's Vdd"
> http://www.spinics.net/lists/linux-sh/msg12007.html
>
> Patch 4 of this series also contributes to part 3 of the scheme, described 
> in http://thread.gmane.org/gmane.linux.ports.sh.devel/15544

You've had these posted for quite a while, so I've pushed them to
mmc-next for 3.6 now.  It would still be good to get some reviews on
them, though -- reviewers, feel free to continue to look at these and
I'll add your Reviewed-by tags (and the updates to the patches if
necessary) as they come in.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
