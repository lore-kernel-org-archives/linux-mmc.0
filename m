From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/10 v3] mmc: tmio/sdhi: hotplug & PM
Date: Fri, 16 Mar 2012 07:55:35 -0400
Message-ID: <87obrwbw08.fsf@laptop.org>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
	<m2obs6qugn.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <m2obs6qugn.fsf@bob.laptop.org> (Chris Ball's message of "Thu, 08
	Mar 2012 23:17:12 -0500")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 08 2012, Chris Ball wrote:
>> Guennadi Liakhovetski (10):
>>   mmc: simplify mmc_cd_gpio_request() by removing two parameters
>>   mmc: tmio: calculate the native hotplug condition only once
>>   mmc: tmio_mmc: support the generic MMC GPIO card hotplug helper
>>   mmc: sh_mobile_sdhi: pass card hotplug GPIO number to TMIO MMC
>>   ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO
>>     hotplug helper
>>   ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO
>>     hotplug helper
>>   mmc: tmio_mmc: power status flag doesn't have to be exposed in
>>     platform data
>>   mmc: tmio_mmc: remove unused sdio_irq_enabled flag
>>   mmc: sh_mobile_sdhi: do not manage PM clocks manually
>>   mmc: tmio: cosmetic: prettify the tmio_mmc_set_ios() function
>
> Looks like you didn't get any ACKs for these, and the ARM patches no
> longer apply -- would you like me to take all but the two ARM patches
> and leave those to you?  (Does that result in working systems?)

I've applied all of these except 5/6 to mmc-next for 3.4 now, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
