From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/6] mfd: rtsx: add func to split u32 into register
Date: Tue, 20 Jan 2015 14:47:13 +0000
Message-ID: <20150120144713.GV13701@x1>
References: <cover.1419297154.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1419297154.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50962 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbATOrU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 09:47:20 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so2935771ier.10
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 06:47:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1419297154.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn

On Tue, 23 Dec 2014, micky_ching@realsil.com.cn wrote:

> From: Micky Ching <micky_ching@realsil.com.cn>
>=20
> Add helper function to write u32 to registers, if we want to put u32
> value to 4 continuous register, this can help us reduce tedious work.
>=20
> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/rtsx_pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_pc=
i.h
> index 74346d5..9234449 100644
> --- a/include/linux/mfd/rtsx_pci.h
> +++ b/include/linux/mfd/rtsx_pci.h
> @@ -558,6 +558,7 @@
>  #define SD_SAMPLE_POINT_CTL		0xFDA7
>  #define SD_PUSH_POINT_CTL		0xFDA8
>  #define SD_CMD0				0xFDA9
> +#define   SD_CMD_START			0x40
>  #define SD_CMD1				0xFDAA
>  #define SD_CMD2				0xFDAB
>  #define SD_CMD3				0xFDAC
> @@ -967,4 +968,12 @@ static inline u8 *rtsx_pci_get_cmd_data(struct r=
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
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
