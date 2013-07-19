From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Fri, 19 Jul 2013 02:28:20 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13DF580@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1374037947-23670-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:15647
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935078Ab3GSC20 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Jul 2013 22:28:26 -0400
In-Reply-To: <1374037947-23670-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Wood Scott-B07421 <B07421@freescale.com>, Fleming Andy-AFLEMING <afleming@freescale.com>, Zhao Chenhui-B35336 <B35336@freescale.com>

Hi, scott

I had update this patch, this is the newest version.
If there is no other problem, can you help merge this patch?
I hope to make sure the following patch don't need to rebuild due to the change of this patch. 

Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Zhang Haijun-B42677
> Sent: Wednesday, July 17, 2013 1:12 PM
> To: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: cbouatmailru@gmail.com; cjb@laptop.org; Wood Scott-B07421; Fleming
> Andy-AFLEMING; Zhang Haijun-B42677; Zhao Chenhui-B35336
> Subject: [PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type
> detection
> 
> Add this file to help detect cpu type in runtime.
> These macros will be more favorable for driver to apply errata and
> workaround to specified cpu type.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> changes for v4:
> 	- Add new set of soc
> 
>  arch/powerpc/include/asm/mpc85xx.h | 92
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/mpc85xx.h
> 
> diff --git a/arch/powerpc/include/asm/mpc85xx.h
> b/arch/powerpc/include/asm/mpc85xx.h
> new file mode 100644
> index 0000000..736d4ac
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc85xx.h
> @@ -0,0 +1,92 @@
> +/*
> + * MPC85xx cpu type detection
> + *
> + * Copyright 2011-2012 Freescale Semiconductor, Inc.
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __ASM_PPC_MPC85XX_H
> +#define __ASM_PPC_MPC85XX_H
> +
> +#define SVR_REV(svr)	((svr) & 0xFF)		/* SOC design resision */
> +#define SVR_MAJ(svr)	(((svr) >>  4) & 0xF)	/* Major revision field*/
> +#define SVR_MIN(svr)	(((svr) >>  0) & 0xF)	/* Minor revision field*/
> +
> +/* Some parts define SVR[0:23] as the SOC version */
> +#define SVR_SOC_VER(svr) (((svr) >> 8) & 0xFFF7FF)	/* SOC Version
> fields */
> +
> +#define SVR_8533	0x803400
> +#define SVR_8535	0x803701
> +#define SVR_8536	0x803700
> +#define SVR_8540	0x803000
> +#define SVR_8541	0x807200
> +#define SVR_8543	0x803200
> +#define SVR_8544	0x803401
> +#define SVR_8545	0x803102
> +#define SVR_8547	0x803101
> +#define SVR_8548	0x803100
> +#define SVR_8555	0x807100
> +#define SVR_8560	0x807000
> +#define SVR_8567	0x807501
> +#define SVR_8568	0x807500
> +#define SVR_8569	0x808000
> +#define SVR_8572	0x80E000
> +#define SVR_P1010	0x80F100
> +#define SVR_P1011	0x80E500
> +#define SVR_P1012	0x80E501
> +#define SVR_P1013	0x80E700
> +#define SVR_P1014	0x80F101
> +#define SVR_P1017	0x80F700
> +#define SVR_P1020	0x80E400
> +#define SVR_P1021	0x80E401
> +#define SVR_P1022	0x80E600
> +#define SVR_P1023	0x80F600
> +#define SVR_P1024	0x80E402
> +#define SVR_P1025	0x80E403
> +#define SVR_P2010	0x80E300
> +#define SVR_P2020	0x80E200
> +#define SVR_P2040	0x821000
> +#define SVR_P2041	0x821001
> +#define SVR_P3041	0x821103
> +#define SVR_P4040	0x820100
> +#define SVR_P4080	0x820000
> +#define SVR_P5010	0x822100
> +#define SVR_P5020	0x822000
> +#define SVR_P5021	0X820500
> +#define SVR_P5040	0x820400
> +#define SVR_T4240	0x824000
> +#define SVR_T4120	0x824001
> +#define SVR_T4160	0x824100
> +#define SVR_C291	0x850000
> +#define SVR_C292	0x850020
> +#define SVR_C293	0x850030
> +#define SVR_B4860	0X868000
> +#define SVR_G4860	0x868001
> +#define SVR_G4060	0x868003
> +#define SVR_B4440	0x868100
> +#define SVR_G4440	0x868101
> +#define SVR_B4420	0x868102
> +#define SVR_B4220	0x868103
> +#define SVR_T1040	0x852000
> +#define SVR_T1041	0x852001
> +#define SVR_T1042	0x852002
> +#define SVR_T1020	0x852100
> +#define SVR_T1021	0x852101
> +#define SVR_T1022	0x852102
> +
> +#define SVR_8610	0x80A000
> +#define SVR_8641	0x809000
> +#define SVR_8641D	0x809001
> +
> +#define SVR_9130	0x860001
> +#define SVR_9131	0x860000
> +#define SVR_9132	0x861000
> +#define SVR_9232	0x861400
> +
> +#define SVR_Unknown	0xFFFFFF
> +
> +#endif
> --
> 1.8.0


