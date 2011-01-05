From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: make DMA support by the driver unconditional
Date: Wed, 5 Jan 2011 10:45:49 +0900
Message-ID: <AANLkTikh5yYj_kXM6fD+SNmurXqmB_ATaKnDfWM5Cwva@mail.gmail.com>
References: <Pine.LNX.4.64.1012290852530.14233@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40655 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab1AEBpu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 20:45:50 -0500
In-Reply-To: <Pine.LNX.4.64.1012290852530.14233@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Dec 29, 2010 at 4:59 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Simplify the driver by removing the possibility to build it without the DMA
> support and remove the respective Kconfig parameter.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Excellent, this helps against bitrot and makes kernel configuration
easier for newbies.

Acked-by: Magnus Damm <damm@opensource.se>
