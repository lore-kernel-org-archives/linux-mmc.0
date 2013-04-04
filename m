From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-spear: add CONFIG_PM_SLEEP to suspend/resume functions
Date: Thu, 04 Apr 2013 10:14:15 -0400
Message-ID: <87fvz6pemg.fsf@octavius.laptop.org>
References: <003301ce2c4b$d2864fb0$7792ef10$%han@samsung.com>
	<003401ce2c4c$26048490$720d8db0$%han@samsung.com>
	<CAOh2x=me7M+pMKQ4O+1BXubfjy4Gq1Pz4EG7-d9nwHoF-vgdzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41837 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761529Ab3DDOOU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 10:14:20 -0400
In-Reply-To: <CAOh2x=me7M+pMKQ4O+1BXubfjy4Gq1Pz4EG7-d9nwHoF-vgdzw@mail.gmail.com>
	(Viresh Kumar's message of "Fri, 29 Mar 2013 12:48:40 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 29 2013, Viresh Kumar wrote:
> On Fri, Mar 29, 2013 at 12:38 PM, Jingoo Han <jg1.han@samsung.com> wrote:
>> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
>> build warning when CONFIG_PM_SLEEP is not selected. This is because
>> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
>> the CONFIG_PM_SLEEP is enabled.
>>
>> drivers/mmc/host/sdhci-spear.c:295:12: warning: 'sdhci_suspend'
>> defined but not used [-Wunused-function]
>> drivers/mmc/host/sdhci-spear.c:308:12: warning: 'sdhci_resume'
>> defined but not used [-Wunused-function]
>>
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>> ---
>>  drivers/mmc/host/sdhci-spear.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
