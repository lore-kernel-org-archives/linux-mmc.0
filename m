From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/6] mmc: sh_mmcif: revision-specific CCS and CLK_CTRL2 handling
Date: Sun, 25 Aug 2013 00:12:00 -0400
Message-ID: <8738pyqui7.fsf@octavius.laptop.org>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Wed, 10 Jul 2013 21:21:11 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Jul 10 2013, Guennadi Liakhovetski wrote:
> This patch series adds version-specific support for Command Completion 
> Signal and the CE_CLK_CTRL2 register. Presumably, the first two patches 
> will go via the MMC tree, the rest should be applied after them.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> Guennadi Liakhovetski (6):
>   mmc: sh_mmcif: revision-specific Command Completion Signal handling
>   mmc: sh_mmcif: revision-specific CLK_CTRL2 handling

Thanks, I've pushed these two patches to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
