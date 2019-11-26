From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: Amlogic 32-bit Meson SoC SDHC MMC controller driver
Date: Mon, 25 Nov 2019 17:22:25 -0800
Message-ID: <7htv6rh1ny.fsf@baylibre.com>
References: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org
Cc: jianxin.pan@amlogic.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lnykww@gmail.com, yinxin_1989@aliyun.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> this is the first non-RFC version of the driver for the Amlogic "SDHC"
> MMC controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

This will need to be reviewed/merged by the MMC maintainers, but to get
some broader testing (including in KernelCI) I've added this series to
the 'testing' branch of my tree so it will be included in my 'integ'
branch.

Kevin
