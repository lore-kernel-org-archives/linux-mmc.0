From: Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
Date: Mon, 24 Sep 2018 20:48:22 +0100
Message-ID: <20180924194412.GA27477@arch>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

What socs have you tested this on? 
On sdm660 it seems to crash device
when writing pwr ctl.

On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
> With SDCC5, the MCI register space got removed and the offset/order of
> several registers have changed. Based on SDCC version used and the register,
> we need to pick the base address and offset.
> 
> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm"
> 
> Changes since RFC:
> 	Dropped voltage regulator changes in sdhci-msm
> 	Split the "Register changes for sdcc V5" patch
> 	Instead of checking mci removal for deciding which base addr to use,
> 	new function pointers are defined for the 2 variants of sdcc: 
> 		1) MCI present
> 		2) V5 (mci removed)
> 	Instead of string comparing with the compatible string from DT file,
> 	the sdhci_msm_probe will now pick the data associated with the
> 	compatible entry and use it to load variant specific address offsets
> 	and msm variant specific read/write ops.
> 
> Changes since V1:
> 	Removed unused msm_reab & msm_writeb APIs
> 	Changed certain register addresses from uppercase to lowercase hex
> 	letters
> 	Removed extra lines and spaces
> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
> 	one for Documentation and other for the driver changes.
> 
> Changes since V2:
> 	Used lower case for macro function defenitions
> 	Removed unused function pointers for msm_readb & msm_writeb
> 
> 
> Sayali Lokhande (3):
>   mmc: sdhci-msm: Define new Register address map
>   Documentation: sdhci-msm: Add new compatible string for SDCC v5
>   mmc: host: Register changes for sdcc V5
> 
> Vijay Viswanath (1):
>   mmc: sdhci-msm: Add msm version specific ops and data structures
> 
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
>  drivers/mmc/host/sdhci-msm.c                       | 511 ++++++++++++++++-----
>  2 files changed, 391 insertions(+), 127 deletions(-)
> 
> -- 
>  Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
