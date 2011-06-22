From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Wed, 22 Jun 2011 18:05:06 +0200
Message-ID: <4E0212B2.3070203@ti.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1308752314-32079-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Hilman, Kevin" <khilman@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Balaji,

On 6/22/2011 4:18 PM, Krishnamoorthy, Balaji T wrote:
> Removing the custom state machine - lazy disable framework in omap_hsmmc
> to make way for runtime pm to handle host controller
> power states.
> This allows mmc_host_enable/mmc_host_disable to be replaced by
> runtime get_sync and put_sync at host controller driver.
>
> Enable runtime PM in omap_hsmmc

That's a good news, I was struggling with some hwmod cleanup due to the 
lack of pm_runtime support for the MMC driver.
I'll try that series without the hacks I had to do on top of my cleanup.

Thanks,
Benoit
