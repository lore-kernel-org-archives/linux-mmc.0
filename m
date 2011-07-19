From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: [PATCH v2 1/3] fault-inject: make fault injection available for
 modules
Date: Tue, 19 Jul 2011 16:44:29 -0700
Message-ID: <4E2616DD.3010607@linux.intel.com>
References: <1311111106-26814-1-git-send-email-per.forlin@linaro.org> <1311111106-26814-2-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1311111106-26814-2-git-send-email-per.forlin@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, Akinobu Mita <akinobu.mita@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

On 07/19/2011 02:31 PM, Per Forlin wrote:
> export symbols should_fail() and init_fault_attr_dentries() in order
> to make modules use the fault injection functionality
>
> Signed-off-by: Per Forlin<per.forlin@linaro.org>
> ---
>   lib/fault-inject.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 7e65af7..cd28364 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -131,6 +131,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>
>   	return true;
>   }
> +EXPORT_SYMBOL(should_fail);

Should this be EXPORT_SYMBOL_GPL()?

>
>   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>
> @@ -311,5 +312,6 @@ fail:
>   	cleanup_fault_attr_dentries(attr);
>   	return -ENOMEM;
>   }
> +EXPORT_SYMBOL(init_fault_attr_dentries);

and here too?

>
>   #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
