From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
Date: Fri, 27 Jun 2014 15:47:22 -0700
Message-ID: <CAD=FV=WhTdyinkmZFVW5VxK1m-1Z=gMmofBU1RC0t82oEDEZzA@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
	<CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
	<CAKuRcO+OaknUtj9mJ+SQJPMj70hdLTMkDYCXq4L5JdwzDKdj6g@mail.gmail.com>
	<CAD=FV=Vy5vRan0KEDFFwVO0omgsUMwJK6WwCsWxGYynzT-e5ig@mail.gmail.com>
	<CAKuRcOLDCFQnw01ReKqNNfiiCwSWwi6Rd7UZFph+JzK2CQ4T_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKuRcOLDCFQnw01ReKqNNfiiCwSWwi6Rd7UZFph+JzK2CQ4T_w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Yuvaraj,

On Fri, Jun 27, 2014 at 3:59 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
>>> mmc_regulator_set_ocr() is failing as its a fixed-regulator.
>>
>> Can you explain more about what's failing?  It sure looks like mmc
>> core is supposed to handle this given comments below
>>
>> /*
>> * If we're using a fixed/static regulator, don't call
>> * regulator_set_voltage; it would fail.
>> */
> tps65090 driver does not register through fixed regulator framework.It
> uses normal regulator framework and supports only
> enable/disable/is_enabled callbacks.Also it lacks certain callbacks
> for list_voltage, get_voltage ,set_voltage etc.
> [    2.306476] dwmmc_exynos 12220000.mmc: Failed getting OCR mask: -22
> [    2.393403] dwmmc_exynos 12220000.mmc: could not set regulator OCR (-22)
> For the above reason,regulator framework treats fet4 as unused
> regulator and disables the vmmc regulator.

Ah.  Perhaps tps65090 needs to be fixed then...  I'm not sure any
other drivers cared before so maybe that's why it was never caught?

-Doug
