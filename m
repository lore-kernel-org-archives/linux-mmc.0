From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: add module param to set fault injection attributes
Date: Wed, 14 Sep 2011 20:47:24 +0900
Message-ID: <CAC5umyjAymZL7jA2VJq=aPBRnUDyUL6poTitLL6DBrk2SfZnug@mail.gmail.com>
References: <1315990017-16912-1-git-send-email-per.forlin@linaro.org>
	<1315990017-16912-3-git-send-email-per.forlin@linaro.org>
	<CAC5umygS+viGcG2wAi=7vbjmiQB1jVgwKNAeZxDxB4WMC-teGg@mail.gmail.com>
	<CAJ0pr1-WiLDS-wdb1je81L=tk0TVCbH9eci2YZ=JBp+G7rZ0GQ@mail.gmail.com>
	<CAJ0pr1-2K5Emr+Sq4MqcBoYFDRVV9=HE9_A0U72SZrT1DFEy3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAJ0pr1-2K5Emr+Sq4MqcBoYFDRVV9=HE9_A0U72SZrT1DFEy3A@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2011/9/14 Per Forlin <per.forlin@linaro.org>:

>>>> +static int fail_mmc_request_param_set(const char *val,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 const struct kernel_param *kp)
>>>> +{
>>>> + =A0 =A0 =A0 setup_fault_attr(&fail_default_attr, (char *) val);
> I am thinking of returning failure here if setup_fault_attr() fails.
> if (setup_fault_attr(&fail_default_attr, (char *) val) =3D=3D 0)
> =A0return -EINVAL;

It's good idea and it also prevents from loading the module if invalid
parameter is specified.

> There will be a printk(KERN_WARNING "FAULT_INJECTION: failed to parse
> arguments) it setup() fails. Is it too harsh to return failure?

Yes.  I'll try to fix in the future.
