From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 22/26] devicetree: fix name of pinctrl-bindings.txt
Date: Mon, 18 Jun 2018 06:48:13 +0100
Message-ID: <20180618054813.GA31141@dell>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <1832904c012f823958663464ac4fb249f77978b5.1529079120.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1832904c012f823958663464ac4fb249f77978b5.1529079120.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 15 Jun 2018, Mauro Carvalho Chehab wrote:

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
