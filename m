From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 2/3] mmc: core: add random fault injection
Date: Tue, 13 Sep 2011 16:19:59 +0200
Message-ID: <CAJ0pr18dn3CtBsXk9MG3Zn9zSwAiNoxB3b-62aMO3+8H+kUX3A@mail.gmail.com>
References: <1313758358-27536-1-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-2-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-3-git-send-email-per.forlin@stericsson.com>
	<CAC5umyjWx7ZvT+F_XhOZt_utr=mS-0p5tDpJ1ioWNiDAJLNXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAC5umyjWx7ZvT+F_XhOZt_utr=mS-0p5tDpJ1ioWNiDAJLNXwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Per Forlin <per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 13 September 2011 15:12, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 2011/8/19 Per Forlin <per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>:
>
>> +#ifdef KERNEL
>> +/*
>> + * Internal function. Pass the boot param fail_mmc_request to
>> + * the setup fault injection attributes routine.
>> + */
>> +static int __init setup_fail_mmc_request(char *str)
>> +{
>> + =A0 =A0 =A0 return setup_fault_attr(&fail_mmc_request, str);
>> +}
>> +__setup("fail_mmc_request=3D", setup_fail_mmc_request);
>> +#endif /* KERNEL */
>
> You attempt to enable __setup() only when mmc_core is built into
> the kernel. =A0Does it really work? I cannot find any drivers using
> "KERNEL" macro.
>
Your right it doesn't work. I think I change from ifndef MODULE to
ifdef KERNEL at one point.
It should be "ifndef MODULE"

> You can use module_param_cb() instead of __setup() without #ifdef KERNEL.
> When mmc_core is built into the kernel, you can specify the parameter
> with "mmc_core.fail_mmc_request=3D..."
>
Thanks, this is the proper way to do it.

> Sorry for pointing that out too late.
>
I think this patch is queued for 3.2 so there should be time to fix it stil=
l.

Thanks again,
Per
