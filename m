From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: increase the pad I/O drive strength
 for DDR50 card
Date: Tue, 18 Apr 2017 07:33:11 -0700
Message-ID: <CAJ+vNU2WB0EWkLZ4iNg9kbCrJh4iEF=Tk=5AEZAAN9YL=fnkgA@mail.gmail.com>
References: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Sender: stable-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, aisheng.dong@nxp.com, stable@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 17, 2017 at 4:10 AM, Haibo Chen <haibo.chen@nxp.com> wrote:
> Currently for DDR50 card, it need tuning in default. We meet tuning fail
> issue for DDR50 card and some data CRC error when DDR50 sd card works.
>
> This is because the default pad I/O drive strength can't make sure DDR50
> card work stable. So increase the pad I/O drive strength for DDR50 card,
> and use pins_100mhz.
>
> Tested-and-reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v4.4+

Haibo,

I believe for stable to know how far back this needs to be applied (to
4.4) you need to add something like the following in your commit log:

This fixes DDR50 card support for IMX since DDR50 tuning was enabled
from commit 9faac7b95ea4 (mmc: sdhci: enable tuning for DDR50)

Regards,

Tim
