From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC PATCH] mmc: block: Add new ioctl to send combo commands
Date: Wed, 2 Sep 2015 11:28:48 -0700
Message-ID: <CAOesGMh9d6yX-dS6jg2eu2hvN5S=87rr7L-+ZUreX=GGHDxRaA@mail.gmail.com>
References: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33860 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbbIBS2t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2015 14:28:49 -0400
Received: by ykdg206 with SMTP id g206so19190150ykd.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2015 11:28:48 -0700 (PDT)
In-Reply-To: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>

Hi,

On Wed, Sep 2, 2015 at 7:21 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> From: Seshagiri Holi <sholi@nvidia.com>
>
> Certain eMMC devices allow vendor specific device information to be read
> via a sequence of vendor commands. These vendor commands must be issued
> in sequence and an atomic fashion. One way to support this would be to
> add an ioctl function for sending a sequence of commands to the device
> atomically as proposed here. These combo commands are simple array of
> the existing mmc_ioc_cmd structure.

This seems reasonable to me, being able to do a sequence of
back-to-back operations without system read/writes slipping through.



> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
> index 1f5e68923929..5943e51f22b3 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -45,8 +45,23 @@ struct mmc_ioc_cmd {
>  };
>  #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
>
> -#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
> +/**
> + * struct mmc_ioc_combo_cmd - combo command information
> + * @num_of_cmds: number of commands to send
> + * @mmc_ioc_cmd_list: pointer to list of commands
> + */
> +struct mmc_ioc_combo_cmd {
> +       uint8_t num_of_cmds;
> +       struct mmc_ioc_cmd *mmc_ioc_cmd_list;
> +};

The size of this struct will depend on the pointer size of userspace.

It might be better to use a u64 for the pointer instead. Otherwise
you'd need a compat ioctl wrapper to copy a 32-bit pointer over on a
64-bit kernel.



-Olof
