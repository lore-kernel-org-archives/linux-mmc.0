From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask
 is empty.
Date: Thu, 14 Aug 2014 17:29:40 +0200
Message-ID: <53ECD5E4.4090905@collabora.co.uk>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk> <CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Tim Kryger <tim.kryger@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Mark Brown <broonie@kernel.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Tim,

Thanks for your feedback.

On 08/14/2014 04:13 PM, Tim Kryger wrote:
> 
> https://lkml.org/lkml/2014/8/12/377
> 
> Perhaps I misunderstood the discussion in that thread but couldn't
> this failure also be addressed by adding proper constraints for each
> FET in individual DTS files to reflect the range of voltages that are
> safe for all consumers of that supply on the board?
> 
> I thought the main concern with your other change was that the
> constraints you listed in the DTSI represented the limits of the PMIC
> and not the consumers.
> 
> -Tim
> 

Yes, if the child regulator has the constraints defined then
regulator_voltage_list() won't filter the obtained parent voltage so it
won't be necessary to call regulator_get_voltage() directly.

But as Mark said on the thread you referred [0], if the voltage is not
allowed to change for a regulator then it makes no sense to have their
constraints specify a voltage range. And in this particular case the
parent supply of the FET used as vmmc-supply is a fixed regulator.

Now I wonder why mmc_regulator_get_ocrmask() even sets as a valid voltage
in the OCR mask the voltage for a fixed regulator if
mmc_regulator_set_ocr() is a no-op in this case but I guess is because
users of this function shouldn't really care about this peculiarity. In
any case, this change is consistent since with this patch FETs behaves the
same as other fixed regulators whose voltage can't be changed but the
voltage is still reported in the OCR mask.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/13/364
