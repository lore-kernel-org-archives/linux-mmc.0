From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 0/1] block: Add test-iosched scheduler
Date: Mon, 11 Jun 2012 21:06:01 +0530
Message-ID: <CANfBPZ9U+b4p5UQbX_oeLba28fTMfUrVONN=bRakn6d2Or=1ew@mail.gmail.com>
References: <1339011882-7919-1-git-send-email-merez@codeaurora.org>
 <CANfBPZ8C7YY760yx9ATi1_UJ_itL0N+fVdxx0Lim-55SgGjbng@mail.gmail.com> <41394741acbaf5451f81382a2f31b44f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41394741acbaf5451f81382a2f31b44f.squirrel@www.codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Jun 9, 2012 at 8:24 PM,  <merez@codeaurora.org> wrote:
>
>> On Thu, Jun 7, 2012 at 1:14 AM, Maya Erez <merez@codeaurora.org> wrote:
>>> The test scheduler allows testing a block device by dispatching
>>> specific requests according to the test case and declare PASS/FAIL
>>> according to the requests completion error code
>>>
>> I can't get the point. Isn't this possible purely from userspace using
>> IOCTLs ?
>> Even otherwise, requiring to modify the scheduler for each test case
>> is definitely not scalable.
> The main benefit of the test-iosched is the ability to determine the
> timing of each request that is being dispatched and to put on hold the
> real FS requests so that they won't affect the tests scenario.

Then a potentially long running test can block any useful work that can
be done on the device. no-op is not the right scheduler for the example
you mentioned (eMMC), so such device has to be mounted only for the
purpose of running the tests.
So using standard noop + debugfs would be sufficient for 99% of the cases ?

> It also allows each block device to determine pass/fail result taking into
> account the expected behavior and the actual result.


> The scheduler doesn't have to be changed per tests case. What made you
> think it should be?
Err.. I misread this section of documentation. I read is as sysfs
instead of debugfs.
My mistake..
<Quote>
+Each test is exposed via debugfs and can be triggered by writing to
+the debugfs file. In order to add a new test one should expose a new debugfs
+file for the new test.
</Quote>

> Currently we use the test-iosched to test the eMMC4.5 features (such as
> BKOPs, packed commands and sanitize). I hope that after we will release
> the tests later this week it will be clearer.
>>
Sure. It'd be useful.
