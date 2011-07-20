From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2 2/3] mmc: core: add random fault injection
Date: Wed, 20 Jul 2011 23:49:30 +0200
Message-ID: <CAJ0pr1_YcCac7m5RvAPX=r81F3yhgXsAo_hou0_RQmx3WgWbUQ@mail.gmail.com>
References: <1311111106-26814-1-git-send-email-per.forlin@linaro.org>
	<1311111106-26814-3-git-send-email-per.forlin@linaro.org>
	<4E261B7F.8020002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4E261B7F.8020002@linux.intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, Akinobu Mita <akinobu.mita@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-mmc@vger.kernel.org

Hi James,

On 20 July 2011 02:04, J Freyensee <james_p_freyensee@linux.intel.com> =
wrote:
> On 07/19/2011 02:31 PM, Per Forlin wrote:
>>
>> This adds support to inject data errors after a completed host trans=
fer.
>> The mmc core will return error even though the host transfer is
>> successful.
>> This simple fault injection proved to be very useful to test the
>> non-blocking error handling in the mmc_blk_issue_rw_rq().
>> Random faults can also test how the host driver handles pre_req()
>> and post_req() in case of errors.
>>
>> Signed-off-by: Per Forlin<per.forlin@linaro.org>
>> ---
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 58
>> ++++++++++++++++++++++++++++++++++++++++++++
>> =A0drivers/mmc/core/debugfs.c | =A0 =A05 ++++
>> =A0include/linux/mmc/host.h =A0 | =A0 =A03 ++
>> =A0lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0| =A0 11 ++++++++
>> =A04 files changed, 77 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index ab36c7b..3f822b4 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -23,6 +23,8 @@
>> =A0#include<linux/log2.h>
>> =A0#include<linux/regulator/consumer.h>
>> =A0#include<linux/pm_runtime.h>
>> +#include<linux/fault-inject.h>
>> +#include<linux/random.h>
>>
>
> As a suggestion, would you want to also use '#ifdef CONFIG_FAIL_MMC_R=
EQUEST'
> for fault-inject.h and random.h? =A0If they are not used in a non-deb=
ug linux
> kernel configuration, could this possibly cause a little extra code b=
loat if
> they are a part of a production Linux kernel compile/configuration?
>
I try to avoid ifdefs in general but I see your point. I accept your
comment and add the ifdef.

