From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2] ARM: at91: add atmel-mci support for chips and boards
 which can use it
Date: Tue, 29 May 2012 12:56:10 +0200
Message-ID: <4FC4AB4A.8060605@atmel.com>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com> <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com> <20120528074133.GR3377@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:15594 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2E2MQU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 May 2012 08:16:20 -0400
In-Reply-To: <20120528074133.GR3377@game.jcrosoft.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/28/2012 09:41 AM, Jean-Christophe PLAGNIOL-VILLARD :
> On 12:23 Mon 21 May     , ludovic.desroches@atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
>> use it instead of at91_mci driver.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> ---
>> V2: add several boards I missed
> for the 9g20 and 9260 please drop the old driver support too

No, we will drop the support for old driver when we finish the
transition period. We will then drop at91_mci with all configuration
data in device/board files.

> for calao bord you can do it too

Well, you can add it yourself. As you may be able to test it, it sounds
better if you handle this part...

Bye,
-- 
Nicolas Ferre
