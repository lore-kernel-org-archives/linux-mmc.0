From: =?ks_c_5601-1987?B?wOW/tcH4?= <yj84.jang@samsung.com>
Subject: [PATCH] Move the judgement of timeout into mmc_switch_status_error()
Date: Thu, 24 Dec 2015 18:13:01 +0900
Message-ID: <008f01d13e2b$4a2a3150$de7e93f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: js07.lee@samsung.com, =?ks_c_5601-1987?B?J8DMsaTIoyc=?= <demon.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

>From bc1e491b29d9199f16c6e002a69f9377677b93af Mon Sep 17 00:00:00 2001

From: "yj84.jang" <yj84.jang@samsung.com>

Date: Wed, 16 Dec 2015 08:52:47 +0900

Subject: [PATCH] Move the judgement of timeout into
mmc_switch_status_error()

 

__mmc_switch() is possible to misjudge error.

 

Although jiffies was overed timeout, 

the chance about "R1_CURRENT_STATE(status) != R1_STATE_PRG" is exists. 

In other words, Successful completion of CMD6 with timeout error.

 

Kernel expects failure of __mmc_switch,

but card is completed CMD6 in this case.

It makes mismatch status between mmc subsystem and mmc card.

 

Especially, in case of partition switch,

If timeout occurs with normal status of CMD13 response unfortunatley, 

"main_md->curr" will not be set, even card switched successfully.

 

Checking state of mmc card is needed when judging an timeout error, 

if it is just timeout or timeout with error.

 

Signed-off-by: yj84.jang <yj84.jang@samsung.com>

---

drivers/mmc/core/mmc_ops.c |    5 +++--

1 file changed, 3 insertions(+), 2 deletions(-)

 

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c

index 1f44426..033f475 100644

--- a/drivers/mmc/core/mmc_ops.c

+++ b/drivers/mmc/core/mmc_ops.c

@@ -456,6 +456,8 @@ int mmc_switch_status_error(struct mmc_host *host, u32
status)

                    if (status & R1_SPI_ILLEGAL_COMMAND)

                               return -EBADMSG;

         } else {

+                   if (R1_CURRENT_STATE(status) == R1_STATE_PRG)

+                              return -ETIMEDOUT;

                    if (status & 0xFDFFA000)

                               pr_warn("%s: unexpected status %#x after
switch\n",

                                         mmc_hostname(host), status);

@@ -568,8 +570,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
index, u8 value,

                    if (time_after(jiffies, timeout)) {

                               pr_err("%s: Card stuck in programming state!
%s\n",

                                         mmc_hostname(host), __func__);

-                               err = -ETIMEDOUT;

-                               goto out;

+                              break;

                    }

         } while (R1_CURRENT_STATE(status) == R1_STATE_PRG);

 

-- 

1.7.9.5

 
