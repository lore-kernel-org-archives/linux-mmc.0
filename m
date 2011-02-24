From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 0/5] OMAP: HSMMC: hwmod adaptation
Date: Thu, 24 Feb 2011 11:19:44 +0100
Message-ID: <4D6630C0.9060405@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-mmc@vger.kernel.org

Hi Kishore,

On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:
> Adding hwmod data for hsmmc device on OMAP2430/OMAP3/OMAP4.
> Adapting the omap_hsmmc driver to hwmod framework.
>
> The patch series is based on -rc6 and tested on OMAP2430, OMAP3430SDP
> &  OMAP4430SDP.

Could you rebase it on top of omap-for-linus, it does apply for the moment.

Thanks,
Benoit

>
> V3:
> ---
> Omap2420 platform consists of mmc block as in omap1 and not the
> hsmmc block as present in omap2430, omap3, omap4 platforms.
> The series takes care of hwmod adaptation of hsmmc drivers and
> thus excluding the omap2420 platforms.
>
> The patch series has dependency on :
>   1)https://patchwork.kernel.org/patch/585281/
>   2)https://patchwork.kernel.org/patch/538301/
>
> V2:
> ---
> http://www.spinics.net/lists/linux-omap/msg45443.html
>
> V1:
> ---
> http://www.spinics.net/lists/linux-mmc/msg05689.html
>
>
> Anand Gadiyar (1):
>    OMAP4: hwmod data: enable HSMMC
>
> Kishore Kadiyala (2):
>    OMAP: hwmod data: Add dev_attr and use in the host driver
>    OMAP: adapt hsmmc to hwmod framework
>
> Paul Walmsley (2):
>    OMAP2430: hwmod data: Add HSMMC
>    OMAP3: hwmod data: Add HSMMC
>
>   arch/arm/mach-omap2/devices.c              |  251 ----------------------------
>   arch/arm/mach-omap2/hsmmc.c                |  153 ++++++++++++++++--
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  155 +++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  221 ++++++++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 +++-
>   arch/arm/mach-omap2/prcm-common.h          |    4 +
>   arch/arm/plat-omap/include/plat/mmc.h      |   24 +--
>   drivers/mmc/host/omap_hsmmc.c              |    4 +-
>   8 files changed, 554 insertions(+), 284 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

