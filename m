From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: rtsx: add func to split u32 into register
Date: Mon, 1 Dec 2014 12:16:54 +0000
Message-ID: <20141201121654.GF15845@x1>
References: <cover.1417056337.git.micky_ching@realsil.com.cn>
 <51dde5250305623c420e78fa555800ef8fef0a09.1417056337.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:48377 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaLAMRC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Dec 2014 07:17:02 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so7361092qcx.41
        for <linux-mmc@vger.kernel.org>; Mon, 01 Dec 2014 04:17:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51dde5250305623c420e78fa555800ef8fef0a09.1417056337.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: sameo@linux.intel.com, chris@printf.net, ulf.hansson@linaro.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, rogerable@realtek.com, wei_wang@realsil.com.cn

On Thu, 27 Nov 2014, micky_ching@realsil.com.cn wrote:

> From: Micky Ching <micky_ching@realsil.com.cn>
>=20
> Add helper function to write u32 to registers, if we want to put u32
> value to 4 continuous register, this can help us reduce tedious work.
>=20
> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> ---
>  include/linux/mfd/rtsx_pci.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Okay, I'm happy that Dan is now satisfied.

Can I take this patch, or does patch 2 depend on it?

> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_pc=
i.h
> index 74346d5..bf45ea2 100644
> --- a/include/linux/mfd/rtsx_pci.h
> +++ b/include/linux/mfd/rtsx_pci.h
> @@ -967,4 +967,19 @@ static inline u8 *rtsx_pci_get_cmd_data(struct r=
tsx_pcr *pcr)
>  	return (u8 *)(pcr->host_cmds_ptr);
>  }
> =20
> +static inline void rtsx_pci_write_be32(struct rtsx_pcr *pcr, u16 reg=
, u32 val)
> +{
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val >> 24);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 16);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 8);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val);
> +}
> +
> +static inline void rtsx_pci_write_le32(struct rtsx_pcr *pcr, u16 reg=
, u32 val)
> +{
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 8);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 16);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val >> 24);
> +}
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
