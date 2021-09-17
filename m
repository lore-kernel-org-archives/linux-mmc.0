Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB2C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D5061152
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 07:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhIQHPP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:15:15 -0400
Received: from mail3.swissbit.com ([176.95.1.57]:43636 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIQHPO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 03:15:14 -0400
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 731A1462824;
        Fri, 17 Sep 2021 09:13:51 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 42750462823;
        Fri, 17 Sep 2021 09:13:51 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri, 17 Sep 2021 09:13:51 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Fri, 17 Sep
 2021 09:13:50 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0792.015; Fri, 17 Sep 2021 09:13:50 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     =?iso-8859-1?Q?M=E5rten_Lindahl?= <marten.lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "kernel@axis.com" <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: Support more time for data read timeouts
Thread-Topic: [PATCH] mmc: dw_mmc: Support more time for data read timeouts
Thread-Index: AQHXmyGJEdFbNAnwc0S6TM4fCxk95aun7N9x
Date:   Fri, 17 Sep 2021 07:13:50 +0000
Message-ID: <35064dfafab0419384b95a9800cf2c4e@hyperstone.com>
References: <20210827085634.21225-1-marten.lindahl@axis.com>
In-Reply-To: <20210827085634.21225-1-marten.lindahl@axis.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26412.006
X-TMASE-Result: 10--5.151800-10.000000
X-TMASE-MatchedRID: Eqw74mxM7XXUL3YCMmnG4qJVTu7sjgg1DibuessoYDZm3JRfoPI9scwM
        TBTkNfIjF3uQYtPkNr6vj5H7qV3MygScyU4SO7bFf+uRK1dZrq9I5IKBmueVWjVnQMQE4iIl/vz
        iKpflyKX6SY/N1J2k2yLuZAk1qAxOgp82HbRpnMzVsW2YGqoUtJKLNrbpy/A0zP9LEqj2YngZ1G
        fA6BFBC+7y3cKtcypIjY1J/WyyVZuMKc5FAaJl6pr5ykm9NtIcP7uiVpnmLFjBDqAtpW0v84nO/
        I/i7S2AlUkoMluWRitdQO/9ABX3u0xg8KZsB8KvVZ54ioe2Ewu/m13BpxkSel33rgHQQnWVfjcd
        X7WMS/A0mpdbUFhhsxFCuSA0AK/rQY6eLE365oblvSeYSYEULCILdc+InEErL++JA985eCezu34
        v/cyxLCrKPE0EtCuv+Bb1Wo7XcLafJKoJNVF/JJMIKPXbrloXrOCEGIPhtwjDOS0FhcAXSmjJRm
        VgWl9cz8Lcx42EyZhqrgtzev+ggZr/5QhTM8mCrfwvtt71iU83ljUklwm/buJiUqjHevI0Tx9jh
        If/nmxKp2trhZa6PI9CL1e45ag4BR65NXYd9CsaPMGCcVm9DuBefETzWLKxjhBDYLFALmIzn85L
        9kDJDEB3Wnq8f0aKM9VlGvdZFucjsdTXcZiIKJciNJzaqUX1S3sNHVAxomx32Xz6cV3Ps5c1qCk
        ooZMTOjLTSH5MW5mu0znGjE0042peo4CgsnKMb056mCmF00Z9LQinZ4QefJxSu1RP8S9J+gtHj7
        OwNO0kshYUTZcZE1Bt6XHZn0yUbZW26P/ISRVJsd1bLu+CDXkVa8FklWB9Vlxr1FJij9s=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: bc694a48-4a24-4f98-a51d-311dead70881-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

So I'm in favor in reworking the DRTO timeout calculation to something more meaningful.
(Maybe we should keep the R though as it currently only affects reads, but more on that later).

After playing around with dw_mmc (on the rk3399) Ive seen 3 issues with the current driver.
Lets look at the traces (format: timestamp,type(1=cmd,2=rsp48, 3=rsp136, 4=dataover),cmdopcode,arg)

-The worst of them Id say is this one:
32611.175228177,1,25,059f5000
32611.175247135,2,25,00000080
32611.175265218,0,RESP TO CMD 25 : 80 CONTAINED AN ERROR -84
--- hang --- tasklet never getting scheduled again
I send a patch for that yesterday.

-Then there's the case where the register is at reset value and the timeout is about 167 seconds
1547.207376888,1,55,00000000
1547.207986555,2,55,00000120
1547.208669638,2,41,80ff8000
1547.208064638,1,41,41040000
1547.208736055,1,02,00000000
1547.209899513,1,03,00000000
1547.209786721,3,02,00000000000000000000000000000001
1547.210519680,2,03,00010520
1547.210577638,1,09,00010000
1547.211636471,3,09,007f00321b5980f26ebb7fff1640009b
1547.211717763,1,07,00010000
1547.212334721,2,07,00000700
1547.212402305,1,55,00010000
1547.213022180,2,55,00000920
1547.213096471,1,51,00000000
1547.213718680,2,51,00000920
1547.214967596,4,51,0,8
1547.214971096,5,51,00a5000000000000
1547.215036930,1,55,00010000
1547.215660013,2,55,00000920
1547.215747721,1,13,00000000
1547.216369930,2,13,00000920
1631.102136318,0,Sending stop abort due data ERROR: data status: 208
Note the long gap between the last two lines, I can send a simple fix for that today.

-The last one I'm not sure why it occurs but I can also see something like this
77769.308526825,1,23,0000000c
77769.308550158,2,23,00000900
77769.308598575,1,25,08ac7800
77769.308614908,2,25,00000900
-- hang -- tasklet never getting scheduled again

To my understanding there should not be a state where we don't receive an interrupt
when a data write times out, but apparently this can happen.

This patch would fix the second issue.
Can we extend it to catch a dtwo timeout, too?
I'd just add a flag in dw_mci_set_dto for writes and give it some extra slack.
The case happened rarely enough for me that I'd say anything that is not a complete hang of the driver
is a good enough improvement.

Regards,
Christian


From: Mårten Lindahl <marten.lindahl@axis.com>
Sent: Friday, August 27, 2021 10:56 AM
To: Jaehoon Chung; Ulf Hansson
Cc: kernel@axis.com; linux-mmc@vger.kernel.org; Mårten Lindahl
Subject: [PATCH] mmc: dw_mmc: Support more time for data read timeouts
    
For data read transfers a data transfer over timer (dto_timer) is
started to make sure the data command can be completed in cases the Data
Transfer Over (DTO) interrupt does not come. This timer was originally
introduced as a quirk in commit 57e104864bc48 ("mmc: dw_mmc: add quirk
for broken data transfer over scheme"), but is since a while back part
of the running code.

The dto timer picks the DATA_TIMEOUT value in the TMOUT register for its
timeout, which will give a max timeout of approximately 84 + (10 spare)
milliseconds on a 200MHz clock. But this register is not intended to be
used like that, since it is a counter for data read timeouts (DRTO) and
response timeouts (RTO), which will result in error interrupts in case
of data read and response delays.

The TMOUT register is always set with a full value for every transfer,
which according to the manual (and with 200MHz clock) will give a full
DRTO of:
((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms

But as the same register is used for the dto_timer, the dto_timer will
always have a fixed timeout.

Instead of always setting a fixed value in TMOUT register, we can use
data->timeout_ns for the DRTO interrupts that actually matches what was
provided per requested command. Likewise we can also use timeout_ns for
the dto_timer, which will allow a max timeout of 587 ms, instead of the
fixed 94 ms. Furthermore, if a data error interrupt comes, it shouldn't
be necessary to wait for the dto_timer before we finish the command, but
instead we can handle it in the interrupt handler.

Lets fix this. In most cases data->timeout_ns values are given, but in
case it is not given, the maximum (default) timeout for the dto_timer,
and the DRTO, is set to approximately 587 ms.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 108 ++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c3229d8c7041..0762d95293d4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -52,6 +52,7 @@
 
 #define DW_MCI_FREQ_MAX 200000000       /* unit: HZ */
 #define DW_MCI_FREQ_MIN 100000          /* unit: HZ */
+#define DW_MCI_DATA_TMOUT_NS_MAX       587202490
 
 #define IDMAC_INT_CLR           (SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
                                  SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
@@ -390,6 +391,23 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
         spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
+static void dw_mci_set_dto(struct dw_mci *host, u32 timeout_ns)
+{
+       unsigned int dto_ns;
+       unsigned long irqflags;
+
+       if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX)
+               dto_ns = DW_MCI_DATA_TMOUT_NS_MAX;
+       else
+               dto_ns = timeout_ns;
+
+       spin_lock_irqsave(&host->irq_lock, irqflags);
+       if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
+               mod_timer(&host->dto_timer,
+                         jiffies + nsecs_to_jiffies(dto_ns));
+       spin_unlock_irqrestore(&host->irq_lock, irqflags);
+}
+
 static void dw_mci_start_command(struct dw_mci *host,
                                  struct mmc_command *cmd, u32 cmd_flags)
 {
@@ -1144,9 +1162,10 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
         host->sg = NULL;
         host->data = data;
 
-       if (data->flags & MMC_DATA_READ)
+       if (data->flags & MMC_DATA_READ) {
                 host->dir_status = DW_MCI_RECV_STATUS;
-       else
+               dw_mci_set_dto(host, data->timeout_ns);
+       } else
                 host->dir_status = DW_MCI_SEND_STATUS;
 
         dw_mci_ctrl_thld(host, data);
@@ -1277,6 +1296,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
         mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
+static void dw_mci_set_data_timeout(struct dw_mci *host, u32 timeout_ns)
+{
+       u32 timeout, freq_mhz, tmp, tmout;
+
+       if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX) {
+               /* Timeout (maximum) */
+               mci_writel(host, TMOUT, 0xFFFFFFFF);
+               return;
+       }
+
+       timeout = timeout_ns / NSEC_PER_USEC;
+       freq_mhz = host->bus_hz / NSEC_PER_MSEC;
+
+       /* TMOUT[7:0] (RESPONSE_TIMEOUT) */
+       tmout = 0xFF;
+
+       /* TMOUT[10:8] (DATA_TIMEOUT) */
+       tmp = ((timeout * freq_mhz) / 0xFFFFFF) + 1;
+       tmout |= (tmp & 0x7) << 8;
+
+       /* TMOUT[31:11] (DATA_TIMEOUT) */
+       tmp = ((tmp - 1) * 0xFFFFFF) / freq_mhz;
+       tmp = (timeout - tmp) * freq_mhz / 8;
+       tmout |= (tmp & 0x1FFFFF) << 11;
+
+       mci_writel(host, TMOUT, tmout);
+       dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%08x",
+               timeout_ns, tmout);
+}
+
 static void __dw_mci_start_request(struct dw_mci *host,
                                    struct dw_mci_slot *slot,
                                    struct mmc_command *cmd)
@@ -1297,7 +1346,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
         data = cmd->data;
         if (data) {
-               mci_writel(host, TMOUT, 0xFFFFFFFF);
+               dw_mci_set_data_timeout(host, data->timeout_ns);
                 mci_writel(host, BYTCNT, data->blksz*data->blocks);
                 mci_writel(host, BLKSIZ, data->blksz);
         }
@@ -1897,31 +1946,6 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
         return data->error;
 }
 
-static void dw_mci_set_drto(struct dw_mci *host)
-{
-       unsigned int drto_clks;
-       unsigned int drto_div;
-       unsigned int drto_ms;
-       unsigned long irqflags;
-
-       drto_clks = mci_readl(host, TMOUT) >> 8;
-       drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
-       if (drto_div == 0)
-               drto_div = 1;
-
-       drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
-                                  host->bus_hz);
-
-       /* add a bit spare time */
-       drto_ms += 10;
-
-       spin_lock_irqsave(&host->irq_lock, irqflags);
-       if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
-               mod_timer(&host->dto_timer,
-                         jiffies + msecs_to_jiffies(drto_ms));
-       spin_unlock_irqrestore(&host->irq_lock, irqflags);
-}
-
 static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
 {
         if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
@@ -2052,15 +2076,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
                         }
 
                         if (!test_and_clear_bit(EVENT_XFER_COMPLETE,
-                                               &host->pending_events)) {
-                               /*
-                                * If all data-related interrupts don't come
-                                * within the given time in reading data state.
-                                */
-                               if (host->dir_status == DW_MCI_RECV_STATUS)
-                                       dw_mci_set_drto(host);
+                                               &host->pending_events))
                                 break;
