From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 11 Apr 2011 17:23:49 -0400
Message-ID: <m3ipuka3dm.fsf@pullcord.laptop.org>
References: <alpine.DEB.2.00.1104071816270.10238@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55493 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab1DKVSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:18:55 -0400
In-Reply-To: <alpine.DEB.2.00.1104071816270.10238@peruna> (John Calixto's
	message of "Thu, 7 Apr 2011 18:18:27 -0700 (PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org

Hi John,

On Thu, Apr 07 2011, John Calixto wrote:
> Sending ACMDs from userspace is useful for such things as:
>
>     - The security application of an SD card (SD Specification, Part =
3,
>       Security)
>
>     - SD passthrough for virtual machines
>
> Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621
> SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
>
> Signed-off-by: John Calixto <john.calixto@modsystems.com>

This adds two gcc warnings here (compiling for ARM):

  CC      drivers/mmc/card/block.o
drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_ioctl_copy_from_=
user=E2=80=99:
drivers/mmc/card/block.c:199:33: warning: cast to pointer from integer =
of different size [-Wint-to-pointer-cast]
drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_ioctl_acmd=E2=80=
=99:
drivers/mmc/card/block.c:308:20: warning: cast to pointer from integer =
of different size [-Wint-to-pointer-cast]

=2E..
> +	if (copy_from_user(idata->buf, (u8 *) user->data_ptr, idata->buf_by=
tes)) {
> +		err =3D -EFAULT;
> +		goto copy_err;
> +	}
=2E..
> +		if (copy_to_user((u8 *) ic_ptr->data_ptr, idata->buf, idata->buf_b=
ytes)) {
> +			err =3D -EFAULT;
> +			goto acmd_rel_host;
> +		}
=2E..

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
