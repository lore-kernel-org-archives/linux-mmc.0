From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC
 MMC host controller
Date: Thu, 21 Nov 2019 13:28:16 -0600
Message-ID: <20191121192816.GA7377@bogus>
References: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
 <20191117142716.154764-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191117142716.154764-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, jianxin.pan@amlogic.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lnykww@gmail.com, yinxin_1989@aliyun.com
List-Id: linux-mmc@vger.kernel.org

On Sun, Nov 17, 2019 at 03:27:15PM +0100, Martin Blumenstingl wrote:
> This documents the devicetree bindings for the SDHC MMC host controller
> found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> HS200 mode (up to 100MHz clock).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
