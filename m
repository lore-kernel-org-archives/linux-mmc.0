From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 23/27] devicetree: fix name of pinctrl-bindings.txt
Date: Tue, 3 Jul 2018 08:33:47 +0100
Message-ID: <20180703073347.GG20176@dell>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <d04d47f9fba035cf9de8589a288964c636324d58.1528990947.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d04d47f9fba035cf9de8589a288964c636324d58.1528990947.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Jun 2018, Mauro Carvalho Chehab wrote:

> Rename:
> 	pinctrl-binding.txt -> pinctrl-bindings.txt
> 
> In order to match the current name of this file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt | 2 +-
>  Documentation/devicetree/bindings/mfd/as3722.txt              | 2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/mmc/microchip,sdhci-pic32.txt         | 2 +-
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt            | 2 +-
>  .../devicetree/bindings/pinctrl/pinctrl-max77620.txt          | 4 ++--
>  .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt          | 4 ++--
>  Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt   | 4 ++--
>  .../devicetree/bindings/serial/microchip,pic32-uart.txt       | 2 +-
>  Documentation/devicetree/bindings/spi/spi-st-ssc.txt          | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
