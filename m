From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sh_mmcif: Correct TX DMA channel allocation
Date: Wed, 10 Feb 2016 15:45:46 +0100
Message-ID: <12843205.GL7Z1MTmk1@wuerfel>
References: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:60213 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcBJOp4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 09:45:56 -0500
In-Reply-To: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, ykaneko0929@gmail.com, geert+renesas@glider.be, laurent.pinchart@ideasonboard.com, kouichi.tomita.yn@renesas.com, takeshi.kihara.df@renesas.com, koji.matsuoka.xm@renesas.com

On Wednesday 10 February 2016 14:07:01 Chris Paterson wrote:
> Commit 27cbd7e815a8 ("mmc: sh_mmcif: rework dma channel handling")
> introduced a typo causing the TX DMA channel allocation to be overwritten
> by the requested RX DMA channel.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sorry about the trouble.
