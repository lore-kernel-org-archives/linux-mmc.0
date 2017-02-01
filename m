From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 6/6] dts: doc: rename rpm_requests to respect DT
 naming conventions
Date: Wed, 1 Feb 2017 08:06:51 -0600
Message-ID: <20170201140651.57qf6pvugoq33s4a@rob-hp-laptop>
References: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
 <1485508205-1904-7-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485508205-1904-7-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 27, 2017 at 01:10:05AM -0800, Jeremy McNicoll wrote:
> Node names cannot have an underscore '_' in the name.

Well, they can, it's just convention.

> Simply rename 'rpm_request' nodes to 'rpm-request' and
> adjust associated documentation to reflect reality.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
> 
>  Note:
>    Kept bindings and dts together as this is a simple search
>    and replace.
> 
> 
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

Acked-by: Rob Herring <robh@kernel.org>
