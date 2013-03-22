From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3 5/7] mmc: queue work on any cpu
Date: Fri, 22 Mar 2013 13:30:32 -0400
Message-ID: <87r4j7jq9z.fsf@octavius.laptop.org>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<08070dbf56439c84b8c25837c2049ff8e8eafd6e.1363617402.git.viresh.kumar@linaro.org>
	<87vc8jjqhc.fsf@octavius.laptop.org>
	<CAKohpomqkYeMgvTpjrUjGs3md=vzguW5Ae6Snf4hzsqtQxNDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpomqkYeMgvTpjrUjGs3md=vzguW5Ae6Snf4hzsqtQxNDOw@mail.gmail.com>
	(Viresh Kumar's message of "Fri, 22 Mar 2013 22:57:49 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de, tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com, linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 22 2013, Viresh Kumar wrote:
> On 22 March 2013 22:56, Chris Ball <cjb@laptop.org> wrote:
>> On Mon, Mar 18 2013, Viresh Kumar wrote:
>>
>> /home/cjb/git/mmc/drivers/mmc/core/core.c: In function
>> =E2=80=98mmc_schedule_delayed_work=E2=80=99:
>> /home/cjb/git/mmc/drivers/mmc/core/core.c:88:2: error: implicit
>> declaration of function =E2=80=98queue_delayed_work_on_any_cpu=E2=80=
=99
>> [-Werror=3Dimplicit-function-declaration]
>>
>> I've dropped this patch for now.  This function doesn't seem to be
>> defined in linux-next either.
>
> Hi chris,
>
> This patch was part of a bigger patchset which also adds this API. I
> don't want you to
> apply this one but just Ack here. Probably Tejun or some scheduler
> maintainer will
> apply it later (if they like all patches).

Thanks, makes sense.  For [5/7]:

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
