From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/7] mmc: sdhci-s3c: Fix driver data for Exynos4 SoCs
Date: Wed, 4 Oct 2017 10:15:59 +0200
Message-ID: <CAJKOXPdX=davaNB9Eb74UJxqwMpaFHNnA0m1uM26GyZjicCB0Q@mail.gmail.com>
References: <CGME20171004063835eucas1p1082954a0113f374f11ff364cf4b95408@eucas1p1.samsung.com>
 <20171004063828.22068-1-m.szyprowski@samsung.com> <20171004063828.22068-4-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdJDIQC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Oct 2017 04:16:02 -0400
In-Reply-To: <20171004063828.22068-4-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Oct 4, 2017 at 8:38 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Support for non-dt based initialization for Exynos SoCs has been removed,
> so there is no need to keep driver IDs for this case. While touching this,
> replace odd conditional code for instantiating driver data for Exynos4
> SoCs with a simple reference and move that driver data under CONFIG_OF.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