>> =A0#include<linux/mmc/card.h>
>> =A0#include<linux/mmc/host.h>
>> @@ -82,6 +84,58 @@ static void mmc_flush_scheduled_work(void)
>> =A0 =A0 =A0 =A0flush_workqueue(workqueue);
>> =A0}
>>
>> +#ifdef CONFIG_FAIL_MMC_REQUEST
>> +
>> +static DECLARE_FAULT_ATTR(fail_mmc_request);
>> +
>> +static int __init setup_fail_mmc_request(char *str)
>
> Function comment header somewhere (here or the .h file?)
>
>> +{
>> + =A0 =A0 =A0 return setup_fault_attr(&fail_mmc_request, str);
>> +}
>> +__setup("fail_mmc_request=3D", setup_fail_mmc_request);
>> +
>> +static void mmc_should_fail_request(struct mmc_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_request *mrq)
>> +{
>
> Function comment header somewhere (here or the .h file)?
>
I will do.

>> + =A0 =A0 =A0 struct mmc_command *cmd =3D mrq->cmd;
>> + =A0 =A0 =A0 struct mmc_data *data =3D mrq->data;
>> + =A0 =A0 =A0 static const int data_errors[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -ETIMEDOUT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -EILSEQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -EIO,
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 if (!data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>
> Should 'if (!cmd)' also be checked or is this guaranteed to always ha=
ve a
> valid value for this function (and if there are certain commands in '=
struct
> mmc_command *cmd =3D mrq->cmd' that will not work with this function =
then that
> is something that should be documented in the function comment header=
)?
>
cmd will always be set from where the mmc_should_fail_request() is call=
ed.
This code only inject data errors. For commands with no data struct
there will be no error inject. This is a choice I have made. It is
possible to extend this by injecting errors for cmds without data too
but it would require an additional flag in order to control inject
errors on data and cmd separately. I will add this information to the
function description.

>> + =A0 =A0 =A0 if (cmd->error || data->error || !host->make_it_fail |=
|
>> + =A0 =A0 =A0 =A0 =A0 !should_fail(&fail_mmc_request, data->blksz * =
data->blocks))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 data->error =3D data_errors[random32() % ARRAY_SIZE(da=
ta_errors)];
>> + =A0 =A0 =A0 data->bytes_xfered =3D (random32() % (data->bytes_xfer=
ed>> =A09))<<
>> =A09;
>> +}
>> +
>> +static int __init fail_mmc_request_debugfs(void)
>> +{
>> + =A0 =A0 =A0 return init_fault_attr_dentries(&fail_mmc_request,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "fail_mmc_request");
>> +}
>> +
>> +#else /* CONFIG_FAIL_MMC_REQUEST */
>> +
>> +static void mmc_should_fail_request(struct mmc_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_request *mrq)
>> +{
>> +}
>> +
>> +static int __init fail_mmc_request_debugfs(void)
>> +{
>> + =A0 =A0 =A0 return 0;
>> +}
>> +#endif /* CONFIG_FAIL_MMC_REQUEST */
>> +
>> +
>> =A0/**
>> =A0 * =A0 =A0mmc_request_done - finish processing an MMC request
>> =A0 * =A0 =A0@host: MMC host which completed request
>> @@ -108,6 +162,8 @@ void mmc_request_done(struct mmc_host *host, str=
uct
>> mmc_request *mrq)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd->error =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops->request(host, mrq);
>> =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_should_fail_request(host, mrq);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led_trigger_event(host->led, LED_OFF)=
;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("%s: req done (CMD%u): %d: %=
08x %08x %08x %08x\n",
>> @@ -2064,6 +2120,8 @@ static int __init mmc_init(void)
>> =A0 =A0 =A0 =A0if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unregister_host_class;
>>
>> + =A0 =A0 =A0 fail_mmc_request_debugfs();
>> +
>> =A0 =A0 =A0 =A0return 0;
>>
>> =A0unregister_host_class:
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 998797e..588e76f 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -188,6 +188,11 @@ void mmc_add_host_debugfs(struct mmc_host *host=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0root,=
&host->clk_delay))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_node;
>> =A0#endif
>> +#ifdef CONFIG_FAIL_MMC_REQUEST
>> + =A0 =A0 =A0 if (!debugfs_create_u8("make-it-fail", S_IRUSR | S_IWU=
SR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0root,&h=
ost->make_it_fail))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_node;
>> +#endif
>> =A0 =A0 =A0 =A0return;
>>
>> =A0err_node:
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 771455f..250b46d 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -303,6 +303,9 @@ struct mmc_host {
>>
>> =A0 =A0 =A0 =A0struct mmc_async_req =A0 =A0*areq; =A0 =A0 =A0 =A0 =A0=
/* active async req */
>>
>> +#ifdef CONFIG_FAIL_MMC_REQUEST
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make_it_=
fail;
>> +#endif
>> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 private[0] ____cach=
eline_aligned;
>> =A0};
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index c768bcd..c2d1423 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1057,6 +1057,17 @@ config FAIL_IO_TIMEOUT
>> =A0 =A0 =A0 =A0 =A0Only works with drivers that use the generic time=
out handling,
>> =A0 =A0 =A0 =A0 =A0for others it wont do anything.
>>
>> +config FAIL_MMC_REQUEST
>> + =A0 =A0 =A0 bool "Fault-injection capability for MMC IO"
>> + =A0 =A0 =A0 select DEBUG_FS
>> + =A0 =A0 =A0 depends on FAULT_INJECTION&& =A0MMC
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Provide fault-injection capability for MMC IO.
>> + =A0 =A0 =A0 =A0 This will make the mmc core return data errors. Th=
is is
>> + =A0 =A0 =A0 =A0 useful to test the error handling in the mmc block=
 device
>> + =A0 =A0 =A0 =A0 and to test how the mmc host driver handles retrie=
s from
>> + =A0 =A0 =A0 =A0 the block device.
>> +
>> =A0config FAULT_INJECTION_DEBUG_FS
>> =A0 =A0 =A0 =A0bool "Debugfs entries for fault-injection capabilitie=
s"
>> =A0 =A0 =A0 =A0depends on FAULT_INJECTION&& =A0SYSFS&& =A0DEBUG_FS
>
>
> --
> J (James/Jay) Freyensee
> Storage Technology Group
> Intel Corporation
>
