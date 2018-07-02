From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
Date: Mon, 2 Jul 2018 15:17:21 +0200
Message-ID: <CAPDyKFof7cV-ixNCySBOTJ2Ht6m2-RNUNWYFxZ1WGf==v1P2qw@mail.gmail.com>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, devicetree@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Jeremy McNicoll <jeremymc@redhat.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Harjani Ritesh <riteshh@codeaurora.org>, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 19 June 2018 at 07:39, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> With SDCC5, the MCI register space got removed and the offset/order of
> several registers have changed. Based on SDCC version used and the register,
> we need to pick the base address and offset.
>
> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm"
>
> Changes since RFC:
>         Dropped voltage regulator changes in sdhci-msm
>         Split the "Register changes for sdcc V5" patch
>         Instead of checking mci removal for deciding which base addr to use,
>         new function pointers are defined for the 2 variants of sdcc:
>                 1) MCI present
>                 2) V5 (mci removed)
>         Instead of string comparing with the compatible string from DT file,
>         the sdhci_msm_probe will now pick the data associated with the
>         compatible entry and use it to load variant specific address offsets
>         and msm variant specific read/write ops.
>
> Changes since V1:
>         Removed unused msm_reab & msm_writeb APIs
>         Changed certain register addresses from uppercase to lowercase hex
>         letters
>         Removed extra lines and spaces
>         Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>         one for Documentation and other for the driver changes.
>
> Changes since V2:
>         Used lower case for macro function defenitions
>         Removed unused function pointers for msm_readb & msm_writeb
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

Thanks, applied for next!

Kind regards
Uffe
