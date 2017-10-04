From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 3/7] mmc: sdhci-s3c: Fix driver data for Exynos4 SoCs
Date: Wed, 04 Oct 2017 12:03:41 +0200
Message-ID: <c4980018-dbef-9ec7-9103-5b0dea00a828@samsung.com>
References: <20171004063828.22068-1-m.szyprowski@samsung.com>
        <CGME20171004063835eucas1p1082954a0113f374f11ff364cf4b95408@eucas1p1.samsung.com>
        <20171004063828.22068-4-m.szyprowski@samsung.com>
        <104fe074-3e54-f37c-ac4b-704e5153c154@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <104fe074-3e54-f37c-ac4b-704e5153c154@samsung.com>
Content-language: en-GB
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 10/04/2017 10:39 AM, Sylwester Nawrocki wrote:
> On 10/04/2017 08:38 AM, Marek Szyprowski wrote:
>> Support for non-dt based initialization for Exynos SoCs has been removed,
>> so there is no need to keep driver IDs for this case. While touching this,
>> replace odd conditional code for instantiating driver data for Exynos4
>> SoCs with a simple reference and move that driver data under CONFIG_OF.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Reviewed-by: Sylwester Nawrocki <m.szyprowski@samsung.com>

Oops, this should have been:
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I guess it's too late to fix that since the patch is applied to a stable
branch.

--
Regards,
Sylwester
