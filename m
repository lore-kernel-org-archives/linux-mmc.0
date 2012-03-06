From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move the
 header file
Date: Tue, 6 Mar 2012 23:40:08 +0900
Message-ID: <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
References: <4F55ABF0.1060801@samsung.com>
	<20120306130054.GA9890@sirena.org.uk>
	<201203061415.18836.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201203061415.18836.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

2012/3/6 Heiko St=FCbner <heiko@sntech.de>:
> Am Dienstag, 6. M=E4rz 2012, 14:00:54 schrieb Mark Brown:
>> On Tue, Mar 06, 2012 at 03:17:20PM +0900, Jaehoon Chung wrote:
>> > This patchset is the purpose for using sdhci-pltfm.c and
>> > removing the arch dependency.
>> > The sdhci-s3c has too heavy arch dependency.
>> > For example, if work for sdhci-s3c.c at mmc-tree, sometime need to=
 change
>> > sdhci.h for Samsung-Soc.
>>
>> This series will break S3C64xx, you've not touched it at all in the
>> update but it uses the same SDHCI controller.
>
> This problem will probably also surface for the S3C2416 which also us=
es the
> same SDHCI controller.

i didn't know why will break  on them. Could you explain to me?
Are there codes which affect S3C64XX and S3C24XX?
If i miss out something, let me know.

Best Regards,
Jaehoon Chung
>
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
