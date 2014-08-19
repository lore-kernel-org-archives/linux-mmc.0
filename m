From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask
 is empty.
Date: Tue, 19 Aug 2014 14:54:13 +0200
Message-ID: <53F348F5.8040800@collabora.co.uk>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>	<CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>	<20140814151958.GY17528@sirena.org.uk>	<CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com>	<53EDBB5B.4000209@collabora.co.uk>	<20140815095528.GH17528@sirena.org.uk>	<CAPDyKFpm5nzXp5p0qxDof2NcOML911eYkjPNMsn9a2ttdnW7gQ@mail.gmail.com>	<53F3351C.1020500@collabora.co.uk> <CAPDyKFrW1ZojV0sWTswapWDvkmgshtyb=NP9CrY+GymdQeRq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrW1ZojV0sWTswapWDvkmgshtyb=NP9CrY+GymdQeRq5w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Tim Kryger <tim.kryger@gmail.com>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 08/19/2014 02:43 PM, Ulf Hansson wrote:
> 
> Well, currently this seems like the best approach. If we end up having
> some new regulator helper function, future wise, we can convert to
> such later on.
>

Great, thanks a lot for your help!

> Kind regards
> Uffe
> 

Best regards,
Javier
