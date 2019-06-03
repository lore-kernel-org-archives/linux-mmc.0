From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: remove redundant check of slots == 0
Date: Mon, 3 Jun 2019 15:48:27 +0200
Message-ID: <CAPDyKFpo6EqOp0mqVj7yHdttoh957QSZ8sFzHMs+QFz-cHETew@mail.gmail.com>
References: <20190531113223.27474-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190531113223.27474-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 31 May 2019 at 13:32, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The calculation of slots results in a value in the range 1..8
> and so slots can never be zero.  The check for slots == 0 is
> always going to be false, hence it is redundant and can be
> removed.
>
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ab9e2b901094..f70436261746 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2044,8 +2044,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>
>         slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>         dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> -       if (slots == 0)
> -               return -ENODEV;
>
>         BUG_ON(slots > MAX_SLOTS);
>
> --
> 2.20.1
>
