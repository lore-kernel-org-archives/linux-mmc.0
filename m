From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 00/10] mmc: Add HW Command Queuing Support
Date: Wed, 15 Jun 2016 18:31:04 +0530
Message-ID: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43574 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbcFONCD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:02:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>


Hi All, 

This patch series refreshes the older patch series sent a
while ago by Asutosh Das[1].

Current set of patch series is only introducing the basic CMDQ
driver to get more review comments. Based on the reviews, will
add other features as well to the patch list.

Below paras describes about the CMDQ feature and a brief
implementaion details of HW CMDQ :-

In this patch series, we propose a method to add support for
Command Queueing(CQ) feature added to eMMC-5.1 specification.
This feature includes new commands for issuing tasks to the
device and orders the execution of tasks to the device. It
also has task management functions.

Working of CQ with HW CQ support :-
Both card and controller(HC) maintains a queue where tasks can be
queued for execution. SW pulls the requests from block layer,
prepares request's task/transfer descriptors and issues
(by ringing the doorbell) it to CMDQ HC. CMDQ HC then queues this
task to the card queue (can queue while data transfer is in progress)
by preparing and sending CMD44 followed by CMD45.

While SW driver can issues the tasks asynchronously to CMDQ HC,
until the queue is full, HC can in parallel, send SQS
(send queue status) to card to read QSR (queue status register),
to know which tasks are ready for execution in card.
Based on the QSR, HC can send CMD46/47 (read/write) for the
task which was ready for execution in card.

Main advantage of CQ comes for Random requests and thus
we see that in below performance table that it's mainly
the random requests that gets most of the benefit.

Brief on implementation details :-
The initialization of CQ is decided based on the underlying
driver capability and the capability advertised by the card
through ext_csd.

In order to support queueing of multiple requests, we have
added a new issue function to mmc-queue. This selectively
pulls the requests and prepares and issues it to the underlying
driver. We have used the inherent tagging mechanism of kernel
block layer to keep track and map tags to the slots of underlying
driver. The current design doesn't block for the request to
complete. We have separated the issuing and completion path
of the request and tracking is done using the tag assigned to
the request.

We have introduced a number of APIs to mmc block layer to
facilitate servicing of requests.

The completion of requests is handled in a softirq registered
with the kernel block layer during initialization.

A new layer has been introduced to serve the CQ compliant drivers.
This layer (cq_hci) has all the standard functionality implemented.
It also has necessary hooks for convenience of platform drivers.


Performance Data :-
|------------------------------------
|Androbench	| CQ	|  Legacy  |
|---------------|-------|----------|
|Seq Read(MBps)	| 227.41|  216.97  |	
|---------------|-------|----------|
|Seq Write(MBps)| 56.6	|  56.44   |
|---------------|-------|----------|
|Rand.Read(IOPs)| 7144	|  4554    |
|---------------|-------|----------|
|Rand.Write(IOPS| 2374  |  1629	   |
|----------------------------------|


Patch Description in brief:-
Patch 1/10 - Reads ext_csd to know whether the card supports
CMDQ or not.

Patch 2/10 - Adds support for a seperate queue and
mmc_cmdq_thread for pulling and issuing the requests.
Since this patch series adds a seperate queue for HW CMDQ
support, this should not conflict with SW CMDQ series,
except in places where we are (initializing/enabling? and)
defining CMDQ definitions for card.

Patch 3/10 - Adds initialization and enabling of CMDQ in
card and controller if both supports it.

Patch 4-5,8,9/10 - Add read/write/flush/halt support to CMDQ

Patch 6/10 - This change does not relate to CMDQ in general,
but only w.r.t. SDMA & ADMA.

Patch 7/10 - Add CMDQ_HCI file for host controllers that support
CMDQ.

Patch 10/10 - Add CQ support to sdhci.

[1]:- http://www.spinics.net/lists/linux-arm-msm/msg12692.html

Asutosh Das (7):
  mmc: core: Add support to read command queue parameters
  mmc: queue: initialization of command queue
  mmc: core: Add command queue initialzation support
  mmc: core: add flush request support to command queue
  mmc: core: Add halt support
  mmc: cmdq-host: add halt support to command queue host
  mmc: sdhci: add command queue support to sdhci

Subhash Jadavani (1):
  mmc: host: sdhci: don't set SDMA buffer boundary in ADMA mode

Venkat Gopalakrishnan (2):
  mmc: card: add read/write support in command queue mode
  mmc: cmdq: support for command queue enabled host

 drivers/mmc/card/block.c    | 316 +++++++++++++++++++-
 drivers/mmc/card/queue.c    | 193 ++++++++++++-
 drivers/mmc/card/queue.h    |  11 +-
 drivers/mmc/core/core.c     |  98 +++++++
 drivers/mmc/core/mmc.c      |  68 +++++
 drivers/mmc/core/mmc_ops.c  |  47 ++-
 drivers/mmc/host/Kconfig    |  13 +
 drivers/mmc/host/Makefile   |   1 +
 drivers/mmc/host/cmdq_hci.c | 691 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cmdq_hci.h | 211 ++++++++++++++
 drivers/mmc/host/sdhci.c    | 169 ++++++++++-
 drivers/mmc/host/sdhci.h    |   6 +
 include/linux/mmc/card.h    |  11 +-
 include/linux/mmc/core.h    |  13 +
 include/linux/mmc/host.h    |  77 +++++
 include/linux/mmc/mmc.h     |   4 +
 16 files changed, 1905 insertions(+), 24 deletions(-)
 create mode 100644 drivers/mmc/host/cmdq_hci.c
 create mode 100644 drivers/mmc/host/cmdq_hci.h

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

