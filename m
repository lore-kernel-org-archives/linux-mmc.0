From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move the
 header file
Date: Wed, 07 Mar 2012 12:03:31 +0900
Message-ID: <4F56D003.5070406@samsung.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk> <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
 <20120306163052.GX19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20120306163052.GX19635@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 03/07/2012 01:30 AM, Mark Brown wrote:

> On Tue, Mar 06, 2012 at 11:40:08PM +0900, Jae hoon Chung wrote:
>> 2012/3/6 Heiko St=FCbner <heiko@sntech.de>:
>>> Am Dienstag, 6. M=E4rz 2012, 14:00:54 schrieb Mark Brown:
>=20
>>>> This series will break S3C64xx, you've not touched it at all in th=
e
>>>> update but it uses the same SDHCI controller.
>=20
>>> This problem will probably also surface for the S3C2416 which also =
uses the
>>> same SDHCI controller.
>=20
>> i didn't know why will break  on them. Could you explain to me?
>> Are there codes which affect S3C64XX and S3C24XX?
>> If i miss out something, let me know.
>=20
> The same IP is present and used with the same driver on other Samsung
> SoCs.

Hi Mark.

I know that used with the same driver on other Samsung-SoCs(S3C64XX/S3C=
24XX..etc)
I just only used the interface in sdhci-pltfm.c. Nothing difference..
Why do you think that will break the other SoC?

Header file(/plat/regs-sdhci.h) also is only used in sdhci-s3c.c.
And the least portion is moved into /linux/mmc/.=20
Then included "linux/mmc/sdhci-s3c.h" in plat/sdhci.h.

What's difference?=20
If you can explain the more detail, i can understand.
But sorry, now i didn't accept your opinion.

Best Regards,
Jaehoon Chung
