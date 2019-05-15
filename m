From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
Date: Wed, 15 May 2019 13:53:16 +0200
Message-ID: <CAPDyKFrmTEkknnmU22xuKaoG1=SbU2MfQANPmtV0wcF1xKaguA@mail.gmail.com>
References: <20190509172427.17835-1-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509172427.17835-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 May 2019 at 19:24, Scott Branden <scott.branden@broadcom.com> wrote:
>
> This patch series fixes data hold timing issues for various sdhci-iproc
> ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
> in quirks.
>
> Changes from v2:
>  - Added info to commit message as to stable tag selection decision
>    as per Adrian Hunter
>
> Changes from v1:
>  - Change fixes tag to Cc: stable@vger.kernel.org to specify version
>    to backport to
>
> Trac Hoang (2):
>   mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
>     problem
>   mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
>
>  drivers/mmc/host/sdhci-iproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>

Applied for fixes, thanks!

Kind regards
Uffe
