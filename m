From: merez@codeaurora.org
Subject: Re: [PATCH v2 0/1] block: Add test-iosched scheduler
Date: Sat, 9 Jun 2012 07:54:18 -0700 (PDT)
Message-ID: <41394741acbaf5451f81382a2f31b44f.squirrel@www.codeaurora.org>
References: <1339011882-7919-1-git-send-email-merez@codeaurora.org>
    <CANfBPZ8C7YY760yx9ATi1_UJ_itL0N+fVdxx0Lim-55SgGjbng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ8C7YY760yx9ATi1_UJ_itL0N+fVdxx0Lim-55SgGjbng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Maya Erez <merez@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


> On Thu, Jun 7, 2012 at 1:14 AM, Maya Erez <merez@codeaurora.org> wrot=
e:
>> The test scheduler allows testing a block device by dispatching
>> specific requests according to the test case and declare PASS/FAIL
>> according to the requests completion error code
>>
> I can't get the point. Isn't this possible purely from userspace usin=
g
> IOCTLs ?
> Even otherwise, requiring to modify the scheduler for each test case
> is definitely not scalable.
The main benefit of the test-iosched is the ability to determine the
timing of each request that is being dispatched and to put on hold the
real FS requests so that they won't affect the tests scenario.
It also allows each block device to determine pass/fail result taking i=
nto
account the expected behavior and the actual result.
The scheduler doesn't have to be changed per tests case. What made you
think it should be?
Currently we use the test-iosched to test the eMMC4.5 features (such as
BKOPs, packed commands and sanitize). I hope that after we will release
the tests later this week it will be clearer.
>
>> Changes in v2:
>> =A0 =A0- Export test-iosched functionality to allow definition of th=
e block
>> device
>> =A0 =A0 =A0tests under the block device layer
>> =A0 =A0- Add registration of block device tests utilities
>>
>> Maya Erez (1):
>> =A0block: Add test-iosched scheduler
>>
>> =A0Documentation/block/test-iosched.txt | =A0 39 ++
>> =A0block/Kconfig.iosched =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +
>> =A0block/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
>> =A0block/blk-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
3 +-
>> =A0block/test-iosched.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1025
>> ++++++++++++++++++++++++++++++++++
>> =A0include/linux/test-iosched.h =A0 =A0 =A0 =A0 | =A0218 +++++++
>> =A06 files changed, 1292 insertions(+), 2 deletions(-)
>> =A0create mode 100644 Documentation/block/test-iosched.txt
>> =A0create mode 100644 block/test-iosched.c
>> =A0create mode 100644 include/linux/test-iosched.h
>>
>

Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
