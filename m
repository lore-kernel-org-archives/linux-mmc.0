From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 5/7] mmc: queue work on any cpu
Date: Tue, 19 Mar 2013 08:58:52 +0100
Message-ID: <CAPDyKFqnr7k=Aa-jdXwG=G1nP9UqCGboz8CLUO1fiRU2=Yg9gQ@mail.gmail.com>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<08070dbf56439c84b8c25837c2049ff8e8eafd6e.1363617402.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:42069 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757735Ab3CSH6x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Mar 2013 03:58:53 -0400
Received: by mail-vb0-f44.google.com with SMTP id fr13so125013vbb.31
        for <linux-mmc@vger.kernel.org>; Tue, 19 Mar 2013 00:58:52 -0700 (PDT)
In-Reply-To: <08070dbf56439c84b8c25837c2049ff8e8eafd6e.1363617402.git.viresh.kumar@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de, tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com, linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 18 March 2013 16:23, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> mmc uses workqueues for running mmc_rescan(). There is no real dependency of
> scheduling these on the cpu which scheduled them.
>
> On a idle system, it is observed that and idle cpu wakes up many times just to
> service this work. It would be better if we can schedule it on a cpu which isn't
> idle to save on power.
>
> By idle cpu (from scheduler's perspective) we mean:
> - Current task is idle task
> - nr_running == 0
> - wake_list is empty
>
> This patch replaces the queue_delayed_work() with
> queue_delayed_work_on_any_cpu() siblings.
>
> This routine would look for the closest (via scheduling domains) non-idle cpu
> (non-idle from schedulers perspective). If the current cpu is not idle or all
> cpus are idle, work will be scheduled on local cpu.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9290bb5..adf331a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -85,7 +85,7 @@ MODULE_PARM_DESC(
>  static int mmc_schedule_delayed_work(struct delayed_work *work,
>                                      unsigned long delay)
>  {
> -       return queue_delayed_work(workqueue, work, delay);
> +       return queue_delayed_work_on_any_cpu(workqueue, work, delay);
>  }
>
>  /*
> --
> 1.7.12.rc2.18.g61b472e
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
