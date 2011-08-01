From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC PATCH 1/9] mmc: atmel-mci: change namespace
Date: Mon, 01 Aug 2011 16:19:52 +0100
Message-ID: <4E36C418.1060604@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com> <1311863398-31579-2-git-send-email-ludovic.desroches@atmel.com> <20110730074807.GH25658@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:26518 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1HAPUA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Aug 2011 11:20:00 -0400
In-Reply-To: <20110730074807.GH25658@game.jcrosoft.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, ludovic.desroches@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, patrice.vilchez@atmel.com

On 07/30/2011 08:48 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:29 Thu 28 Jul     , ludovic.desroches@atmel.com wrote:
>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>
>> Homogenize namespace to atmci.
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
> prefer ATMEL_MCI
>
> ATMCI is not clear

Well it is used all over the place in the driver code. It is shorter and 
in coherence with what is existing already: I will take ATMCI_ naming by 
Ludovic.

Best regards,
-- 
Nicolas Ferre
