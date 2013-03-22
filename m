From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 5/7] mmc: queue work on any cpu
Date: Fri, 22 Mar 2013 22:57:49 +0530
Message-ID: <CAKohpomqkYeMgvTpjrUjGs3md=vzguW5Ae6Snf4hzsqtQxNDOw@mail.gmail.com>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<08070dbf56439c84b8c25837c2049ff8e8eafd6e.1363617402.git.viresh.kumar@linaro.org>
	<87vc8jjqhc.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:45781 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422654Ab3CVR1u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 13:27:50 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so4651418oag.18
        for <linux-mmc@vger.kernel.org>; Fri, 22 Mar 2013 10:27:50 -0700 (PDT)
In-Reply-To: <87vc8jjqhc.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de, tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com, linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 22 March 2013 22:56, Chris Ball <cjb@laptop.org> wrote:
> On Mon, Mar 18 2013, Viresh Kumar wrote:
>
> /home/cjb/git/mmc/drivers/mmc/core/core.c: In function =91mmc_schedul=
e_delayed_work=92:
> /home/cjb/git/mmc/drivers/mmc/core/core.c:88:2: error: implicit decla=
ration of function =91queue_delayed_work_on_any_cpu=92 [-Werror=3Dimpli=
cit-function-declaration]
>
> I've dropped this patch for now.  This function doesn't seem to be
> defined in linux-next either.

Hi chris,

This patch was part of a bigger patchset which also adds this API. I
don't want you to
apply this one but just Ack here. Probably Tejun or some scheduler
maintainer will
apply it later (if they like all patches).
