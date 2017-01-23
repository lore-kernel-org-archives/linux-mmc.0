From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH V2 4/4] dts: doc: rename rpm_requests to respect DT
 naming conventions
Date: Mon, 23 Jan 2017 02:39:47 -0800
Message-ID: <20170123103947.GA22659@mini-rhel.redhat.com>
References: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
 <1484614729-26751-5-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484614729-26751-5-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 16, 2017 at 04:58:49PM -0800, Jeremy McNicoll wrote:
> Node names cannot have an underscore '_' in the name.
> Simply rename 'rpm_request' nodes to 'rpm-request'.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.txt              | 2 +-
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt        | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt         | 6 +++---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt             | 2 +-
>  arch/arm/boot/dts/qcom-apq8074-dragonboard.dts                      | 2 +-
>  arch/arm/boot/dts/qcom-apq8084.dtsi                                 | 2 +-
>  arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts            | 2 +-
>  arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts               | 2 +-
>  arch/arm/boot/dts/qcom-msm8974.dtsi                                 | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                               | 2 +-
>  arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi                       | 2 +-
>  11 files changed, 13 insertions(+), 13 deletions(-)
>

Just in case someone trips over this thread in the future.

Table 2.1 from http://www.devicetree.org/specifications-pdf
provides useful information on naming conventions.

-jeremy
