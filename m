From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI / PM: Export acpi_device_fix_up_power()
Date: Thu, 19 May 2016 15:52:18 +0200
Message-ID: <CAJZ5v0hNGiZWG55RHZt7m0Spg-cOEXpxYaCuF4rBc1NYsoSY3g@mail.gmail.com>
References: <1463664342-19209-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1463664342-19209-1-git-send-email-ulf.hansson@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Laszlo Fiat <laszlo.fiat@gmail.com>, Nicholas Krause <xerofoify@gmail.com>, Stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 19, 2016 at 3:25 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Drivers that needs acpi_device_fix_up_power(), allow them to be built as
> modules by exporting this function.
>
> Cc: <stable@vger.kernel.org> # 4.5+
> Tested-by: Laszlo Fiat <laszlo.fiat@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Rafael/Len, if you are okay with using acpi_device_fix_up_power() as a fix
> for an issue in patch 2/2, then I would like to request an ack so I can take
> both these patches via my MMC tree.

Yeah, should be fine.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/device_pm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index cd2c3d6..993fd31 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -319,6 +319,7 @@ int acpi_device_fix_up_power(struct acpi_device *device)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(acpi_device_fix_up_power);
>
>  int acpi_device_update_power(struct acpi_device *device, int *state_p)
>  {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
