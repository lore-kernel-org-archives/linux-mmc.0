From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos: Lower SD card interface voltage
 to 2.8v on Odroid X/X2/U3
Date: Wed, 27 Apr 2016 17:30:50 -0400
Message-ID: <4691605f-545d-b721-af7d-e4b7669bcd79@osg.samsung.com>
References: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
 <1461765620-6833-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461765620-6833-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux.amoon@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello 

On 04/27/2016 10:00 AM, Krzysztof Kozlowski wrote:
> Odroid X/X2/U3 schematics say that SD card vmmc regulator
> (LDO21/TFLASH) operates on 2.8 V. Mainline U-Boot uses that value as
> well. 2.8 V is common on Exynos-based boards. Additionally use some
> descriptive name for this regulator.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
