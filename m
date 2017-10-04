From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] mmc: sdhci-s3c: Fix driver data for Exynos4 SoCs
Date: Wed, 4 Oct 2017 12:50:06 +0200
Message-ID: <CAPDyKFqCXofOLTFSNR+N2DgXBp-f22=qCdj--YtRZ+xxcD9x0Q@mail.gmail.com>
References: <20171004063828.22068-1-m.szyprowski@samsung.com>
 <CGME20171004063835eucas1p1082954a0113f374f11ff364cf4b95408@eucas1p1.samsung.com>
 <20171004063828.22068-4-m.szyprowski@samsung.com> <104fe074-3e54-f37c-ac4b-704e5153c154@samsung.com>
 <c4980018-dbef-9ec7-9103-5b0dea00a828@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:48279 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdJDKuI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 06:50:08 -0400
Received: by mail-it0-f51.google.com with SMTP id m123so15676488ita.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2017 03:50:07 -0700 (PDT)
In-Reply-To: <c4980018-dbef-9ec7-9103-5b0dea00a828@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 4 October 2017 at 12:03, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> On 10/04/2017 10:39 AM, Sylwester Nawrocki wrote:
>> On 10/04/2017 08:38 AM, Marek Szyprowski wrote:
>>> Support for non-dt based initialization for Exynos SoCs has been removed,
>>> so there is no need to keep driver IDs for this case. While touching this,
>>> replace odd conditional code for instantiating driver data for Exynos4
>>> SoCs with a simple reference and move that driver data under CONFIG_OF.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
>> Reviewed-by: Sylwester Nawrocki <m.szyprowski@samsung.com>
>
> Oops, this should have been:
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> I guess it's too late to fix that since the patch is applied to a stable
> branch.

I can deal with that, no worries.

Kind regards
Uffe
