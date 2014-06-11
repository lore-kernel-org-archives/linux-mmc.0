From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v4] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller
Date: Wed, 11 Jun 2014 23:07:09 +0100
Message-ID: <86tx7rm776.fsf@void.printf.net>
References: <Pine.LNX.4.64.1405312005390.20582@axis700.grange>
	<86y4x3mfhc.fsf@void.printf.net>
	<Pine.LNX.4.64.1406112218060.2586@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51581 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbaFKWHQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jun 2014 18:07:16 -0400
In-Reply-To: <Pine.LNX.4.64.1406112218060.2586@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 11 Jun 2014 22:20:07 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On Wed, Jun 11 2014, Guennadi Liakhovetski wrote:
>> Please send fixes for the compiler warnings, potential-null mrq,
>
> Sure, it's on my todo for Saturday, is this ok?

Cool, thanks.

>> and
>> perhaps add an ARCH_ dependency to stop this building on x86_64.
>
> Is there a specific reason to only build it on ARM? It can be used with 
> various architectures, but we can make it depend on COMPILE_TEST (or 
> whatever that option is called), but I'm not sure that's required.

Mainly that it looked like it wasn't intended for 64-bit systems,
but if that's untrue then I guess it's okay to leave it building.
Of course, you could depend on each of the architectures you're
aware of it being potentially used on, rather than just ARM.

- Chris.
-- 
Chris Ball   <http://printf.net/>
