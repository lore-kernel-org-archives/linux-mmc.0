From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v2] SDHCI-S3C fixes and enhancements (driver specific
	code)
Date: Tue, 6 Jul 2010 14:29:26 +0900
Message-ID: <AANLkTinY8-9ubunlbbQY8Le1OluqqGbPNa9r_GcCyHwZ@mail.gmail.com>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi Andrew,

I hope to merge it at next merge windows.

Others any comments?

Thank you,
Kyungmin Park

On Wed, Jun 16, 2010 at 3:49 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> This series includes various fixes to sdhci-s3c driver as well as a
> major feature enhancement. This patch series is prepared to get compl=
ete
> sdhci support on Samsung Aquila board.
>
> A quick overview on the patches:
>
> #1 - add missing sdhci_s3c_driver_remove() function
> #2 - introduce new sdhci quirk to get rid of anoying runtime warning =
and
> =A0 =A0 possible problems with slow mmc/sd cards
> #3 - add support for various methods of notifying the host driver abo=
ut
> =A0 =A0 the card insertion/removal (should be compatible with existin=
g code)
>
> Last patch requires changes to the Samsung platform setup code, which
> has been posted in a separate patch series for easier merging, please
> refer to the "[PATCH v2] SDHCI-S3C fixes and enhancements (platform
> specific code)" thread.
>
> Changes since V1:
> - added support for gpio external interrupt card based detect method
> =A0directly to sdhci-s3c driver
> - removed duplicate Kconfig patch
> - removed timeout patch (not really needed)
>
> A complete list of patches:
>
> [PATCH 1/3] sdhci-s3c: add missing remove function
> [PATCH 2/3] sdhci-s3c: add support for the non standard minimal clock=
 value
> [PATCH 3/3] sdhci-s3c: add support for new card detection methods
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
