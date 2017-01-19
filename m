From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCHv1 0/8] mmc: sdhci-msm: Provide support for enhanced strobe
Date: Thu, 19 Jan 2017 21:53:21 +0100
Message-ID: <CAPDyKFr3mfLDW+4QV2rM4CZoj7Kn1RbSsHLMiF+oZ6uQ20rDGA@mail.gmail.com>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com, git@kchr.de
List-Id: linux-mmc@vger.kernel.org

On 10 January 2017 at 08:00, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> Hi,
>
> Resending this patch series, as no one could review it -possibly due to
> holidays during that time.
>
> This patch series mainly provides enhanced strobe support to sdhci-msm driver
> along with some additions of HW recommended sequence. This has been tested on
> 8996 based internal target & on db410c.
>
> Patches 1-3 :- Factors out few functions to be re-used again.
>                To also simplify large functions and makes it more readable.
>
> Patches 4-5 :- Few recommendations based on HW prog. guide.
>
> Patches 6 :- Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
>              so that ->platform_execute_tuning (underlying platform driver) can
>              know about HS400 tuning.
>
> Patch 7 :- Implements an additional step as per HPG for HS400 tuning.
>
> Patch 8 :- Implements enhanced strobe functionality in sdhci-msm driver.
>
>
> Ritesh Harjani (6):
>   mmc: sdhci-msm: Factor out sdhci_msm_hc_select_mode
>   mmc: sdhci-msm: Factor out function to set/get msm clock rate
>   mmc: sdhci-msm: Factor out sdhci_msm_hs400
>   mmc: sdhci: Clear SDHCI_HS400_TUNING flag after
>     platform_execute_tuning
>   mmc: sdhci-msm: Make HS400 tuning follow as per recommeneded HW
>     sequence
>   mmc: sdhci-msm: Provide enhanced_strobe mode feature support
>
> Subhash Jadavani (1):
>   mmc: sdhci-msm: configure CORE_CSR_CDC_DELAY_CFG to recommended value
>
> Venkat Gopalakrishnan (1):
>   mmc: sdhci-msm: Reset vendor specific func register on probe
>
>  drivers/mmc/host/sdhci-msm.c | 356 ++++++++++++++++++++++++++-----------------
>  drivers/mmc/host/sdhci.c     |   6 +-
>  2 files changed, 224 insertions(+), 138 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>

Ritesh, Adrian,

I realized that Adrian requested a minor fixup of patch6. However to
simplify a bit for all of us, avoiding another new version of the
series being sent I decided to pick this series as is.

Adrian, I even took the liberty of adding your ack for patch6. I also
trust Ritesh to make a fix for patch6, but on top of the series I have
just applied.

If you have any objections, please tell me!

Kind regards
Uffe
