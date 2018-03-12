From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
Date: Mon, 12 Mar 2018 12:07:42 +0200
Message-ID: <1520849262.10722.582.camel@linux.intel.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>, ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, avri.altman@wdc.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir_Zapolskiy@mentor.com
List-Id: linux-mmc@vger.kernel.org

On Mon, 2018-03-12 at 10:01 +0530, Harish Jenny K N wrote:
> This patch exports the host capabilities to debugfs
> 
> This idea of sharing host capabilities over debugfs
> came up from Abbas Raza <Abbas_Raza@mentor.com>
> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
> 

Address below minors and, FWIW, take mine

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +	for_each_set_bit(bit, (const unsigned long *)&caps,
> BITS_PER_LONG)

> +	for_each_set_bit(bit, (const unsigned long *)&caps2,
> BITS_PER_LONG)

Explicit casting is not needed anymore in both cases.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
