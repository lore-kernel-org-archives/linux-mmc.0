From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: add module param to set fault injection attributes
Date: Wed, 14 Sep 2011 19:05:44 +0900
Message-ID: <CAC5umygS+viGcG2wAi=7vbjmiQB1jVgwKNAeZxDxB4WMC-teGg@mail.gmail.com>
References: <1315990017-16912-1-git-send-email-per.forlin@linaro.org>
	<1315990017-16912-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1315990017-16912-3-git-send-email-per.forlin@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2011/9/14 Per Forlin <per.forlin@linaro.org>:

> +#ifdef CONFIG_FAIL_MMC_REQUEST
> +
> +static DECLARE_FAULT_ATTR(fail_default_attr);
> +static char *fail_request;

This is not used anymore and ...

> +static int fail_mmc_request_param_set(const char *val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct kernel_param *kp)
> +{
> + =A0 =A0 =A0 setup_fault_attr(&fail_default_attr, (char *) val);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct kernel_param_ops fail_mmc_request_param_ops =3D =
{
> + =A0 =A0 =A0 .set =3D fail_mmc_request_param_set
> +};
> +module_param_cb(fail_request, &fail_mmc_request_param_ops,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &fail_request, 0);

you can change this third parameter to NULL.

> +
> +#endif /* CONFIG_FAIL_MMC_REQUEST */
