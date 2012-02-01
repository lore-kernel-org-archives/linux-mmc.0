From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] Improve handling of card removal
Date: Wed, 01 Feb 2012 11:37:57 +0200
Message-ID: <4F2907F5.7030706@intel.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com> <4F19564B.9070501@intel.com> <4F27E5D5.1050906@stericsson.com> <4F27F31B.6020401@intel.com> <4F280B71.5060901@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26301 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab2BAJhz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Feb 2012 04:37:55 -0500
In-Reply-To: <4F280B71.5060901@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 31/01/12 17:40, Ulf Hansson wrote:
> Adrian Hunter wrote:
>> On 31/01/12 15:00, Ulf Hansson wrote:
>>> Adrian Hunter wrote:
>>>> On 19/01/12 18:39, Ulf Hansson wrote:
>>>>> These patches is based upon the patch recently pushed to the mmc mailing
>>>>> list:
>>>>> mmc: core: Force a "detect" to handle non-properly removed cards
>>>>>
>>>>> According to Adrian Hunters comment about adding a CAP2 flag to enable
>>>>> this feature has been done.
>>>>>
>>>>> Patch 2 depends on patch 1; but patch 1 can also be discussed separately.
>>>> There should only be 1 patch otherwise you are breaking bisectablility for
>>>> people not setting MMC_CAP2_DETECT_ON_ERR
>>> The first patch "Prevent I/O as soon as possible..." does only make sure
>>> that I/O is prevented as soon as possible but still within the timeout for
>>> the scheduled detect work. Once the detect work (mmc_rescan) has run the
>>> "detect_change" flag is preventing any further I/O errors from directly
>>> trying to detect a card removal.
>>>
>>> The second patch introduces the MMC_CAP2_DETECT_ON_ERR, as you suggested.
>>
>> For drivers not using MMC_CAP2_DETECT_ON_ERR, the first patch introduces a
>> change in behaviour and the second patch removes it again.  Anyone doing a
>> git bisect that lands between the patches will see that change in behaviour.
>>  There is no reason for that - just make it one patch.
> 
> The first patch is trying to "Prevent I/O as soon as possible at card removal". It changes some behavior for how we handle card removal, yes. A change I believe you would like to have no matter if the second patch is accepted or not.
> 
> The second patch, takes the card removal handling to the next level. If MMC_CAP2_DETECT_ON_ERR is used, card removal will be checked for every I/O error until the card has been detected to be removed. It does not remove the behavior for the first patch it only makes it possible to enable the option of checking for card removal at I/O errors as well.

Make the patch like this and there is no problem:



diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bec0bf2..a847311 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2077,18 +2077,30 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 int mmc_detect_card_removed(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
+	int ret;

 	WARN_ON(!host->claimed);
 	/*
 	 * The card will be considered unchanged unless we have been asked to
 	 * detect a change or host requires polling to provide card detection.
 	 */
-	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
+	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
+	    && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
 		return mmc_card_removed(card);

 	host->detect_change = 0;

-	return _mmc_detect_card_removed(host);
+	ret = _mmc_detect_card_removed(host);
+	if (ret && (host->caps2 & MMC_CAP2_DETECT_ON_ERR)) {
+		/*
+		 * Schedule a detect work as soon as possible to let a
+		 * rescan handle the card removal.
+		 */
+		cancel_delayed_work(&host->detect);
+		mmc_detect_change(host, 0);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(mmc_detect_card_removed);

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd13e05..368a2b9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -257,6 +257,7 @@ struct mmc_host {
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
+#define MMC_CAP2_DETECT_ON_ERR	(1 << 7)	/* On I/O err check card removal */

 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
