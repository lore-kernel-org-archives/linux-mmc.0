From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/3] mmc: atmel-mci: correct data timeout computation
Date: Sat, 31 Mar 2012 23:43:06 -0400
Message-ID: <87vclkm81h.fsf@laptop.org>
References: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
	<1332930513-14893-1-git-send-email-ludovic.desroches@atmel.com>
	<4F72F9A5.60900@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48696 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280Ab2DADnA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 31 Mar 2012 23:43:00 -0400
In-Reply-To: <4F72F9A5.60900@atmel.com> (Nicolas Ferre's message of "Wed, 28
	Mar 2012 13:44:37 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Mar 28 2012, Nicolas Ferre wrote:
> On 03/28/2012 12:28 PM, ludovic.desroches@atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>> 
>> The HSMCI operates at a rate of up to Master Clock divided by two.
>> Moreover previous calculation can cause overflows and so wrong
>> timeouts.
>> 
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
