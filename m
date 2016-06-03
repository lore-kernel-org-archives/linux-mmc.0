From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 17/20] x86, mmc: use Intel family name macros for mmc driver
Date: Fri, 3 Jun 2016 09:42:37 +0200
Message-ID: <CAPDyKFqtfNW0WZwZKNcv5Pzei+q+3Ad15z9+a_jgob0-+M4RwQ@mail.gmail.com>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com> <20160602001221.85C6DEC6@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602001221.85C6DEC6@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, x86@kernel.org, dave.hansen@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 June 2016 at 02:12, Dave Hansen <dave@sr71.net> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Another straightforward replacement of magic numbers.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

I assume you are going to queue this via the x86 tree or whatever tree
that makes sense!?

Kind regards
Uffe

> ---
>
>  b/drivers/mmc/host/sdhci-acpi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff -puN drivers/mmc/host/sdhci-acpi.c~x86-intel-families-sdhci-acpi drivers/mmc/host/sdhci-acpi.c
> --- a/drivers/mmc/host/sdhci-acpi.c~x86-intel-families-sdhci-acpi       2016-06-01 15:45:09.826201501 -0700
> +++ b/drivers/mmc/host/sdhci-acpi.c     2016-06-01 15:45:09.830201683 -0700
> @@ -43,6 +43,7 @@
>
>  #ifdef CONFIG_X86
>  #include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
>  #include <asm/iosf_mbi.h>
>  #endif
>
> @@ -126,7 +127,7 @@ static const struct sdhci_acpi_chip sdhc
>  static bool sdhci_acpi_byt(void)
>  {
>         static const struct x86_cpu_id byt[] = {
> -               { X86_VENDOR_INTEL, 6, 0x37 },
> +               { X86_VENDOR_INTEL, 6, INTEL_FAM6_MODEL_ATOM_SILVERMONT1 },
>                 {}
>         };
>
> _
