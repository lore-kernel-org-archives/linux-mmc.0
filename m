From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 1/5] sdhci-s3c: depend on plat-samsung
Date: Fri, 11 Jun 2010 14:42:07 +0900
Message-ID: <AANLkTildPiWp2BZvTm8sOvaMy1gRSTH8RHqvZQRdYP6-@mail.gmail.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
	<1276076383-24825-2-git-send-email-m.szyprowski@samsung.com>
	<000701cb08fd$2f8e15a0$8eaa40e0$%kim@samsung.com>
	<20100611052407.GX7248@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20100611052407.GX7248@trinity.fluff.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 11, 2010 at 2:24 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Jun 11, 2010 at 09:29:38AM +0900, Kukjin Kim wrote:
>> Marek Szyprowski wrote:
>> >
>> > Most Samsung SoC have support for SDHCI block, so make the driver
>> > dependent on the Samsung platform instead on listing all SoCs in t=
he
>> > Kconfig (and updating it again when support for the new SoC varian=
t is
>> > added).
>> >
>> Hi, Marek
>>
>> Kyungmin Park already submitted same patch.
>
> Hmm, Mr Park and Co really need to learn how to handle the treatment =
of
> patches. I'm really disapointed that these patches get submitted with=
out
> the proper authour accreditation. If this isn't sorted out then I for
> one will start thinking about giving this stuff an automatic reject.

It's just Marek missed the previous my patch, and I reply there's
duplicated patch already.

Thank you,
Kyungmin Park

>
> Please ensure that the original authour of a patch is accredited for
> the work, and the right sign-off and any other ack data is kept with
> the patch. There's documentation about most of this in the kernel
> already at Documentation/SubmittingPatches.
>
>> And Andrew Morton added to the -mm tree.
>> http://www.spinics.net/lists/mm-commits/msg79159.html
>>
>> But, I think your comment is better...
>>
>> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>> > =A0drivers/mmc/host/Kconfig | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> > index e171e77..acf5bf6 100644
>> > --- a/drivers/mmc/host/Kconfig
>> > +++ b/drivers/mmc/host/Kconfig
>> > @@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
>> >
>> > =A0config MMC_SDHCI_S3C
>> > =A0 =A0 tristate "SDHCI support on Samsung S3C SoC"
>> > - =A0 depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
>> > + =A0 depends on MMC_SDHCI && PLAT_SAMSUNG
>> > =A0 =A0 help
>> > =A0 =A0 =A0 This selects the Secure Digital Host Controller Interf=
ace (SDHCI)
>> > =A0 =A0 =A0 often referrered to as the HSMMC block in some of the =
Samsung S3C
>> > --
>>
>>
>> Thanks.
>>
>> Best regards,
>> Kgene.
>> --
>> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> SW Solution Development Team, Samsung Electronics Co., Ltd.
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
