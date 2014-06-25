From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
Date: Wed, 25 Jun 2014 10:28:50 -0700
Message-ID: <CAD=FV=UCinFuZQW+_GYFw=M046ziTLRNvvHUvsx_GQ0kjw5DfQ@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
	<CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
	<53AA3F78.3080804@samsung.com>
	<001201cf9067$3c5b2070$b5116150$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001201cf9067$3c5b2070$b5116150$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Seungwon,

On Wed, Jun 25, 2014 at 4:18 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >> +       case MMC_POWER_ON:
>> >> +               if (!IS_ERR(mmc->supply.vqmmc) &&
>> >> +                               !test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
> You can use regulator_is_enabled() instead of flag bit, DW_MMC_IO_POWERED.

I'd be a little worried about regulator_is_enabled() since regulators
are reference counted.  What if someone else is sharing this
regulator?  The regulator might happen to be enabled when you check it
but unless you add your own dw_mmc reference count they might turn it
off.

> Important thing is that if powering vmmc failed at MMC_POWER_UP, vqmmc should not be powered.

Good point.
