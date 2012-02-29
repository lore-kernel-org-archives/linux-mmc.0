From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: atmel-mci causing oops?
Date: Wed, 29 Feb 2012 22:44:55 +0100
Message-ID: <4F4E9C57.9020502@atmel.com>
References: <20120229173115.GA23529@ldesroches-Latitude-E6320> <m2linlo83r.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:49193 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab2B2VpZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Feb 2012 16:45:25 -0500
In-Reply-To: <m2linlo83r.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, "Ferre, Nicolas" <nicolas.ferre@atmel.com>, plagnioj@jcrosoft.com, me@danielpalmer.co.uk, linux-arm-kernel@lists.infradead.org

Hi Chris,

On 02/29/2012 06:35 PM, Chris Ball wrote:
> Hi Ludovic,
>
> On Wed, Feb 29 2012, Ludovic Desroches wrote:
>> You can find the two patches into the mmc-next tree of Chris:
>> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=43df92914ea0623893bcb801791d5d2be2f5e015
>> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=9cfa4030ea90f2fc204532975a824b987433f6dd
>>
>> By the way, Chris, is it possible to put these patches as a fix for 3.3
>> kernel? Without them we will have this oops each time someone would use
>> mmc without a DMA Controller or if it is impossible to get a dma channel.
> Will do, thanks.  Should they go to 3.2-stable, too?
>
> - Chris.
You're right 3.2 kernel is also concerned so they can go to 3.2-stable.

Thanks.

Ludovic

