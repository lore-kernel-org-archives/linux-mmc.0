From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/5] OMAP: HSMMC: hwmod adaptation
Date: Tue, 8 Feb 2011 15:44:00 -0800
Message-ID: <20110208234400.GO20795@atomide.com>
References: <1297198431-23779-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1297198431-23779-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com
List-Id: linux-mmc@vger.kernel.org

* Kishore Kadiyala <kishore.kadiyala@ti.com> [110208 12:45]:
> Adding hwmod data for hsmmc device on OMAP2420/OMAP2430/OMAP3/OMAP4.
> Adapting the omap_hsmmc driver to hwmod framework
> 
> V2:
> ---
> Updated hwmod data for OMAP2420 & OMAP2430. 
> 
> The patch series is rebased on v2.6.38-rc4 and tested on OMAP4430SDP, 
> OMAP3430SDP & OMAP2430SDP.
> 
> For OMAP2430SDP validation, the patch series has dependency on
> https://patchwork.kernel.org/patch/538301/

No luck on 2430sdp with these and the above patch applied:

# dmesg | grep -i mmc                                                  
omap_hwmod: mmc1_hwmod: cannot clk_get opt_clk mmchsdb_fck       
omap_hwmod: mmchs2_fck: missing clockdomain for mmchs2_fck.      
omap_hwmod: mmc2_hwmod: cannot clk_get opt_clk mmchsdb_fck       
omap_hwmod: mmc1_hwmod: softreset failed (waited 10000 usec)     
omap_hwmod: mmc2_hwmod: softreset failed (waited 10000 usec)     
print_constraints: VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
 
> Testing on N8x0 is pending due to unavailability of working ones.
> Will be thankful if some body test this series on N8x0.

And on n800 this series produces imprecise external abort (0xc06) at 0x0
early during the boot. Maybe take a look on H4 SDP? Note that all
2420 based boards are using drivers/mmc/host/omap.c, not hsmm.

Regards,

Tony
