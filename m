From: Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
Date: Thu, 22 Oct 2015 10:18:48 -0400
Message-ID: <5628F048.3000501@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com> <5626E9BC.40300@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35432 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757631AbbJVOTT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Oct 2015 10:19:19 -0400
In-Reply-To: <5626E9BC.40300@oracle.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>, Franklin S Cooper Jr <fcooper@ti.com>, linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 10/20/2015 09:26 PM, santosh shilimkar wrote:
> On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
>> From: Franklin Cooper <fcooper@ti.com>
>>
>> Unlike other Keystone 2 devices, newer Keystone 2 SOCs may utilize
>> pinmuxing which requires PINCTRL to be enabled. Therefore, enable
>> PINCTRL for all Keystone 2 devices.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>   arch/arm/mach-keystone/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
> I would be happy to add this one when I see pin
> control data in DTS and its actually going to be
> used in upstream kernel. Till then I don't want
> to add this one.
>
Agree. It is too early to add the defconfig update and should be 
deferred to when the DTS update is made. What if the newer keystone 2 
SoC never end up in the tree?

Murali
> Regards,
> Santosh
>


-- 
Murali Karicheri
Linux Kernel, Keystone
