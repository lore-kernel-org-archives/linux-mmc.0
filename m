From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: fix error return code in sdhci_acpi_add_own_cd()
Date: Thu, 27 Jun 2013 10:56:36 -0400
Message-ID: <877ghfr49n.fsf@octavius.laptop.org>
References: <CAPgLHd_FWg3egTZxBena+BTgWdZCzqr9AjV1_NpWBGYD3aPz0w@mail.gmail.com>
	<000801ce5b65$28d9f400$7a8ddc00$@samsung.com> <51A44E6C.9070708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56469 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab3F0O4q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:56:46 -0400
In-Reply-To: <51A44E6C.9070708@intel.com> (Adrian Hunter's message of "Tue, 28
	May 2013 09:27:56 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Wei Yongjun' <weiyj.lk@gmail.com>, rafael.j.wysocki@intel.com, sonic.zhang@analog.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

Hi,

On Tue, May 28 2013, Adrian Hunter wrote:
> On 28/05/13 08:35, Jingoo Han wrote:
>> On Tuesday, May 28, 2013 2:26 PM, Wei Yongjun wrote:
>>>
>>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>>
>>> Fix to return a negative error code in the gpio_to_irq() error
>>> handling case instead of 0, as done elsewhere in this function.
>>>
>>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> It looks good.
>> 
>> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
>
> Yes, thank you!
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Pushed to mmc-next for 3.11, sorry for the delay.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
