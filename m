From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/05] tmio_mmc: SDHI hotplug and random fixes
Date: Mon, 22 Feb 2010 13:43:54 +0900
Message-ID: <aec7e5c31002212043hf9dd9b6rbe72328592d455ae@mail.gmail.com>
References: <20100217073735.32726.12020.sendpatchset@t400s>
	 <20100219114620.GE10255@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100219114620.GE10255@sortiz.org>
Sender: linux-sh-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, g.liakhovetski@gmx.de, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

Hi Samuel,

On Fri, Feb 19, 2010 at 8:46 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> On Wed, Feb 17, 2010 at 04:37:35PM +0900, Magnus Damm wrote:
>> tmio_mmc: SDHI hotplug and random fixes
>>
>> [PATCH 01/05] tmio_mmc: Keep card-detect interrupts enabled
>> [PATCH 02/05] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support V2
>> [PATCH 03/05] tmio_mmc: Use 100ms mmc_detect_change() delay
>> [PATCH 04/05] tmio_mmc: Remove const from platform data V3
>> [PATCH 05/05] tmio_mmc: Balance cell enable()/disable() calls
>>
> Since some of this code depends on the tmio.h changes, I'm taking this
> patchset. Please let me know if that's fine with you.

Sounds great, thank you! I've just posted two patches for
sh_mobile_sdhi, please pick them up as well if possible.

Thanks,

/ magnus
