From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 3/4] arm64: dts: Enable SDHCI for Nexus 5X (msm8992)
Date: Thu, 19 Jan 2017 11:21:24 -0600
Message-ID: <20170119172124.jcaamrdd6g7ibnet@rob-hp-laptop>
References: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
 <1484614729-26751-4-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484614729-26751-4-git-send-email-jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, git-LJ92rlH3Dns@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 16, 2017 at 04:58:48PM -0800, Jeremy McNicoll wrote:
> Add Nexus 5X (msm8992) SDHCI support, including initial regulator
> entries to support enabling the main SDHCI/MMC.
> 
> The RPM is common between 8992 & 8994 simply reflect reality with
> a shared DT entry.
> 
> The msm8994 RPM regulator talks over SMD to the APPS processor.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
> Dropped RobH's ACK explicitly after addressing all feedback.
> The reason is that msm8994-smd-rpm.dtsi was created to allow
> for sharing between 8992 & 8994 as the RPM is common between
> the two. 
> 
>  .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  40 +++
>  .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   2 +
>  arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  82 ++++++
>  arch/arm64/boot/dts/qcom/msm8992.dtsi              | 153 ++++++++++++
>  arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      | 276 +++++++++++++++++++++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/regulator/qcom_smd-regulator.c             |  49 ++++
>  6 files changed, 602 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
