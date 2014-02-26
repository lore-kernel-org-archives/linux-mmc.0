From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: SD card timeout problems on Nokia N900 (omap_hsmmc on OMAP3)
Date: Wed, 26 Feb 2014 07:02:40 +0100
Message-ID: <CAOf5uwn0sziBhE9edyiVqj8MUTidbX19YhgDsgikn5VLbx0B7A@mail.gmail.com>
References: <20140225234746.GA13866@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20140225234746.GA13866@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Balaji T K <balajitk@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sebastian

On Wed, Feb 26, 2014 at 12:47 AM, Sebastian Reichel <sre@ring0.de> wrote:
> Hi,
>
> I have problems with the SD-card initialization on my Nokia N900
> using a 3.14-rc1 based kernel in DT boot mode. The bug is can be
> circumvented by changing the kernel slightly (e.g. remove some DT
> nodes or mark them as disabled). So the SD card's timeout problems
> seem to derive from kernel timing problems. I'm pretty sure, that
> the problems are not originating from a broken SD card, since
>
>  1. The SD card worked quite good before and still does depending
>     on unrelated DTS changes (=> loading less drivers).
>  2. The SD card works flawlessly on my notebook using a USB adapter
>  3. Another SD card showed the same problem
>
> I tried to git bisect the problem, but I just get shown some
> unrelated driver additions.
>
> Anyways, this is the error I get during boot:
>
> [    3.896820] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> ...
> [    5.956237] mmc0: error -110 whilst initialising SD card
>

Are you sure that some subsystem that you deactivate don't change
pin muxing setting? Can you check in the broken system if the pins of the sdcard
are correctly muxed? Does it happen even if you change the sdcard?

Michael

> I added some debug prints to trace the error:
>
>  * mmc_sd_init_card()
>  * mmc_sd_get_cid()
>  * mmc_send_app_op_cond()
>
> Can you give me any hints how to find & fix the problem's source?
>
> -- Sebastian
