From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sh_mmcif: add support for Device Tree DMA bindings
Date: Sun, 25 Aug 2013 00:11:13 -0400
Message-ID: <877gfaquji.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1306241434200.19735@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37417 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841Ab3HYELR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Aug 2013 00:11:17 -0400
In-Reply-To: <Pine.LNX.4.64.1306241434200.19735@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 24 Jun 2013 14:36:34 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Mon, Jun 24 2013, Guennadi Liakhovetski wrote:
> To use DMA in the Device Tree case the driver has to be modified
> to use suitable API to obtain DMA channels.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
