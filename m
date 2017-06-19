From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 19/21] dt-bindings: mmc: dw_mmc-k3: add document of
 hi3660 mmc
Date: Mon, 19 Jun 2017 14:43:43 +0200
Message-ID: <CAPDyKFpvJu8_TETWr0Vy4ubDC7NYvi7TxmSLYZyw33qHFsoNaQ@mail.gmail.com>
References: <20170614082338.15673-1-guodong.xu@linaro.org> <20170614082338.15673-20-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-20-guodong.xu@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wei Xu <xuwei5@hisilicon.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, Peter Griffin <peter.griffin@linaro.org>, puck.chen@hisilicon.com, Lee Jones <lee.jones@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, zhangfei <zhangfei.gao@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Li Wei <liwei213@huaw>
List-Id: linux-mmc@vger.kernel.org

On 14 June 2017 at 10:23, Guodong Xu <guodong.xu@linaro.org> wrote:
> Add bindings for hi3660 mmc support
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> index df37058..8af1afc 100644
> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -12,6 +12,7 @@ extensions to the Synopsys Designware Mobile Storage Host Controller.
>  Required Properties:
>
>  * compatible: should be one of the following.
> +  - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
>    - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
>    - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
>
> --
> 2.10.2
>

Thanks, applied for next!

Kind regards
Uffe
