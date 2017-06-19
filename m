From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH][mmc-next][RESEND] mmc: sdhci-pci: make guid
 intel_dsm_guid static
Date: Mon, 19 Jun 2017 13:01:38 +0200
Message-ID: <CAPDyKFo9x8J=gbeVsbRNhNUd48htrjtgV8NEmv83BLDVmMN1Lg@mail.gmail.com>
References: <20170619105521.19071-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170619105521.19071-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 June 2017 at 12:55, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>

Both me and Adrian have acked this, so it's fine to pick up by Christoph.

Kind regards
Uffe

>
> The guid intel_dsm_guid does not need to be in global scope, so make
> it static.
>
> Cleans up sparse warning:
> "symbol 'intel_dsm_guid' was not declared. Should it be static?"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 3c02c5b394d6..f1d8385d91f0 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -404,7 +404,7 @@ struct intel_host {
>         bool    d3_retune;
>  };
>
> -const guid_t intel_dsm_guid =
> +static const guid_t intel_dsm_guid =
>         GUID_INIT(0xF6C13EA5, 0x65CD, 0x461F,
>                   0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
>
> --
> 2.11.0
>
