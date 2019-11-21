From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] memstick: Fix Kconfig indentation
Date: Thu, 21 Nov 2019 12:30:05 +0100
Message-ID: <CAPDyKFohHYuqu=a4PJMqPq6ydNGcVjVMotyiSniF=mhZQ-qa4Q@mail.gmail.com>
References: <20191120134101.14738-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120134101.14738-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 20 Nov 2019 at 14:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/core/Kconfig | 18 +++++++++---------
>  drivers/memstick/host/Kconfig |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
> index 516f454fde14..08192fd70eb4 100644
> --- a/drivers/memstick/core/Kconfig
> +++ b/drivers/memstick/core/Kconfig
> @@ -6,16 +6,16 @@
>  comment "MemoryStick drivers"
>
>  config MEMSTICK_UNSAFE_RESUME
> -        bool "Allow unsafe resume (DANGEROUS)"
> -        help
> -          If you say Y here, the MemoryStick layer will assume that all
> -          cards stayed in their respective slots during the suspend. The
> -          normal behaviour is to remove them at suspend and
> -          redetecting them at resume. Breaking this assumption will
> -          in most cases result in data corruption.
> +       bool "Allow unsafe resume (DANGEROUS)"
> +       help
> +         If you say Y here, the MemoryStick layer will assume that all
> +         cards stayed in their respective slots during the suspend. The
> +         normal behaviour is to remove them at suspend and
> +         redetecting them at resume. Breaking this assumption will
> +         in most cases result in data corruption.
>
> -          This option is usually just for embedded systems which use
> -          a MemoryStick card for rootfs. Most people should say N here.
> +         This option is usually just for embedded systems which use
> +         a MemoryStick card for rootfs. Most people should say N here.
>
>  config MSPRO_BLOCK
>         tristate "MemoryStick Pro block device driver"
> diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
> index 446c93ecef8f..4113343da056 100644
> --- a/drivers/memstick/host/Kconfig
> +++ b/drivers/memstick/host/Kconfig
> @@ -18,7 +18,7 @@ config MEMSTICK_TIFM_MS
>           'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
>           (TIFM_7XX1)'.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called tifm_ms.
>
>  config MEMSTICK_JMICRON_38X
> @@ -29,7 +29,7 @@ config MEMSTICK_JMICRON_38X
>           Say Y here if you want to be able to access MemoryStick cards with
>           the JMicron(R) JMB38X MemoryStick card reader.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called jmb38x_ms.
>
>  config MEMSTICK_R592
> --
> 2.17.1
>
