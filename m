From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] ARM: mmci:Remove unnecessary #include header file in mmci.c
Date: Wed, 16 Mar 2016 12:37:51 +0100
Message-ID: <CAPDyKFrtAVK2CHxzw0B783pxe6ixreab-XT7uX3cWi7XB8mtpg@mail.gmail.com>
References: <1457934273-2977-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457934273-2977-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
List-Id: linux-mmc@vger.kernel.org

On 14 March 2016 at 06:44, Wang Hongcheng <annie.wang@amd.com> wrote:
> The header file asm/sizes.h is unnecessary.
> And it can also be compiled under X86 arch after the removal.
>
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>

Thanks, applied for next! I took the liberty to update the change log
a bit as well as the header for it.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index fb26674..e5e5441 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -40,7 +40,6 @@
>
>  #include <asm/div64.h>
>  #include <asm/io.h>
> -#include <asm/sizes.h>
>
>  #include "mmci.h"
>  #include "mmci_qcom_dml.h"
> --
> 1.9.1
>
