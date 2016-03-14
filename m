From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 3/4] mmc: davinci: prepare clock
Date: Mon, 14 Mar 2016 12:13:49 -0500
Message-ID: <56E6F14D.4090106@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-4-git-send-email-david@lechnology.com>
 <56E6A66D.1080909@ti.com> <56E6F03F.5060908@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:58283 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbcCNRNn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2016 13:13:43 -0400
In-Reply-To: <56E6F03F.5060908@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 03/14/2016 12:09 PM, David Lechner wrote:
> On 03/14/2016 06:54 AM, Sekhar Nori wrote:
>> On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
>>> When trying to use this driver with the common clock framework, enabling
>>> the clock fails because it was not prepared. This fixes the problem by
>>> calling clk_prepare and clk_enable in a single function.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>> Patch looks good. But I wonder how you hit this issue since we dont use
>> common clock framework on mach-davinci and this driver is not used
>> anywhere else AFAIK.
>>
>> Regards,
>> Sekhar
>>
> Because I am working towards getting the common clock framework working
> on mach-davinci - at least with da8xx/device tree. :-)

I should also mention that I did test using the existing mach-davinci 
clocks as well.
