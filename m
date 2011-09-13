From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v9 2/3] mmc: core: add random fault injection
Date: Tue, 13 Sep 2011 22:12:04 +0900
Message-ID: <CAC5umyjWx7ZvT+F_XhOZt_utr=mS-0p5tDpJ1ioWNiDAJLNXwQ@mail.gmail.com>
References: <1313758358-27536-1-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-2-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-3-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1313758358-27536-3-git-send-email-per.forlin@stericsson.com>
Sender: linux-doc-owner@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org, Per Forlin <per.forlin@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2011/8/19 Per Forlin <per.forlin@stericsson.com>:

> +#ifdef KERNEL
> +/*
> + * Internal function. Pass the boot param fail_mmc_request to
> + * the setup fault injection attributes routine.
> + */
> +static int __init setup_fail_mmc_request(char *str)
> +{
> + =A0 =A0 =A0 return setup_fault_attr(&fail_mmc_request, str);
> +}
> +__setup("fail_mmc_request=3D", setup_fail_mmc_request);
> +#endif /* KERNEL */

You attempt to enable __setup() only when mmc_core is built into
the kernel.  Does it really work? I cannot find any drivers using
"KERNEL" macro.

You can use module_param_cb() instead of __setup() without #ifdef KERNE=
L.
When mmc_core is built into the kernel, you can specify the parameter
with "mmc_core.fail_mmc_request=3D..."

Sorry for pointing that out too late.
