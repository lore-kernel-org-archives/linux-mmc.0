From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 1/3] mmc:core: parse voltage from device-tree
Date: Tue, 30 Jul 2013 09:34:29 +0800
Message-ID: <51F71825.9000904@freescale.com>
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com> <1375135638.30721.58@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:41210
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756516Ab3G3BeB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jul 2013 21:34:01 -0400
In-Reply-To: <1375135638.30721.58@snotra>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, Xie Xiaobo-R63061 <X.Xie@freescale.com>

On 07/30/2013 06:07 AM, Scott Wood wrote:
> On 07/28/2013 09:56:33 PM, Haijun Zhang wrote:
>> Add function to support get voltage from device-tree.
>> If there are voltage-range specified in device-tree node, this function
>> will parse it and return the avail voltage mask.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
>>  drivers/mmc/core/core.c  | 48 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mmc/core.h |  1 +
>>  2 files changed, 49 insertions(+)
>
> Move the code rather than copying it.
>
> -Scott
Hi, Scott

You mean?

-- 
Thanks & Regards

Haijun


