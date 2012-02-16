From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH 3/4] mmc: sdhci-s3c: use the sdhci-s3c.h instead of regs-sdhci.h
Date: Thu, 16 Feb 2012 23:54:47 +0900
Message-ID: <CAELcNGSF=63EbKbjBY8Su+g24Lfw5hOaK2=T=e=RN_QikmbR9w@mail.gmail.com>
References: <4F39EB0C.1080003@samsung.com>
	<4F3CFB62.5030604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51699 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2BPOyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2012 09:54:49 -0500
In-Reply-To: <4F3CFB62.5030604@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

2012/2/16 Kukjin Kim <kgene.kim@samsung.com>:
> On 02/14/12 14:03, Jaehoon Chung wrote:
>>
>> Use the sdhci-s3c.h
>>
> This patch should be merged into 2nd patch which is including change =
the
> name to S3C_SDHCI_xxx from S3C64Xx_SDHCI_xxx. BTW, I'm not sure the n=
ame
> should/can be changed because as you know S3C64XX_ means this can be =
used
> after S3C64XX or just for S3C64XX, so need to check data sheet of SDH=
CI part
> for S3C24XX and S3C64XX and later.
Hi Mr. Kukjin.

I know that use only S3C64XX_ or S3C24XX.
But i think no problem that change to S3C_SDHCI_xxx form S3C64XX_SDHCI_=
xxx.
Because now that's meaningless...Though use the S3C64XX_SDHCI_xxx or S3=
C24xxx_,
finally that also use in sdhci-s3c.c.

What means that distinguish between S3C_SDHCI and S3C64xx_SDHCI?

Best Regards,
Jaehoon Chung

>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
