From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: Fix card detection regression
Date: Wed, 15 Jan 2014 16:41:39 +0800
Message-ID: <52D649C3.4020003@linaro.org>
References: <1389774667-18309-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1389774667-18309-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, chris@printf.net, tgih.jun@samsung.com, patches@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

Hi, Sachin



On 01/15/2014 04:31 PM, Sachin Kamat wrote:
> mmc_gpio_get_cd returns a negative error value upon failure.
> However gpio_cd was initialised with the negated return value
> of the above function. This negation resulted in losing of the
> error value thereby triggering the code to take a wrong path as
> IS_ERR_VALUE(gpio_cd) now returned 0 even when mmc_gpio_get_cd
> returned an error value. This issue introduced by commit bf626e5550f2
> ("mmc: dw_mmc: use slot-gpio to handle cd pin") caused card detection
> failure on Exynos5 boards which is now fixed by this patch.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for the patch
I just submitted one patch to fix the issue, in case you missed it.
Also spin_lock is required for atomic accessing DW_MMC_CARD_PRESENT.
Otherwise sd detect may be failed sometimes.

Could you help take a look.

Thanks
