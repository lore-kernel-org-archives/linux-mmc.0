From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCHv5 2/6] ARM: dts: exynos: fix regulator min values of
 LDO13 for Odroid XU3/XU4
Date: Tue, 13 Nov 2018 20:32:54 +0100
Message-ID: <20181113193254.GC2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-3-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-3-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:34PM +0000, Anand Moon wrote:
> Looking at the schematic sd_2 min/max range from 1.8V/2.8V so fix the
> regulator min value to 1.8V. Without these changes sdcard will failed
> to detect on booting when UHS-I tuning is enabled.
> 

Thanks, applied.

Best regards,
Krzysztof
