From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask is empty.
Date: Sun, 17 Aug 2014 10:11:30 -0700
Message-ID: <CAD7vxxKTk2Na9B4ae6EGT8HaKDRp0iu4zX1tB8DPtmePKbHrLw@mail.gmail.com>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>
	<CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>
	<20140814151958.GY17528@sirena.org.uk>
	<CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com>
	<53EDBB5B.4000209@collabora.co.uk>
	<CAD7vxxKvZCxnDpPn3X1Uch_6m7Hfj_vApNfxUS2Wex9BjjBUdg@mail.gmail.com>
	<20140815222914.GM17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140815222914.GM17528@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 15, 2014 at 3:29 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 15, 2014 at 07:19:41AM -0700, Tim Kryger wrote:
>
>> That is a little different from my suggestion where the constraints
>> check is skipped when the regulator output is fixed.  It effectively
>> does this now when the regulator itself provides the fixed voltage.
>> However, the checks aren't skipped when that fixed voltage is coming
>> from an ancestor.  Why the difference?
>
> Nobody has written suitable code, and please bear in mind that even if
> the code is written there will probably be cases where it's too
> expensive for whatever reason so Javier's change is going to be needed.

I fail to see how replicating similar logic at all current
regulator_list_voltage call sites would be any more efficient than
handling this directly in regulator core.
