From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 3/4] mmc: davinci: prepare clock
Date: Tue, 15 Mar 2016 10:46:16 +0530
Message-ID: <56E79AA0.9050308@ti.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-4-git-send-email-david@lechnology.com>
 <56E6A66D.1080909@ti.com> <56E6F03F.5060908@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51465 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbcCOFRe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Mar 2016 01:17:34 -0400
In-Reply-To: <56E6F03F.5060908@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Monday 14 March 2016 10:39 PM, David Lechner wrote:
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

Alright, glad to know someone is pursuing this.

Thanks,
Sekhar
