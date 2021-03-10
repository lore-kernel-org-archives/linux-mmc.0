Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01455C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3CF64FEE
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 08:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCJIyJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:54:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:63463 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhCJIyB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Mar 2021 03:54:01 -0500
IronPort-SDR: N1c/VTPu+aw+y4OXwdNwtYHXjPzCdI1ld/SOJXir4pewgZA//DZOIyiQuODpxg14bR6ZiTa3Ko
 1ZVLlXmqfaBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188459445"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188459445"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 00:54:00 -0800
IronPort-SDR: 08yYzv6xbqJRuyXWsglhFI/0x/C5lX/KsL6DjIoAP/cSJSCqfkB1r2QHb0M8uK3nGvbXmWqYQb
 KtOFFznv5yMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="376890852"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2021 00:53:57 -0800
Subject: Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Luca Porzio <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
References: <20210215003249.GA12303@lupo-laptop>
 <CAPDyKFou4VdtUV66-c8y_tV9g9oaUCa8nphsLW6gH0_bi7y_dA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d9d7a7c7-dd26-8e07-e510-7e2493bff882@intel.com>
Date:   Wed, 10 Mar 2021 10:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFou4VdtUV66-c8y_tV9g9oaUCa8nphsLW6gH0_bi7y_dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/03/21 12:46 pm, Ulf Hansson wrote:
> + Adrian
> 
> On Mon, 15 Feb 2021 at 01:33, Luca Porzio <porzio@gmail.com> wrote:
>>
>> cmdq_en attribute in sysfs now can now be written.
>> When 0 is written:
>>   CMDQ is disabled and kept disabled across device reboots.
>> When 1 is written:
>>   CMDQ mode is instantly reneabled (if supported).
>>
>> Signed-off-by: Luca Porzio <lporzio@micron.com>
>> Signed-off-by: Zhan Liu <zliua@micron.com>
> 
> Luca, thanks for your patch! I am about to start to review this.
> 
> I have also looped in Adrian to get his opinions.
> 
> Get back to you soon!
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/core/mmc.c   | 152 ++++++++++++++++++++++++++++++---------
>>  include/linux/mmc/card.h |   1 +
>>  2 files changed, 118 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 0d80b72ddde8..5c7d5bac5c00 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -794,7 +794,120 @@ MMC_DEV_ATTR(enhanced_rpmb_supported, "%#x\n",
>>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>>  MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>>  MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
>> -MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
>> +
>> +
>> +/* Setup command queue mode and CQE if underling hw supports it
>> + * and assuming force_disable_cmdq has not been set.
>> + */
>> +static int mmc_cmdq_setup(struct mmc_host *host, struct mmc_card *card)
>> +{
>> +       int err;
>> +
>> +       /* Check HW support */
>> +       if (!card->ext_csd.cmdq_support || !(host->caps2 & MMC_CAP2_CQE))
>> +               card->force_disable_cmdq = true;
>> +
>> +       /* Enable/Disable  CMDQ mode */
>> +       if (!card->ext_csd.cmdq_en && !card->force_disable_cmdq) {
>> +               err = mmc_cmdq_enable(card);
>> +               if (err && err != -EBADMSG)
>> +                       return err;
>> +               if (err) {
>> +                       pr_warn("%s: Enabling CMDQ failed\n",
>> +                           mmc_hostname(card->host));
>> +                       card->ext_csd.cmdq_support = false;
>> +                       card->ext_csd.cmdq_depth = 0;
>> +               }
>> +
>> +       } else if (card->ext_csd.cmdq_en && card->force_disable_cmdq) {
>> +               err = mmc_cmdq_disable(card);
>> +               if (err) {
>> +                       pr_warn("%s: Disabling CMDQ failed, error %d\n",
>> +                           mmc_hostname(card->host), err);
>> +                       err = 0;
>> +               }
>> +       }
>> +
>> +       /*
>> +        * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
>> +        * disabled for a time, so a flag is needed to indicate to re-enable the
>> +        * Command Queue.
>> +        */
>> +       card->reenable_cmdq = card->ext_csd.cmdq_en;
>> +
>> +       /* Enable/Disable Host CQE */
>> +       if (!card->force_disable_cmdq) {
>> +
>> +               if (host->cqe_ops && !host->cqe_enabled) {
>> +                       err = host->cqe_ops->cqe_enable(host, card);
>> +                       if (!err) {
>> +                               host->cqe_enabled = true;

Re-initializing the card is also a recovery path for the block driver.
Changing host->cqe_enabled during a recovery reset, creates an unexpected
dependency for the block driver.  That should not be necessary, and given
that cqhci does memory allocation as part of enabling, it is better not to
disable / re-enable if it can be helped.

From a design point of view, it is really the block driver that should
control the use of command queuing rather than expecting it to cope with
changes from a lower level.

>> +
>> +                               if (card->ext_csd.cmdq_en) {
>> +                                       pr_info("%s: Command Queue Engine enabled\n",
>> +                                           mmc_hostname(host));
>> +                               } else {
>> +                                       host->hsq_enabled = true;
>> +                                       pr_info("%s: Host Software Queue enabled\n",
>> +                                           mmc_hostname(host));
>> +                               }
>> +                       }
>> +               }
>> +
>> +       } else {
>> +
>> +               if (host->cqe_enabled) {
>> +                       host->cqe_ops->cqe_disable(host);
>> +                       host->cqe_enabled = false;
>> +                       pr_info("%s: Command Queue Engine disabled\n",
>> +                           mmc_hostname(host));
>> +               }
>> +
>> +               host->hsq_enabled = false;

This looks quite wrong for hsq which is currently not used with
cmdq.

>> +               err = 0;
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +
>> +static ssize_t cmdq_en_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +       struct mmc_card *card = mmc_dev_to_card(dev);
>> +
>> +       return sprintf(buf, "%d\n", card->ext_csd.cmdq_en);
>> +}
>> +
>> +static ssize_t cmdq_en_store(struct device *dev, struct device_attribute *attr,
>> +                                const char *buf, size_t count)
>> +{
>> +       struct mmc_card *card = mmc_dev_to_card(dev);
>> +       struct mmc_host *host = card->host;
>> +       unsigned long enable;
>> +       int err;
>> +
>> +       if (!card || kstrtoul(buf, 0, &enable))
>> +               return -EINVAL;
>> +       if (!card->ext_csd.cmdq_support)
>> +               return -EOPNOTSUPP;
>> +
>> +       enable = !!enable;
>> +       if (enable == card->ext_csd.cmdq_en)
>> +               return count;
>> +
>> +       mmc_get_card(card, NULL);
>> +       card->force_disable_cmdq = !enable;
>> +       err = mmc_cmdq_setup(host, card);
>> +       mmc_put_card(card, NULL);
>> +
>> +       if (err)
>> +               return err;
>> +       else
>> +               return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(cmdq_en);
>> +
>>
>>  static ssize_t mmc_fwrev_show(struct device *dev,
>>                               struct device_attribute *attr,
>> @@ -1838,40 +1951,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>          * Enable Command Queue if supported. Note that Packed Commands cannot
>>          * be used with Command Queue.
>>          */
>> -       card->ext_csd.cmdq_en = false;
>> -       if (card->ext_csd.cmdq_support && host->caps2 & MMC_CAP2_CQE) {
>> -               err = mmc_cmdq_enable(card);
>> -               if (err && err != -EBADMSG)
>> -                       goto free_card;
>> -               if (err) {
>> -                       pr_warn("%s: Enabling CMDQ failed\n",
>> -                               mmc_hostname(card->host));
>> -                       card->ext_csd.cmdq_support = false;
>> -                       card->ext_csd.cmdq_depth = 0;
>> -               }
>> -       }
>> -       /*
>> -        * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
>> -        * disabled for a time, so a flag is needed to indicate to re-enable the
>> -        * Command Queue.
>> -        */
>> -       card->reenable_cmdq = card->ext_csd.cmdq_en;
>> -
>> -       if (host->cqe_ops && !host->cqe_enabled) {
>> -               err = host->cqe_ops->cqe_enable(host, card);
>> -               if (!err) {
>> -                       host->cqe_enabled = true;
>> -
>> -                       if (card->ext_csd.cmdq_en) {
>> -                               pr_info("%s: Command Queue Engine enabled\n",
>> -                                       mmc_hostname(host));
>> -                       } else {
>> -                               host->hsq_enabled = true;
>> -                               pr_info("%s: Host Software Queue enabled\n",
>> -                                       mmc_hostname(host));
>> -                       }
>> -               }
>> -       }
>> +       err = mmc_cmdq_setup(host, card);
>> +       if (err)
>> +               goto free_card;
>>
>>         if (host->caps2 & MMC_CAP2_AVOID_3_3V &&
>>             host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index f9ad35dd6012..e554bb0cf722 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -272,6 +272,7 @@ struct mmc_card {
>>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>>
>>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>> +       bool                    force_disable_cmdq; /* Keep Command Queue disabled */
>>
>>         unsigned int            erase_size;     /* erase size in sectors */
>>         unsigned int            erase_shift;    /* if erase unit is power 2 */
>> --
>> 2.17.1
>>

