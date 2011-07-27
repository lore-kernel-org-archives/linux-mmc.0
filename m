From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v4 2/3] mmc: core: add random fault injection
Date: Wed, 27 Jul 2011 21:46:21 +0200
Message-ID: <CAJ0pr1_--ubHVW792iQP5juSzFFcJR2tTcnO4mLE4Sh=rX+Jhg@mail.gmail.com>
References: <1311711119-6286-1-git-send-email-per.forlin@linaro.org>
	<1311711119-6286-3-git-send-email-per.forlin@linaro.org>
	<CAC5umygcfno0-=rA9G0OcxuVK2YK9UokfoYoy45qBT8w0+ytvg@mail.gmail.com>
	<CAJ0pr19RWjCJAvnkVR+gL7y8_X4TSFfs7JqXgydWuWMAPPb1ZQ@mail.gmail.com>
	<CAC5umygDP6WCrHmhRqMSDBmnOyB1aw+3nuCqvyz9xGXg9QeePw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAC5umygDP6WCrHmhRqMSDBmnOyB1aw+3nuCqvyz9xGXg9QeePw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

On 27 July 2011 18:08, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 2011/7/27 Per Forlin <per.forlin@linaro.org>:
>
>> There is an issue with patch v4 now when fault_attr is per-host.
>> Without your patch the entry is still created at the root but there
>> are many instances of fault-attr. I think it's better to wait for yo=
ur
>> patch to make it into the mmc-next tree before submitting my patch. =
I
>> will prepare a patch v5 that depends on your upcoming changes in
>> fault-inject with a note that states the dependency.
>
> Or you can prepare a patch for -mm and ask Andrew to add it to the -m=
m
> tree.
>
Thanks for the tip,

>> Would you mind adding "patch 1/3" (export_symbol_gpl) to your
>> patch-set since it depends on the new function names in your patch?
>> If not, I can resend the patch on top of your changes to match the n=
ew
>> function names if you prefer to have this patch separate.
>
> I recommend it to be a part of your patchset. =A0The new function nam=
e
> (fault_create_debugfs_attr) is not likely to change for a time. =A0Yo=
u can
> add Acked-by: Akinobu Mita <akinobu.mita@gmail.com>
>
Beside fault_create_debugfs_attr() the other function is should_fail.
I presume this name will be changed too, and start with the fault_?

Regards,
Per
