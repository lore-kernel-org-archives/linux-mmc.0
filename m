From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: remove include <mach/cpu.h>
Date: Thu, 27 Jun 2013 11:27:06 -0400
Message-ID: <878v1vpoad.fsf@octavius.laptop.org>
References: <1365511500-13778-1-git-send-email-nicolas.ferre@atmel.com>
	<20130605094225.GC2805@ludovic.desroches@atmel.com>
	<20130606083300.GJ23653@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54463 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab3F0P1L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:27:11 -0400
In-Reply-To: <20130606083300.GJ23653@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Thu, 6 Jun 2013 10:33:00 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 06 2013, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:42 Wed 05 Jun     , Ludovic Desroches wrote:
>> On Tue, Apr 09, 2013 at 02:45:00PM +0200, Nicolas Ferre wrote:
>> > Header file not needed anymore as we have removed
>> > the calls to cpu_is_xxx() macro.
>> > 
>> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> 
>> Late but of course:
>> 
>> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
