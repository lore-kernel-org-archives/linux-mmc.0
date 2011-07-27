From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v4 2/3] mmc: core: add random fault injection
Date: Wed, 27 Jul 2011 11:02:12 +0200
Message-ID: <CAJ0pr19RWjCJAvnkVR+gL7y8_X4TSFfs7JqXgydWuWMAPPb1ZQ@mail.gmail.com>
References: <1311711119-6286-1-git-send-email-per.forlin@linaro.org>
	<1311711119-6286-3-git-send-email-per.forlin@linaro.org>
	<CAC5umygcfno0-=rA9G0OcxuVK2YK9UokfoYoy45qBT8w0+ytvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAC5umygcfno0-=rA9G0OcxuVK2YK9UokfoYoy45qBT8w0+ytvg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

On 27 July 2011 01:17, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 2011/7/27 Per Forlin <per.forlin@linaro.org>:
>> This adds support to inject data errors after a completed host trans=
fer.
>> The mmc core will return error even though the host transfer is succ=
essful.
>> This simple fault injection proved to be very useful to test the
>> non-blocking error handling in the mmc_blk_issue_rw_rq().
>> Random faults can also test how the host driver handles pre_req()
>> and post_req() in case of errors.
>
> Looks good but I have one question.
>
>> @@ -304,6 +307,10 @@ struct mmc_host {
>>
>> =A0 =A0 =A0 =A0struct mmc_async_req =A0 =A0*areq; =A0 =A0 =A0 =A0 =A0=
/* active async req */
>>
>> +#ifdef CONFIG_FAIL_MMC_REQUEST
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make_it_=
fail;
>> + =A0 =A0 =A0 struct fault_attr =A0 =A0 =A0 fail_mmc_request;
>> +#endif
>> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 private[0] ____cach=
eline_aligned;
>> =A0};
>
> I think make_it_fail is not needed anymore because if fail_attr is
> defined per-host then you can enable it by setting probability=3D0
> or times=3D0 per-host.
>
Yes, if there are many debugfs entries, one for each host make_if_fail
is no longer necessary.
There is an issue with patch v4 now when fault_attr is per-host.
Without your patch the entry is still created at the root but there
are many instances of fault-attr. I think it's better to wait for your
patch to make it into the mmc-next tree before submitting my patch. I
will prepare a patch v5 that depends on your upcoming changes in
fault-inject with a note that states the dependency.

Would you mind adding "patch 1/3" (export_symbol_gpl) to your
patch-set since it depends on the new function names in your patch?
If not, I can resend the patch on top of your changes to match the new
function names if you prefer to have this patch separate.

Please let me know.

Thanks,
Per
