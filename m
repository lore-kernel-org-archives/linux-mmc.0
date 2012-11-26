From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Mon, 26 Nov 2012 17:28:09 +0200
Message-ID: <50B38A89.1050506@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org> <5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org> <5089549D.3060507@stericsson.com> <CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com> <508D2F2E.3020006@codeaurora.org> <CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com> <508FC5E4.8010906@codeaurora.org> <CAFEEs1=+xD+jkydx7O-MLcvbyNkZ7BQbi=Q10c_Ln0XyXdRPmQ@mail.gmail.com> <50A3B598.4030702@codeaurora.org> <50A51A9E.9020004@stericsson.com> <50AA005B.8050903@codeaurora.org> <50AA4312.5000703@stericsson.com> <50AAA5F2.6000200@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000805060707090306090301"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:4081 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab2KZP2N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 10:28:13 -0500
In-Reply-To: <50AAA5F2.6000200@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000805060707090306090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 11/19/2012 11:34 PM, Per Förlin wrote:
> On 11/19/2012 03:32 PM, Per Förlin wrote:
>> On 11/19/2012 10:48 AM, Konstantin Dorfman wrote:
>>
> I'm fine with wait_event() (block request transfers) combined with completion (for other transfer), as long as the core.c API is intact. I don't see a reason for a new start_data_req()
>
> mmc_start_req() is only used by the mmc block transfers.
> Making a test case in mmc_test.c is a good way to stress test the feature (e.g. random timing of incoming new requests) and it will show how the API works too.
>
> BR
> Per
>
Right now there are couple of tests in mmc_test module that use async 
request mechanism. After applying my fix (v3 mmc: fix async request 
mechanism for sequential read scenarios), these test were broken.

The patch attached fixes those broken tests and also you can see exactly 
what is API change. It is not in mmc_start_req() signature, it is new 
context_info field that we need to synchronize with NEW_REQUEST 
notification. mmc_test is not uses the notification, but it is very easy 
to implement.


>> My main concern is to avoid adding new API to core.c in order to add the NEW_REQ feature. My patch is an example of changes to be done in core.c without adding new functions.
Now you can review API changes.

>>
>>>
>>> We would like to have a generic capability to handle additional events,
>>> such as HPI/stop flow, in addition to the NEW_REQUEST notification.
>>> Therefore, an event mechanism seems to be a better design than completion.
>>>
>>> I've looked at SDIO code and from what I can understand, right now SDIO
>>> is not using async request mechanism and works from 'wait_for_cmd()`
>>> level. This means that such work as exposing MMC core API's is major
>>> change and definitely should be separate design and implementation
>>> effort, while my current patch right now will fix mmc thread behavior
>>> and give better performance for upper layers.
>> You are right. There is no support in the SDIO implementation for pre/post/async feature. Still I had it in mind design the "struct mmc_async". It's possible to re-use the mmc core parts in order to utilize this support in the SDIO case. I'm not saying we should design for SDIO but at least keep the API in a way that it's potential usable from SDIO too. The API of core.c (start/wait of requests) should make sense without the existence of MMC block driver (block/queue).
>>
>> One way to test the design is to add a test in mmc_test.c for penging NEW_REQ. In mmc_test.c there is not block.c or queue.c.
>> If the test case if simple to write in mmc_test.c it's means that the API is on a good level.
I can simulate single NEW_PACKET notification in the mmc_test, but this 
will check only correctness, without real queue of requests we can't 
see/measure tpt/latency gain of this.

Kind reminder about patch v3, waiting for your review.

Thanks

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

--------------000805060707090306090301
Content-Type: text/x-diff;
 name="0001-mmc_test-fix-non-blocking-req-test-to-support-mmc-co.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mmc_test-fix-non-blocking-req-test-to-support-mmc-co.pa";
 filename*1="tch"

>From 240fa5757e9c784679b391ba42ec58e70fe856d9 Mon Sep 17 00:00:00 2001
From: Konstantin Dorfman <kdorfman@codeaurora.org>
Date: Mon, 26 Nov 2012 11:50:35 +0200
Subject: [RFC/PATCH] mmc_test: fix non-blocking req test to support mmc core
 wait_event mechanism

After introduce new wait_event synchronization mechanism at mmc/core/core.c level,
non-blocking request tests from mmc_test ut module are broken.

This patch fixes the tests by updating test environment to work
correctly on top of new wait_event mechanism.

Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 759714e..764471f 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -764,7 +764,8 @@ static int mmc_test_check_broken_result(struct mmc_test_card *test,
 static void mmc_test_nonblock_reset(struct mmc_request *mrq,
 				    struct mmc_command *cmd,
 				    struct mmc_command *stop,
-				    struct mmc_data *data)
+				    struct mmc_data *data,
+				    struct mmc_context_info *context_info)
 {
 	memset(mrq, 0, sizeof(struct mmc_request));
 	memset(cmd, 0, sizeof(struct mmc_command));
@@ -774,6 +775,7 @@ static void mmc_test_nonblock_reset(struct mmc_request *mrq,
 	mrq->cmd = cmd;
 	mrq->data = data;
 	mrq->stop = stop;
+	mrq->context_info = context_info;
 }
 static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 				      struct scatterlist *sg, unsigned sg_len,
@@ -790,6 +792,8 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	struct mmc_command stop2;
 	struct mmc_data data2;
 
+	struct mmc_context_info context_info;
+
 	struct mmc_test_async_req test_areq[2];
 	struct mmc_async_req *done_areq;
 	struct mmc_async_req *cur_areq = &test_areq[0].areq;
@@ -800,14 +804,18 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	test_areq[0].test = test;
 	test_areq[1].test = test;
 
-	mmc_test_nonblock_reset(&mrq1, &cmd1, &stop1, &data1);
-	mmc_test_nonblock_reset(&mrq2, &cmd2, &stop2, &data2);
+	memset(&context_info, 0, sizeof(struct mmc_context_info));
+
+	mmc_test_nonblock_reset(&mrq1, &cmd1, &stop1, &data1, &context_info);
+	mmc_test_nonblock_reset(&mrq2, &cmd2, &stop2, &data2, &context_info);
 
 	cur_areq->mrq = &mrq1;
 	cur_areq->err_check = mmc_test_check_result_async;
 	other_areq->mrq = &mrq2;
 	other_areq->err_check = mmc_test_check_result_async;
 
+	spin_lock_init(&context_info.lock);
+	init_waitqueue_head(&context_info.wait);
 	for (i = 0; i < count; i++) {
 		mmc_test_prepare_mrq(test, cur_areq->mrq, sg, sg_len, dev_addr,
 				     blocks, blksz, write);
@@ -819,10 +827,10 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 		if (done_areq) {
 			if (done_areq->mrq == &mrq2)
 				mmc_test_nonblock_reset(&mrq2, &cmd2,
-							&stop2, &data2);
+							&stop2, &data2, &context_info);
 			else
 				mmc_test_nonblock_reset(&mrq1, &cmd1,
-							&stop1, &data1);
+							&stop1, &data1, &context_info);
 		}
 		done_areq = cur_areq;
 		cur_areq = other_areq;
-- 
1.7.6


--------------000805060707090306090301--
