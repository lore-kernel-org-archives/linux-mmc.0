From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Tue, 15 Nov 2011 11:16:41 +0530
Message-ID: <4EC1FCC1.6070609@st.com>
References: <4EBCC49E.5060008@st.com> <877h36hvki.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:53294 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909Ab1KOFrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 00:47:14 -0500
In-Reply-To: <877h36hvki.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

On 11/12/2011 8:54 AM, Chris Ball wrote:
> On Fri, Nov 11 2011, Viresh Kumar wrote:
>> > Controller specific suspend/resume are still not called, so i think it might
>> > be related to core code. I am using 2.6.37 kernel version.
>> >
>> > Any help on this?
> Please try to reproduce on 3.1 and let us know if it's present there.

Hi Chris,

Support for SPEAr13xx is not present on 3.1 and it will take some time to
move support there. I have a bit more info which might able you to guide us:

file: drivers/mmc/card/queue.c

static int mmc_queue_thread(void *d)
{
	...
	do {
		req = blk_fetch_request(q);
		...
		if (!req) {
			if (kthread_should_stop()) {
				set_current_state(TASK_RUNNING);
				break;
			}
			up(&mq->thread_sem);
			schedule();
			down(&mq->thread_sem);
			continue;
		}
		set_current_state(TASK_RUNNING);
		mq->issue_fn(mq, req);
	} while (1);
	...
}

- In normal cases, i.e. when we are able to stop this thread,
  req is returned as NULL from blk_fetch_request()
- Suspend hang only occurs when the card is mounted.
- When suspend hangs, req is not returned as NULL and the card is
  already removed by kernel and so we never check kthread_should_stop().
  So it hangs.

-- 
viresh
