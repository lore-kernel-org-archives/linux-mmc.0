From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: kconfig: replace FAULT_INJECTION with FAULT_INJECTION_DEBUG_FS
Date: Thu, 19 Nov 2015 12:29:55 +0100
Message-ID: <CAPDyKFoP2rqm_bWStOBLoNK7kYdD=9Jwdq2=G3X3X1+ZQhpEgA@mail.gmail.com>
References: <CAPDyKFq39uWPTBou+CUDqbWj8_RENeZMmokV3LRA5LBpG7fAVw@mail.gmail.com>
	<1447182739-8996-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447182739-8996-1-git-send-email-adrien+dev@schischi.me>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 November 2015 at 20:12, Adrien Schildknecht
<adrien+dev@schischi.me> wrote:
> Fault-injection capability for MMC IO uses debugfs entries to configure
> the attributes.
> FAULT_INJECTION_DEBUG_FS must be enabled to use FAIL_MMC_REQUEST.
>
> Replace FAULT_INJECTION with FAULT_INJECTION_DEBUG_FS.
> Also remove 'select DEBUG_FS' since FAULT_INJECTION_DEBUG_FS depends on
> it.
>
> Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  lib/Kconfig.debug | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 749e886..5c038d2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1523,8 +1523,7 @@ config FAIL_IO_TIMEOUT
>
>  config FAIL_MMC_REQUEST
>         bool "Fault-injection capability for MMC IO"
> -       select DEBUG_FS
> -       depends on FAULT_INJECTION && MMC
> +       depends on FAULT_INJECTION_DEBUG_FS && MMC
>         help
>           Provide fault-injection capability for MMC IO.
>           This will make the mmc core return data errors. This is
> --
> 2.6.2
>
