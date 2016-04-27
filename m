From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: exynos: Define vqmmc for SD card and
 allow disabling regulators on Odroid X/X2/U3
Date: Wed, 27 Apr 2016 17:09:38 -0400
Message-ID: <ba632ed9-6e6f-8a5d-5708-9c039e14056e@osg.samsung.com>
References: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux.amoon@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello Krzysztof,

On 04/27/2016 10:00 AM, Krzysztof Kozlowski wrote:
> The SD-card vmmc-supply contained incorrectly two regulators. The second
> one is ignored. Fix this by defining proper vmmc and vqmmc supplies.
> Additionally these regulators do not have to be always on, so allow
> disabling them to reduce energy consumption.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
