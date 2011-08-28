From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4 v8] mmc: tmio, sdhi: provide multiple irq handlers
Date: Sun, 28 Aug 2011 13:58:54 -0400
Message-ID: <m2sjolxvs1.fsf@bob.laptop.org>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1314235648-8959-1-git-send-email-horms@verge.net.au> (Simon
	Horman's message of "Thu, 25 Aug 2011 10:27:24 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Wed, Aug 24 2011, Simon Horman wrote:
> The SDHI driver already supports making use of up to three interrupt
> sources.
>
> This series breaks up the existing interrupt handler into three handlers,
> one for sdcard access, one for card detect and one for SDIO interrupts.
> A cover-all handler, which makes use of these new broken-out handlers
> is provided for for the case where there is a multiplexed interrupt source.
>
> This series also wires up the new IRQ handlers for the mackerel and ag4evm.
>
> This series contains the following patches:
>
> [PATCH v8 1/4] mmc: tmio: Cache interrupt masks
> [PATCH v8 2/4] mmc: tmio: Provide separate interrupt handlers
> [PATCH v8 3/4] mmc: sdhi: Allow name IRQs to use specific handlers
> [PATCH v8 4/4] ARM: shmobile: ag5evm, ap4: Named SDHI IRQ sources

Thanks, all applied to mmc-next for 3.2, using Guennadi's v9 for 3/4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
