From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: core: add random fault injection
Date: Tue, 26 Jul 2011 22:01:46 +0200
Message-ID: <CAJ0pr19E0DEHg=tWRqh97syAf89qM96MSgNz=h838UoDNgW24A@mail.gmail.com>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
	<1311199321-4618-3-git-send-email-per.forlin@linaro.org>
	<CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
	<CAJ0pr1_rL8rsEbDR-PL6fs9EzyGfUMbmeUjTGk=WspvrAkdy+g@mail.gmail.com>
	<CAJ0pr19oTmt5PQw45wbRO8qEzVi3J1OgL=w9Ma7XxX-=1A=A=A@mail.gmail.com>
	<CAC5umyjR3V2uFtWZ7tQQtGH2B=s+-C43U1H01qYysBScYc8fxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAC5umyjR3V2uFtWZ7tQQtGH2B=s+-C43U1H01qYysBScYc8fxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

On 26 July 2011 03:41, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 2011/7/26 Per Forlin <per.forlin@linaro.org>:
>>>> And I know that init_fault_attr_dentries() can only create a
>>>> subdirectory in debugfs root directory. =A0But I have a patch whic=
h
>>>> support for creating it in arbitrary directory. =A0Could you take =
a look
>>>> at this? (Note that this patch is based on mmotm and not yet teste=
d)
>>>>
>> I looked at your patch and it raised two questions.
>> I can't use FAULT_ATTR_INITIALIZER since mmc_host is allocated on th=
e
>> heap. It looks like setup_fault_attr(attr, str) will fail if str is
>> NULL. How can I initialise the fault_attrs if not stack allocated?
>> About the boot param initialisation of fault attr. There can only be
>> one fault_mmc_request boot param for the entire kernel but there is
>> one fault_attr per host, and there may be many hosts. It would be
>> convenient if setup_fault_attrs would take (attr, boot_param_name),
>> look up boot_param_name and use that otherwise set default values.
>
> I think you can define one default fail_attr for boot time configurat=
ion
> and copy it to per-host fail_attr in mmc_add_host_debugfs().
>
You're right. This works fine. I'll prepare a new version of my patch.
