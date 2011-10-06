From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] arm: omap4: hsmmc: pbias fixes
Date: Thu, 6 Oct 2011 12:58:42 -0700
Message-ID: <20111006195842.GP6324@atomide.com>
References: <1317644571-25175-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317644571-25175-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [111003 04:48]:
> MMC1 pbias and speed control fix for SDMMC1 extended I/O cell
> Rebase to git://github.com/tmlind/linux.git fixes
> 	commit 122a98589349fe3388ffb7b996b54614951c934a
> 	Author: Tapani Utriainen <tapani@technexion.com>
> 	Date:   Fri Sep 30 11:05:56 2011 -0700
> 
> 	    ARM: OMAP: irq: loop counter fix in omap_init_irq()
> 
> 
> Balaji T K (2):
>   arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
>   arm: omap4: hsmmc: configure SDMMC1_DR0 properly

Thanks adding both to fixes-part2 branch.

Regards,

Tony
