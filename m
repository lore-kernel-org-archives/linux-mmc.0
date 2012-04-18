From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: cd-gpio.c: Include header to pickup exported symbol prototypes
Date: Wed, 18 Apr 2012 19:59:39 -0400
Message-ID: <871unkmw0k.fsf@laptop.org>
References: <201204171303.39744.hartleys@visionengravers.com>
	<Pine.LNX.4.64.1204172230540.27488@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56397 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab2DRX73 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 19:59:29 -0400
In-Reply-To: <Pine.LNX.4.64.1204172230540.27488@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 17 Apr 2012 22:31:17 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, svenkatr@ti.com

Hi,

On Tue, Apr 17 2012, Guennadi Liakhovetski wrote:
> On Tue, 17 Apr 2012, H Hartley Sweeten wrote:
>
>> Include the linux/mmc/cd-gpio.h header to pickup the prototypes
>> for the two exported symbols.
>> 
>> This quiets the sparse warnings:
>> 
>> warning: symbol 'mmc_cd_gpio_request' was not declared. Should it be static?
>> warning: symbol 'mmc_cd_gpio_free' was not declared. Should it be static?
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> Acked-by: Venkatraman S <svenkatr@ti.com>
>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
