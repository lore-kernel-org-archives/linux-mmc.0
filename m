From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 08/12] mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
Date: Wed, 11 Dec 2013 21:25:09 -0500
Message-ID: <87mwk66c1m.fsf@octavius.laptop.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<23114596.UeGyAebmZh@avalon> <87a9g67t63.fsf@octavius.laptop.org>
	<4390506.Q1di3yUE6Z@avalon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4390506.Q1di3yUE6Z@avalon> (Laurent Pinchart's message of "Thu,
	12 Dec 2013 03:16:05 +0100")
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Laurent,

On Wed, Dec 11 2013, Laurent Pinchart wrote:
>> I'm sorry about the delay -- it's in mmc-next for 3.14 now.
>
> Thanks a lot and sorry about shouting. Don't worry about the delay, I only 
> wanted to make sure the patch would get in v3.14.

No worries, it was deserved yelling.  :-)

> [PATCH v3 1/3] mmc: sh_mmcif: Factorize DMA channel request and configuration 
> code
> [PATCH v3 2/3] mmc: sh_mmcif: Fix compilation warning on 64-bit platforms

These two are in mmc-next now too.  (I usually wait for someone with
SH hardware to ACK, but I understand that Guennadi's not around as
much anymore.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
