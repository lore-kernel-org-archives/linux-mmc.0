From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask
 is empty.
Date: Fri, 15 Aug 2014 13:13:42 +0200
Message-ID: <53EDEB66.1040304@collabora.co.uk>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk> <CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com> <20140814151958.GY17528@sirena.org.uk> <CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com> <53EDBB5B.4000209@collabora.co.uk> <20140815095528.GH17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140815095528.GH17528@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Mark,

On 08/15/2014 11:55 AM, Mark Brown wrote:
> On Fri, Aug 15, 2014 at 09:48:43AM +0200, Javier Martinez Canillas wrote:
> 
>> But now I wonder why regulator_list_voltage() even list the voltage for
>> fixed regulators (desc->fixed_uV) since they don't have the ability to
> 
> That's because it's very cheap to do and there is a comprehensible thing
> we can return - if we have to read the voltage that means potentially
> asking the hardware in an I2C transaction which is not cheap.
> 

Thanks a lot for the explanation, that does make a lot of sense.

> 
> There's plenty of potentially variable regulators used in these
> situations, I expect it's more likely that people were just ignoring the
> warning since it has no practical effect.
> 

Indeed.

Best regards,
Javier
