From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC v2 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Tue, 24 May 2016 09:41:06 +0900
Message-ID: <20160524004106.GD2477@verge.net.au>
References: <1463727743-7567-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463727743-7567-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 20, 2016 at 04:02:20PM +0900, Simon Horman wrote:
> 
> Hi,
> 
> this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
> sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
> Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
> SDR-50 support to the same driver.
> 
> This series enables UHS-I SDR-104 on the r8a7790/Lager where
> UHS-I SDR-50 is already enabled.
> 
> It is based on a merge of:
> * The next branch of the mmc tree  
> * The renesas-next-20160427v2-v4.6-rc1 tag of the renesas tree
> * The sh-pfc-for-v4.7-tag1 tag of the renesas-drivers tree
> 
> The first two mmc driver patches are targeted at the next branch of the mmc
> tree. The last DT patch is targeted at the devel branch of the renesas tree.
> 
> To aid review this series is provided in the _temporary_ topic/sdr104-v2 branch
> of the renesas tree.
> 
> 
> I received somewhat extensive review of v1 of this series and I have
> attempted to rework, correspondingly extensively, these patches to reflect
> that review. I apologise if I missed anything noted in v1. And given the
> extent of the changes since then I fully expect to need to follow-up with v3.
> 
> A pleasant side effect of the above mentioned changes is
> that v2 has roughly 40% fewer lines of code than v1 :)
> 
> 
> Please see "[PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi" for
> indicative test results: I do not believe the numbers have not changed
> in a material way since then.

I accidently omitted one patch from this series, some irq updates for tmio.
I will post it as part of v3. It is already available at the branch
mentioned above.

> Ai Kyuse (2):
>   mmc: tmio: Add tuning support
>   mmc: sh_mobile_sdhi: Add tuning support
> 
> Simon Horman (1):
>   ARM: dts: r8a7790: lager: Enable UHS-I SDR-104
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |   1 +
>  drivers/mmc/host/sh_mobile_sdhi.c   | 216 +++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/tmio_mmc.h         |   6 +
>  drivers/mmc/host/tmio_mmc_pio.c     |  85 +++++++++++++-
>  4 files changed, 306 insertions(+), 2 deletions(-)
> 
> -- 
> 2.1.4
> 
