From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: Add SDHCI support for STMicroelectronics SoCs
Date: Thu, 22 May 2014 17:44:21 +0200
Message-ID: <537E1B55.1090807@st.com>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: kernel@stlinux.com, lee.jones@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Peter,

On 05/22/2014 05:18 PM, Peter Griffin wrote:
> This series adds a SDHCI platform driver for ST SoCs, along with
> the additional device tree bindings and configuration to enable
> the controller to work properly.
>
> Initially it supports the stih416 and stih415 SoCs, and has
> been tested on a stih416-b2020 board.

In next version, could you also add  drivers/mmc/host/sdhci-st.c in the 
ARM/STI ARCHITECTURE field of MAINTAINERS file?


Thanks,
Maxime


>
> regards,
>
> Peter.
>
