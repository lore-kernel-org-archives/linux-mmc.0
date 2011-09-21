From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2 0/2] Move sdhci-s3c platform helper into driver
Date: Wed, 21 Sep 2011 19:51:13 +0900
Message-ID: <002401cc784c$61e2c180$25a84480$%kim@samsung.com>
References: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Thomas Abraham wrote:
> 
> Changes since v1:
> - Rebased with 'for-next' branch of
>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>   (tested with commit id a08b7e19811181309da2306338027fe1d3f8001d at the
>   tip of the for-next branch, not sure if there have been further
>   commits after that).
> 
> The platform helper that sets up the default sdhci-s3c controller
> configuration can be removed and moved into the sdhci-s3c driver.
> This platform helper is removed for s3c2416, s3c64xx, s5pc100,
> s5pv210 and Exynos4 platforms.
> 
> Since the platform helper function pointer was being passed in the
> platform data of sdhci-s3c driver, the removal of this pointer from
> the platform data is step closer to complete device tree support for
> sdhci-s3c driver.
> 
> This patchset has been tested on the following platforms.
> SMDK2416, SMDK6410, SMDKC100, SMDKV210 and SMDKV310.

Oh, I found :)
Looks ok to me, will apply.

As a note, please kindly ignore previous my comments on v.1 patch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
