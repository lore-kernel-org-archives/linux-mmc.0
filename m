From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] mmc: atmel-mci: add support for old mci IPs
Date: Thu, 17 May 2012 08:43:35 -0400
Message-ID: <87obpn3rm0.fsf@laptop.org>
References: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43600 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964794Ab2EQMni (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 May 2012 08:43:38 -0400
In-Reply-To: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Wed, 16 May 2012 15:25:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

Hi Ludovic,

On Wed, May 16 2012, ludovic.desroches@atmel.com wrote:
> This set of patches is an extra step to remove at91-mci dirver which is mainly
> used for old chips having mci IPs whose version is lesser than v2xx (rm9200
> and 9261).
> Since it introduces many changes and there was a lack of logs to help people
> when there is an issue with atmel-mci driver, I added some debug logs.
>
> These changes have been tested on at91rm9200, at91sam9261, at91sam9263,
> at91sam9g10 and at91sam9g45.

Thanks, pushed all four to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
