From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Prevent eMMC VCC supply to be cut from late init
Date: Wed, 09 May 2012 12:56:05 -0400
Message-ID: <87zk9hmgyi.fsf@laptop.org>
References: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
	<20120509155622.GE3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37176 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760365Ab2EIQz7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 12:55:59 -0400
In-Reply-To: <20120509155622.GE3955@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Wed, 9 May 2012 16:56:23 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Jasi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On Wed, May 09 2012, Mark Brown wrote:
> On Wed, May 09, 2012 at 04:15:26PM +0200, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> 
>> For eMMC cards that has been initialized from a bootloader,
>> the VCC voltage supply must not be cut in an uncontrolled
>> manner, without first sending SLEEP or POWEROFF_NOTIFY.
>> 
>> The regulator_init_complete late initcall, may cut the VCC
>> regulator if it's reference counter is zero. To be able to
>> prevent the regulator from being cut, mmc_start_host, which
>> should execute at device init and thus before late init,
>> calls mmc_power_up. Then the host driver is able to increase
>> the reference to the regulator.
>
> This looks like a good, simple solution - working out how we avoid extra
> power ups will probably be more invasive and might not be worth the
> effort for something that's boot time only.
>
> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
