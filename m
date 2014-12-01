From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/2] mfd: rtsx: add func to split u32 into register
Date: Mon, 1 Dec 2014 12:46:51 +0000
Message-ID: <20141201124651.GA12068@x1>
References: <cover.1417141102.git.micky_ching@realsil.com.cn>
 <6a6de978f479758fb9e767d8a6e013e8a006a39a.1417141102.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40335 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbaLAMq6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Dec 2014 07:46:58 -0500
Received: by mail-qa0-f46.google.com with SMTP id n8so1047284qaq.33
        for <linux-mmc@vger.kernel.org>; Mon, 01 Dec 2014 04:46:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6a6de978f479758fb9e767d8a6e013e8a006a39a.1417141102.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: sameo@linux.intel.com, chris@printf.net, ulf.hansson@linaro.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, rogerable@realtek.com, wei_wang@realsil.com.cn

On Fri, 28 Nov 2014, micky_ching@realsil.com.cn wrote:

> From: Micky Ching <micky_ching@realsil.com.cn>
>=20
> Add helper function to write u32 to registers, if we want to put u32
> value to 4 continuous register, this can help us reduce tedious work.
>=20
> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> ---
>  include/linux/mfd/rtsx_pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Looks fine to me.  Let me know how you want to handle this:

=46or my own reference:

Acked-by: Lee Jones <lee.jones@linaro.org>

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
