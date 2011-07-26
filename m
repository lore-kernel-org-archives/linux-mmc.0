From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: core: add random fault injection
Date: Tue, 26 Jul 2011 10:41:22 +0900
Message-ID: <CAC5umyjR3V2uFtWZ7tQQtGH2B=s+-C43U1H01qYysBScYc8fxQ@mail.gmail.com>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
	<1311199321-4618-3-git-send-email-per.forlin@linaro.org>
	<CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
	<CAJ0pr1_rL8rsEbDR-PL6fs9EzyGfUMbmeUjTGk=WspvrAkdy+g@mail.gmail.com>
	<CAJ0pr19oTmt5PQw45wbRO8qEzVi3J1OgL=w9Ma7XxX-=1A=A=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAJ0pr19oTmt5PQw45wbRO8qEzVi3J1OgL=w9Ma7XxX-=1A=A=A@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

2011/7/26 Per Forlin <per.forlin@linaro.org>:
>>> And I know that init_fault_attr_dentries() can only create a
>>> subdirectory in debugfs root directory. =A0But I have a patch which
>>> support for creating it in arbitrary directory. =A0Could you take a=
 look
>>> at this? (Note that this patch is based on mmotm and not yet tested=
)
>>>
> I looked at your patch and it raised two questions.
> I can't use FAULT_ATTR_INITIALIZER since mmc_host is allocated on the
> heap. It looks like setup_fault_attr(attr, str) will fail if str is
> NULL. How can I initialise the fault_attrs if not stack allocated?
> About the boot param initialisation of fault attr. There can only be
> one fault_mmc_request boot param for the entire kernel but there is
> one fault_attr per host, and there may be many hosts. It would be
> convenient if setup_fault_attrs would take (attr, boot_param_name),
> look up boot_param_name and use that otherwise set default values.

I think you can define one default fail_attr for boot time configuratio=
n
and copy it to per-host fail_attr in mmc_add_host_debugfs().

/* pseudo-code */

static DECLARE_FAULT_ATTR(default_mmc_fail_attr);

static int __init setup_fail_mmc_request(char *str)
{
	return setup_fault_attr(&default_mmc_fail_attr, str);
}
__setup("fail_mmc_request=3D", setup_fail_mmc_request);

=2E..

void mmc_add_host_debugfs(struct mmc_host *host)
{
	...

#ifdef CONFIG_FAIL_MMC_REQUEST
	host->fail_attr =3D default_mmc_fail_attr;
	if (!debugfs_create_fault_attr("fail_mmc_request",
					root, &host->fail_attr))
		goto err_node;
#endif
	...
}