-                       }
 
                         set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
 
@@ -2091,16 +2108,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
                         fallthrough;
 
                 case STATE_DATA_BUSY:
-                       if (!dw_mci_clear_pending_data_complete(host)) {
-                               /*
-                                * If data error interrupt comes but data over
-                                * interrupt doesn't come within the given time.
-                                * in reading data state.
-                                */
-                               if (host->dir_status == DW_MCI_RECV_STATUS)
-                                       dw_mci_set_drto(host);
+                       if (!dw_mci_clear_pending_data_complete(host))
                                 break;
-                       }
 
                         host->data = NULL;
                         set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
@@ -2649,12 +2658,21 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
                 }
 
                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
+                       spin_lock(&host->irq_lock);
+
+                       del_timer(&host->dto_timer);
+
                         /* if there is an error report DATA_ERROR */
                         mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
                         host->data_status = pending;
                         smp_wmb(); /* drain writebuffer */
                         set_bit(EVENT_DATA_ERROR, &host->pending_events);
+
+                       /* In case of error, we cannot expect a DTO */
+                       set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
                         tasklet_schedule(&host->tasklet);
+
+                       spin_unlock(&host->irq_lock);
                 }
 
                 if (pending & SDMMC_INT_DATA_OVER) {
-- 
2.20.1

    =
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

