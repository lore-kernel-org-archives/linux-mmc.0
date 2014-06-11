From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v4] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller
Date: Wed, 11 Jun 2014 20:08:15 +0100
Message-ID: <86y4x3mfhc.fsf@void.printf.net>
References: <Pine.LNX.4.64.1405312005390.20582@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34085 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbaFKTIT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jun 2014 15:08:19 -0400
In-Reply-To: <Pine.LNX.4.64.1405312005390.20582@axis700.grange> (Guennadi
	Liakhovetski's message of "Sat, 31 May 2014 20:38:51 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Guennadi,

On Sat, May 31 2014, Guennadi Liakhovetski wrote:
> This patch adds a driver for the Renesas usdhi6rol0 SD/SDIO host controller
> in both PIO and DMA modes.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v4: replaced several numerical values with macros

Please send fixes for the compiler warnings, potential-null mrq, and
perhaps add an ARCH_ dependency to stop this building on x86_64.

Thanks,

- Chris.
-- 
Chris Ball   <http://printf.net/>
