From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/6] tmio/sdhi: add cmd23 support
Date: Mon, 22 May 2017 14:03:04 +0200
Message-ID: <CAPDyKFpHOmQSVVd8mkMjxdGWr=Tn8p4E3+0LWdzk-UGFkbhQGw@mail.gmail.com>
References: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 May 2017 at 15:31, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> This series adds CMD23 support to SDHI. It was tested on H2 (Gen2, Lager) and
> M3W (Gen3, Salvator-X). The test procedure can be found here:
>
> http://elinux.org/Tests:SDHI-CMD23
>
> Patches are based on mmc/next from today. A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-cmd23
>
> Changes since RFC:
>
> * rebased on top of Simon's DMA rework now in mmc/next
> * added Geerts tags
> * cosmetic change in patch 6, put new capability in a separate line
>
> Thanks,
>
>    Wolfram
>
>
> Wolfram Sang (6):
>   mmc: tmio: make tmio_mmc_request function more readable
>   mmc: tmio: refactor handling mrq
>   mmc: tmio: remove outdated comment
>   mmc: tmio: move finish_request function further down
>   mmc: tmio: add CMD23 support
>   mmc: sdhi: add CMD23 support to R-Car Gen2 & Gen3
>
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c |   6 +-
>  drivers/mmc/host/tmio_mmc_core.c         | 135 ++++++++++++++++++-------------
>  2 files changed, 82 insertions(+), 59 deletions(-)


Thanks, applied for next!

Kind regards
Uffe
