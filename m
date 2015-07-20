From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] mmc: sdhci: Card detection fixes
Date: Mon, 20 Jul 2015 16:21:58 +0200
Message-ID: <CAPDyKFrr_MhvVQ_rJWbU8SYz3gK6CQEi9o6j6oUzh-h+zA7q=A@mail.gmail.com>
References: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 July 2015 at 14:16, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
> Following changes aimed to fix some aspects of card detection, when
> BROKEN_CARD_DETECTION quirk is set.
>
> Changes since first version [1]:
>
> * Patch 1/3 is a modified to first check for MMC_CAP_NONREMOVABLE
>   and then check for a valid value in "gpio_cd"
>
> [1] http://permalink.gmane.org/gmane.linux.kernel.mmc/32875
>
> Ivan T. Ivanov (3):
>   mmc: sdhci: let GPIO based card detection have higher precedence
>   mmc: sdhci: don't use card state polling when CD GPIO is defined
>   mmc: sdhci: properly check card present state when quirk
>     NO_CARD_NO_RESET is set
>
>  drivers/mmc/host/sdhci.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied!

Kind regards
Uffe
