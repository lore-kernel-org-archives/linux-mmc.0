From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/3] MMC: Fix checkpatch complaints about long lines
Date: Mon, 20 Jun 2011 09:58:45 +0200
Message-ID: <4DFEFDB5.9070805@atmel.com>
References: <1308419437-18306-1-git-send-email-sebras@gmail.com> <20110619065048.GC1632@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:51441 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1FTH7G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 03:59:06 -0400
In-Reply-To: <20110619065048.GC1632@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>

Le 19/06/2011 08:50, Wolfram Sang :
> On Sat, Jun 18, 2011 at 07:50:37PM +0200, Sebastian Rasmussen wrote:
>> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> 
> I don't think it improves readability, so not worth the change IMO.

I have the same feeling: can't we be more tolerant with this soft limit
requirement?

And for sure changing existing code only for this is a bad idea.

Bye,
-- 
Nicolas Ferre

