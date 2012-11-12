From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: hsmmc: Fix NULL pointer dereference on unload when
 booted with device tree
Date: Mon, 12 Nov 2012 18:50:12 +0530
Message-ID: <50A0F78C.6030600@ti.com>
References: <20121109182534.GR6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121109182534.GR6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday 09 November 2012 11:55 PM, Tony Lindgren wrote:
> When booting with device tree, we don't have any pdata, and will
> get the following when trying to unload omap_hsmmc:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000044
> pgd = edafc000
> *pgd=adbbd831, *pte=00000000, *ppte=00000000
> SMP ARM
> Modules linked in: omap_hsmmc(-) omap_serial pinctrl_single
> CPU: 1    Not tainted  (3.7.0-rc4-00044-g8ca5f6a-dirty #245)
> PC is at omap_hsmmc_gpio_free+0x8/0x3c [omap_hsmmc]
> LR is at omap_hsmmc_remove+0xf0/0x174 [omap_hsmmc]
<snip>
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> ---
>
> This is against v3.7-rc4, would be nice to get in during the -rc cycle.
>
Hi Tony,

Got fixed by below commit, merged in rc5

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=9ea28ecbeb090159a3383ff60b29dee00c489774

