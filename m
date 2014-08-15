From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask is empty.
Date: Fri, 15 Aug 2014 16:51:38 +0200
Message-ID: <CAPDyKFpm5nzXp5p0qxDof2NcOML911eYkjPNMsn9a2ttdnW7gQ@mail.gmail.com>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>
	<CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>
	<20140814151958.GY17528@sirena.org.uk>
	<CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com>
	<53EDBB5B.4000209@collabora.co.uk>
	<20140815095528.GH17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140815095528.GH17528@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tim Kryger <tim.kryger@gmail.com>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 August 2014 11:55, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 15, 2014 at 09:48:43AM +0200, Javier Martinez Canillas wrote:
>
>> But now I wonder why regulator_list_voltage() even list the voltage for
>> fixed regulators (desc->fixed_uV) since they don't have the ability to
>> vary voltage. The regulator_list_voltage() documentation says:
>
> That's because it's very cheap to do and there is a comprehensible thing
> we can return - if we have to read the voltage that means potentially
> asking the hardware in an I2C transaction which is not cheap.
>
>> > It seems odd to make callers be the ones to handle this subtlety.
>
>> If regulator_list_voltage() didn't list the voltage for fixed regulators,
>> then this subtlety should had been handled by callers before but they
>> didn't because they rely on regulator_list_voltage() to always return a
>> voltage even for fixed regulators.
>
> There's plenty of potentially variable regulators used in these
> situations, I expect it's more likely that people were just ignoring the
> warning since it has no practical effect.

Just wanted to add some input regarding the errors in the mmc case.
These are of high importance. In principle if you get, "Failed getting
OCR mask: -22", likely you will be using a wrong OCR mask while
negotiating the voltage level with the card.

So, somehow we need to address this issue.

Kind regards
Uffe
