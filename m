From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH v2 0/5] OMAP: HSMMC: hwmod adaptation
Date: Thu, 10 Feb 2011 19:59:42 +0530
Message-ID: <AANLkTin7znqTB5FQyD1w1puiwDbx9QMTFSUvJz53VU8m@mail.gmail.com>
References: <1297198431-23779-1-git-send-email-kishore.kadiyala@ti.com>
	<20110208234400.GO20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20110208234400.GO20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 9, 2011 at 5:14 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Kishore Kadiyala <kishore.kadiyala@ti.com> [110208 12:45]:
>> Adding hwmod data for hsmmc device on OMAP2420/OMAP2430/OMAP3/OMAP4.
>> Adapting the omap_hsmmc driver to hwmod framework
>>
>> V2:
>> ---
>> Updated hwmod data for OMAP2420 & OMAP2430.
>>
>> The patch series is rebased on v2.6.38-rc4 and tested on OMAP4430SDP,
>> OMAP3430SDP & OMAP2430SDP.
>>
>> For OMAP2430SDP validation, the patch series has dependency on
>> https://patchwork.kernel.org/patch/538301/
>
> No luck on 2430sdp with these and the above patch applied:
Hi Tony,

Can you let us know your SDP board version.

2430sdp VG5.1.0 + SD card on MMC1 slot worked for me with 2.6.38-rc3

>
> # dmesg | grep -i mmc
> omap_hwmod: mmc1_hwmod: cannot clk_get opt_clk mmchsdb_fck
> omap_hwmod: mmchs2_fck: missing clockdomain for mmchs2_fck.
> omap_hwmod: mmc2_hwmod: cannot clk_get opt_clk mmchsdb_fck
> omap_hwmod: mmc1_hwmod: softreset failed (waited 10000 usec)
> omap_hwmod: mmc2_hwmod: softreset failed (waited 10000 usec)
> print_constraints: VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
>
