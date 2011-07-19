From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v9 11/12] mmc: core: add random fault injection
Date: Tue, 19 Jul 2011 08:17:02 +0200
Message-ID: <CAJ0pr19Ktx_R8Zmr=rDivhc5A__N7OwoSj3ehitX_pS_xmooSA@mail.gmail.com>
References: <1309539333-2606-1-git-send-email-per.forlin@linaro.org>
	<1309539333-2606-12-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63390 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab1GSGRD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2011 02:17:03 -0400
In-Reply-To: <1309539333-2606-12-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Venkatraman S <sv>
Cc: Per Forlin <per.forlin@linaro.org>

This patch prevents mmc core to be built as a module if mmc fault
injection is selected.

Changes needed to resolve this:
 * remove fault inject module from core.c
 * export should_fail() and init_fault_attr_dentries() in fault-injecti=
on.c
 * update documentation fault-injection.txt

On 1 July 2011 18:55, Per Forlin <per.forlin@linaro.org> wrote:
> This simple fault injection proved to be very useful to
> test the error handling in the block.c rw_rq(). It may
> still be useful to test if the host driver handle
> pre_req() and post_req() correctly in case of errors.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Venkatraman S <svenkatr@ti.com>
> Tested-by: Sourav Poddar<sourav.poddar@ti.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> =A0drivers/mmc/core/core.c =A0 =A0| =A0 54 ++++++++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/mmc/core/debugfs.c | =A0 =A05 ++++
> =A0include/linux/mmc/host.h =A0 | =A0 =A03 ++
> =A0lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0| =A0 11 +++++++++
> =A04 files changed, 73 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d2d7239..62a8cc7 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -23,6 +23,8 @@
> =A0#include <linux/log2.h>
> =A0#include <linux/regulator/consumer.h>
> =A0#include <linux/pm_runtime.h>
> +#include <linux/fault-inject.h>
> +#include <linux/random.h>
>
> =A0#include <linux/mmc/card.h>
> =A0#include <linux/mmc/host.h>
> @@ -82,6 +84,56 @@ static void mmc_flush_scheduled_work(void)
> =A0 =A0 =A0 =A0flush_workqueue(workqueue);
> =A0}
>
> +#ifdef CONFIG_FAIL_MMC_REQUEST
> +
> +static DECLARE_FAULT_ATTR(fail_mmc_request);
> +
> +static int __init setup_fail_mmc_request(char *str)
> +{
> + =A0 =A0 =A0 return setup_fault_attr(&fail_mmc_request, str);
> +}
> +__setup("fail_mmc_request=3D", setup_fail_mmc_request);
> +
> +static void mmc_should_fail_request(struct mmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_request *mrq)
> +{
> + =A0 =A0 =A0 struct mmc_command *cmd =3D mrq->cmd;
> + =A0 =A0 =A0 struct mmc_data *data =3D mrq->data;
> + =A0 =A0 =A0 static const int data_errors[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -ETIMEDOUT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -EILSEQ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -EIO,
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 if (!data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (cmd->error || data->error || !host->make_it_fail ||
> + =A0 =A0 =A0 =A0 =A0 !should_fail(&fail_mmc_request, data->blksz * d=
ata->blocks))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 data->error =3D data_errors[random32() % ARRAY_SIZE(dat=
a_errors)];
> + =A0 =A0 =A0 data->bytes_xfered =3D (random32() % (data->bytes_xfere=
d >> 9)) << 9;
> +}
> +
> +static int __init fail_mmc_request_debugfs(void)
> +{
> + =A0 =A0 =A0 return init_fault_attr_dentries(&fail_mmc_request,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "fail_mmc_request");
> +}
> +
> +late_initcall(fail_mmc_request_debugfs);
This line prevents mmc core to be built as a module, since there will
be two init_module (the mmc core one and this one) for the same
module.

> +
> +#else /* CONFIG_FAIL_MMC_REQUEST */
> +
> +static void mmc_should_fail_request(struct mmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_request *mrq)
> +{
> +}
> +
+static int __init fail_mmc_request_debugfs(void)
+{
+}
Add fail_mmc_request_debugfs here and call it from mmc_init()

> +#endif /* CONFIG_FAIL_MMC_REQUEST */
> +
> +
> =A0/**
> =A0* =A0 =A0 mmc_request_done - finish processing an MMC request
> =A0* =A0 =A0 @host: MMC host which completed request
> @@ -108,6 +160,8 @@ void mmc_request_done(struct mmc_host *host, stru=
ct mmc_request *mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd->error =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops->request(host, mrq);
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_should_fail_request(host, mrq);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led_trigger_event(host->led, LED_OFF);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("%s: req done (CMD%u): %d: %0=
8x %08x %08x %08x\n",
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 998797e..588e76f 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -188,6 +188,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0root, =
&host->clk_delay))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_node;
> =A0#endif
> +#ifdef CONFIG_FAIL_MMC_REQUEST
> + =A0 =A0 =A0 if (!debugfs_create_u8("make-it-fail", S_IRUSR | S_IWUS=
R,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0root, &h=
ost->make_it_fail))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_node;
> +#endif
> =A0 =A0 =A0 =A0return;
>
> =A0err_node:
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 59db6f2..0d0a48f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -301,6 +301,9 @@ struct mmc_host {
>
> =A0 =A0 =A0 =A0struct mmc_async_req =A0 =A0*areq; =A0 =A0 =A0 =A0 =A0=
/* active async req */
>
> +#ifdef CONFIG_FAIL_MMC_REQUEST
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make_it_f=
ail;
> +#endif
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 private[0] ____cache=
line_aligned;
> =A0};
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c768bcd..330fc70 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1057,6 +1057,17 @@ config FAIL_IO_TIMEOUT
> =A0 =A0 =A0 =A0 =A0Only works with drivers that use the generic timeo=
ut handling,
> =A0 =A0 =A0 =A0 =A0for others it wont do anything.
>
> +config FAIL_MMC_REQUEST
> + =A0 =A0 =A0 bool "Fault-injection capability for MMC IO"
> + =A0 =A0 =A0 select DEBUG_FS
> + =A0 =A0 =A0 depends on FAULT_INJECTION
depends on FAULT_INJECTION && MMC

> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Provide fault-injection capability for MMC IO.
> + =A0 =A0 =A0 =A0 This will make the mmc core return data errors. Thi=
s is
> + =A0 =A0 =A0 =A0 useful for testing the error handling in the mmc bl=
ock device
> + =A0 =A0 =A0 =A0 and how the mmc host driver handle retries from
> + =A0 =A0 =A0 =A0 the block device.
and test how the mmc host driver handle retries from
