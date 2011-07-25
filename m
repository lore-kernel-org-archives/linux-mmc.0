From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: core: add random fault injection
Date: Mon, 25 Jul 2011 21:19:21 +0200
Message-ID: <CAJ0pr1_rL8rsEbDR-PL6fs9EzyGfUMbmeUjTGk=WspvrAkdy+g@mail.gmail.com>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
	<1311199321-4618-3-git-send-email-per.forlin@linaro.org>
	<CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

On 25 July 2011 17:58, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 2011/7/21 Per Forlin <per.forlin@linaro.org>:
>> This adds support to inject data errors after a completed host trans=
fer.
>> The mmc core will return error even though the host transfer is succ=
essful.
>> This simple fault injection proved to be very useful to test the
>> non-blocking error handling in the mmc_blk_issue_rw_rq().
>> Random faults can also test how the host driver handles pre_req()
>> and post_req() in case of errors.
>
> Looks good to me.
>
Thanks,

>> @@ -82,6 +87,66 @@ static void mmc_flush_scheduled_work(void)
>> =A0 =A0 =A0 =A0flush_workqueue(workqueue);
>> =A0}
>>
>> +#ifdef CONFIG_FAIL_MMC_REQUEST
>> +
>> +static DECLARE_FAULT_ATTR(fail_mmc_request);
>
> I think the fail_attr should be defined for each mmc_host like make_i=
t_fail
> in struct mmc_host and debugfs entries should also be created in a
> subdirectory of mmc host debugfs.
>
I looked at blk-core.c and used the same code here. Current code
creates the entry under the debugfs root. This means one fail_attr for
all hosts.
I agree, it's more clean to move the fail_attr to the
host-debugfs-entry which require the fail_attr to be stored same way
as make_it_fail.

> And I know that init_fault_attr_dentries() can only create a
> subdirectory in debugfs root directory. =A0But I have a patch which
> support for creating it in arbitrary directory. =A0Could you take a l=
ook
> at this? (Note that this patch is based on mmotm and not yet tested)
>
Thanks, I will check it out.

Regards,
Per
