From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask is empty.
Date: Thu, 14 Aug 2014 07:13:00 -0700
Message-ID: <CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Tim Kryger <tim.kryger@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Mark Brown <broonie@kernel.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 14, 2014 at 5:39 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The operation conditions register (OCR) stores the voltage
> profile of the card, however the list of possible voltages
> is restricted by the voltage range supported by the supply
> used as VCC/VDD. So in mmc_vddrange_to_ocrmask() a OCR mask
> is obtained to filter the not supported voltages, from the
> value read in the host controller OCR register.
>
> For fixed regulators, regulator_list_voltage() returns the
> fixed output for the first selector but this doesn't happen
> for switch (FET) regulators that obtain their voltage from
> their parent supply. A call to regulator_get_voltage() is
> needed in this case so the regulator core can return the
> FET's parent supply voltage output.
>
> This change is consistent with the fact that for other
> fixed regulators (that are not FETs) the OCR mask is
> returned even when mmc_regulator_set_ocr() checks if the
> regulator is fixed before calling regulator_set_voltage().
>
> Without this patch, the following warning is reported when
> a FET is used as a vmmc-supply:
>
> dwmmc_exynos 12220000.mmc: Failed getting OCR mask: -22
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

https://lkml.org/lkml/2014/8/12/377

Perhaps I misunderstood the discussion in that thread but couldn't
this failure also be addressed by adding proper constraints for each
FET in individual DTS files to reflect the range of voltages that are
safe for all consumers of that supply on the board?

I thought the main concern with your other change was that the
constraints you listed in the DTSI represented the limits of the PMIC
and not the consumers.

-Tim
