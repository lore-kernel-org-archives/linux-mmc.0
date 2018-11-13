From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCHv5 4/6] ARM: dts: exynos: Add pin configuration for SD
 write protect on Odroid XU3/XU4
Date: Tue, 13 Nov 2018 20:54:56 +0100
Message-ID: <20181113195456.GF2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-5-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-5-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:36PM +0000, Anand Moon wrote:
> Add SD card write-protect pin configuration to be sure that it will be
> properly pulled down to indicate write access.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes since v4:
> 1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
>    Marek Szyprowski feedback).
> 2. Pull pin down.
> 3. change the subject and commit message.
> Sorry Krzysztof if I have copied your commit message to describe the
> changes.

Thanks, applied.

Best regards,
Krzysztof
