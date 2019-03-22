From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add Ulf Hansson to the MEMORYSTICK section
Date: Fri, 22 Mar 2019 19:03:29 +0200
Message-ID: <CACAwPwY=rhfyoLvkPNB4Pdagv_wjKgnybeW1Az1gd3vAF_0exg@mail.gmail.com>
References: <20190322114345.26532-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322114345.26532-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alex Dubov <oakad@yahoo.com>, Alex Dubov <alex.dubov@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Rui Feng <rui_feng@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

Thanks!
I also expect to start contributing again to maintain the code I have
in the kernel, after I done with upsteaming the nvme-mdev driver I
have just sent for initial review.
I work for Red Hat now, so I hope I'll find some time for that in the
future (still on a hobby basis of course).

Best regards,
     Maxim Levitsky

PS: my work email is mlevitsk@redhat.com


On Fri, Mar 22, 2019 at 1:43 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The amount of changes to the memorystick subsystem are limited as of today.
> However, I have a couple of times been funneling changes through my MMC
> tree and it have turned out fine. So, I am here by volunteering to continue
> doing this, by adding myself and the link to the MMC tree to the MEMSTICK
> section.
>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Alex Dubov <alex.dubov@gmail.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Rui Feng <rui_feng@realsil.com.cn>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61bdbade3daf..8434d6ffa243 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14463,11 +14463,15 @@ T:    git git://linuxtv.org/media_tree.git
>  S:     Maintained
>  F:     drivers/media/i2c/imx355.c
>
> -SONY MEMORYSTICK STANDARD SUPPORT
> +SONY MEMORYSTICK SUBSYSTEM
>  M:     Maxim Levitsky <maximlevitsky@gmail.com>
>  M:     Alex Dubov <oakad@yahoo.com>
> +M:     Ulf Hansson <ulf.hansson@linaro.org>
> +L:     linux-mmc@vger.kernel.org
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>  S:     Maintained
> -F:     drivers/memstick/core/ms_block.*
> +F:     drivers/memstick/
> +F:     include/linux/memstick.h
>
>  SONY VAIO CONTROL DEVICE DRIVER
>  M:     Mattia Dongili <malattia@linux.it>
> --
> 2.17.1
>
