Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0CFC10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7950720746
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCMOIf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:08:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:4546 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCMOIe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Mar 2020 10:08:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 07:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="237232100"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2020 07:08:32 -0700
Subject: Re: [PATCH RFC 1/3] mmc: core: Try harder if transfer mode switch
 fails
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20200312142501.9868-1-adrian.hunter@intel.com>
 <20200312142501.9868-2-adrian.hunter@intel.com>
 <CAPDyKFpHZDy3TvHdQBuKgu5k3QkE+Pqcu5jumWa=LAY+ixUheg@mail.gmail.com>
 <5e2007ba-a090-b09b-6933-87c3548ed4f5@intel.com>
 <CAPDyKFrthSS+SMFMZUCPLY+QSUiO0w3pWij9aw3oh2f5jEMa_Q@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <719031e9-a902-b00b-43f8-9e06f2d35248@intel.com>
Date:   Fri, 13 Mar 2020 16:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrthSS+SMFMZUCPLY+QSUiO0w3pWij9aw3oh2f5jEMa_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/03/20 12:40 pm, Ulf Hansson wrote:
> On Fri, 13 Mar 2020 at 10:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 12/03/20 5:45 pm, Ulf Hansson wrote:
>>> On Thu, 12 Mar 2020 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> Add extra busy wait and retries if transfer mode switch fails.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/core/mmc_ops.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>>> index aa0cab190cd8..619088a94688 100644
>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>> @@ -599,6 +599,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>>                 cmd.sanitize_busy = true;
>>>>
>>>>         err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>>>> +       if (err && index == EXT_CSD_HS_TIMING) {
>>>> +               /* Try harder for timing changes */
>>>> +               __mmc_poll_for_busy(card, timeout_ms, send_status,
>>>> +                                   retry_crc_err, MMC_BUSY_CMD6);
>>>> +               err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>>>> +       }
>>>
>>> Hmm, what do you think of moving this to the caller(s) of
>>> __mmc_switch() and in particular only at those places were we find it
>>> useful. Me personally, would prefer that option.
>>>
>>> To do that, we may need to have the possibility of specifying the
>>> number of retries that should be used in the mmc_wait_for_cmd() call
>>> to the caller can check the error code better.
>>>
>>> Moreover, it looks a bit risky to do the polling for all kinds of
>>> errors - shouldn't we do for CRC errors?
>>>
>>
>> What about this then?
> 
> Looks good to me!
> 
> Is the retry in __mmc_switch() with MMC_CMD_RETRIES okay for now you think?

Yes, the additional error handling effectively gives a few more retries, so
that should do for now.


From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 13 Mar 2020 16:01:06 +0200
Subject: [PATCH] mmc: core: Do not change frequency before switch from HS400

Host controllers may support HS400 only at the expected frequency, so
do not change frequency before switch from HS400 but in case of CRC
error, wait for a busy card and then try again. Also try again after
frequency change if the error persists.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c     | 27 +++++++++++++++++++++------
 drivers/mmc/core/mmc_ops.c |  6 +++---
 drivers/mmc/core/mmc_ops.h |  3 +++
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c2abd417a84a..faa5d30ed891 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1235,20 +1235,35 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	int err;
 	u8 val;
 
-	/* Reduce frequency to HS */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
 			   false, true);
-	if (err)
-		goto out_err;
+	if (err == -EILSEQ) {
+		__mmc_poll_for_busy(card, card->ext_csd.generic_cmd6_time,
+				    false, true, MMC_BUSY_CMD6);
+		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				   EXT_CSD_HS_TIMING, val,
+				   card->ext_csd.generic_cmd6_time, 0, false,
+				   true);
+	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
+	if (err) {
+		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				   EXT_CSD_HS_TIMING, val,
+				   card->ext_csd.generic_cmd6_time, 0, false,
+				   true);
+	}
+	if (err)
+		goto out_err;
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aa0cab190cd8..8d9c3b97269c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -484,9 +484,9 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	return 0;
 }
 
-static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			       bool send_status, bool retry_crc_err,
-			       enum mmc_busy_cmd busy_cmd)
+int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+			bool send_status, bool retry_crc_err,
+			enum mmc_busy_cmd busy_cmd)
 {
 	struct mmc_host *host = card->host;
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 38dcfeeaf6d5..649985507f87 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -36,6 +36,9 @@ int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+			bool send_status, bool retry_crc_err,
+			enum mmc_busy_cmd busy_cmd);
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-- 
2.17.1

