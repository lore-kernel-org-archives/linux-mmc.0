From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2 1/3] fault-inject: make fault injection available for modules
Date: Wed, 20 Jul 2011 23:50:31 +0200
Message-ID: <CAJ0pr19a9j-GBP4KveKqrjyZiqGNzoXd8S=-BWOtCv5nNrt5EQ@mail.gmail.com>
References: <1311111106-26814-1-git-send-email-per.forlin@linaro.org>
	<1311111106-26814-2-git-send-email-per.forlin@linaro.org>
	<4E2616DD.3010607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4E2616DD.3010607@linux.intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, Akinobu Mita <akinobu.mita@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

Hi James,

On 20 July 2011 01:44, J Freyensee <james_p_freyensee@linux.intel.com> =
wrote:
> On 07/19/2011 02:31 PM, Per Forlin wrote:
>>
>> export symbols should_fail() and init_fault_attr_dentries() in order
>> to make modules use the fault injection functionality
>>
>> Signed-off-by: Per Forlin<per.forlin@linaro.org>
>> ---
>> =A0lib/fault-inject.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
>> index 7e65af7..cd28364 100644
>> --- a/lib/fault-inject.c
>> +++ b/lib/fault-inject.c
>> @@ -131,6 +131,7 @@ bool should_fail(struct fault_attr *attr, ssize_=
t
>> size)
>>
>> =A0 =A0 =A0 =A0return true;
>> =A0}
>> +EXPORT_SYMBOL(should_fail);
>
> Should this be EXPORT_SYMBOL_GPL()?
>
I forgot to consider this. GPL is fine with me. I'll update.

>>
>> =A0#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>>
>> @@ -311,5 +312,6 @@ fail:
>> =A0 =A0 =A0 =A0cleanup_fault_attr_dentries(attr);
>> =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0}
>> +EXPORT_SYMBOL(init_fault_attr_dentries);
>
> and here too?
>
dito.

>>
>> =A0#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
>
>
> --
> J (James/Jay) Freyensee
> Storage Technology Group
> Intel Corporation
>
