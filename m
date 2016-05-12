From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: mmc: do not use CMD13 to get status after speed mode
 switch
Date: Thu, 12 May 2016 13:29:40 +0300
Message-ID: <57345B14.7030308@intel.com>
References: <1462344872-6448-1-git-send-email-chaotian.jing@mediatek.com>
 <5732E43E.8070800@intel.com> <1463036431.11653.3.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20235 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbcELKdg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2016 06:33:36 -0400
In-Reply-To: <1463036431.11653.3.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On 12/05/16 10:00, Chaotian Jing wrote:
> On Wed, 2016-05-11 at 10:50 +0300, Adrian Hunter wrote:
>> On 04/05/16 09:54, Chaotian Jing wrote:
>>> Per JEDEC spec, it is not recommended to use CMD13 to get card status
>>> after speed mode switch. below are two reason about this:
>>> 1. CMD13 cannot be guaranteed due to the asynchronous operation.
>>> Therefore it is not recommended to use CMD13 to check busy completion
>>> of the timing change indication.
>>> 2. After switch to HS200, CMD13 will get response of 0x800, and even the
>>> busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
>>>
>>> this patch drops CMD13 when doing speed mode switch, if host do not
>>> support MMC_CAP_WAIT_WHILE_BUSY and there is no ops->card_busy(),
>>> then the only way is to wait a fixed timeout.
>>
>> This looks like it should be 3 patches:
>> 	1. Change __mmc_switch
>> 	2. Change HS200 and HS400 selection
>> 	3. Change HS selection
>>
>> However there is another problem: card_busy is not the same as busy signal -
>> see below.  So that needs to be sorted out first.
>>
> We should make that card_busy() is the same with busy signal asserted.
> as you know, if card was not in busy state, all data pins should be high
> level as it is pull-up by default. so that's no conflict to check card
> busy signal by DAT0 or DAT0 ~ DAT3.

Potentially SDIO uses DAT1 for card interrupt, so that is a conflict right
there.

Also SDHCI does it backwards (don't ask me why) and considers 0000 to be
busy, so there's another conflict.

Some of the language in the SD and SDHCI specifications seems to indicate
that checking all 4 DAT lines during voltage switch is optional i.e. only 1
of the lines must be checked.  If that is true then we could change all the
drivers over to check just DAT0, and expect that to work for both busy
signalling and SD voltage switch checks.

So it seems to me card_busy still needs to be sorted out first.

