From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH V3] powerpc/85xx: Add support for 85xx cpu type detection
Date: Tue, 16 Jul 2013 08:46:44 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13C0099@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1373502232-4772-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:44311
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753040Ab3GPIsM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Jul 2013 04:48:12 -0400
In-Reply-To: <1373502232-4772-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Wood Scott-B07421 <B07421@freescale.com>, Fleming Andy-AFLEMING <afleming@freescale.com>, Wrobel Heinz-R39252 <r39252@freescale.com>, Zhao Chenhui-B35336 <B35336@freescale.com>

Hi, scott

Need I change something?
I have some patches depend on this.
Expect your advice.

Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Zhang Haijun-B42677
> Sent: Thursday, July 11, 2013 8:24 AM
> To: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: cbouatmailru@gmail.com; cjb@laptop.org; Wood Scott-B07421; Fleming
> Andy-AFLEMING; Wrobel Heinz-R39252; Zhang Haijun-B42677; Zhao Chenhui-
> B35336
> Subject: [PATCH V3] powerpc/85xx: Add support for 85xx cpu type detection
> 
> Add this file to help detect cpu type in runtime.
> These macros will be more favorable for driver to apply errata and
> workaround to specified cpu type.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> changes for v3:
> 	- remove get_svr and is_svr_rev
> 
>  arch/powerpc/include/asm/mpc85xx.h | 47
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/mpc85xx.h
> 
> diff --git a/arch/powerpc/include/asm/mpc85xx.h
> b/arch/powerpc/include/asm/mpc85xx.h
> new file mode 100644
> index 0000000..824b619
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc85xx.h
> @@ -0,0 +1,47 @@
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
> +#define SVR_P1010	0x80f900
> +#define SVR_P2041	0x821001
> +#define SVR_P3041	0x821103
> +#define SVR_P5010	0x822100
> +#define SVR_P5020	0x822000
> +#define SVR_P5040	0x820400
> +#define SVR_T4240	0x824800
> +#define SVR_B4860	0x868800
> +
> +#endif
> --
> 1.8.0


