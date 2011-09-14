From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v9 2/3] mmc: core: add random fault injection
Date: Wed, 14 Sep 2011 08:51:20 +0200
Message-ID: <CAJ0pr19+qC0nVwzrq5wbQKzgSVFXzuSgJ2T8auNhmXpzQu8bfg@mail.gmail.com>
References: <1313758358-27536-1-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-2-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-3-git-send-email-per.forlin@stericsson.com>
	<CAC5umyjWx7ZvT+F_XhOZt_utr=mS-0p5tDpJ1ioWNiDAJLNXwQ@mail.gmail.com>
	<CAJ0pr18dn3CtBsXk9MG3Zn9zSwAiNoxB3b-62aMO3+8H+kUX3A@mail.gmail.com>
	<CAJ0pr1-ba0iY808igXJuEiWAX5zwhTUD6r+8MAMeBTHYFTenCg@mail.gmail.com>
	<CAC5umygBmE-dayTrUhU_=dn7+YZ=nd8-s7SJw5xLxnKN1pBMAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAC5umygBmE-dayTrUhU_=dn7+YZ=nd8-s7SJw5xLxnKN1pBMAQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 14 September 2011 01:37, Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2011/9/14 Per Forlin <per.forlin@linaro.org>:
>> Hi Akinobu,
>>
>> On 13 September 2011 16:19, Per Forlin <per.forlin@linaro.org> wrote=
:
>>> On 13 September 2011 15:12, Akinobu Mita <akinobu.mita@gmail.com> w=
rote:
>>>> 2011/8/19 Per Forlin <per.forlin@stericsson.com>:
>>>>
>>>>> +#ifdef KERNEL
>>>>> +/*
>>>>> + * Internal function. Pass the boot param fail_mmc_request to
>>>>> + * the setup fault injection attributes routine.
>>>>> + */
>>>>> +static int __init setup_fail_mmc_request(char *str)
>>>>> +{
>>>>> + =A0 =A0 =A0 return setup_fault_attr(&fail_mmc_request, str);
>>>>> +}
>>>>> +__setup("fail_mmc_request=3D", setup_fail_mmc_request);
>>>>> +#endif /* KERNEL */
>>>>
>>>> You attempt to enable __setup() only when mmc_core is built into
>>>> the kernel. =A0Does it really work? I cannot find any drivers usin=
g
>>>> "KERNEL" macro.
>>>>
>>> Your right it doesn't work. I think I change from ifndef MODULE to
>>> ifdef KERNEL at one point.
>>> It should be "ifndef MODULE"
>
> It's simple and I like this solution.
>
It's simple and the patch would be just two lines.
The reason for changing my mind is that it may be useful to be able to
pass the fault injection attributes even when mmc_core is a module.

> module_param is more complicated than this. Also the parameter is onl=
y
> usefull when when mmc_core is built into the kernel (it's useless whe=
n
> mmc_core is built as a module).
>
If you want to enable fault injection for the mmc_core module at load
time (during mmc initialisation) the param must be used.
modprobe mmc_core fail_request=3D1,1,1,1
As soon as the module is loaded there is no need for the module param a=
nymore.

>>>> You can use module_param_cb() instead of __setup() without #ifdef =
KERNEL.
>>>> When mmc_core is built into the kernel, you can specify the parame=
ter
>>>> with "mmc_core.fail_mmc_request=3D..."
>>>>
>> I am considering using module_param() with perm =3D 0 (not visible i=
n
>> sysfs). The purpose of the param is to set fault attributes during
>> kerne boot time or module load time. After the kernel boot all can b=
e
>> set under debug fs, therefore no need to make the module param
>> visible.
>>
>> What do you think about this? I have not tested it yet.
>> ----------------------------------------------------------
>
> ...
>
>> ----------------------------------------------------------
>> It's only necessary to call setup_fault_attr() once for all hosts.
>> Here it's called one time for each host. I think it's ok since the
>> routine is small and used for debugging purposes.
>> I could use a static bool to indicate whether setup_fault_attr() has
>> already been issued.
>> + if (fail_mmc_request && !setup_fault_attr_done)
>
> module_param_cb() doesn't work as you expected?
I made a silly mistake thinking the set() hook would only be issued if
setting the param via sysfs. I turned out that I just mistyped the
boot-param name, sorry.
I now have a working test with module_param_cb() implemented.

Thanks,
Per
