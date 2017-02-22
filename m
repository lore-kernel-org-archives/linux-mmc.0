From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 0/4] mmc: core: Provide CMD5 awake and partial_init
 support
Date: Wed, 22 Feb 2017 08:55:16 +0800
Message-ID: <c126edac-af50-3f39-53d7-9290da5b1da0@rock-chips.com>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Ritesh,

On 2017/2/20 16:03, Ritesh Harjani wrote:
> As per JEDEC spec - CMD5 can be used to awake from sleep mode for emmc.
> This patch series provide CMD5(awake) + mmc_partial_init support to resume
> mmc card device. This is mainly to reduce the resume time.
>

For modem eMMC devices which support vccq to be 1v8, you patch seem to
work fine but that didn't work for some eMMCs that only support 3v3
vccq, for instance, some older v4.41 eMMC devices.

Also, the spec didn't clearly have a statement about the fact that the
partial init should work if keeping vqmmc.

So finally you should have to add a fallback method once the partial
init doesn't work well. In the point, this policy is not just host
specified, but also eMMC device specified. So I guess this is why you
expose a new DT property here instead?!


> This was tested on db410c (emmc with HS200 mode) and MS8996 (emmc with HS400ES)
> based internal board. This patch reduced the resume time by ~50% on msm8996
> and ~11% on db410c.
>
> As of now this patch series provides a caps (MMC_CAP2_SLEEP_AWAKE) to enable this feature.
> Since there is no dependency on host platform for this, we can enable this feature by
> default as well. Thoughts?
>
>
> Ritesh Harjani (4):
>   Documentation: mmc: add mmc-sleep-awake
>   mmc: core: add mmc-sleep-awake caps
>   mmc: mmc: add support for CMD5 awake
>   mmc: core: Implement mmc_partial_init during resume
>
>  Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
>  drivers/mmc/core/core.c                       |  13 +++
>  drivers/mmc/core/core.h                       |   1 +
>  drivers/mmc/core/host.c                       |   2 +
>  drivers/mmc/core/mmc.c                        | 160 ++++++++++++++++++++++++--
>  include/linux/mmc/card.h                      |   3 +
>  include/linux/mmc/host.h                      |   2 +
>  7 files changed, 176 insertions(+), 7 deletions(-)
>


-- 
Best Regards
Shawn Lin
