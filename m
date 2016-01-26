From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove repetitive clear interrupt
Date: Tue, 26 Jan 2016 08:40:40 +0800
Message-ID: <56A6C088.8060103@rock-chips.com>
References: <1453684420-1860-1-git-send-email-shawn.lin@rock-chips.com>
 <56A5A11A.5030103@samsung.com> <56A5AAF9.5090002@rock-chips.com>
 <1630713.rPyRx6D05H@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:48131 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcAZAlG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2016 19:41:06 -0500
In-Reply-To: <1630713.rPyRx6D05H@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016/1/25 16:55, Arnd Bergmann wrote:
> On Monday 25 January 2016 12:56:25 Shawn Lin wrote:
>> On 2016/1/25 12:14, Jaehoon Chung wrote:
>>> Hi, Shawn.
>>>
>>> On 01/25/2016 10:13 AM, Shawn Lin wrote:
>>>> This patch remove repetitive clear interrupt while
>>>> probing dw_mmc.
>>>
>>> Could you explain to me more?
>>
>> yes, it's a trivial improvement.
>>
>> dw_mci_probe clear interrupt and disable all interrupt firstly.
>> Then commit 2da1d7f2 add a new clear-interrupt operation before
>> enable some interrupt. I can't see any reason to clear it twice
>> here. No any side effect I had found in my test pattern without this
>> . May I miss some important case?
>>
>
> The explanation should go into the patch description to explain why
> it is done. The one sentence "This patch remove repetitive clear
> interrupt while probing dw_mmc" that you wrote instead can be
> removed, it just repeats the patch subject.
>

Hi Arnd

Thanks for sharing that. I will respin v2 to add this into commit-msg.

> 	Arnd
>
>
>


-- 
Best Regards
Shawn Lin

