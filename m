From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3 5/7] mmc: queue work on any cpu
Date: Fri, 22 Mar 2013 13:26:07 -0400
Message-ID: <87vc8jjqhc.fsf@octavius.laptop.org>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<08070dbf56439c84b8c25837c2049ff8e8eafd6e.1363617402.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08070dbf56439c84b8c25837c2049ff8e8eafd6e.1363617402.git.viresh.kumar@linaro.org>
	(Viresh Kumar's message of "Mon, 18 Mar 2013 20:53:27 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de, tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com, linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Mar 18 2013, Viresh Kumar wrote:
> mmc uses workqueues for running mmc_rescan(). There is no real depend=
ency of
> scheduling these on the cpu which scheduled them.
>
> On a idle system, it is observed that and idle cpu wakes up many time=
s just to
> service this work. It would be better if we can schedule it on a cpu =
which isn't
> idle to save on power.
>
> By idle cpu (from scheduler's perspective) we mean:
> - Current task is idle task
> - nr_running =3D=3D 0
> - wake_list is empty
>
> This patch replaces the queue_delayed_work() with
> queue_delayed_work_on_any_cpu() siblings.
>
> This routine would look for the closest (via scheduling domains) non-=
idle cpu
> (non-idle from schedulers perspective). If the current cpu is not idl=
e or all
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
>  				     unsigned long delay)
>  {
> -	return queue_delayed_work(workqueue, work, delay);
> +	return queue_delayed_work_on_any_cpu(workqueue, work, delay);
>  }
> =20
>  /*

/home/cjb/git/mmc/drivers/mmc/core/core.c: In function =E2=80=98mmc_sch=
edule_delayed_work=E2=80=99:
/home/cjb/git/mmc/drivers/mmc/core/core.c:88:2: error: implicit declara=
tion of function =E2=80=98queue_delayed_work_on_any_cpu=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]

I've dropped this patch for now.  This function doesn't seem to be
defined in linux-next either.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
