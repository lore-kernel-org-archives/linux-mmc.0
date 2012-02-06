From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Mon, 06 Feb 2012 14:26:54 +0900
Message-ID: <4F2F649E.2010106@samsung.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
 <m2mx8y6ls1.fsf@bob.laptop.org>
 <CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34750 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab2BFF1B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 00:27:01 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYY007ILHSRNT30@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 Feb 2012 14:27:00 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYY00H7NHSZO070@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 Feb 2012 14:27:00 +0900 (KST)
In-reply-to: <CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 02/06/2012 02:13 PM, Saugata Das wrote:

> On 5 February 2012 08:15, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Wed, Feb 01 2012, Saugata Das wrote:
>>> From: Saugata Das <saugata.das@linaro.org>
>>>
>>> This patch groups the read or write transfers to eMMC in different contexts
>>> based on the block number. Transfers to consecutive blocks are grouped to a
>>> common context. So several small transfers combine to give performance like
>>> a large multi block transfer.
>>>
>>> The patch creates a context of 1MB multiple in non-large unit mode. Reliable
>>> mode is enabled in the context based on whether reliable write is enabled.
>>
>> Do you see any performance changes with this patchset?  If so, can you
>> give details?
> 
> I do not see any performance impact (positive or negative) on the
> sample eMMC-4.5 device which I have. This could be due to the slow
> bridge which I use (1-bit mode at 25MHz) to connect the eMMC-4.5
> device on micro-SD slot of 8500 platform.

I think that should be increased the performance by how we select the context.
I also didn't see any performance benefit..8-bit mode at 50Mhz.
But i have interest for this feature

Best Regards,
Jaehoon Chung

> 
>>
>> Thanks,
>>
>> - Chris.
>> --
>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>> One Laptop Per Child
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


