From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 3/4] mmc: sdhci-acpi: Set MMC_CAP2_NO_SDIO_RESET if
 child has wake from S4 (hibernate)
Date: Mon, 24 Apr 2017 23:52:00 +0200
Message-ID: <CAJZ5v0hcfsbfy=KhgTDvg7zj-egKODDJAF0-gqWdxuxKfyBFPQ@mail.gmail.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com> <1492769288-7474-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1492769288-7474-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 21, 2017 at 12:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> SDIO reset interferes with a SDIO function driver's restore from
> hibernation. Set MMC_CAP2_NO_SDIO_RESET if a child node has _S4W method
> which indicates a capability to wake from S4 (hibernate).
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index c6a9a1bfaa22..e053a45db6b1 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -374,6 +374,14 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>         return NULL;
>  }
>
> +static bool sdhci_acpi_child_has_s4w(struct acpi_device *child)
> +{
> +       acpi_handle handle = child->handle;
> +       unsigned long long ret;
> +
> +       return ACPI_SUCCESS(acpi_evaluate_integer(handle, "_S4W", NULL, &ret));

First off, there is acpi_has_method().

Second, checking child->wakeup.sleep_state is a better indicator of S4
wakeup support.

> +}
> +
>  static int sdhci_acpi_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;

Thanks,
Rafael
