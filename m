From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 1/4] mmc:core: parse voltage from device-tree
Date: Tue, 27 Aug 2013 08:52:25 +0800
Message-ID: <521BF849.5020106@freescale.com>
References: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com> <87zjs49zp5.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:48548 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab3H0Asw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2013 20:48:52 -0400
In-Reply-To: <87zjs49zp5.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, galak@kernel.crashing.org, cbouatmailru@gmail.com, scottwood@freescale.com, X.Xie@freescale.com

On 08/27/2013 12:36 AM, Chris Ball wrote:
> Hi Haijun,
>
> On Sun, Aug 25 2013, Haijun Zhang wrote:
>> Add function to support get voltage from device-tree.
>> If there are voltage-range specified in device-tree node, this function
>> will parse it and return the available voltage mask.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> Acked-by: Anton Vorontsov <anton@enomsg.org>
>
> Thanks, I've pushed all four patches to mmc-next for 3.12.
>
> - Chris.
>

Thank you very much!

-- 
Thanks & Regards

Haijun

